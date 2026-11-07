---
name: crawl4ai
description: Raspa (scrape) e rastreia (crawl) sites gratuitamente com o crawl4ai instalado localmente, devolvendo Markdown limpo. É o substituto do Firecrawl quando os créditos dele acabarem. Use esta skill SEMPRE que uma ferramenta do Firecrawl (firecrawl_scrape, firecrawl_search, crawl etc.) falhar por falta de créditos, cota, plano ou pagamento (HTTP 402, "insufficient credits", "payment required", "upgrade your plan", limite excedido), e também quando o usuário pedir explicitamente o crawl4ai, uma raspagem gratuita/local, ou para extrair o conteúdo de um site, ler várias páginas de um domínio, baixar a documentação de um site em Markdown, ou pegar links de uma página e o Firecrawl não estiver disponível. Não use enquanto o Firecrawl estiver funcionando, a menos que o usuário peça.
---

# crawl4ai — raspagem local e gratuita

O usuário tem o Firecrawl como ferramenta principal. Esta skill é a reserva: quando o Firecrawl
recusar por créditos/cota, troque para o crawl4ai sem pedir permissão e avise em uma linha
("O Firecrawl ficou sem créditos, usei o crawl4ai local."). Depois continue a tarefa normalmente.

O crawl4ai roda um Chromium headless neste computador, então não custa nada, mas é mais lento
que o Firecrawl (alguns segundos por página) e não tem busca na web: para *buscar* algo, use
WebSearch e depois raspe os resultados com esta skill.

## Como usar

Rode o script incluído com o Python do sistema. Use o caminho absoluto, porque a pasta
Scripts do Python não está no PATH:

```bash
python "C:/Users/mgabr/.claude/skills/crawl4ai/scripts/crawl.py" URL [URL ...] [opções]
```

Por padrão ele salva um `.md` por página em `./crawl_output/` (relativo ao diretório atual)
e imprime um resumo JSON com título, tamanho e caminho de cada arquivo. Leia os arquivos
gerados para responder. Prefira salvar em arquivo em vez de `--stdout` quando forem várias
páginas ou páginas longas, para não encher o contexto.

| Opção | Quando usar |
|---|---|
| `--fit` | Quer só o conteúdo principal (tira menu, rodapé, barra lateral). Bom padrão para artigos e páginas de produto. |
| `--selector "main"` | Sabe qual parte da página interessa (seletor CSS). |
| `--deep 2 --max-pages 30` | Precisa de várias páginas do mesmo site (ex.: documentação inteira). Segue só links do mesmo domínio. |
| `--scroll` | Conteúdo que aparece ao rolar (feeds, listas infinitas). |
| `--wait-for ".classe"` | Página monta o conteúdo via JavaScript depois de carregar. |
| `--stealth` | Site bloqueia robôs (403, captcha, página vazia). |
| `--links` | Precisa da lista de links internos/externos. |
| `--stdout` | Uma página curta e você quer o texto direto na saída. |
| `--out pasta` | Escolher onde salvar. |

## Se der errado

- **Página vazia ou muito curta**: tente `--scroll` e/ou `--wait-for`; depois `--stealth`.
- **403/bloqueio**: `--stealth`. Se ainda falhar, avise o usuário: alguns sites exigem login ou
  bloqueiam qualquer robô, e não tente burlar captcha.
- **Timeout**: aumente com `--timeout 120`.
- **Erro de navegador não encontrado**: rode
  `"C:/Users/mgabr/AppData/Local/Python/pythoncore-3.14-64/Scripts/crawl4ai-setup.exe"` e tente de novo.
- **Para diagnóstico geral**: `crawl4ai-doctor.exe` na mesma pasta Scripts.

## Uso avançado

Para extração estruturada (ex.: tabela de preços em JSON) ou algo que o script não cobre,
escreva um script Python próprio com a API (`AsyncWebCrawler`, `CrawlerRunConfig`,
`JsonCssExtractionStrategy`) em um arquivo — não use `python -c`, porque o crawl4ai chama
`load_dotenv()` ao ser importado e quebra sem um arquivo de script. Use o `crawl.py` como
exemplo de configuração.

Respeite os termos dos sites e não raspe áreas logadas ou dados pessoais sem o usuário pedir.
