#!/usr/bin/env sh

# Merge resume PDF: page 1 (title) + letter PDF + remaining resume pages.
# Usage: merge-letter-pdf.sh <resume.pdf> <letter.pdf> <output.pdf>

set -e

RESUME_PDF="$1"
LETTER_PDF="$2"
OUTPUT_PDF="$3"
WORKDIR="${4:-Temp}"

if [ -z "$RESUME_PDF" ] || [ -z "$LETTER_PDF" ] || [ -z "$OUTPUT_PDF" ]; then
  echo "🚨\tUsage: merge-letter-pdf.sh <resume.pdf> <letter.pdf> <output.pdf> [workdir]"
  exit 1
fi

mkdir -p "$WORKDIR"

merge_with_qpdf() {
  qpdf --empty --pages "$RESUME_PDF" 1 "$LETTER_PDF" "$RESUME_PDF" 2-z -- "$OUTPUT_PDF"
}

merge_with_pdfunite() {
  PAGE1="${WORKDIR}/merge-page1.pdf"
  REST_PREFIX="${WORKDIR}/merge-rest"

  rm -f "${WORKDIR}"/merge-page1.pdf "${WORKDIR}"/merge-rest-*.pdf

  if ! pdfseparate -f 1 -l 1 "$RESUME_PDF" "$PAGE1" 2>/dev/null; then
    echo "🚨\tCannot read resume PDF for merge: ${RESUME_PDF}"
    exit 1
  fi

  if ! pdfseparate -f 2 "$RESUME_PDF" "${REST_PREFIX}-%d.pdf" 2>/dev/null; then
    echo "🚨\tCannot split resume PDF for merge: ${RESUME_PDF}"
    exit 1
  fi

  if [ ! -f "$LETTER_PDF" ]; then
    echo "🚨\tCover letter PDF not found: ${LETTER_PDF}"
    exit 1
  fi

  # shellcheck disable=SC2086
  pdfunite "$PAGE1" "$LETTER_PDF" ${REST_PREFIX}-*.pdf "$OUTPUT_PDF"

  rm -f "${WORKDIR}"/merge-page1.pdf "${WORKDIR}"/merge-rest-*.pdf
}

merge_with_docker_qpdf() {
  docker run --rm -v "$PWD:/data" minidocks/qpdf \
    qpdf --empty --pages \
    "/data/${RESUME_PDF#./}" 1 \
    "/data/${LETTER_PDF#./}" \
    "/data/${RESUME_PDF#./}" 2-z \
    -- "/data/${OUTPUT_PDF#./}"
}

if command -v qpdf >/dev/null 2>&1; then
  merge_with_qpdf
elif command -v pdfunite >/dev/null 2>&1 && command -v pdfseparate >/dev/null 2>&1; then
  merge_with_pdfunite
elif docker info >/dev/null 2>&1; then
  echo "👉\tMerging PDFs via Docker (minidocks/qpdf)"
  docker pull minidocks/qpdf >/dev/null 2>&1 || true
  merge_with_docker_qpdf
else
  echo "🚨\tNo PDF merge tool found. Install qpdf or poppler (pdfunite/pdfseparate), or start Docker."
  exit 1
fi
