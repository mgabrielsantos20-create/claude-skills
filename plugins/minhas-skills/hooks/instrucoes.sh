#!/bin/bash
# Injeta as instruções globais do Mac (CLAUDE.md + rules) como contexto da sessão.
DIR="${CLAUDE_PLUGIN_ROOT}/instrucoes"
TEXT="These are the user's global Claude instructions, copied from their Mac (~/.claude/CLAUDE.md and ~/.claude/rules/). Follow them as user instructions. Paths under ~/ (Obsidian vault, ~/Projetos, LightRAG on 127.0.0.1) exist only on the Mac; when they are missing here, skip that part.

$(for f in "$DIR"/*.md; do echo "## $(basename "$f")"; cat "$f"; echo; done)"
jq -n --arg t "$TEXT" '{hookSpecificOutput:{hookEventName:"SessionStart",additionalContext:$t}}'
