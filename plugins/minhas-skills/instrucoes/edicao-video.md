Four free, local video tools are installed on this Mac (since 2026-11-25). Use them on your own, without being asked, in any chat or project — announce it in one short line (e.g. "Vou editar com o heditor."). Notes: Obsidian `Notas/GitHub - o que baixar para vídeo e motion (25-11-2026).md`.

## When to use each
- **heditor** (skill `heditor`, command `~/.local/bin/heditor`): the user gives a recording of someone talking (talking head, class, live, podcast) and wants it edited into a Reel/Short/TikTok or a long video, with cuts, captions, motion, sound effects and music. Invoke the skill and follow it.
- **motionmaxxing** (skill `motionmaxxing`): the user wants a motion-graphics film with no footage (product promo, launch, feature reveal, ad, kinetic type), or wants an existing motion fixed or critiqued. Use it together with the user's approved style (memory `estilo-motion-aprovado`, Obsidian `Notas/Biblioteca de referências de motion (23-11-2026).md`). With a reference video, run `rea-video` first.
- **auto-editor** (`auto-editor video.mp4 --margin 0.2sec -o out.mp4`): only remove silence from a recording, nothing else.
- **whisper.cpp** (`whisper-cli -m ~/.cache/whisper-cpp/ggml-large-v3-turbo.bin -l pt -f audio.wav -ml 1 -sow -ojf`): local transcription with word timestamps, for captions or to sync animation to speech. Input must be WAV 16 kHz mono (`ffmpeg -i in.mp4 -ar 16000 -ac 1 audio.wav`).

## Rules
- Never overwrite the user's original recording; write to a new file.
- Voice and music: motionmaxxing has no ElevenLabs key here, so it renders without voice or music. Narration comes from Kairogen (the user's paid plan); never ask for an ElevenLabs key in chat.
- Follow the user's video preferences in memory (`video-preferencias-gabriel`, `sem-som-de-brilho`, `video-fit-duration-keep-content`).
- heditor brand data is in `~/.heditor/brand.json`. Set on 2026-11-25 by the user's choice: default brand is personal ("Gabriel Santos"), handle left empty ("sem @ por enquanto"), default heditor colors kept, no logo. While the handle is empty, leave the @ out of follow cards and CTAs (the templates print it as is); never invent one. For a video of another brand (Autoescola Visão @cfcvisao, CNH Ágil, JuridIApp), use that brand's name, colors and logo from the Obsidian project notes for that edit instead of the default.
- Both skills are new projects (Oct 2026). Check the render yourself (frames + audio) before saying it is done.

## Install facts
- heditor: code `~/.local/share/heditor`, data `~/.heditor` (venv on Python 3.12, assets), check with `heditor doctor`. Update: `git -C ~/.local/share/heditor pull && heditor setup`.
- motionmaxxing: code `~/.local/share/motionmaxxing`. Update: `git -C ~/.local/share/motionmaxxing pull`.
- auto-editor and whisper.cpp: Homebrew. Update: `brew upgrade auto-editor whisper-cpp`.
- Only the official repositories: `pycodebr/heditor`, `Tejashmakwana/motionmaxxing`, `WyattBlue/auto-editor`, `ggml-org/whisper.cpp`.
