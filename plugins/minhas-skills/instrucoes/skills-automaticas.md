Proactively use the `grilling` and `conselho` skills when a task calls for more depth — the user wants this without having to ask. Announce it in one short line (e.g. "Vou te fazer algumas perguntas antes de começar (grilling) — diga 'pula' se não quiser.") and proceed; if the user says "pula"/"sem perguntas"/"direto", skip it for that task.

## When to start with `grilling` (interview before acting)

Invoke the `grilling` skill BEFORE planning or writing code when the user starts something open-ended where their own decisions are still missing:
- a new project, app, site, feature, automation, or business/product idea
- a plan, strategy, or redesign described in a sentence or two, with goals, scope, audience, or constraints left unstated
- any request where you would otherwise have to guess at 2+ important decisions that only the user can make

Do NOT grill for: quick questions, small or well-specified edits, bug fixes with a clear symptom, factual lookups, or when the user already gave a detailed spec. Keep it to the decisions that matter.

## When to use `conselho` (multiple perspectives)

Invoke the `conselho` skill when the user faces a consequential decision with real trade-offs, where a single viewpoint could miss something:
- choosing between options (architecture, stack, vendor, approach, pricing, strategy)
- high-stakes or hard-to-reverse choices (legal, financial, security, data, launches)
- the user asks for an opinion, "o que você acha", "qual é melhor", or a review of an important plan/document

Use the `rapido` mode by default when invoking it on your own (saves usage); use the full mode only when the user asks or the stakes are clearly high. Do NOT convene the council for routine questions or tasks with one obvious answer.

## Combining them

For a new, important initiative: first `grilling` until the plan is clear, then `conselho` on the key decision(s) that remain, then execute.
