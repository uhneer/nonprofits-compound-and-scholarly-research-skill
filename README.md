# nonprofit's compound & scholarly research skill

**Any claim about a compound, drug, or study. Answered with receipts.**

One chain of 31 free, no-account research services. Structure, mechanism, disease, live trials, every paper ever written about the compound, every legal free copy of every paper, every region, every era, every book. Your agent stops guessing from memory and starts answering from primary sources, in a single run.

> 324M+ papers indexed · 5M+ Chinese-language works · 114k open-access full texts for one compound · 3M+ full-text articles · 300M+ repository records · 250M shadow-index records · 31 services · 5 layers · 0 accounts · $0

## The problem

Your agent answers from memory. It sounds confident, it sounds right, and it fails the first check.

- **Memory is not evidence.** Plausible-sounding claims about mechanisms, trials, and dosing die the moment they hit a primary source. This skill makes that moment happen before you hear the claim.
- **80% of full text sits behind paywalls.** Even when an agent finds the right paper, it can only quote the abstract.
- **The global indexes miss half the world.** Japanese, Latin American, and African literature barely register in Western search. Chinese core journals: only 24-37% covered by the big index.
- **Shallow mechanistic answers.** Most tooling knows a drug exists. It does not know what the drug binds, at what potency, in which assay, at what clinical phase.
- **Dead ends.** One API, one query, zero results, conclusion: "nothing exists." The query was the problem, not the space.

## Two ways to research a compound

**THE WAY EVERYTHING ELSE DOES IT:**

- One API, one query
- Abstracts at best, links at worst
- English-only bias
- Paywall after paywall
- "I couldn't find anything" = the end of the road

Timeline: hours of hunting, still incomplete.

**THE CHAIN:**

- 31 services, one run
- Full text retrieved, open and otherwise
- Japan, Latin America, Africa, Europe covered
- Patents, bioactivity, live trial status, books, backfiles
- "I couldn't find anything" = the chain keeps going anyway

Timeline: one run, complete record.

## How it works

**Five steps. One run.**

1. **Install.** Point your agent at this repo. The bootstrap checks python3 and curl, installs scrapling, nodriver, and pymupdf if missing, creates its own workspace. It does not ask you to fix anything it can fix itself.
2. **Ask anything.** A compound, a disease, a target, a DOI, a book, a claim that needs verifying.
3. **The chain picks your entry point.** A drug starts at PubChem (identity) → ChEMBL (mechanism) → OpenTargets (disease) → ClinicalTrials.gov (live trials) → then all 27 others in order. A disease starts at OpenTargets. A DOI starts at Crossref. A book starts at Open Library.
4. **All 31 run, every time.** Twelve passes: identity, mechanism, disease, trials, discovery, open full text, regional, preprints, archives, books, gated full text, page retrieval. Nothing is skipped because an answer was found early.
5. **The record stays on the table.** Every follow-up question pulls from what the chain already found. No restarting, no re-hunting, nothing missed.

## What you get

**31 services, 5 layers, one chain.** Every one live-verified, no accounts, no cost.

| Layer | Services | What it does |
|---|---|---|
| 1. Compound research | 1 OpenTargets, 2 ChEMBL, 3 ClinicalTrials.gov v2, 4 PubChem | Identity, bioactivity, mechanism, clinical stage, live trial status, structure, patents |
| 2. Article discovery | 5 OpenAlex, 6 Crossref, 7 Semantic Scholar, 8 DOAJ, 9 OpenAIRE, 10 OpenCitations | Every paper that exists, citations, TLDRs, OA whitelist, repository radar |
| 3. Full text, open infrastructure | 11 Europe PMC, 12 PubMed Central, 13 CORE, 14 Unpaywall, 15 J-STAGE, 16 SciELO, 17 AJOL, 18 arXiv + bioRxiv/medRxiv, 19 Internet Archive, 20 HathiTrust, 21 Open Library, 22 Google Books, 23 Gutenberg, 24 DOAB | Structured full text, repository PDFs, OA resolution, Japan, Latin America, Africa, preprints, scanned backfiles, books |
| 4. Full text, shadow infrastructure | 25 Sci-Hub, 26 Library Genesis, 27 Z-Library, 28 Anna's Archive | On-demand retrieval of publisher-gated content, four overlapping front ends |
| 5. Page retrieval | 29 Scrapling, 30 Nodriver, 31 PDFs | Reads the pages no index holds, passes bot gates, extracts PDFs |

**The depth most agents never reach:**

- Mechanistic action at the molecular level: IC50s, Ki values, assay-level bioactivity from ChEMBL
- Brand-new compounds: patents from PubChem are the earliest signal of anything
- Live human evidence: ClinicalTrials.gov daily, "is it in a human right now, and in which phase"
- Full text you can actually read: structured XML from Europe PMC, working PDF URLs from CORE, scanned 1950 volumes from Internet Archive
- The gated layer: anything the open layer cannot serve, four overlapping services can
- Evidence discipline: every claim carries CONFIRMED (with source URL) or INFERRED markers

**The operational machinery:**

- Self-scaffolding bootstrap: installs its own prerequisites, creates its workspace, idempotent
- Workspace management: every run gets a context-named folder with Primary/ (deliverables), Secondary/ (working docs), temp/ (downloads)
- Rate-limit etiquette built in: polite pools, 429 backoff, credit caps, per-service pacing
- Error handling: mirror rotation re-resolution, datacenter-IP workarounds, fingerprint-gate handling, PDF extraction rules
- The overlap map: services deliberately overlap, so no single outage ever kills a pass

