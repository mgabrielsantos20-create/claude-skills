#!/bin/bash
# Só roda na nuvem. No Mac ele duplicaria as skills (instala minhas-skills por cima de ~/.claude/skills).
if [ "$(uname)" = "Darwin" ]; then
  echo "Este script é para a nuvem (claude.ai/code > ambiente Default > Script de configuração). No Mac não faz nada."
  exit 0
fi
# Script de configuração da nuvem: instala marketplaces e plugins do Mac do Gabriel.
# A lista vem de plugins.json, gerado pelo sync.sh a partir do ~/.claude/settings.json do Mac.
# Plugin novo instalado no Mac chega aqui sozinho, sem mudar este script.
LISTA="$(curl -fsSL https://raw.githubusercontent.com/mgabrielsantos20-create/claude-skills/main/plugins.json || true)"
if [ -n "$LISTA" ]; then
  echo "$LISTA" | python3 -c 'import json,sys; [print(r) for r in json.load(sys.stdin)["marketplaces"]]' | while read -r repo; do
    claude plugin marketplace add "$repo" || true
  done
  echo "$LISTA" | python3 -c 'import json,sys; [print(p) for p in json.load(sys.stdin)["plugins"]]' | while read -r plugin; do
    claude plugin install "$plugin" || true
  done
fi
claude plugin marketplace add mgabrielsantos20-create/claude-skills || true
claude plugin install minhas-skills@gabriel-skills || true

# gstack: precisa do Bun para instalar. Fica em ~/.claude/skills/gstack, como no Mac.
if [ ! -d "$HOME/.claude/skills/gstack" ]; then
  command -v bun >/dev/null 2>&1 || { curl -fsSL https://bun.sh/install | bash; export PATH="$HOME/.bun/bin:$PATH"; }
  mkdir -p "$HOME/.claude/skills"
  git clone -q --depth 1 https://github.com/garrytan/gstack.git "$HOME/.claude/skills/gstack" \
    && (cd "$HOME/.claude/skills/gstack" && ./setup --host claude --no-browser) || true
fi

# MCPs de navegador e shadcn: instalados antes da sessão, para não baixar na hora e estourar o tempo.
# O Chrome stable atende o playwright-mcp e o chrome-devtools-mcp.
npm i -g @playwright/mcp chrome-devtools-mcp shadcn || true
npx -y playwright install --with-deps chrome || true
