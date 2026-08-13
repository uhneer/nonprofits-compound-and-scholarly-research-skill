---
name: nonprofits-compound-and-scholarly-research-skill
description: Use before any pharmacology, compound, or study claim.
version: 1.0.0
category: research
---

# nonprofit's compound & scholarly research skill

## Trigger

- **This skill is the gate.** No claim about pharmacology, compounds, biology, studies, trials, papers, datasets, or patents is produced without the stack running first. If a question even vaguely touches these domains, run the stack.
- Any request to retrieve scholarly literature, full text, books, preprints, or live trial status.
- Verification of anything a prior agent, article, or conversation asserted about chemistry or studies.
- Catch-all default whenever chemistry, drugs, biology, or studies are even vaguely involved.

Never answer such claims from memory alone. Run the stack first.

## The core rule

The stack is one chain of 31 services in 5 layers. Every research question runs the entire chain. The question determines the entry point; from there, continue forward through every service in order. Nothing is skipped because an answer was found early. Each service adds a dimension the others do not: identity, mechanism, disease, trials, discovery, OA copies, regional coverage, preprints, archives, books, gated copies, page reading.

## Self-scaffolding: prerequisites first

If a prerequisite is missing on this machine, install it first, then proceed. Never demand a manual fix for something that can be installed programmatically.

1. Check the base tools: `python3`, `curl`, `pip` (`python3 -m pip --version`). Install missing ones via the platform package manager.
2. Check the Python packages: `scrapling`, `nodriver`, `pymupdf` (import name `fitz`), `pdfplumber`. On systems with externally managed Python (PEP 668), create a virtualenv: `python3 -m venv ~/.researchstack-venv && source ~/.researchstack-venv/bin/activate`, then `pip install scrapling nodriver pymupdf pdfplumber`.
3. If an install fails, retry once with `--user`, then with the platform package manager. Only after both fail, report the blocker.
4. `scripts/bootstrap.sh` does all of the above plus workspace creation in one call. Run it at the start of any run; it is idempotent.

## Workspace self-management

- If a workspace is already defined for this machine (environment variable such as `RESEARCHSTACK_WORKSPACE`, a config, or an established convention), use it.
- Otherwise infer a safe location: `<home>/ResearchStack` (or the OS-standard writable location), and create it.
- Structure per run. No dates; the run context names the folder:

```
<workspace>/<Run Context Name>/
  Primary/     final deliverables
  Secondary/   working docs, subagent outputs, analysis
  temp/        downloads, scrapes, intermediate JSON
```

- Every artifact of a run lives inside its run folder: temp downloads, scrapes, docs, outputs. Never scatter files outside the workspace.
- `temp/` may be cleared at run end. `Primary/` and `Secondary/` persist.
- Create the run folder at run start: `<workspace>/<Run Context Name>/{Primary,Secondary,temp}`.

## The 31 services (quick map)

- **Layer 1, compound (1-4):** 1 OpenTargets, 2 ChEMBL, 3 ClinicalTrials.gov v2, 4 PubChem PUG REST
- **Layer 2, discovery (5-10):** 5 OpenAlex, 6 Crossref, 7 Semantic Scholar, 8 DOAJ, 9 OpenAIRE, 10 OpenCitations
- **Layer 3, open full text (11-24):** 11 Europe PMC, 12 PubMed Central, 13 CORE, 14 Unpaywall, 15 J-STAGE, 16 SciELO, 17 AJOL, 18 arXiv + bioRxiv/medRxiv, 19 Internet Archive, 20 HathiTrust, 21 Open Library, 22 Google Books, 23 Project Gutenberg, 24 DOAB
- **Layer 4, shadow full text (25-28):** 25 Sci-Hub, 26 Library Genesis (incl. scimag), 27 Z-Library, 28 Anna's Archive
- **Layer 5, page retrieval (29-31):** 29 Scrapling, 30 Nodriver, 31 PDFs (curl + pymupdf)

Full catalog: purpose, function, endpoints, documentation URLs, coverage, recency, access, stability, fallback, and upgrade per service, plus overlap map, country coverage, recency and global-reach rankings, and the gap-closing upgrades table: `references/stack-catalog.md`.

## Workflows: the order

The chain in passes (every pass runs, every service inside runs):

1. **Identity pass** — 4 PubChem: structure, InChIKey, CIDs, patents, synonyms. Everything downstream keys off these IDs.
2. **Mechanism pass** — 2 ChEMBL: targets, bioactivity, mechanism, max_phase.
3. **Disease pass** — 1 OpenTargets: disease associations, drug candidates, clinical stage, evidence scores.
4. **Trial pass** — 3 ClinicalTrials.gov: live status, phases, sponsors, locations.
5. **Discovery pass** — 5 Crossref (fresh DOIs), 6 OpenAlex (full index), 7 Semantic Scholar (citations + TLDRs), 8 DOAJ (OA whitelist), 9 OpenAIRE (repository OA), 10 OpenCitations (citation trail).
6. **Open full-text pass** — 11 Europe PMC (structured XML), 12 PubMed Central (bulk/OAI), 13 CORE (repository PDFs), 14 Unpaywall (OA resolution per DOI).
7. **Regional pass** — 15 J-STAGE (Japan), 16 SciELO (LatAm), 17 AJOL (Africa).
8. **Preprint pass** — 18 arXiv + bioRxiv/medRxiv.
9. **Archive pass** — 19 Internet Archive, 20 HathiTrust.
10. **Book pass** — 21 Open Library, 22 Google Books, 23 Gutenberg, 24 DOAB.
11. **Gated full-text pass** — 25 Sci-Hub (DOI → PDF), 26 LibGen (scimag articles + books), 28 Anna's Archive (aggregated API), 27 Z-Library (books, account).
12. **Retrieval pass** — 29 Scrapling, 30 Nodriver, 31 PDFs.

