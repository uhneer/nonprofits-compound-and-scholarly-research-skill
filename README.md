# Nonprofits Compound & Scholarly Research

A self-scaffolding agent skill that acts as the gate before any claim about pharmacology, compounds, biology, studies, trials, or papers is made or answered. One chain of 31 free, no-account research services across 5 layers, with entry points chosen by the question and the full chain run every time.

Point your agent at this repo and tell it to download the skill. Everything it needs is here: `SKILL.md`, the full service catalog, and a bootstrap script that installs prerequisites and sets up the workspace on its own.

## What this skill is

- **The gate.** No claim about pharmacology, compounds, biology, studies, trials, papers, datasets, or patents is produced without the stack running first. If a question even vaguely touches these domains, the stack runs.
- **Full-surface coverage.** 31 services spanning compound identity, mechanisms, disease associations, live trial status, global literature discovery, open full text, regional literatures, preprints, scanned archives, books, shadow full text, and page retrieval.
- **No account, no cost.** Every service in the chain is usable without registration (a few have optional free keys that raise limits; a handful of book/shadow services need a free account or optional upgrade, noted per service).
- **Overlap by design.** Services deliberately overlap so no metadata or full text falls through a crack when a mirror dies or an index lags.
- **Self-scaffolding.** If a prerequisite (scrapling, nodriver, pymupdf, pdfplumber) is missing on the machine, the skill installs it and proceeds. It never demands a manual fix for something installable.
- **Self-managing workspace.** All run artifacts (temp downloads, scrapes, working docs, final deliverables) live in a run-context-named folder under the workspace, split into `Primary/`, `Secondary/`, and `temp/`.

## The 31 services

| # | Service | Layer | Purpose |
|---|---|---|---|
| 1 | OpenTargets | Compound | disease → targets + drug candidates + clinical stage (GraphQL) |
| 2 | ChEMBL | Compound | target → all compounds, bioactivity, mechanism, max_phase |
| 3 | ClinicalTrials.gov v2 | Compound | compound/condition → live trial status, phases, sponsors |
| 4 | PubChem PUG REST | Compound | compound → structure, IDs, synonyms, patents, bioassays |
| 5 | OpenAlex | Discovery | the global scholarly index, 324M works, concepts, OA links |
| 6 | Crossref | Discovery | the DOI backbone, real-time registration |
| 7 | Semantic Scholar | Discovery | citation graph, TLDRs, openAccessPdf |
| 8 | DOAJ | Discovery | open-access journal whitelist, all languages |
| 9 | OpenAIRE | Discovery | repository-hosted OA aggregation |
| 10 | OpenCitations | Discovery | the citation ledger (COCI) |
| 11 | Europe PMC | Open full text | structured full-text XML for biomedicine |
| 12 | PubMed Central | Open full text | OA repository, OAI-PMH + FTP bulk paths |
| 13 | CORE | Open full text | repository PDFs, working downloadUrl without a key |
| 14 | Unpaywall | Open full text | DOI → legal OA copy resolver |
| 15 | J-STAGE | Open full text | Japan, chemistry-heavy journals, keyless search API |
| 16 | SciELO | Open full text | Latin America, Spanish/Portuguese, OAI-PMH |
| 17 | AJOL | Open full text | Africa, OAI-PMH |
| 18 | arXiv + bioRxiv/medRxiv | Open full text | preprints, same-day science |
| 19 | Internet Archive | Open full text | scanned backfiles, international collections |
| 20 | HathiTrust | Open full text | scanned corpus, public-domain full view |
| 21 | Open Library | Open full text | book metadata + public-domain reading |
| 22 | Google Books | Open full text | the largest book index, snippet preview |
| 23 | Project Gutenberg | Open full text | public-domain text |
| 24 | DOAB | Open full text | peer-reviewed open-access books |
| 25 | Sci-Hub | Shadow full text | DOI → PDF for publisher-gated articles |
| 26 | Library Genesis | Shadow full text | books + scimag article database |
| 27 | Z-Library | Shadow full text | books, free account, premium optional |
| 28 | Anna's Archive | Shadow full text | the aggregator, official JSON API, MCP server |
| 29 | Scrapling | Page retrieval | fetch pages the indexes only link to |
| 30 | Nodriver | Page retrieval | undetected Chrome for JS shells and fingerprint gates |
| 31 | PDFs | Page retrieval | curl + pymupdf extraction, never scrape a PDF |

## How it works

