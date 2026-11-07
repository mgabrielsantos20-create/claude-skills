#!/bin/bash
# Script de configuração da nuvem: instala marketplaces e plugins do Mac do Gabriel.
claude plugin marketplace add 21st-dev/claude-code-plugin || true
claude plugin marketplace add anthropics/skills || true
claude plugin marketplace add obra/superpowers-marketplace || true
claude plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill || true
claude plugin marketplace add coreyhaines31/marketingskills || true
claude plugin marketplace add rampstackco/claude-skills || true
claude plugin marketplace add AThevon/genjutsu || true
claude plugin marketplace add sergebulaev/instagram-skills || true
claude plugin marketplace add thedotmack/claude-mem || true
claude plugin marketplace add JuliusBrussee/caveman || true
claude plugin marketplace add jarrodwatts/claude-hud || true
claude plugin marketplace add mvanhorn/last30days-skill || true
claude plugin marketplace add heygen-com/hyperframes || true
claude plugin marketplace add apify/apify-claude-code-plugin || true
claude plugin marketplace add mgabrielsantos20-create/claude-skills || true
claude plugin install 21st@21st || true
claude plugin install example-skills@anthropic-agent-skills || true
claude plugin install document-skills@anthropic-agent-skills || true
claude plugin install superpowers@superpowers-marketplace || true
claude plugin install ui-ux-pro-max@ui-ux-pro-max-skill || true
claude plugin install marketing-skills@marketingskills || true
claude plugin install rampstack-skills@rampstack || true
claude plugin install claude-mem@thedotmack || true
claude plugin install genjutsu@genjutsu || true
claude plugin install instagram-skills@instagram-skills || true
claude plugin install caveman@caveman || true
claude plugin install claude-hud@claude-hud || true
claude plugin install last30days@last30days-skill || true
claude plugin install hyperframes@hyperframes || true
claude plugin install apify@apify || true
claude plugin install minhas-skills@gabriel-skills || true

# gstack: precisa do Bun para instalar. Fica em ~/.claude/skills/gstack, como no Mac.
if [ ! -d "$HOME/.claude/skills/gstack" ]; then
  command -v bun >/dev/null 2>&1 || { curl -fsSL https://bun.sh/install | bash; export PATH="$HOME/.bun/bin:$PATH"; }
  mkdir -p "$HOME/.claude/skills"
  git clone -q --depth 1 https://github.com/garrytan/gstack.git "$HOME/.claude/skills/gstack" \
    && (cd "$HOME/.claude/skills/gstack" && ./setup --host claude --no-browser) || true
fi
