#!/bin/bash
# Fora do Mac, instala o gstack (repo próprio com binários por plataforma) em segundo plano.
[ "$(uname)" = Darwin ] && exit 0
[ -d "$HOME/.claude/skills/gstack" ] && exit 0
(
  mkdir -p "$HOME/.claude/skills"
  git clone -q --depth 1 https://github.com/garrytan/gstack.git "$HOME/.claude/skills/gstack" \
    && cd "$HOME/.claude/skills/gstack" && ./setup --host claude --no-browser
) >/tmp/gstack-install.log 2>&1 &
exit 0
