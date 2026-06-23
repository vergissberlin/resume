# Resume - André Lademann

[![GitHub all releases](https://img.shields.io/github/downloads/vergissberlin/resume/total?style=for-the-badge)](https://github.com/vergissberlin/resume/releases)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/vergissberlin/resume?style=for-the-badge)](https://github.com/vergissberlin/resume/releases/latest)
[![CV - Download](https://img.shields.io/badge/CV-Download-2ea44f?style=for-the-badge)](https://github.com/vergissberlin/resume/releases)

[![André Laserman CV](./Content/Media/Mock/Mock-1.png)](Content/1-curriculum-vitae.md)

## Documents

You can view the documents directly here at GitHub, or download them as PDF/EBook.

| View                                                 | Download                                                          |
|------------------------------------------------------|-------------------------------------------------------------------|
| [📄 Introduction](Content/0-introduction.md)         | [📄 PDF](https://github.com/vergissberlin/resume/releases/latest) |
| [📄 Curriculum Vitae](Content/1-curriculum-vitae.md) | [📄 PDF](https://github.com/vergissberlin/resume/releases/latest) |
| [📄 Profile](Content/2-portfolio.md)                 | [📄 PDF](https://github.com/vergissberlin/resume/releases/latest) |
| [📄 Contact](Content/3-contact.md)                   | [📄 PDF](https://github.com/vergissberlin/resume/releases/latest) |

---

## Local cover letter (not committed)

For job applications you can prepend a DIN 5008 cover letter after the PDF title page. Letters stay local in `Content/Application/` (gitignored).

```sh
mkdir -p Content/Application
cp Content/Application.example/example-gmbh.md Content/Application/meine-firma.md
# Edit Content/Application/meine-firma.md (recipient, subject, body)
./Scripts/build.sh --letter=meine-firma
```

Or with [just](https://github.com/casey/just):

```sh
just build-letter meine-firma
just build-letter-iot meine-firma
```

Optional: `COVER_LETTER=meine-firma` in `Content/Application/.env` so you can run `./Scripts/build.sh` without the flag.

Combined PDF/EPUB filenames include the company from the letter (`letter.company` or the first line of `letter.to`), e.g. `Results/resume-andrelademann-example-gmbh-1.3.2.pdf`.

**Apple Silicon / OrbStack:** The pandoc image is `linux/amd64`. If builds fail with `exec format error` or `checksum failed`, run `just docker-repair`. If that still fails: OrbStack → Settings → Storage → **Reset Docker data**, then `just docker-pull`.

---

## License

This software is licensed under  the [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-nc-sa/4.0/).
