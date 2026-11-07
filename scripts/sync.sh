#!/bin/bash
# Copia ~/.claude/skills para o plugin e envia ao GitHub.
# Fica de fora: gstack (repo próprio, binários grandes), skills que dependem dele (.gstack-owned) e synced (gerida pelo app).
set -euo pipefail
REPO="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$HOME/.claude/skills"
DEST="$REPO/plugins/minhas-skills/skills"

EXCLUDES=(--exclude gstack/ --exclude synced/ --exclude .DS_Store --exclude .git/)
for d in "$SRC"/*/; do
  [ -f "$d/.gstack-owned" ] && EXCLUDES+=(--exclude "$(basename "$d")/")
done

rsync -a --delete "${EXCLUDES[@]}" "$SRC/" "$DEST/"

# Instruções globais: CLAUDE.md + rules. O repo é público, então ficam de fora as regras
# que só valem no Mac e expõem dados pessoais (Obsidian/LightRAG, Hollow Road),
# e o caminho do usuário vira ~.
INSTR="$REPO/plugins/minhas-skills/instrucoes"
mkdir -p "$INSTR"
rsync -a --delete --delete-excluded --exclude "obsidian.md" --exclude "protecao-hollow-road.md" --include "*.md" --exclude "*" \
  "$HOME/.claude/rules/" "$INSTR/"
cp "$HOME/.claude/CLAUDE.md" "$INSTR/CLAUDE.md"
sed -i '' "s#$HOME#~#g" "$INSTR"/*.md

cd "$REPO"
git add -A
if ! git diff --cached --quiet; then
  git commit -q -m "sync skills $(date +%Y-%m-%d)"
  git push -q
  echo "skills enviadas"
else
  echo "nada mudou"
fi
