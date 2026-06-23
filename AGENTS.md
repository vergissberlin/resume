# AGENTS.md

Guidance for AI coding agents (Claude Code, Cursor, Codex, etc.) working in this repository.

## Project overview

A resume/CV generator. Markdown sources in `Content/` are rendered to PDF and EPUB via a Pandoc + Eisvogel Docker image (`ghcr.io/vergissberlin/pandoc-eisvogel-de`). Releases are published to GitHub as PDF/EPUB assets.

- **Language**: Shell scripts + Markdown (no application code)
- **Build tool**: Docker (Pandoc Eisvogel image)
- **CI**: GitHub Actions
- **Versioning**: SemVer via `release-please` (Conventional Commits)
- **License**: CC BY-NC-SA 4.0

## Repository layout

| Path | Purpose |
|------|---------|
| `Content/*.md` | Resume sections (introduction, CV, portfolio, contact) – the canonical source |
| `Content/Profiles/<profile>/*.md` | Profile-specific overrides (e.g. `iot`) – override files with the same name |
| `Content/Media/` | Images, cover art, mockups |
| `Template/Config/*.yml` | Pandoc `defaults`/`metadata` files for PDF & EPUB |
| `Template/letter-din5008.latex` | DIN 5008 Form B cover letter (KOMA-Script `scrlttr2`) |
| `Template/*.html` | HTML/EPUB templates |
| `Template/Backgrounds/` | PDF cover/background images |
| `Scripts/build.sh` | Main build entrypoint |
| `Scripts/merge-letter-pdf.sh` | Merges cover letter PDF after title page |
| `Scripts/filter.sh`, `replace.sh`, `functions.sh` | Pandoc preprocessing helpers |
| `Content/Application/` | **Local only** (gitignored) – cover letters for job applications |
| `Content/Application.example/` | Committed example cover letter to copy into `Content/Application/` |
| `.env`, `.env.<profile>` | Profile-specific variables (`RESUME_FILENAME`, `RESUME_AUTHOR`, …) |
| `.github/workflows/build-and-release.yml` | Tag-triggered build + GitHub Release |
| `.github/workflows/release-please.yml` | Automated version bumps + release PRs |
| `release-please-config.json`, `.release-please-manifest.json` | release-please configuration |

## Build & test commands

```sh
# Default profile
./Scripts/build.sh

# IoT profile (uses .env.iot + Content/Profiles/iot/* overrides)
./Scripts/build.sh --profile=iot

# With a local cover letter (Content/Application/ is gitignored – not used in CI)
./Scripts/build.sh --letter=example-gmbh
./Scripts/build.sh --profile=iot --letter=acme-gmbh

# Or via just (see `just` / `just --list`)
just build-letter example-gmbh
just build-letter-iot example-gmbh
```

Outputs land in `Results/`. The script requires Docker to be running and a git tag to exist (`git describe --tags --abbrev=0`).

### Cover letters (local only)

Cover letters live under `Content/Application/<slug>.md` and are **never committed** (`Content/Application/` is in `.gitignore`). Copy the example from `Content/Application.example/example-gmbh.md` to get started.

- Select via CLI: `--letter=<slug>`
- Or set `COVER_LETTER=<slug>` in `Content/Application/.env` (also gitignored)
- **PDF:** DIN 5008 Form B via `scrlttr2`, merged after the title page (`Scripts/merge-letter-pdf.sh`)
- **EPUB:** letter body prepended as first chapter after the cover image
- CI builds are unchanged (no `--letter`, no `Content/Application/` folder)

Letter metadata is YAML under a `letter:` key (recipient, subject, date, etc.); the Markdown body is the letter text. Use YAML lists for multi-line addresses (`to`, `fromaddress`).

**Agent workflow:** `.cursor/skills/local-bewerbung/` — interactive build with profile and cover letter selection.

There is **no test suite, linter, or type checker**. "Verification" means: the build succeeds, the resulting PDF/EPUB renders correctly. Do not invent test commands.

## Conventions

### Commits

Conventional Commits are **mandatory** – `release-please` derives version bumps from them:

- `feat: …` → minor bump
- `fix: …` → patch bump
- `feat!: …` or `BREAKING CHANGE:` in body → major bump
- `chore:`, `docs:`, `ci:`, `refactor:`, `build:`, `perf:` → no version bump, but shown in changelog

### Branches & releases

- Default branch: `main`
- Never push directly to `main` – open a PR
- Do **not** create tags manually – `release-please` does this when the release PR is merged
- The tag push triggers `build-and-release.yml` which builds & uploads the assets

### Profiles

When adding profile-specific content:
1. Create the override file under `Content/Profiles/<profile>/<same-filename>.md`.
2. Add a matching `.env.<profile>` if variables differ.
3. Update `Scripts/build.sh` calls in `.github/workflows/build-and-release.yml` to build the new profile.

The build script picks the override automatically when the file exists; otherwise it falls back to `Content/<file>.md`.

### Editing markdown

- Keep heading hierarchy clean – `build.sh` extracts the first `# ` as the document title for single-file PDFs.
- File names use a numeric prefix (`0-…`, `1-…`) for ordering; the prefix is stripped from output filenames.
- Don't break Pandoc syntax – `filter.sh`/`replace.sh` normalise some characters but are not a full parser.

## Sensitive data

This repo contains personal data (CV/portfolio of the maintainer). When making changes:

- **Do not** invent or alter personal details (employer names, dates, contact info). Ask before changing factual content.
- **Do not** commit anything from `.env*` that contains secrets. The committed `.env` and `.env.iot` are config, not secrets – check before adding new variables.
- Use placeholder data in examples, never real third-party contact data.

## What agents should NOT do

- Do **not** add a test framework, linter, or formatter "just because" – this repo deliberately has none.
- Do **not** add Node/Python/Go tooling unless explicitly requested.
- Do **not** rewrite the build pipeline to a different tool (Hugo, mdBook, …) without explicit approval.
- Do **not** push tags or releases manually – the automation handles this.
- Do **not** commit binaries to `Results/` – they belong on GitHub Releases.
- Do **not** edit `CHANGELOG.md` by hand once release-please owns it.

## Useful references

- Pandoc Eisvogel template: <https://github.com/Wandmalfarbe/pandoc-latex-template>
- release-please docs: <https://github.com/googleapis/release-please>
- Conventional Commits: <https://www.conventionalcommits.org/>
