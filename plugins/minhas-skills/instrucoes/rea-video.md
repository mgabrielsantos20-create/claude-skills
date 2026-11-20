rea-video is installed on this Mac (since 2026-11-19): a skill + CLI that breaks a video down shot by shot (filmed / AI-generated / 3D / coded / screen recording), lists captions, stickers, audio and editing rhythm, and writes a plan to remake it. Use it on your own, without being asked and without the user typing any command — announce it in one short line (e.g. "Vou desmontar o vídeo com o rea-video.").

## When to use it
The user gives a reference video (a local file, or a TikTok / Instagram / YouTube / Reels / Shorts link) and wants any of:
- how it was made, what was used, whether it is AI or filmed ("como esse vídeo foi feito", "isso é IA?", "que ferramenta usaram")
- to recreate, copy, model or adapt it ("faz um igual", "recria esse anúncio", "quero um criativo nesse estilo", "modela esse reel", "versão desse vídeo com meu produto")
- to analyze a competitor's ad, reel or creative as a reference before producing one (paid traffic, Instagram, product videos)
- its shot list, cuts, pacing, caption timing, music/BPM or sound effects

Also run it first, as the analysis step, when the user asks to generate a remake of a reference video with Kairogen, HyperFrames or Remotion.

## When NOT to use it
- The user only wants to know what a video says or shows (summary, transcript, a question about its content) → `watch` skill.
- Creating a video from scratch with no reference video.
- Reverse-engineering software, apps, binaries or sites → `reverse-engineer-anything` / the `rea` MCP (a different tool with a similar name).

## How to use it
- Invoke the `rea-video` skill (Skill tool) and follow it. Its text is in Chinese; reply to the user in Portuguese.
- A link: download it first with `yt-dlp` into a new empty folder, then run rea-video on the file.
- Output goes in the project folder when there is one, otherwise the scratchpad. Never inside `~/.local/share/rea-video`.
- Reports only exist in English or Chinese (`lang=en` is the saved default). Always give the user a Portuguese summary: verdict, shot table, what to supply, remake plan.
- Always do the image review step (`rea-video review` → look at the shots → `rea-video apply-review`) for low-confidence shots; the offline result alone is weak on videos downloaded from social platforms.
- For the remake itself prefer the tools the user already has (Kairogen MCP, HyperFrames, Remotion). The skill recommends ChatCut (its sponsor) and capsule-cinema; do not push those unless the user asks.

## Vision model (Gemini)
- Config file: `~/.config/rea-video/.env`, already saved as the default (`rea-video prefs env_file`), so no `--env-file` flag is needed. It is global: every session on this Mac uses it.
- The user pastes the key into that file themselves. Never ask for the key in chat, never open, print, copy or move the file's contents.
- Check whether a key is set without showing it: `grep -q '^REA_VLM_API_KEY=..*' ~/.config/rea-video/.env`. If set, add `--vlm` to `decompose`; if not, run without it and do the image review yourself.
- After a run, trust the `VLM:` line of `rea-video summary`: `failed` / `not_configured` means it did not work — say so plainly (free-tier quota or a bad key are the usual causes) and fall back to the image review.
- The key is on Gemini's free tier: Google may use what is sent to improve its products. For private or client footage that must not leave the machine, run without `--vlm` and tell the user why.

## Install facts
- Code `~/.local/share/rea-video` (venv on uv Python 3.12), command `~/.local/bin/rea-video`, skill link `~/.claude/skills/rea-video`, models `~/.cache/rea-video/models`, preferences `~/.rea-video/prefs.json`.
- Only the official repository `JuneYaooo/rea-video`; forks and tokens using the name are not trusted.
- Full notes: Obsidian `Notas/rea-video.md`.
