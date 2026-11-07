---
name: conselho
description: Conselho de IAs feito só com o Claude (sem OpenRouter, sem custo extra). Vários conselheiros com perspectivas diferentes respondem de forma independente, avaliam as respostas uns dos outros anonimamente e um presidente sintetiza a resposta final. Use quando o usuário disser "conselho", "pergunte ao conselho", "llm council", "quero várias opiniões", "segunda opinião", ou pedir que vários pontos de vista avaliem uma decisão, plano, código ou pergunta difícil.
argument-hint: "[pergunta] [rapido|profundo]"
---

# Conselho (somente Claude)

Inspirado no LLM Council do Karpathy, mas sem modelos externos: a diversidade vem de **papéis diferentes** e **contextos isolados**. Seja honesto com o usuário: é o mesmo modelo de base, então a independência é menor que a de um conselho com GPT/Gemini/Grok.

Pergunta: $ARGUMENTS (se vazio ou se referir à conversa, monte a pergunta a partir do contexto do chat).

## Modos
- **padrão**: 4 conselheiros + revisão cruzada (etapa 2 completa).
- **rapido**: 4 conselheiros, sem revisão cruzada; o presidente faz a avaliação.
- **profundo**: 5 conselheiros (inclui o "Usuário afetado") + revisão cruzada.

## Conselheiros
1. **Especialista** – rigor técnico e factual, melhores práticas, precisão.
2. **Cético** – advogado do diabo: riscos, falhas, suposições frágeis, o que pode dar errado.
3. **Pragmático** – custo, tempo, simplicidade, o que dá para executar já.
4. **Criativo** – alternativas não óbvias, reformular o problema, opções que ninguém considerou.
5. *(só no profundo)* **Usuário afetado** – a perspectiva de quem vai usar/sofrer as consequências.

## Passo 0 – Montar o dossiê
Escreva um **dossiê autocontido**: a pergunta + todo o contexto necessário (trechos de código, textos, restrições, objetivos do usuário). Os conselheiros não veem este chat.

## Etapa 1 – Opiniões independentes

**Se a ferramenta Agent estiver disponível (Claude Code):** lance TODOS os conselheiros em paralelo, numa única mensagem, uma chamada Agent por conselheiro (`subagent_type: general-purpose`). Prompt de cada um:

> Você é o conselheiro **<papel>** de um conselho. <descrição do papel>. Responda à pergunta abaixo de forma independente e completa, a partir da sua perspectiva, mas buscando a resposta correta (não só criticar). Se a pergunta envolver arquivos do projeto, você pode lê-los. Seja direto, ≤ 400 palavras, e termine com uma linha "CONCLUSÃO: ...".
> DOSSIÊ: <dossiê>

**Se não houver Agent (chat normal):** escreva cada opinião em sequência, uma por papel, assumindo de verdade a perspectiva de cada um sem olhar para as anteriores. Avise o usuário de que, neste modo, as opiniões são simuladas no mesmo contexto.

## Etapa 2 – Revisão anônima (pule no modo rapido)
1. Embaralhe as respostas e rotule como **Resposta A, B, C...** sem dizer qual papel escreveu cada uma. Guarde o mapeamento.
2. Com Agent: lance em paralelo um revisor por conselheiro (mesmos papéis). Prompt:
   > Você é o conselheiro **<papel>**. Abaixo está uma pergunta e respostas anônimas. Avalie cada uma (pontos fortes e fracos, erros factuais) e termine EXATAMENTE com:
   > RANKING FINAL:
   > 1. Resposta X
   > 2. Resposta Y
   > ...
   > PERGUNTA: <dossiê>
   > RESPOSTAS: <respostas rotuladas>
3. Sem Agent: faça você mesmo as avaliações, uma por papel, com o mesmo formato.
4. Calcule a **posição média** de cada resposta (menor = melhor) e desanonimize.

## Etapa 3 – Presidente (você)
Sintetize considerando as opiniões, o ranking e os pontos de consenso/divergência. Corrija erros apontados na revisão.

## Formato da resposta ao usuário
```
## Resposta do conselho
<síntese final, clara e acionável>

## Ranking dos conselheiros
| # | Conselheiro | Posição média |
...

## Consensos e divergências
- Concordaram em: ...
- Divergiram em: ... (quem defendeu o quê)

<details><summary>Opiniões individuais</summary>
### Especialista
...
</details>
```
Responda no idioma do usuário. Se houver uma opinião minoritária forte (o cético apontando um risco sério, por exemplo), destaque-a mesmo que tenha ficado mal ranqueada.
