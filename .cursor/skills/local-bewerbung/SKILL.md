---
name: local-bewerbung
description: Builds a local job application (Bewerbung) with DIN 5008 cover letter as PDF and EPUB. Discovers profiles and letters from the repo, asks which profile and Anschreiben to use, then runs Scripts/build.sh. Use when the user wants a Bewerbung, Anschreiben, cover letter build, --letter, or --profile application package.
disable-model-invocation: true
---

# Lokale Bewerbung mit Anschreiben

Orchestrates the existing build pipeline in `Scripts/build.sh`. Does not change CI or commit `Content/Application/`.

## Workflow checklist

```plantext
- [ ] 1. Discover profiles and cover letters
- [ ] 2. AskQuestion: profile + Anschreiben (mandatory)
- [ ] 3. Create new letter if chosen
- [ ] 4. Preflight (Docker, git tag)
- [ ] 5. Run build.sh
- [ ] 6. Report output paths in Results/
```

**Never run the build until both profile and letter slug are confirmed.**

## Step 1: Discover options

From the repository root:

```sh
# Cover letter slugs (basename without .md)
ls -1 Content/Application/*.md 2>/dev/null | while read f; do basename "$f" .md; done

# Profiles: always include "standard"; add folders under Content/Profiles/
ls -1 Content/Profiles/ 2>/dev/null
```

- **standard** = default build (no `--profile` flag)
- Any folder under `Content/Profiles/` (e.g. `iot`) → `--profile=<name>`

If `Content/Application/` is missing or empty, include **"Neues Anschreiben (aus Vorlage)"** in the letter question.

## Step 2: AskQuestion (required)

Use **AskQuestion** with exactly these two prompts:

### Question 1: Profil

Options (build dynamically):

| Label | Value for build |
|-------|-----------------|
| Standard (empfohlen wenn unsicher) | `standard` |
| Each name from `Content/Profiles/` | profile name, e.g. `iot` |

### Question 2: Anschreiben

Options:

- Each slug from `Content/Application/*.md`
- **Neues Anschreiben (aus Vorlage)** if user needs a new letter

If **"Neues Anschreiben"** was selected, ask for a slug (kebab-case, e.g. `acme-gmbh`) before continuing.

## Step 3: New cover letter (conditional)

Only when the user chose a new letter:

```sh
mkdir -p Content/Application
cp Content/Application.example/example-gmbh.md Content/Application/<slug>.md
```

Then collect or edit:

- Recipient (`letter.to` list)
- Subject, reference line, date, place
- Body paragraphs

**Rules:**

- Do not invent personal facts (employer names, dates, addresses) — ask the user or use placeholders from the example until they provide real data.
- Use YAML **lists** for `to` and `fromaddress` (not `|` multiline blocks). See [reference.md](reference.md).

## Step 4: Preflight

```sh
docker info >/dev/null 2>&1 || echo "Docker not running"
git describe --tags --abbrev=0
test -f "Content/Application/<slug>.md"
```

If preflight fails, stop and report the blocker.

**Apple Silicon:** image `ghcr.io/vergissberlin/pandoc-eisvogel-de` may need `linux/amd64`. If builds fail with `exec format error`, suggest Docker emulation or building on CI/linux.

## Step 5: Build

```sh
# standard profile
./Scripts/build.sh --letter=<slug>

# named profile (e.g. iot)
./Scripts/build.sh --profile=iot --letter=<slug>
```

Do **not** commit `Content/Application/` or `Results/`. Only mention `Content/Application/.env` with `COVER_LETTER=<slug>` if the user asks for a default without `--letter`.

## Step 6: Report results

Read `RESUME_FILENAME` from `.env` and the git tag:

```sh
git describe --tags --abbrev=0
# source .env → RESUME_FILENAME
```

Main outputs in `Results/`:

| File | Content |
|------|---------|
| `resume-<RESUME_FILENAME>[-<profile>]-<company>-<tag>.pdf` | Title page → cover letter → resume (no TOC) |
| `resume-<RESUME_FILENAME>[-<profile>]-<company>-<tag>.epub` | Cover → chapter "Anschreiben" → resume |
| `<RESUME_FILENAME>[-<profile>]-<section>-<tag>.pdf` | Single sections (no cover letter) |

Tell the user the full paths and suggest opening the combined PDF.

## Additional resources

- YAML schema, DIN 5008 details, merge flow: [reference.md](reference.md)
- Repo rules for agents: [AGENTS.md](../../../AGENTS.md)