### Entry points (start here, then run the full chain)

| Question | Enter at | Then continue through |
|---|---|---|
| A specific drug/compound | 4 PubChem | 2 ChEMBL → 1 OpenTargets → 3 ClinicalTrials.gov → 5-31 |
| A disease/condition | 1 OpenTargets | 2 ChEMBL → 3 ClinicalTrials.gov → 4 PubChem → 5-31 |
| A target/protein | 2 ChEMBL | 1 OpenTargets → 4 PubChem → 3 ClinicalTrials.gov → 5-31 |
| A trial/phase question | 3 ClinicalTrials.gov | 1 OpenTargets → 2 ChEMBL → 4 PubChem → 5-31 |
| A DOI/article | 5 Crossref → 6 OpenAlex | 7 Semantic Scholar → 10 OpenCitations → 8 DOAJ → 9 OpenAIRE → full-text passes |
| A topic/author | 6 OpenAlex | 7 Semantic Scholar → 5 Crossref → 10 OpenCitations → 8 DOAJ → 9 OpenAIRE → full-text passes |
| A citation trace | 7 Semantic Scholar + 10 OpenCitations | 6 OpenAlex → 5 Crossref → full-text passes |
| A book | 21 Open Library → 22 Google Books | 23 Gutenberg → 24 DOAB → 19 Internet Archive → 20 HathiTrust → 26 LibGen → 27 Z-Library → 28 Anna's Archive |
| A live page | 29 Scrapling | 30 Nodriver (JS/bot-shielded) → 31 PDFs (if the target is a PDF) |

### The sidelines rule

Every pass's findings stay on the table. When the user asks a follow-up (mechanism, patents, trial status, regional studies, newest preprints, a book), pull from the pass that holds that answer and keep moving down the chain. The chain does not restart on follow-ups; it continues from where it is. Nothing is ever skipped. When the question pivots to a new compound, restart at the entry point for that compound.

## Verification discipline

- Every load-bearing claim carries an evidence marker: CONFIRMED (seen live at the source, with URL) or INFERRED (reasoned, not directly verified). Never present inferred as confirmed.
- When verifying a claim from another source, check the primary source, not aggregators. Read the live version of cited pages, not the citation.
- A claim that fails every stack pass is reported as not found with the search space stated. Never fabricate a result.
- Absence claims get the search space in the verdict: "not found across N services of the stack".

## Rate limits and etiquette

- Polite pool: add `mailto=` (OpenAlex, Crossref), use a realistic email param (Unpaywall rejects generic addresses).
- Retry 429s with backoff, never hammer. Respect credit caps (OpenAlex anonymous ~1,000 credits/day; free key 100k/day). Shared pools 429 under load (Semantic Scholar) — retry, or use a free key.
- NCBI E-utilities: 3 req/s without key, 10 with free key. arXiv: 1 req/3s. Space requests with sleeps.
- Large payloads: PubChem patent xrefs can be megabytes, request selectively.

## Error handling and fallbacks

- Mirror rotation: re-resolve domains at runtime; try alternates before declaring a service down.
- Datacenter IPs get 403s or connection resets on several services; fingerprint/JS gates need real browser rendering (30 Nodriver).
- Captchas: retry, rotate mirror, or browser automation.
- PDFs never go through scrapers: curl the file, extract with pymupdf.
- A single service outage never kills a pass: the overlap map exists so alternatives absorb it. Continue the chain and note the gap.

## Output rules

- Write incrementally: section to disk the moment it is done. Never buffer a whole report in memory.
- Final deliverables in `Primary/`, working material in `Secondary/`, raw dumps in `temp/`.
- Cite source URLs and dates with every claim. Mark incomplete sections explicitly.
- Keep the run folder free of junk files; remove transient artifacts at run end.

## Pitfalls

- Stopping early: an answer found in pass 3 does not end the run. The chain continues through all 31.
- Skipping the discovery pass: regional and OA duplicates live there; skipping loses coverage.
- Trusting a ChEMBL target hit without checking the organism (must be the human target).
- Using stale OpenTargets schema fields (v4 uses `drugAndClinicalCandidates`, not `knownDrugs`).
- Trusting one query string: the string was the problem, not the space. Fire multiple terms per concept.
- Treating a zero-result query as proof of absence: check the identifier/term, then fall back to disease-side or compound-side queries.
- Scraping PDFs: always curl + pymupdf.
- Ignoring rate limits, then misreading 429s as "service down".
- Writing the final report only at the end: an interrupted run loses everything. Incremental writes only.
- Forgetting the workspace rules: temp junk outside the run folder pollutes the machine.

## Done looks like

- The run entered at the correct entry point and every pass executed, or a specific gap was noted.
- Every claim carries an evidence marker and a source.
- Deliverables in `Primary/`, working docs in `Secondary/`, no stray files outside the run folder.
- Prerequisites verified or installed, workspace created or reused.