The stack is one chain of all 31 services. Every research question runs the entire chain. The question determines the entry point; from there the run continues forward through every service in order:

1. **Identity pass** — PubChem (structure, IDs, patents)
2. **Mechanism pass** — ChEMBL (targets, bioactivity, mechanism, phase)
3. **Disease pass** — OpenTargets (associations, candidates, stage)
4. **Trial pass** — ClinicalTrials.gov (live status)
5. **Discovery pass** — Crossref, OpenAlex, Semantic Scholar, DOAJ, OpenAIRE, OpenCitations
6. **Open full-text pass** — Europe PMC, PubMed Central, CORE, Unpaywall
7. **Regional pass** — J-STAGE, SciELO, AJOL
8. **Preprint pass** — arXiv, bioRxiv/medRxiv
9. **Archive pass** — Internet Archive, HathiTrust
10. **Book pass** — Open Library, Google Books, Gutenberg, DOAB
11. **Gated full-text pass** — Sci-Hub, LibGen, Anna's Archive, Z-Library
12. **Retrieval pass** — Scrapling, Nodriver, PDFs

Entry point examples: a drug starts at PubChem then ChEMBL then OpenTargets then ClinicalTrials.gov then the rest; a disease starts at OpenTargets; a target starts at ChEMBL; a DOI starts at Crossref then OpenAlex; a book starts at Open Library and Google Books; a live page starts at Scrapling. Whatever the entry point, the whole chain runs, and follow-up questions pull from passes already on the table (the sidelines rule) without restarting.

## Features

- **Self-scaffolding bootstrap:** `scripts/bootstrap.sh` checks python3/curl, creates a virtualenv when the system Python is externally managed, installs scrapling, nodriver, pymupdf, and pdfplumber if missing, and ensures the workspace exists. Idempotent, run it at the start of any run.
- **Workspace management:** uses `RESEARCHSTACK_WORKSPACE` if set, else an established convention, else `<home>/ResearchStack`. Every run gets a context-named folder with `Primary/` (final deliverables), `Secondary/` (working docs), and `temp/` (downloads, scrapes, intermediate JSON). No dates; the run context names the folder.
- **Verification discipline:** every load-bearing claim carries an evidence marker (CONFIRMED with source URL, or INFERRED). Primary sources beat aggregators. Absence claims state the search space.
- **Documented rate limits and etiquette:** polite pools, 429 backoff, credit caps, per-service request pacing.
- **Error handling and fallbacks:** mirror rotation re-resolution, datacenter-IP block workarounds, fingerprint-gate handling via Nodriver, PDF extraction rules, and the overlap map so a single outage never kills a pass.
- **Full service catalog:** `references/stack-catalog.md` holds purpose, function, endpoints, documentation URLs, coverage, recency, access, stability, fallback, and upgrade for every service, plus the overlap map, country/regional coverage, recency and global-reach rankings, and the gap-closing upgrades table.

## Installation

Clone or copy this repo into your agent's skills directory, or point your agent at this URL and say "download this skill":

```
git clone https://github.com/uhneer/nonprofits-compound-and-scholarly-research
```

Then place the `SKILL.md` file (with the `references/` and `scripts/` folders beside it) into your agent's skills folder. Common locations are `~/.claude/skills/`, `~/.hermes/skills/`, or whatever directory your agent reads skills from.

No configuration needed. The first run installs missing prerequisites itself and creates its workspace.

## Requirements

- `python3` and `curl` (installed via the platform package manager if missing; the bootstrap tells you)
- Python packages `scrapling`, `nodriver`, `pymupdf`, `pdfplumber` (auto-installed by the bootstrap)
- An internet connection. Most services are keyless; optional free keys raise limits (documented in the catalog).

## File layout

```
SKILL.md                        the skill itself: trigger, workflow, rules
references/stack-catalog.md     full 31-service catalog with docs, limits, fallbacks
scripts/bootstrap.sh            self-scaffolding: prerequisites + workspace
README.md                       this file
LICENSE                         MIT
```

## Notes

- Mirror-based services (Sci-Hub, LibGen, Z-Library, Anna's Archive) rotate domains; the skill re-resolves at runtime and falls back across them.
- Some services block datacenter IPs or use fingerprint JS gates; the skill's Layer 5 (Scrapling, Nodriver) exists exactly for that.
- A few closed regional literatures (China CNKI, Russia eLibrary, Taiwan Airiti, MENA Al Manhal) have no API of any kind; the catalog documents what does exist.
