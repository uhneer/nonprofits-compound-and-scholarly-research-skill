# Stack Catalog — all 31 services

Per service: purpose, function (endpoints and patterns), documentation, coverage, recency, access, stability, fallback, upgrade. Mirror-based services rotate domains; re-resolve at runtime.

## Layer 1: Compound research

### 1. OpenTargets (GraphQL) — api.platform.opentargets.org/api/v4/graphql
- **Purpose:** disease → associated targets and drug candidates with clinical stage; target → diseases; drug → indications. Scored associations backed by genetics, somatic mutations, drug data, literature mining.
- **Function:** single GraphQL endpoint. Fields: `drug { id name maximumClinicalStage }`, evidence scoring per association, mechanism annotations, links to trials and literature. Disease search: `{ search(queryString:"term") { hits { id name } } }`; disease drugs: `{ disease(efoId: "ID") { drugAndClinicalCandidates { rows { maxClinicalStage drug { name } } } } }`. v4 schema, `drugAndClinicalCandidates` not `knownDrugs`.
- **Docs:** platform.opentargets.org/docs (GraphQL playground, schema introspection).
- **Coverage:** diseases, targets, drugs as worldwide entities; mechanisms from ChEMBL, trial evidence from registries.
- **Recency:** periodic releases, multi-month cadence.
- **Access:** no key, no account.

### 2. ChEMBL (REST) — www.ebi.ac.uk/chembl/api
- **Purpose:** target → all compounds with measured bioactivity (IC50, Ki, EC50), mechanism of action, max_phase. Curated from medicinal-chemistry literature.
- **Function:** endpoints for molecules, targets, assays, activities, documents. Target search: `target/search.json?q=<name>%20Homo%20sapiens` → target_chembl_id; mechanisms: `mechanism.json?target_chembl_id=<ID>`; molecule: `molecule/<CHEMBLID>.json` → pref_name. max_phase: 4 = approved, 3 = phase 3, 2 = phase 2, 1 = phase 1. Cross-references to PubChem via UniChem.
- **Docs:** ebi.ac.uk/chembl/api/data/docs (Swagger).
- **Coverage:** worldwide literature, no country limitation. Example: aspirin = CHEMBL25, max_phase 4.0.
- **Recency:** quarterly releases.
- **Access:** no key, no account.

### 3. ClinicalTrials.gov v2 (REST) — clinicaltrials.gov/api/v2/studies
- **Purpose:** compound or condition → live human-trial registry: overall status, phases, sponsors, locations, interventions, results.
- **Function:** full protocol-section records, filters (`query.term`, `query.intr`, `query.cond`), pagination via `nextPageToken`, JSON. Fields: `protocolSection.{statusModule.overallStatus, designModule.phases, identificationModule.briefTitle}`.
- **Docs:** clinicaltrials.gov/data-api.
- **Coverage:** worldwide registry; China (ChiCTR), Japan (jRCT), India (CTRI) keep national registries where some trials appear only; WHO ICTRP aggregates.
- **Recency:** daily updates, the most real-time API in the stack.
- **Access:** no key, no account.

### 4. PubChem PUG REST (REST) — pubchem.ncbi.nlm.nih.gov/rest/pug
- **Purpose:** compound → structure, identifiers (SMILES, InChI, InChIKey, CID), synonyms, properties, patent cross-references, bioassays, literature links.
- **Function:** `compound/name/<drug>/cids/JSON`, `compound/<CID>/property/CanonicalSMILES,InChIKey,MolecularFormula/JSON`, `compound/<CID>/xrefs/PatentID/JSON`, `compound/<CID>/synonyms/JSON`, structure search by name/SMILES/InChI; JSON/XML/CSV output. Example: aspirin = CID 2244, InChIKey BSYNRYMUTXBXSQ-UHFFFAOYSA-N, large patent ID list.
- **Docs:** pubchem.ncbi.nlm.nih.gov/docs/pug-rest.
- **Coverage:** fully global. Patent xref responses can be megabytes; request selectively.
- **Recency:** continuous deposition, weekly-ish refresh.
- **Access:** no key, no account.

## Layer 2: Article discovery

