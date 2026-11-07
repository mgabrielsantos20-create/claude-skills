The user wants ALL installed skills to be used at the right moments WITHOUT ever having to ask for them. This applies to every skill in the available skills list, not only the areas below.

How to apply, on every user request:
1. Before answering or acting, scan the available skills list and ask: "is there a skill whose purpose matches this task?" The user writes in Portuguese while most skill descriptions are in English — match by meaning, not by keyword (e.g. "tráfego pago" = paid ads, "petição/contrato" = legal, "painel" = dashboard).
2. If one fits, invoke it with the Skill tool FIRST, then do the work. Announce it in one short line (e.g. "Usando contract-review + legal-risk-assessment.").
3. Use the 1-3 most relevant skills, not every loosely related one. When several installed skills overlap (e.g. frontend-design exists in several plugins), prefer the one named in the map below.
4. Skip skills only for trivial requests: quick factual questions, small edits, casual conversation.

## Preferred skill per area (tie-breaker for overlaps)

## Jurídico (direito brasileiro)
- Analisar/revisar/redigir contrato, cláusulas, aditivo → `contract-review` (+ `legal-risk-assessment` se houver risco a classificar)
- Avaliar risco jurídico, exposição, chance de êxito, parecer → `legal-risk-assessment`
- NDA / acordo de confidencialidade → `nda-triage`
- Privacidade, proteção de dados, LGPD, DPA, pedido de titular → `compliance`
- Peça, petição, parecer ou contrato que precise sair em Word/PDF → também `anthropic-skills:docx` ou `anthropic-skills:pdf`
These legal skills were written for US/corporate practice. Always adapt to Brazilian law: cite Brazilian legislation (CF, CC, CPC, CDC, CLT, LGPD etc.) and case law only when you are sure of it, never invent articles, súmulas or decisions, and flag what the user must verify.

## Dashboards, dados e planilhas
- Qualquer gráfico, dashboard, painel, KPI, relatório visual → `dataviz` (+ `impeccable` se for uma interface/app de dashboard)
- Consultas SQL → `sql-queries`
- Planilha Excel/CSV (criar, analisar, fórmulas) → `anthropic-skills:xlsx`

## Sites e landing pages
- Criar site ou landing page nova → `taste-skill` (+ `marketing-skills:copywriting` para os textos)
- Melhorar/refazer um site existente → `redesign-skill`
- Polir, auditar ou ajustar UI (layout, tipografia, cores, responsivo) → `impeccable`
- Aumentar conversão, CTA, formulário, "o site não converte" → `marketing-skills:cro`
- SEO, Google, ranqueamento → `marketing-skills:seo-audit` (dados estruturados: `marketing-skills:schema`)
- Site lento, Core Web Vitals → `rampstack-skills:performance-optimization`
- Parecer app no celular → `mobile-native`; animações → `animate`

## Tráfego pago e marketing
- Estratégia/estrutura de campanha, Meta Ads, Google Ads, verba, público → `marketing-skills:ads` (+ `rampstack-skills:paid-media-strategy` para plano completo)
- Criativos, textos e roteiros de anúncio → `marketing-skills:ad-creative`
- Analisar resultados, CPA, ROAS, CTR, "a campanha não performa" → `rampstack-skills:ads-performance-analytics`
- Página de destino da campanha → `marketing-skills:cro`
- Textos de venda em geral → `marketing-skills:copywriting`; oferta → `marketing-skills:offers`
- Instagram orgânico → a skill `instagram-skills:ig-*` correspondente (legenda, carrossel, perfil, hashtags, planejamento)

## Design
- Interface/produto (telas, componentes, app) → `impeccable`
- Crítica ou feedback de um design → `design:design-critique`
- Identidade visual, marca → `rampstack-skills:brand-identity`; logo → `rampstack-skills:logo-design`
- Acessibilidade → `design:accessibility-review`
- Apresentação/slides → `anthropic-skills:pptx`

## Any other area
Areas not listed here (documents, Obsidian, animation, 3D, finance models, Instagram, SEO, emails, MCP/plugins, etc.) follow the same rule: find the fitting skill in the available skills list and use it.
