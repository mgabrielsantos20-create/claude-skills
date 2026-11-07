# claude-skills

Marketplace privado com as skills pessoais do Gabriel, para que projetos abertos na nuvem (ou em outra máquina) tenham as mesmas skills.

- `scripts/sync.sh` copia `~/.claude/skills` para `plugins/minhas-skills/skills` e faz push.
- O hook global `~/.claude/hooks/ligar-skills.sh` adiciona este marketplace ao `.claude/settings.json` de cada projeto git aberto no Mac.
- Fora do plugin: `gstack` e as skills que dependem dele, e a pasta `synced`.
- Instruções globais (`~/.claude/CLAUDE.md` e `~/.claude/rules/`) vão em `instrucoes/` e entram na sessão por um hook do plugin.
- Fora do Mac, o plugin instala o gstack (e as skills dele) de github.com/garrytan/gstack.
- MCPs em `.mcp.json`. Os que pedem chave leem variáveis de ambiente: `STITCH_API_KEY`, `TWENTYFIRST_API_KEY`, `CONTEXT7_API_KEY`. O `rea` fica de fora (só roda no Mac).
