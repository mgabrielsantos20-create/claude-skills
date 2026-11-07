"""Crawl one or more URLs with crawl4ai and save clean Markdown.

Free, local alternative to Firecrawl (runs a headless Chromium on this machine).

Examples:
  python crawl.py https://example.com
  python crawl.py https://a.com https://b.com --out pasta_saida
  python crawl.py https://docs.site.com --deep 2 --max-pages 30
  python crawl.py https://site.com --fit --selector "main"
  python crawl.py https://site.com --scroll --wait-for ".produto"
  python crawl.py https://site.com --stdout
"""
import argparse
import asyncio
import json
import os
import re
import sys
from pathlib import Path
from urllib.parse import urlparse

os.environ.setdefault("CRAWL4AI_NO_CLOUD_NOTICE", "1")
CALLER_CWD = Path.cwd()
# crawl4ai calls load_dotenv() on import, which needs a real working directory.
os.chdir(Path(__file__).resolve().parent)

for stream in (sys.stdout, sys.stderr):
    try:
        stream.reconfigure(encoding="utf-8", errors="replace")
    except AttributeError:
        pass

from crawl4ai import (  # noqa: E402
    AsyncWebCrawler,
    BFSDeepCrawlStrategy,
    BrowserConfig,
    CacheMode,
    CrawlerRunConfig,
    DefaultMarkdownGenerator,
    DomainFilter,
    FilterChain,
    PruningContentFilterLXML,
)


def slugify(url: str) -> str:
    p = urlparse(url)
    slug = (p.netloc + p.path).strip("/") or "pagina"
    slug = re.sub(r"[^A-Za-z0-9._-]+", "_", slug)
    return slug[:120]


def pick_markdown(result, fit: bool) -> str:
    md = result.markdown
    if md is None:
        return ""
    if fit and getattr(md, "fit_markdown", None):
        return md.fit_markdown
    return getattr(md, "raw_markdown", None) or str(md)


async def run(args) -> int:
    browser_cfg = BrowserConfig(headless=not args.show_browser, verbose=False, enable_stealth=args.stealth)

    md_gen = DefaultMarkdownGenerator(
        content_filter=PruningContentFilterLXML(threshold=0.48, threshold_type="fixed") if args.fit else None
    )

    deep = None
    if args.deep:
        domains = sorted({urlparse(u).netloc for u in args.urls})
        deep = BFSDeepCrawlStrategy(
            max_depth=args.deep,
            max_pages=args.max_pages,
            include_external=False,
            filter_chain=FilterChain([DomainFilter(allowed_domains=domains)]),
        )

    run_cfg = CrawlerRunConfig(
        cache_mode=CacheMode.BYPASS,
        markdown_generator=md_gen,
        css_selector=args.selector,
        excluded_tags=["nav", "footer", "aside"] if args.fit else None,
        wait_for=args.wait_for,
        scan_full_page=args.scroll,
        remove_overlay_elements=True,
        remove_consent_popups=True,
        magic=args.stealth,
        page_timeout=args.timeout * 1000,
        deep_crawl_strategy=deep,
        verbose=False,
    )

    results = []
    async with AsyncWebCrawler(config=browser_cfg) as crawler:
        for url in args.urls:
            out = await crawler.arun(url=url, config=run_cfg)
            results.extend(out if isinstance(out, list) else [out])

    out_dir = Path(args.out).resolve()
    if not args.stdout:
        out_dir.mkdir(parents=True, exist_ok=True)

    summary, ok = [], 0
    for r in results:
        entry = {"url": r.url, "success": bool(r.success), "status": r.status_code}
        if not r.success:
            entry["error"] = (r.error_message or "")[:300]
            summary.append(entry)
            continue
        ok += 1
        md = pick_markdown(r, args.fit)
        title = " ".join(((r.metadata or {}).get("title") or "").split()) or None
        entry.update({"title": title, "chars": len(md)})
        if args.links:
            links = r.links or {}
            entry["links_internal"] = [l.get("href") for l in links.get("internal", [])][:200]
            entry["links_external"] = [l.get("href") for l in links.get("external", [])][:200]
        if args.stdout:
            print(f"\n<!-- {r.url} -->\n{md}")
        else:
            path = out_dir / f"{slugify(r.url)}.md"
            path.write_text(f"<!-- fonte: {r.url} -->\n\n{md}", encoding="utf-8")
            entry["file"] = str(path)
        summary.append(entry)

    report = {"pages_ok": ok, "pages_failed": len(results) - ok, "pages": summary}
    if not args.stdout:
        (out_dir / "_resumo.json").write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8")
    print(json.dumps(report, ensure_ascii=False, indent=2), file=sys.stderr if args.stdout else sys.stdout)
    return 0 if ok else 1


def main() -> int:
    ap = argparse.ArgumentParser(description="Crawl URLs com crawl4ai e salva Markdown limpo.")
    ap.add_argument("urls", nargs="+", help="Uma ou mais URLs")
    ap.add_argument("--out", default="crawl_output", help="Pasta de saída (padrão: ./crawl_output)")
    ap.add_argument("--stdout", action="store_true", help="Imprime o Markdown em vez de salvar arquivos")
    ap.add_argument("--fit", action="store_true", help="Remove menus/rodapés e mantém só o conteúdo principal")
    ap.add_argument("--selector", help="Seletor CSS para limitar a extração (ex.: 'main', 'article')")
    ap.add_argument("--deep", type=int, default=0, help="Segue links internos até esta profundidade")
    ap.add_argument("--max-pages", type=int, default=20, help="Limite de páginas no modo --deep (padrão 20)")
    ap.add_argument("--scroll", action="store_true", help="Rola a página inteira (conteúdo carregado ao rolar)")
    ap.add_argument("--wait-for", help="Espera um seletor CSS ('css:.x') ou condição JS ('js:() => ...')")
    ap.add_argument("--stealth", action="store_true", help="Modo anti-bloqueio para sites que recusam robôs")
    ap.add_argument("--links", action="store_true", help="Inclui a lista de links no resumo")
    ap.add_argument("--show-browser", action="store_true", help="Abre o navegador visível (debug)")
    ap.add_argument("--timeout", type=int, default=60, help="Timeout por página em segundos (padrão 60)")
    args = ap.parse_args()
    if args.wait_for and not args.wait_for.startswith(("css:", "js:")):
        args.wait_for = f"css:{args.wait_for}"
    # Relative --out is relative to where the script was called from, not the script's own folder.
    args.out = str(CALLER_CWD / args.out)
    return asyncio.run(run(args))


if __name__ == "__main__":
    sys.exit(main())