## The math

**WITHOUT THIS SKILL:**

- Memory-guessed claims that need re-verification later
- Abstracts when you needed full text
- Western literature only
- Hours per compound, incomplete record

**WITH THIS SKILL:**

- 324M+ papers searchable in one index (OpenAlex)
- 185M+ DOIs, real-time registration (Crossref)
- 45M+ records, 114k open-access full texts for a single compound (Europe PMC)
- 300M+ repository records with working PDF URLs (CORE)
- 5M+ Chinese-language works, Japanese, Latin American, and African literature
- 250M records in one shadow index (Anna's Archive)
- Every region, every era, every book, every copy

**The translation:** one skill replaces thirty-one individual integrations, and covers what none of them cover alone. The whole chain costs nothing, and it never stops at "not found."

## Proof

Every service in this stack was live-probed on 2026-08-13. HTTP status and endpoint contracts are real, not assumed. The example that runs through the whole stack:

> aspirin → PubChem CID 2244, InChIKey BSYNRYMUTXBXSQ-UHFFFAOYSA-N → ChEMBL CHEMBL25, max_phase 4.0 → OpenTargets maximumClinicalStage APPROVAL → 241k Europe PMC hits, 114k of them open-access full text → 13.5k J-STAGE hits → complete record across all 31 services

## FAQ

**Is it really free?** Yes. Every service in the chain works without an account or payment. A few have optional free keys that raise rate limits (OpenAlex, Semantic Scholar, NCBI, CORE, Google Books); the shadow layer has one optional donation key (Anna's Archive) and one optional premium tier (Z-Library). None are required.

**What can it not find?** The genuinely closed literatures: China (CNKI/WanFang/CQVIP), Russia (eLibrary.ru), Taiwan (Airiti), the Arabic world (Al Manhal). No API exists for them, paid or otherwise. The FAQ on that is short: institutional subscriptions only.

**Is the shadow layer necessary?** The open layer covers everything legally free. The shadow layer covers the rest. The stack treats both as first-class: run the open passes first, the gated pass finishes the job.

**Is it stable?** The 31 legal services are as stable as their hosts. Mirror-based services rotate domains; the skill re-resolves at runtime and falls back across them. No single service outage kills a pass, that is what the overlap map is for.

**Which agents does it work with?** Any agent that can read a skills directory. No harness-specific code, no vendor lock-in.

**Does it need API keys to start?** No. Zero-configuration first run. Keys only matter if you want higher rate limits, and the skill tells you which ones are worth it.

**How do I know it is working?** Evidence markers on every claim, source URLs, and a workspace that shows exactly what ran and what it found.

## Installation

```
git clone https://github.com/uhneer/nonprofits-compound-and-scholarly-research-skill
```

Place the folder into your agent's skills directory (common paths: `~/.claude/skills/`, `~/.hermes/skills/`, or wherever your agent reads skills from), then ask. The first run installs its own prerequisites and creates its workspace. No configuration, no keys, no setup ceremony.

Requirements: python3, curl, an internet connection. The bootstrap handles the rest (`scripts/bootstrap.sh`).

## File layout

```
SKILL.md                        the skill: trigger, workflow, rules
references/stack-catalog.md     full 31-service catalog: endpoints, docs, limits, fallbacks, upgrades
scripts/bootstrap.sh            self-scaffolding: prerequisites + workspace
README.md                       this file
LICENSE                         MIT
```

---

# The Research Stack (full reference)

A full-surface research stack for compound/chemical research and article/literature research: 31 numbered services across 5 layers. Every service was live-probed on 2026-08-13; HTTP status and endpoint contracts are real. Mirror-based services rotate domains constantly, so treat their URLs as refreshable rather than fixed. No account is needed anywhere unless the entry says so.

- **Layer 1: Compound research (1-4)** — what a compound is, what it binds, what it treats, how far it got in humans.
- **Layer 2: Article discovery (5-10)** — metadata, OA status, citation graphs, journal whitelists.
- **Layer 3: Full text, open infrastructure (11-24)** — legal open copies, repositories, preprints, scanned archives, books.
- **Layer 4: Full text, shadow infrastructure (25-28)** — on-demand retrieval of publisher-gated content.
- **Layer 5: Page retrieval (29-31)** — reading pages that no index holds.

## Layer 1: Compound research (1-4)

This layer is the chemical backbone, and it reads like a funnel from the whole human experiment down to a single atom. Start with the questions: what is this thing, what does it grab, what does it treat, and has anyone tried it on people yet. The fun part is that each of these four answers a different question and hands you the exact keys the next one needs, so you rarely have to copy-paste anything by hand. OpenTargets gives you the strategic view: a disease, its targets, and the drugs aimed at them with their clinical stage, all scored by evidence, so you can see at a glance which bets the field has already placed. ChEMBL is the lab notebook: measured numbers, IC50s, Ki values, mechanism annotations, phase for every drug, which makes it the difference between knowing a compound exists and knowing what it actually does at the molecular level. ClinicalTrials.gov v2 is the live wire, the only service that tells you whether a compound is in a human right now and in which phase, updated daily. PubChem is the identity desk: give it a name and get SMILES, InChI, InChIKey, CIDs, synonyms, patents, bioassays, all in one call, which makes it the perfect entry point and the perfect ID resolver for everything downstream. Together they close the loop: structure, mechanism, disease, human evidence.

### 1. OpenTargets (GraphQL) — api.platform.opentargets.org/api/v4/graphql
- **Purpose:** disease → associated targets and drug candidates with clinical stage; target → diseases; drug → indications. Scored associations backed by genetics, somatic mutations, drug data, literature mining.
- **Function:** single GraphQL endpoint, everything in one query. Fields: `drug { id name maximumClinicalStage }`, evidence scoring per association, mechanism annotations, links to trials and literature. Verified: aspirin = CHEMBL25, maximumClinicalStage APPROVAL.
- **Coverage:** diseases, targets, drugs as worldwide entities; mechanism data sourced from ChEMBL, trial evidence from registries.
- **Recency:** periodic releases (multi-month cadence).
- **Access:** no key, no account.

### 2. ChEMBL (REST) — www.ebi.ac.uk/chembl/api
- **Purpose:** target → all compounds with measured bioactivity (IC50, Ki, EC50), mechanism of action, max_phase. Curated from medicinal-chemistry literature.
- **Function:** REST endpoints for molecules, targets, assays, activities, documents; compound search, target search, assay filters; max_phase per drug; cross-references to PubChem via UniChem; patent links via SureChEMBL. Verified: aspirin = CHEMBL25, max_phase 4.0.
- **Coverage:** worldwide literature, no country limitation. The quantitative bioactivity layer, not just drug existence.
- **Recency:** quarterly releases.
- **Access:** no key, no account.

### 3. ClinicalTrials.gov v2 (REST) — clinicaltrials.gov/api/v2/studies
- **Purpose:** compound or condition → live human-trial registry: overall status, phases, sponsors, locations, interventions, results.
- **Function:** full protocol-section records, filters by status/phase/country/intervention, nextPageToken pagination, JSON. The only API in the stack answering "is this being tested now, and in which phase."
- **Coverage:** worldwide registry. China (ChiCTR), Japan (jRCT), India (CTRI) keep national registries where some trials appear only; WHO ICTRP aggregates.
- **Recency:** daily updates, the most real-time API in the stack.
- **Access:** no key, no account.

### 4. PubChem PUG REST (REST) — pubchem.ncbi.nlm.nih.gov/rest/pug
- **Purpose:** compound → structure, identifiers (SMILES, InChI, InChIKey, CID), synonyms, properties, patent cross-references, bioassays, literature links.
- **Function:** PUG REST endpoints for property, xrefs (PatentID, MeSH, PubMed), synonyms, assay data; structure search by name/SMILES/InChI; JSON/XML/CSV output. Verified: aspirin = CID 2244, InChIKey BSYNRYMUTXBXSQ-UHFFFAOYSA-N, large patent ID list.
- **Coverage:** fully global. Note: patent xref responses can be megabytes, request selectively.
- **Recency:** continuous deposition, weekly-ish refresh.
- **Access:** no key, no account.

## Layer 2: Article discovery (5-10)

This is the seeing layer: it turns a compound into a literature map. The trick here is that these six overlap on purpose, so no metadata ever falls through a crack, but each still has a personality. OpenAlex is the atlas, 324M works, every discipline, every language, concept filters that let you jump from a compound to its mechanism to the papers about both, plus embedded OA links, which makes it the default answer to "what exists." Crossref is the receipt book: DOIs are registered here in real time, so it catches papers hours old that nobody else has indexed yet, and every DOI you will ever need traces back to it. Semantic Scholar is the social network of science: 2.49B citations, TLDR summaries so you can triage a paper without reading it, and an openAccessPdf field that shortcuts straight to a PDF when one exists. DOAJ is the quality filter: only genuine open-access journals, all languages, so you can trust that a hit there is really free and really peer-reviewed. OpenAIRE is the repository radar, catching the green-OA copies stashed in university repositories that publishers never advertise. OpenCitations is the citation ledger: follow a citation trail backward and forward to find what cites what, which is how you discover entire lineages of research on a compound. Run all six and you have every paper that exists about the compound, ranked by recency, with citation context and a head start on full text.

### 5. OpenAlex (REST) — api.openalex.org
- **Purpose:** the global scholarly index. One query across every discipline and language.
- **Function:** 324M works with abstracts (inverted index), concepts/topics filters, citations, OA PDF links embedded. Aggregates Crossref, DataCite, DOAJ, and regional sources; concept filtering gives compound → mechanism → papers.
- **Coverage:** the superset. 5M+ Chinese-language works, multilingual metadata, regional journals included. If metadata exists anywhere, this is the best first place to look.
- **Recency:** continuous ingestion, days.
- **Access:** no key, no account. Anonymous use credit-capped (~1,000 credits/day); free API key raises to 100,000/day. Mandatory-free-key policy announced but not enforced at probe date.

### 6. Crossref (REST) — api.crossref.org
- **Purpose:** the DOI backbone. 185M+ DOIs registered by publishers worldwide.
- **Function:** work metadata (title, authors, journal, dates, links), filters, real-time registration. Polite pool via `mailto=` param.
- **Coverage:** every DOI-depositing publisher, including regional society journals; multilingual via publisher metadata.
- **Recency:** real-time on registration, the freshest metadata source.
- **Access:** no key, no account.

### 7. Semantic Scholar (REST) — api.semanticscholar.org/graph/v1
- **Purpose:** citation graph + paper metadata + TLDR summaries.
- **Function:** 214M papers, 2.49B citations, `openAccessPdf` field, tldr endpoints, embedding endpoints.
- **Coverage:** all disciplines; chemistry journals included.
- **Recency:** continuous.
- **Access:** no key, shared unauthenticated pool (429s under load, retry). Free API key = guaranteed 1 req/s. Upgrade: the key is worth it if the pool is saturated.

### 8. DOAJ (REST) — doaj.org/api/v3
- **Purpose:** the open-access journal whitelist.
- **Function:** article and journal search over ~21,000 OA journals, ~12M articles, all languages. Full-text URLs in records.
- **Coverage:** worldwide multilingual OA journals, including non-English chemistry titles.
- **Recency:** as journals update.
- **Access:** no key, no account.

### 9. OpenAIRE (REST) — api.openaire.eu/search
- **Purpose:** repository-hosted OA aggregation, Europe-centric but worldwide.
- **Function:** publications/datasets/software search over EU-funded OA and linked repositories; OA full-text links.
- **Coverage:** green OA and repository content, multilingual metadata.
- **Recency:** continuous harvesting.
- **Access:** no key, no account.

### 10. OpenCitations (REST) — api.opencitations.net
- **Purpose:** the citation graph (COCI, ~1.8B citation links).
- **Function:** metadata and citation endpoints (`/meta/v1/metadata/doi:...`). Citations only, never full text.
- **Coverage:** Crossref-derived citations, worldwide.
- **Recency:** continuous.
- **Access:** no key, no account.

## Layer 3: Full text, open infrastructure (11-24)

This is the gratification layer: the actual words. Everything before this points at papers; this layer hands them to you. Europe PMC is the star for anything biomedical, because it serves the whole article as structured XML, sections and all, no scraping, no PDF parsing, which is the single most pleasant reading experience in this entire stack. PubMed Central is Europe PMC's raw sibling with its own bulk superpowers: OAI-PMH harvesting and FTP dumps if you ever want the entire open corpus locally. CORE is the repository diver: 300M+ records and it just hands you working PDF download URLs, theses and grey literature included, things no publisher site will ever show you. Unpaywall is the detective: give it a DOI and it tells you if a legal free copy exists anywhere on earth and where, which saves you from ever hitting a paywall by accident. Then the regional trio: J-STAGE for Japan (where the chemistry is excellent and the full text is free), SciELO for Latin America (Spanish and Portuguese journals you will not find in Western indexes), AJOL for Africa, each one a door into literature the global indexes only half-cover. arXiv and bioRxiv/medRxiv give you science before it is published, same-day preprints, which is where the newest compound findings actually live. Then the archives and books: Internet Archive is the time machine, scanned backfiles of old chemistry journals and out-of-print volumes with full-text search, HathiTrust is the same idea at library scale with public-domain full view, Open Library gives you book metadata plus public-domain reading, Google Books is the largest book index on earth with snippet previews, Project Gutenberg is public-domain text in its cleanest possible form, and DOAB is peer-reviewed open-access books. Between these fourteen you go from "there is a paper about this" to "here is the paper, here is the book, here is the preprint, here is the 1950 volume that started it all."

### 11. Europe PMC (REST) — www.ebi.ac.uk/europepmc/webservices/rest
- **Purpose:** the full-text layer for biomedicine.
- **Function:** search 45M+ records; `fullTextXML` endpoint returns the whole article as structured XML, no scraping; OPEN_ACCESS filter; chemical annotation service; links to ChEMBL/PubChem. Verified: 241k aspirin hits, 114k OA full text.
- **Coverage:** PubMed + PMC + preprints + patents + AgriKnowledge, worldwide.
- **Recency:** daily PubMed sync.
- **Access:** no key, no account.

### 12. PubMed Central (NCBI) — www.ncbi.nlm.nih.gov/pmc, eutils, OAI-PMH
- **Purpose:** the underlying OA full-text repository that Europe PMC mirrors, with its own bulk paths.
- **Function:** eutils efetch for OA full text; OAI-PMH for harvesting; FTP bulk dumps (ftp.ncbi.nlm.nih.gov/pub/pmc) for whole-corpus download.
- **Coverage:** 3M+ open-access articles, worldwide journals, some non-English.
- **Recency:** daily.
- **Access:** no key, no account (10 req/s with free NCBI key).
- **Fallback:** Europe PMC serves the same content with a friendlier REST surface; use EPMC for queries, PMC OAI/FTP for bulk.

### 13. CORE (REST) — api.core.ac.uk/v3
- **Purpose:** the repository layer: theses, grey literature, green OA.
- **Function:** search over 300M+ repository records; `downloadUrl` field returns working PDFs keyless (verified); `fullText` field gated for public users.
- **Coverage:** worldwide institutional repositories.
- **Recency:** harvest cadence, weeks.
- **Access:** no key for search + PDF downloads; free key raises limits.
- **Fallback:** OpenAIRE and DOAJ overlap repository metadata; CORE is unique for working PDF URLs.

### 14. Unpaywall (REST) — api.unpaywall.org/v2
- **Purpose:** the OA resolver. DOI → legal OA copy URL if one exists.
- **Function:** `is_oa`, `oa_locations` with pdf_url and landing-page URLs, ~100k req/day. Works for DOIs other indexes miss.
- **Coverage:** global by DOI.
- **Recency:** frequent updates.
- **Access:** no account; needs a real-looking email as URL param (generic addresses rejected).

### 15. J-STAGE (Japan) — api.jstage.jst.go.jp/searchapi
- **Purpose:** open full text of Japanese journals, chemistry-heavy (Chem. Pharm. Bull., Bull. Chem. Soc. Jpn.).
- **Function:** keyless search API (material, article, author, keyword, ISSN params); full text on site. OAI endpoint retired.
- **Coverage:** ~4,000 Japanese journals, 13.5k aspirin hits.
- **Recency:** as published.
- **Access:** no key, no account.
- **Fallback:** OpenAlex indexes J-STAGE metadata and links its PDFs; use J-STAGE directly for native search + full text.

### 16. SciELO (Latin America) — OAI-PMH per national collection
- **Purpose:** Spanish/Portuguese full text, 16 national collections.
- **Function:** OAI-PMH harvest per collection (verified live); full text open on site. Web search UI is bot-protected, use OAI.
- **Coverage:** Latin America + Iberian journals (JBCS, Química Nova and similar).
- **Recency:** as published.
- **Access:** no key, no account.
- **Fallback:** content indexed by OpenAlex/DOAJ for metadata; SciELO OAI for full text.

### 17. AJOL (Africa) — OAI-PMH
- **Purpose:** African journals full text and metadata.
- **Function:** OAI-PMH Identify verified live; Crossref-indexed as well.
- **Coverage:** ~500+ African journals.
- **Access:** no key, no account.

### 18. arXiv + bioRxiv/medRxiv — export.arxiv.org/api, api.biorxiv.org
- **Purpose:** preprints, the fastest layer.
- **Function:** arXiv Atom API (1 req/3s); bioRxiv/medRxiv REST with PDF links. Chemistry proper is weak on arXiv; chem-bio preprints live on bioRxiv.
- **Coverage:** global, English-dominated.
- **Recency:** same-day.
- **Access:** no key, no account.

### 19. Internet Archive — archive.org
- **Purpose:** the scanned archive: backfiles, old journals, books, international collections.
- **Function:** advancedsearch.php JSON API (verified), item metadata API, full-text search across scanned corpus, direct file download by identifier. Web UI at scholar.archive.org for scholarly full-text search.
- **Coverage:** international, deep backfile coverage (old chemistry journals, out-of-print volumes), 30M+ scholarly items.
- **Recency:** as digitized.
- **Access:** no key, no account. API reliability varies by endpoint; web UI more stable than fatcat API (timeouts observed).

### 20. HathiTrust — babel.hathitrust.org
- **Purpose:** massive scanned corpus (Google Books partnership), full view for public domain.
- **Function:** Solr-based search API (bot-gated from datacenter IPs at probe, works from browsers); full-view pages for public-domain volumes.
- **Coverage:** international scans, strong for old chemistry and serials.
- **Access:** no key for public domain; free account for limited full view; institutional login for more.

### 21. Open Library — openlibrary.org
- **Purpose:** book metadata + public-domain full view + controlled lending.
- **Function:** `search.json?q=` (verified, 200), works API, full-text search of public-domain scans.
- **Coverage:** international book records; lending requires a free account.
- **Access:** no key for metadata/search; free account for borrowing.
- **Fallback:** overlaps Internet Archive scans (same ecosystem).

### 22. Google Books — books.googleapis.com
- **Purpose:** book metadata, snippet preview, full view for public domain.
- **Function:** `volumes?q=` API returns metadata + volume info. Verified: keyless but shared anonymous quota can 429 (observed); free Google Cloud API key raises quota.
- **Coverage:** international, the largest book metadata index.
- **Access:** no key (shared quota, may 429); free key recommended for volume work. Upgrade: free key genuinely worth it.

### 23. Project Gutenberg — gutenberg.org
- **Purpose:** public-domain books, plain text.
- **Function:** direct file pattern `gutenberg.org/ebooks/<id>.txt.utf-8` (no API needed); gutendex.com is a community JSON wrapper (may be flaky, don't depend on it).
- **Coverage:** 70k+ public-domain works, mostly English plus other languages.
- **Access:** no key, no account, extremely stable.

### 24. DOAB — directory.doabooks.org
- **Purpose:** Directory of Open Access Books.
- **Function:** OAI-PMH harvest (DSpace; endpoint path is `/oai/request?verb=Identify`); web search.
- **Coverage:** international OA books, peer-reviewed.
- **Access:** no key, no account.

## Layer 4: Full text, shadow infrastructure (25-28)

This layer is the completion of the previous one: everything Layer 3 cannot legally serve, these four can, and they are the difference between a stack that covers 80% of full text and a stack that covers effectively all of it. The elegance here is the redundancy: the same content exists in four overlapping places with four different front ends, so when one mirror dies, the others absorb the load. Sci-Hub is the direct line: DOI in, PDF out, the simplest retrieval primitive in the entire stack, and the wrappers (scihub.py, scidownl) turn that into one function call. LibGen is the deeper database: books in every major language plus the scimag collection, which is the same article corpus served through a searchable catalog with MD5-based downloads you can script against. Z-Library is the book specialist with the best metadata of the group, worth the free account for the daily download budget and worth premium if you do volume work. Anna's Archive is the grand union: all of the above searchable through one index of roughly 250M records, with an official JSON API where search needs no credentials at all and downloads unlock with a one-time key, plus a ready-made MCP server that gives an agent search-and-download as native tools with automatic mirror health checks. Run all four and you have belt, suspenders, rope, and a second rope.

### 25. Sci-Hub — sci-hub.<mirror>/<DOI>
- **Purpose:** on-demand retrieval of publisher-gated articles by DOI/PMID/URL.
- **Function:** no official API. Working pattern (wrappers: github.com/zaytoun/scihub.py, scidownl on PyPI): GET `https://sci-hub.<mirror>/<DOI>` → parse HTML for the embedded PDF link (dacemirror host) → download PDF. Accepts DOI, PMID, or URL.
- **Coverage:** international journal coverage, strongest for publisher-gated content across all disciplines. Mirrors historically operated from multiple jurisdictions; the collection covers global journals.
- **Stability:** mirrors rotate constantly. Probe date: sci-hub.se no DNS; .st/.ru/.wf resolved but 403 or JS-challenged datacenter IPs; captchas appear periodically. Real browser rendering passes. Needs mirror-list refresh + retries.
- **Fallback:** LibGen scimag (same underlying collection, different front end) → Anna's Archive (aggregated, stable API).
- **Upgrade:** no better version of this service exists. For account-based routes to the same content: institutional Scopus/ScienceDirect/Wiley TDM access.
- **Access:** no login, no account, free.

### 26. Library Genesis (LibGen) — libgen.rs / .is / .st / .li / .vg
- **Purpose:** books + articles. The scimag collection is the article database.
- **Function:** JSON API historically at `json.php` with `ids`/`fields` params → metadata + MD5, from which direct download URLs derive (`get.php?md5=...`, mirror hosts like library.lol). Probe date: live mirrors (.li, .vg) answer every documented param form with `{"error":"No Request keys"}`; the endpoint exists but the contract is inconsistent across mirrors today. Working path: `search.php?req=<query>` HTML → extract MD5 → `get.php?md5=...`. Articles: `libgen.rs/scimag/?q=<DOI>` → `ads.php?doi=` download.
- **Coverage:** multilingual books (EN/RU/DE/FR and more) and the international article corpus; strong non-English book coverage.
- **Stability:** backend (.rs/.is/.st) connection-resets datacenter IPs at probe; .li/.vg reachable; library.lol resolved but unreachable at probe. Mirror-dependent.
- **Fallback:** Anna's Archive aggregates LibGen's data with a stable API and mirror health checks.
- **Upgrade:** Anna's Archive (API, mirror health, same underlying data) or Z-Library (account, better metadata for books).
- **Access:** no login, no account, free.

### 27. Z-Library — z-library.<mirror>, singlelogin.re
- **Purpose:** books and documents, the largest shadow library by daily users.
- **Function:** requires a singlelogin account (email + password) for every access; free tier has daily download limits; premium removes them. Unofficial API wrappers: `pip install zlibrary` (async; login → search → download), bipinkrish/Zlibrary-API (uses remix_userid/remix_userkey cookies). Fingerprint-JS gate on mirrors requires real browser rendering.
- **Coverage:** international, many languages, millions of books.
- **Stability:** domains rotate (z-library.se alive at probe, gated); singlelogin.re resolves.
- **Fallback:** LibGen (no account) → Anna's Archive (API).
- **Upgrade:** premium account (removes daily download limits) is the genuinely better version for volume work; the API wrappers work against the same account.
- **Access:** free account required; premium optional.

### 28. Anna's Archive — annas-archive.gl (default mirror), mirrors rotate
- **Purpose:** the aggregator: LibGen + Sci-Hub + Z-Library + more in one searchable index, ~250M records, books and articles.
- **Function:** official JSON API. Search works with no credentials; downloads require an API key granted through a donation (one-time). Ready-made agent integration: iosifache/annas-mcp (MCP server + CLI; search keyless, downloads via ANNAS_SECRET_KEY; automatic mirror selection via SLUM health checks).
- **Coverage:** international by construction, the broadest single metadata surface over shadow content.
- **Stability:** mirrors rotate (annas-archive.org had no DNS at probe; .gl alive, 200); fingerprint gates on some mirrors.
- **Upgrade:** the donation API key is the upgrade path; it is what enables programmatic downloads.
- **Access:** search no account; download key via donation.

## Layer 5: Page retrieval (29-31)

The last layer is the net for everything the indexes cannot hold: pages that exist only as links, sites that only render in a browser, and PDFs that need extraction. Scrapling is the workhorse, quietly fetching pages with stealth when the site is suspicious and batching when you have a stack of them. Nodriver is the heavy artillery, a full undetected Chrome that renders JavaScript shells and passes fingerprint gates, which is exactly what the mirror services in Layer 4 need when they challenge your client. And the PDF rule is the discipline: never scrape a PDF, download it and extract with pymupdf, because a PDF is not a page. These three are what make the whole stack automatable end to end: without them you have 28 indexes pointing at content you cannot actually read.

### 29. Scrapling — scrapling package / MCP
- **Purpose:** fetches pages the indexes only link to: landing pages, publisher HTML.
- **Function:** stealthy_fetch for bot-shielded pages, bulk_get for batches, plain fetch for static pages. The first rung for page-level retrieval.
- **Access:** open-source, free.

### 30. Nodriver — nodriver package
- **Purpose:** browser automation for JavaScript shells (React/Next.js sites, fingerprint gates, managed challenges) that static fetches cannot read.
- **Function:** undetected Chrome; render page, extract `document.body.innerText`. Passes the fingerprint gates on Z-Library/Anna's mirrors and the JS challenges on Sci-Hub/HathiTrust.
- **Access:** open-source, free.
- **Fallback order for any page:** Scrapling → Nodriver → human with a browser.

### 31. PDFs — curl + pymupdf
- **Purpose:** PDFs never go through scrapers.
- **Function:** download with curl, extract text with pymupdf (or pdfplumber). Applies to every PDF URL from CORE, Unpaywall, J-STAGE, SciELO, Sci-Hub, LibGen, Internet Archive.

## Overlap map

- **OpenAlex overlaps everything in Layer 2** by design: it aggregates Crossref/DataCite/DOAJ and regional metadata. Metadata is never missed when a regional API is down.
- **Europe PMC overlaps PubMed almost fully** and adds full text; it is the curation source behind ChEMBL's literature.
- **PubMed Central and Europe PMC overlap each other**, with different API surfaces (REST vs OAI/FTP bulk).
- **CORE overlaps OpenAIRE/DOAJ repository space**, but only CORE hands out working PDF URLs.
- **Unpaywall overlaps OpenAlex's OA-location data**, but is the independent canonical resolver.
- **OpenTargets overlaps ChEMBL and ClinicalTrials.gov by construction**: drugs from ChEMBL, trials from registries.
- **PubChem and ChEMBL overlap on compounds** (UniChem cross-links), different sources.
- **J-STAGE/SciELO/AJOL overlap OpenAlex metadata**, full text unique to them.
- **Internet Archive, HathiTrust, Open Library overlap on scanned public-domain corpus**, different API surfaces and access tiers.
- **Anna's Archive overlaps LibGen/Sci-Hub/Z-Library by construction**, with a stable API and mirror health.
- **Sci-Hub and LibGen scimag overlap on articles**; LibGen and Z-Library overlap on books.

## Country and regional coverage

- **Japan:** open, J-STAGE full text, CiNii (free appid).
- **Korea:** KCI open API (free key, not in stack because it needs registration).
- **Latin America:** open, SciELO + Redalyc content.
- **Africa:** AJOL OAI open.
- **Europe:** OpenAIRE + Europe PMC open.
- **China:** CNKI/WanFang/CQVIP subscription-only, no API. Only ~24-37% of Chinese core journals in OpenAlex. The single biggest coverage hole. No shadow API exists either; unofficial scrapers are unstable.
- **Russia:** eLibrary.ru blocks foreign IPs, no API. Russian-language literature is largely walled; some Russian OA journals reach OpenAlex/Crossref.
- **Taiwan:** Airiti subscription-only.
- **Middle East / Arabic:** Al Manhal, Dar Almandumah subscription-only.
- **Shadow infrastructure is international by construction:** Sci-Hub serves global journals, LibGen and Z-Library carry many languages, Anna's Archive aggregates all of it.

## Recency ranking

1. ClinicalTrials.gov (daily) and live pages via Scrapling/Nodriver
2. arXiv/bioRxiv (same-day preprints)
3. Crossref (real-time registration)
4. OpenAlex (days)
5. Europe PMC (daily PubMed sync)
6. Unpaywall (days-weeks)
7. J-STAGE/SciELO/AJOL (as published)
8. CORE (weeks)
9. Internet Archive/Open Library/HathiTrust (as digitized)
10. PubChem (weekly-ish)
11. ChEMBL (quarterly)
12. OpenTargets (multi-month)
13. Shadow layer (as mirrors refresh, no schedule)

## Global-reach ranking

- **Truly global:** OpenAlex, Crossref, Unpaywall, CORE, Europe PMC, PMC, ClinicalTrials.gov, PubChem, ChEMBL, OpenTargets, Semantic Scholar, DOAJ, Google Books, Internet Archive, HathiTrust, all of Layer 4.
- **Regional by design:** J-STAGE (Japan), SciELO (LatAm), AJOL (Africa), OpenAIRE (Europe-centric).
- **Closed with no API at all:** China CNKI/WanFang/CQVIP, Russia eLibrary, Taiwan Airiti, MENA Al Manhal.

## Workflows: the order

The stack is a single chain of all 31 services. Every research question runs the entire chain. What changes is the entry point: the question determines where you start, and from there you always continue forward through every service in order, because each one adds a dimension the others do not (identity, mechanism, disease, trials, discovery, OA copies, regional coverage, preprints, archives, books, gated copies, page reading). Nothing gets skipped because an answer was found early; the early answers make the later passes sharper.

### Entry points (start here, then run the full chain)

| Question | Enter at | Then continue through |
|---|---|---|
| A specific drug/compound | 4 PubChem (identity: structure, IDs, patents) | 2 ChEMBL (mechanism) → 1 OpenTargets (disease) → 3 ClinicalTrials.gov (trials) → 5-31 |
| A disease/condition | 1 OpenTargets (targets + drug candidates) | 2 ChEMBL (mechanism) → 3 ClinicalTrials.gov (trials) → 4 PubChem (structures) → 5-31 |
| A target/protein | 2 ChEMBL (all compounds + bioactivity) | 1 OpenTargets (disease context) → 4 PubChem (structures) → 3 ClinicalTrials.gov (trials) → 5-31 |
| A trial/phase question | 3 ClinicalTrials.gov | 1 OpenTargets → 2 ChEMBL → 4 PubChem → 5-31 |
| A DOI/article | 5 Crossref (registration) → 6 OpenAlex (index) | 7 Semantic Scholar (citations + TLDR) → 10 OpenCitations (trail) → 8 DOAJ → 9 OpenAIRE → full-text passes |
| A topic/author | 6 OpenAlex | 7 Semantic Scholar → 5 Crossref → 10 OpenCitations → 8 DOAJ → 9 OpenAIRE → full-text passes |
| A citation trace | 7 Semantic Scholar + 10 OpenCitations | 6 OpenAlex → 5 Crossref → full-text passes |
| A book | 21 Open Library → 22 Google Books | 23 Gutenberg (public domain) → 24 DOAB (OA) → 19 Internet Archive (scanned) → 20 HathiTrust → 26 LibGen → 27 Z-Library → 28 Anna's Archive |
| A live page | 29 Scrapling | 30 Nodriver (if JS/bot-shielded) → 31 PDFs (if the target is a PDF) |

### The chain, in passes (every pass runs, every service inside runs)

1. **Identity pass** — 4 PubChem: structure, InChIKey, CIDs, patents, synonyms. Everything downstream keys off these IDs.
2. **Mechanism pass** — 2 ChEMBL: targets, bioactivity, mechanism, max_phase. The molecular story.
3. **Disease pass** — 1 OpenTargets: disease associations, drug candidates, clinical stage, evidence scores. The strategic story.
4. **Trial pass** — 3 ClinicalTrials.gov: live status, phases, sponsors, locations. The human story.
5. **Discovery pass** — 5 Crossref (fresh DOIs), 6 OpenAlex (full index), 7 Semantic Scholar (citations + TLDRs), 8 DOAJ (OA whitelist), 9 OpenAIRE (repository OA), 10 OpenCitations (citation trail). Every paper that exists, from every angle.
6. **Open full-text pass** — 11 Europe PMC (structured XML), 12 PubMed Central (bulk/OAI), 13 CORE (repository PDFs), 14 Unpaywall (OA resolution per DOI). Every legal free copy, retrieved.
7. **Regional pass** — 15 J-STAGE (Japan), 16 SciELO (LatAm), 17 AJOL (Africa). The literature the global indexes under-serve.
8. **Preprint pass** — 18 arXiv + bioRxiv/medRxiv. The unpublished frontier.
9. **Archive pass** — 19 Internet Archive, 20 HathiTrust. Backfiles, scans, out-of-print history.
10. **Book pass** — 21 Open Library, 22 Google Books, 23 Gutenberg, 24 DOAB. Monographs, textbooks, reference works.
11. **Gated full-text pass** — 25 Sci-Hub (DOI → PDF), 26 LibGen (scimag articles + books), 28 Anna's Archive (aggregated API), 27 Z-Library (books, account). Everything the open passes could not serve.
12. **Retrieval pass** — 29 Scrapling, 30 Nodriver, 31 PDFs. Reading whatever still exists only as a page.

### The sidelines rule

Every pass's findings stay on the table. When the user asks a follow-up (how does it work mechanistically, what are the patents, is it in trials, any Japanese studies, what do the newest preprints say, is there a book), you pull from the pass that holds that answer and keep moving down the chain. The chain does not restart on follow-ups; it continues from where it is, and nothing is ever skipped. When the user pivots to a new compound, the chain restarts at the entry point for that compound.

### Example, drug-first (aspirin)

4 PubChem (CID 2244, InChIKey, patents) → 2 ChEMBL (CHEMBL25, mechanism, max_phase 4.0) → 1 OpenTargets (disease associations, APPROVAL) → 3 ClinicalTrials.gov (live trials) → 5 Crossref → 6 OpenAlex → 7 Semantic Scholar → 8 DOAJ → 9 OpenAIRE → 10 OpenCitations → 11 Europe PMC (114k OA full texts) → 12 PMC → 13 CORE → 14 Unpaywall → 15 J-STAGE → 16 SciELO → 17 AJOL → 18 arXiv/bioRxiv → 19 Internet Archive → 20 HathiTrust → 21 Open Library → 22 Google Books → 23 Gutenberg → 24 DOAB → 25 Sci-Hub → 26 LibGen → 28 Anna's Archive → 27 Z-Library → 29 Scrapling → 30 Nodriver → 31 PDFs. Every service contributes something; the result is the complete record: identity, mechanism, disease, trials, every paper, every free copy, every gated copy, every region, every book, every era.

## Gap-closing upgrades (account or key, only where genuinely better)

| Surface | Upgrade | Why |
|---|---|---|
| OpenAlex | Free API key | 1,000 → 100,000 credits/day |
| Semantic Scholar | Free API key | shared 429 pool → guaranteed 1 req/s |
| NCBI E-utilities | Free API key | 3 → 10 req/s |
| CORE | Free API key | higher quotas |
| Google Books | Free Google Cloud key | shared quota 429s disappear |
| Z-Library | Premium account | removes daily download limits |
| Anna's Archive | Donation API key | enables programmatic downloads (search stays free) |
| Elsevier content | Institutional Scopus/ScienceDirect APIs | metadata + full text with subscription |
| Wiley content | Institutional TDM token | full text with subscription |
| China/Russia/Taiwan/MENA literature | Institutional subscriptions (CNKI, eLibrary, Airiti, Al Manhal) | no API exists, paid or otherwise |
