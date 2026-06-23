#!/usr/bin/env sh
# Extract company name from cover letter YAML and print a filesystem-safe slug.
# Usage: letter-company-slug.sh <letter.md> [fallback-slug]
#
# Prefers letter.company; otherwise the first entry in letter.to.
# Falls back to the optional second argument (e.g. the letter file slug).

set -eu

LETTER_FILE="${1:?letter file required}"
FALLBACK_SLUG="${2:-}"

company=$(
  awk '
    BEGIN { in_fm = 0; in_letter = 0; in_to = 0 }
    /^---$/ {
      if (in_fm) { exit }
      in_fm = 1
      next
    }
    in_fm && /^letter:/ { in_letter = 1; next }
    in_letter && /^[^[:space:]]/ { in_letter = 0; in_to = 0 }
    in_letter && /^[[:space:]]+company:/ {
      line = $0
      sub(/^[[:space:]]+company:[[:space:]]*/, "", line)
      gsub(/^["'\'']|["'\'']$/, "", line)
      print line
      exit
    }
    in_letter && /^[[:space:]]+to:/ { in_to = 1; next }
    in_to && /^[[:space:]]+-[[:space:]]/ {
      line = $0
      sub(/^[[:space:]]+-[[:space:]]*/, "", line)
      gsub(/^["'\'']|["'\'']$/, "", line)
      print line
      exit
    }
    in_to && /^[[:space:]]+[^-]/ { in_to = 0 }
  ' "$LETTER_FILE"
)

if [ -z "$company" ]; then
  if [ -n "$FALLBACK_SLUG" ]; then
    printf '%s' "$FALLBACK_SLUG"
    exit 0
  fi
  echo "🚨\tCould not extract company name from ${LETTER_FILE}" >&2
  exit 1
fi

printf '%s' "$company" \
  | tr '[:upper:]' '[:lower:]' \
  | sed -e 's/ä/ae/g' -e 's/ö/oe/g' -e 's/ü/ue/g' -e 's/ß/ss/g' \
  | sed 's/[^a-z0-9]/-/g' \
  | sed -e 's/-\+/-/g' -e 's/^-//' -e 's/-$//'