### 5. OpenAlex (REST) — api.openalex.org
- **Purpose:** the global scholarly index. One query across every discipline and language.
- **Function:** works, sources, authors, concepts endpoints; abstracts (inverted index), concepts/topics filters, citations, OA locations. `works?search=`, `works?filter=concepts.id:...`, `mailto=` polite pool. ~324M works.
- **Docs:** docs.openalex.org.
- **Coverage:** the superset: aggregates Crossref, DataCite, DOAJ, regional sources; 5M+ Chinese-language works; multilingual.
- **Recency:** continuous ingestion, days.
- **Access:** no key for basic use (anonymous credit-capped ~1,000/day); free API key raises to 100,000/day. Mandatory-free-key policy announced; anonymous still works.

### 6. Crossref (REST) — api.crossref.org
- **Purpose:** the DOI backbone. 185M+ DOIs registered by publishers worldwide.
- **Function:** `works?filter=doi:...`, `works?rows=`, real-time registration, polite pool via `mailto=`.
- **Docs:** github.com/CrossRef/rest-api-doc.
- **Coverage:** every DOI-depositing publisher including regional society journals; multilingual via publisher metadata.
- **Recency:** real-time on registration, the freshest metadata source.
- **Access:** no key, no account.

### 7. Semantic Scholar (REST) — api.semanticscholar.org/graph/v1
- **Purpose:** citation graph + paper metadata + TLDR summaries.
- **Function:** `paper/search?query=&fields=title,openAccessPdf,tldr,citationCount`, paper lookup by DOI/CorpusId, citation endpoints. ~214M papers, 2.49B citations.
- **Docs:** semanticscholar.org/product/api.
- **Coverage:** all disciplines; chemistry journals included.
- **Recency:** continuous.
- **Access:** no key, shared pool (429s under load; retry). Free key = guaranteed 1 req/s; worth it when the pool is saturated.

### 8. DOAJ (REST) — doaj.org/api/v3
- **Purpose:** the open-access journal whitelist.
- **Function:** `search/articles/<query>`, journal search; ~21,000 OA journals, ~12M articles, all languages; full-text URLs in records.
- **Docs:** doaj.org/docs/api.
- **Coverage:** worldwide multilingual OA journals, including non-English chemistry titles.
- **Recency:** as journals update.
- **Access:** no key, no account.

### 9. OpenAIRE (REST) — api.openaire.eu/search
- **Purpose:** repository-hosted OA aggregation, Europe-centric but worldwide.
- **Function:** `publications?keywords=`, datasets, software; OA full-text links in records.
- **Docs:** develop.openaire.eu.
- **Coverage:** green OA and repository content, multilingual metadata.
- **Recency:** continuous harvesting.
- **Access:** no key, no account.

### 10. OpenCitations (REST) — api.opencitations.net
- **Purpose:** the citation graph (COCI, ~1.8B citation links).
- **Function:** `meta/v1/metadata/doi:...` (metadata), citation endpoints. Citations only, never full text.
- **Docs:** opencitations.net/index/api.
- **Coverage:** Crossref-derived citations, worldwide.
- **Recency:** continuous.
- **Access:** no key, no account.

## Layer 3: Full text, open infrastructure

### 11. Europe PMC (REST) — www.ebi.ac.uk/europepmc/webservices/rest
- **Purpose:** the full-text layer for biomedicine.
- **Function:** `search?query=&format=json` (add `AND OPEN_ACCESS:Y` for OA subset); `fullTextXML` endpoint returns whole articles as structured XML (check `hasText` first; 0 bytes = manuscript-only); chemical annotation service. ~45M records; example scale: aspirin 241k hits, 114k OA full text.
- **Docs:** europepmc.org/RestfulWebService.
- **Coverage:** PubMed + PMC + preprints + patents + AgriKnowledge, worldwide.
- **Recency:** daily PubMed sync.
- **Access:** no key, no account.

### 12. PubMed Central (NCBI) — eutils + OAI + FTP
- **Purpose:** the OA full-text repository with bulk paths.
- **Function:** eutils efetch for OA full text; OAI-PMH harvesting; FTP bulk dumps (ftp.ncbi.nlm.nih.gov/pub/pmc) for whole-corpus download. 3M+ OA articles.
- **Docs:** ncbi.nlm.nih.gov/books/NBK25501 (E-utilities), ncbi.nlm.nih.gov/pmc/tools/oai (OAI).
- **Coverage:** worldwide journals, some non-English.
- **Recency:** daily.
- **Access:** no key (3 req/s), free NCBI key 10 req/s.
- **Fallback:** Europe PMC serves the same content with a friendlier REST surface; use EPMC for queries, PMC OAI/FTP for bulk.

