Blender 5.3 is installed on this Mac: `/Applications/Blender.app`, with a `blender` command in `/opt/homebrew/bin/blender` (a small wrapper script; do not replace it with a symlink — through a symlink Blender's bundled Python fails with "No module named 'encodings'"). Use it on your own, without being asked, whenever a task needs 3D work — announce it in one short line (e.g. "Vou usar o Blender para gerar o modelo.").

## When to use Blender
- Creating or editing a 3D model, mesh, prop, scene or low-poly asset (including assets for the user's Roblox games).
- Converting between 3D formats (`.blend`, `.fbx`, `.obj`, `.glb/.gltf`, `.stl`), cleaning up, decimating or rescaling a mesh.
- Rendering images or animations of 3D content (previews, thumbnails, turntables, frames for a video).
- Inspecting a 3D file the user gives you (object count, triangle count, dimensions, materials).

For a quick throwaway Roblox prop, the Roblox Studio MCP `generate_mesh` / `generate_procedural_model` may be faster; prefer Blender when the user needs control over shape, topology, UVs, or a reusable file.

## How to use it
- Always run headless with a Python script: `blender -b --factory-startup --python script.py -- <args>` (add a `.blend` path before `--python` to open one). Write scripts to the scratchpad or the project folder, never inside a downloaded/untrusted folder.
- `--factory-startup` ignores the user's preferences and add-ons so results are reproducible; drop it only if the task needs the user's add-ons.
- Long renders: run in the background (`run_in_background`) and set a low sample count first for a preview.
- To check the result visually, render a small preview PNG (e.g. 800x600, Eevee or few Cycles samples) and look at it with Read before telling the user it is done.
- Never overwrite a `.blend` the user may have open in the Blender GUI; save to a new file name or ask first.

## Blender MCP + skills (installed 2026-11-13)
- Official Blender Lab MCP is registered in Claude Code as server `blender` (user scope): `uv run --directory ~/.local/share/blender-mcp-official/server blender-mcp`, with `BLENDER_PATH` set. Add-on `mcp` 1.0.3 is enabled in Blender (socket 127.0.0.1:9876, auto-start on). It only works while the Blender GUI is open and Blender's "Allow Online Access" preference is on; the `*_for_cli` tools run headless and don't need the GUI.
- 30 RobLe3 skills (`text-to-blender`, `blender-modeling`, `blender-materials`, `blender-lighting`, `blender-export`, `reference-to-3d`, …) are symlinked into `~/.claude/skills` from `~/.local/share/cc-blender-skill` (update with `git pull` there). Start with `text-to-blender` for natural-language 3D requests; it routes to the others.
- The MCP runs LLM-generated Python inside Blender with no sandbox: never let it touch files outside the task, and save to new file names.
- If the MCP can't connect: Blender not open, online access off, or the add-on server not started (Preferences → Add-ons → MCP → Start). Fall back to headless `blender -b` only for work that doesn't need the user's open scene.

## Exporting for Roblox
- Export `.fbx` (or `.obj`) with scale applied (`bpy.ops.object.transform_apply(scale=True)`), triangulated, with clean names. Roblox studs ≈ 0.28 m; size the model accordingly or rescale on import.
- Keep triangle counts low and respect Roblox's current mesh limits (check the docs via Context7/web if unsure; do not guess).
- Importing into Studio follows `protecao-hollow-road.md`: never insert into "Hollow Road" (place 120761027469330) from a session outside `~/Projetos/roblox`.