### 13. CORE (REST) — api.core.ac.uk/v3
- **Purpose:** the repository layer: theses, grey literature, green OA.
- **Function:** `v3/search/works?q=` (note trailing-slash redirect); `downloadUrl` field returns working PDFs without a key; `fullText` field gated for public users. 300M+ records.
- **Docs:** core.ac.uk/docs.
- **Coverage:** worldwide institutional repositories.
- **Recency:** harvest cadence, weeks.
- **Access:** no key for search + PDF downloads; free key raises limits.
- **Fallback:** OpenAIRE and DOAJ overlap repository metadata; CORE is unique for working PDF URLs.

### 14. Unpaywall (REST) — api.unpaywall.org/v2
- **Purpose:** the OA resolver. DOI → legal OA copy URL if one exists.
- **Function:** `v2/<doi>?email=<real-looking email>` (generic addresses rejected); fields `is_oa`, `oa_locations[]` with `pdf_url` and `url_for_landing_page`. ~100k req/day.
- **Docs:** unpaywall.org/products/api.
- **Coverage:** global by DOI.
- **Recency:** frequent updates.
- **Access:** no account; email param required.

### 15. J-STAGE (Japan) — api.jstage.jst.go.jp/searchapi
- **Purpose:** open full text of Japanese journals, chemistry-heavy (Chem. Pharm. Bull., Bull. Chem. Soc. Jpn.).
- **Function:** keyless search API (material, article, author, keyword, ISSN params); full text on site. OAI endpoint retired. ~4,000 journals; example scale: 13.5k aspirin hits.
- **Docs:** jstage.jst.go.jp (search API reference).
- **Coverage:** Japan-focused.
- **Recency:** as published.
- **Access:** no key, no account.
- **Fallback:** OpenAlex indexes J-STAGE metadata and links PDFs; use J-STAGE for native search + full text.

### 16. SciELO (Latin America) — OAI-PMH per national collection
- **Purpose:** Spanish/Portuguese full text, 16 national collections.
- **Function:** OAI-PMH harvest per collection (e.g. scielo.org.mx/oai?verb=Identify); full text open on site. Web search UI is bot-protected; use OAI. Metadata alternative: articlemeta.scielo.org.
- **Docs:** articlemeta.scielo.org; scielo.org.
- **Coverage:** Latin America + Iberian journals (JBCS, Química Nova and similar).
- **Recency:** as published.
- **Access:** no key, no account.
- **Fallback:** OpenAlex/DOAJ for metadata; SciELO OAI for full text.

### 17. AJOL (Africa) — OAI-PMH
- **Purpose:** African journals full text and metadata.
- **Function:** OAI-PMH at ajol.info/index.php/ajol/oai (Identify verified); Crossref-indexed as well. ~500+ African journals.
- **Docs:** ajol.info.
- **Access:** no key, no account.

### 18. arXiv + bioRxiv/medRxiv — export.arxiv.org/api, api.biorxiv.org
- **Purpose:** preprints, the fastest layer.
- **Function:** arXiv Atom API (`api/query?search_query=all:...`, 1 req/3s); bioRxiv/medRxiv REST (`details/<server>/<doi>` etc.) with PDF links. Chemistry proper is weak on arXiv; chem-bio preprints live on bioRxiv.
- **Docs:** info.arxiv.org/help/api; api.biorxiv.org.
- **Coverage:** global, English-dominated.
- **Recency:** same-day.
- **Access:** no key, no account.

### 19. Internet Archive — archive.org
- **Purpose:** the scanned archive: backfiles, old journals, books, international collections.
- **Function:** `advancedsearch.php?q=...&fl[]=identifier&output=json`; item metadata API; full-text search across scanned corpus; direct file download by identifier. Scholar search UI at scholar.archive.org.
- **Docs:** archive.org/developers.
- **Coverage:** international, deep backfile coverage, 30M+ scholarly items.
- **Recency:** as digitized.
- **Access:** no key, no account. API reliability varies by endpoint; web UI more stable than fatcat API.

### 20. HathiTrust — babel.hathitrust.org
- **Purpose:** massive scanned corpus (Google Books partnership), full view for public domain.
- **Function:** Solr-based search API (bot-gated from datacenter IPs; works from browsers); full-view pages for public-domain volumes.
- **Docs:** hathitrust.org/data.
- **Coverage:** international scans, strong for old chemistry and serials.
- **Access:** no key for public domain; free account for limited full view; institutional login for more.

### 21. Open Library — openlibrary.org
- **Purpose:** book metadata + public-domain full view + controlled lending.
- **Function:** `search.json?q=`, works API, full-text search of public-domain scans.
- **Docs:** openlibrary.org/dev/docs/api.
- **Coverage:** international book records; lending requires a free account.
- **Access:** no key for metadata/search; free account for borrowing.
- **Fallback:** overlaps Internet Archive scans (same ecosystem).

### 22. Google Books — books.googleapis.com
- **Purpose:** book metadata, snippet preview, full view for public domain.
- **Function:** `books/v1/volumes?q=` returns metadata + volume info. Keyless but shared anonymous quota can 429; free Google Cloud API key raises quota.
- **Docs:** developers.google.com/books.
- **Coverage:** international, the largest book metadata index.
- **Access:** no key (shared quota); free key recommended for volume work.

### 23. Project Gutenberg — gutenberg.org
- **Purpose:** public-domain books, plain text.
- **Function:** direct file pattern `gutenberg.org/ebooks/<id>.txt.utf-8` (no API needed); gutendex.com is a community JSON wrapper (may be flaky, don't depend on it).
- **Docs:** gutenberg.org/help; gutendex.com.
- **Coverage:** 70k+ public-domain works, mostly English plus other languages.
- **Access:** no key, no account, extremely stable.

### 24. DOAB — directory.doabooks.org
- **Purpose:** Directory of Open Access Books.
- **Function:** OAI-PMH harvest (DSpace; endpoint `directory.doabooks.org/oai/request?verb=Identify`); web search.
- **Docs:** doabooks.org.
- **Coverage:** international OA books, peer-reviewed.
- **Access:** no key, no account.

## Layer 4: Full text, shadow infrastructure

### 25. Sci-Hub — sci-hub.<mirror>/<DOI>
- **Purpose:** on-demand retrieval of publisher-gated articles by DOI/PMID/URL.
- **Function:** no official API. Pattern (wrappers: github.com/zaytoun/scihub.py, scidownl on PyPI): GET `https://sci-hub.<mirror>/<DOI>` → parse HTML for the embedded PDF link (dacemirror host) → download PDF. Accepts DOI, PMID, or URL.
- **Coverage:** international journal coverage across all disciplines; the collection covers global journals.
- **Stability:** mirrors rotate constantly; typical mirrors .st/.ru/.wf/.ee. Datacenter IPs get 403 or JS challenges; captchas appear periodically. Real browser rendering passes. Needs mirror-list refresh + retries.
- **Fallback:** LibGen scimag (same underlying collection) → Anna's Archive (aggregated, stable API).
- **Upgrade:** no better version of this service exists. Account-based routes to the same content: institutional Scopus/ScienceDirect/Wiley TDM access.
- **Access:** no login, no account.

### 26. Library Genesis (LibGen) — libgen.rs / .is / .st / .li / .vg
- **Purpose:** books + articles. The scimag collection is the article database.
- **Function:** JSON API historically at `json.php` with `ids`/`fields` params → metadata + MD5, from which direct download URLs derive (`get.php?md5=...`, mirror hosts like library.lol). The endpoint exists but the parameter contract is inconsistent across mirrors; the working path is `search.php?req=<query>` HTML → extract MD5 → `get.php?md5=...`. Articles: `libgen.rs/scimag/?q=<DOI>` → `ads.php?doi=` download.
- **Coverage:** multilingual books (EN/RU/DE/FR and more) and the international article corpus; strong non-English book coverage.
- **Stability:** backend (.rs/.is/.st) may connection-reset datacenter IPs; .li/.vg usually reachable; mirror-dependent.
- **Fallback:** Anna's Archive aggregates LibGen's data with a stable API and mirror health checks.
- **Upgrade:** Anna's Archive (API, mirror health, same underlying data) or Z-Library (account, better metadata for books).
- **Access:** no login, no account.

### 27. Z-Library — z-library.<mirror>, singlelogin.re
- **Purpose:** books and documents, the largest shadow library by daily users.
- **Function:** requires a singlelogin account (email + password) for every access; free tier has daily download limits; premium removes them. Unofficial API wrappers: `pip install zlibrary` (async; login → search → download), bipinkrish/Zlibrary-API (uses remix_userid/remix_userkey cookies). Fingerprint-JS gate on mirrors requires real browser rendering.
- **Coverage:** international, many languages, millions of books.
- **Stability:** domains rotate; fingerprint gates; singlelogin.re is the stable login portal.
- **Fallback:** LibGen (no account) → Anna's Archive (API).
- **Upgrade:** premium account (removes daily download limits) for volume work; wrappers work against the same account.
- **Access:** free account required; premium optional.

### 28. Anna's Archive — annas-archive.gl (default mirror), mirrors rotate
- **Purpose:** the aggregator: LibGen + Sci-Hub + Z-Library + more in one searchable index, ~250M records, books and articles.
- **Function:** official JSON API. Search works with no credentials; downloads require an API key granted through a donation (one-time). Agent integration: iosifache/annas-mcp (MCP server + CLI; search keyless, downloads via ANNAS_SECRET_KEY; automatic mirror selection via SLUM health checks).
- **Docs:** annas-archive.gl/faq#api; github.com/iosifache/annas-mcp.
- **Coverage:** international by construction; the broadest single metadata surface over shadow content.
- **Stability:** mirrors rotate; fingerprint gates on some mirrors; SLUM health checks automate selection.
- **Upgrade:** the donation API key enables programmatic downloads (search stays free).
- **Access:** search no account; download key via donation.

## Layer 5: Page retrieval

### 29. Scrapling — scrapling package / MCP
- **Purpose:** fetches pages the indexes only link to: landing pages, publisher HTML.
- **Function:** stealthy_fetch for bot-shielded pages, bulk_get for batches, plain fetch for static pages. First rung for page-level retrieval.
- **Docs:** scrapling.readthedocs.io.
- **Access:** open-source, free.

### 30. Nodriver — nodriver package
- **Purpose:** browser automation for JavaScript shells (React/Next.js sites, fingerprint gates, managed challenges) that static fetches cannot read.
- **Function:** undetected Chrome; render page, extract `document.body.innerText`. Passes fingerprint gates and JS challenges.
- **Docs:** github.com/ultrafunkamsterdam/nodriver.
- **Access:** open-source, free.
- **Fallback order for any page:** Scrapling → Nodriver → human with a browser.

### 31. PDFs — curl + pymupdf
- **Purpose:** PDFs never go through scrapers.
- **Function:** download with curl, extract text with pymupdf (import `fitz`) or pdfplumber. Applies to every PDF URL from CORE, Unpaywall, J-STAGE, SciELO, Sci-Hub, LibGen, Internet Archive.
- **Docs:** pymupdf.readthedocs.io; pdfplumber.readthedocs.io.

---

## Overlap map

- OpenAlex overlaps everything in Layer 2 by design: it aggregates Crossref/DataCite/DOAJ and regional metadata.
- Europe PMC overlaps PubMed almost fully and adds full text; it is the curation source behind ChEMBL's literature.
- PubMed Central and Europe PMC overlap each other with different API surfaces (REST vs OAI/FTP bulk).
- CORE overlaps OpenAIRE/DOAJ repository space, but only CORE hands out working PDF URLs.
- Unpaywall overlaps OpenAlex's OA-location data, but is the independent canonical resolver.
- OpenTargets overlaps ChEMBL and ClinicalTrials.gov by construction: drugs from ChEMBL, trials from registries.
- PubChem and ChEMBL overlap on compounds (UniChem cross-links), different sources.
- J-STAGE/SciELO/AJOL overlap OpenAlex metadata; full text unique to them.
- Internet Archive, HathiTrust, Open Library overlap on scanned public-domain corpus; different API surfaces and access tiers.
- Anna's Archive overlaps LibGen/Sci-Hub/Z-Library by construction, with a stable API and mirror health.
- Sci-Hub and LibGen scimag overlap on articles; LibGen and Z-Library overlap on books.

## Country and regional coverage

- **Japan:** open: J-STAGE full text, CiNii (free appid).
- **Korea:** KCI open API (free key, not in the stack because it needs registration).
- **Latin America:** open: SciELO + Redalyc content.
- **Africa:** AJOL OAI open.
- **Europe:** OpenAIRE + Europe PMC open.
- **China:** CNKI/WanFang/CQVIP subscription-only, no API; only ~24-37% of Chinese core journals in OpenAlex; the single biggest coverage hole; no shadow API exists either.
- **Russia:** eLibrary.ru blocks foreign IPs, no API; Russian-language literature largely walled.
- **Taiwan:** Airiti subscription-only.
- **Middle East / Arabic:** Al Manhal, Dar Almandumah subscription-only.
- **Shadow infrastructure is international by construction:** Sci-Hub serves global journals, LibGen and Z-Library carry many languages, Anna's Archive aggregates all of it.

## Recency ranking (most real-time first)

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
