#!/usr/bin/env sh

# Build PDF files for each Markdown file in the content directory
# and place them in the output directory.

################################################################################
## Include functions
################################################################################
. Scripts/functions.sh


################################################################################
## Parse arguments
################################################################################

PROFILE=""
COVER_LETTER=""
for arg in "$@"; do
  case $arg in
    --profile=*) PROFILE="${arg#*=}" ;;
    --letter=*) COVER_LETTER="${arg#*=}" ;;
  esac
done


################################################################################
## Variables
################################################################################

# Get current date in format DD.MM.YYYY
document_date=$(date +%d.%m.%Y)

# Get current year in format YYYY
document_date_year=$(date +%Y)

# Get latest git tag
document_git_tag=$(git describe --tags --abbrev=0)

# Load dot env file with variables
if [ $CI ]; then
  dontenv .env
else
  set -a
  source .env
  set +a
fi

# Load profile-specific env overrides if a profile is set
if [ -n "$PROFILE" ] && [ -f ".env.${PROFILE}" ]; then
  set -a
  source ".env.${PROFILE}"
  set +a
fi

# Load local application settings (gitignored)
if [ -f "Bewerbung/.env" ]; then
  set -a
  # shellcheck disable=SC1091
  source Bewerbung/.env
  set +a
fi

# Profile suffix for output filenames (empty for default profile)
PROFILE_SUFFIX=""
if [ -n "$PROFILE" ]; then
  PROFILE_SUFFIX="-${PROFILE}"
fi

# Cover letter (local only, optional)
LETTER_ACTIVE=0
LETTER_FILE=""
if [ -n "$COVER_LETTER" ]; then
  LETTER_FILE="Bewerbung/Anschreiben/${COVER_LETTER}.md"
  if [ -f "$LETTER_FILE" ]; then
    LETTER_ACTIVE=1
  else
    echo "⚠️\tCover letter \"${COVER_LETTER}\" not found at ${LETTER_FILE} – building without letter"
  fi
fi

################################################################################
## Environment specific replacements commands
################################################################################

if [ $CI ]; then
	sedcmd="sed -i"
else
	sedcmd="sed -i ''"
fi

################################################################################
## Requirement
################################################################################

# Check if Docker is installed
if ! [ -x "$(command -v docker)" ]; then
  echo "🚨\tDocker is not installed. Please install Docker!"
  exit 1
fi

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
  echo "🚨\tDocker is not running. Please start Docker!"
  exit 1
fi

# Check if sed is installed
if ! [ -x "$(command -v sed)" ]; then
  echo "🚨\tSed is not installed. Please install Sed!"
  exit 1
fi

# Pull docker image ghcr.io/vergissberlin/pandoc-eisvogel-de from GitHub Container Registry if it doesn't exist
if ! docker image inspect ghcr.io/vergissberlin/pandoc-eisvogel-de > /dev/null 2>&1; then
    echo "👉\tPull docker image ghcr.io/vergissberlin/pandoc-eisvogel-de from GitHub Container Registry"
    docker_pandoc_pull
fi

verify_docker_pandoc


################################################################################
## Prepare
################################################################################

# Create temporary directory
mkdir -p Temp

# Copy non-markdown assets (Media, etc.) from the content directory
cp -R Content/Media Temp/ 2>/dev/null || true

# Copy markdown files: use profile override if available, else default
for file in Content/*.md; do
  fname=$(basename "$file")
  if [ -n "$PROFILE" ] && [ -f "Content/Profiles/${PROFILE}/${fname}" ]; then
    cp "Content/Profiles/${PROFILE}/${fname}" Temp/
  else
    cp "$file" Temp/
  fi
done

# Create the output directory if it doesn't exist and delete all files in it
mkdir -p Results
rm -rf Results/*


################################################################################
## Modifier
################################################################################

# Replace some characters in the Markdown files which are not supported by Pandoc
# and place the modified files in the temporary directory
echo "✅\tFilter and replace characters in Markdown files"
for file in Temp/*.md; do
    sh Scripts/filter.sh ${file}
    sh Scripts/replace.sh ${file}
done

# Delete files in temporary directory which are not Markdown files
find Temp -type f -name '*.md"' -delete

# Prepare optional cover letter (local Bewerbung/ folder)
if [ "$LETTER_ACTIVE" -eq 1 ]; then
  echo "✅\tPrepare cover letter \"${COVER_LETTER}\""
  cp "$LETTER_FILE" Temp/letter.md
  sh Scripts/filter.sh Temp/letter.md
  sh Scripts/replace.sh Temp/letter.md
fi

################################################################################
## Generate Multiple Documents
################################################################################

## Generate separate PDF files for each Markdown file in the content directory
echo "\n✅\tGenerate PDF for each file"

# Generate PDF files (content sections only, not cover letter)
for file in Temp/[0-9]*.md; do
  # Check if $file is a file
  if [ -f "$file" ]; then
    # Get the filename without the extension
    filename=$(basename -- "$file")
    filename="${filename%.*}"
    # Strip leading numbers and following dash from filename
    filename=$(echo $filename | sed 's/^[0-9]-*//')

    # Get the headline from the Markdown file
    title=$(grep -m 1 '^# ' $file | sed 's/# //')

    echo "👉\tBuild single PDF for \"${title}\""
    docker_pandoc_run ${file} \
      -o Results/${RESUME_FILENAME}${PROFILE_SUFFIX}-${filename}-${document_git_tag}.pdf \
      --defaults Template/Config/defaults-pdf-single.yml \
      --metadata-file Template/Config/metadata-pdf.yml \
      -V title="${title}" \
      -V author="${RESUME_AUTHOR}" \
      -V subject="${RESUME_SUBJECT}" \
      -V footer-center="v$document_git_tag" \
      -V date="$document_date";
  fi
done

################################################################################
## Generate PDF with combined content
################################################################################

echo "\n✅\tGenerate PDF with combined content"

# Combine content Markdown files into a single file (exclude cover letter)
echo "👉\tCombine all Markdown files into a single Markdown file"
cat Temp/[0-9]*.md > Temp/combined.md

# Filter and replace characters in the single Markdown file
echo "👉\tFilter and replace characters in single Markdown file"
sh Scripts/filter.sh Temp/combined.md

## Replace some characters in the single Markdown file which are not supported by Pandoc
echo "👉\tReplace characters in single Markdown file"
sh Scripts/replace.sh Temp/combined.md

# Use profile-specific PDF defaults if available, else fall back to default
DEFAULTS_PDF="Template/Config/defaults-pdf.yml"
if [ -n "$PROFILE" ] && [ -f "Template/Config/defaults-pdf-${PROFILE}.yml" ]; then
  DEFAULTS_PDF="Template/Config/defaults-pdf-${PROFILE}.yml"
fi

RESUME_PDF_OUTPUT="Results/resume-${RESUME_FILENAME}${PROFILE_SUFFIX}-${document_git_tag}.pdf"
RESUME_PDF_TEMP="Temp/resume-full.pdf"

# EPUB source: optionally prepend cover letter body after the cover image
EPUB_SOURCE="Temp/combined.md"
if [ "$LETTER_ACTIVE" -eq 1 ]; then
  awk 'BEGIN{fm=0} /^---$/{fm++; next} fm>=2{print}' Temp/letter.md > Temp/letter-body.md
  printf '%s\n\n' "# Anschreiben" > Temp/letter-epub.md
  cat Temp/letter-body.md >> Temp/letter-epub.md
  cat Temp/letter-epub.md Temp/combined.md > Temp/combined-with-letter.md
  EPUB_SOURCE="Temp/combined-with-letter.md"
fi

# Generate a single PDF file from all Markdown files in the content directory
echo "👉\tGenerate PDF for all files"
docker_pandoc_run -i \
  -o ${RESUME_PDF_TEMP} \
  --defaults ${DEFAULTS_PDF} \
  --metadata-file Template/Config/metadata-pdf.yml \
  -V title="${RESUME_NAME}" \
  -V subtitle="Resume" \
  -V subject="${RESUME_SUBJECT}" \
  -V lang="en" \
  -V author="${RESUME_AUTHOR}" \
  -V description="Resume by ${RESUME_AUTHOR}" \
  -V footer-center="v$document_git_tag" \
  -V rights="© ${document_date_year} ${RESUME_NAME}, ${RESUME_LICENSE}" \
  -V date="$document_date" \
  Temp/combined.md;

if [ "$LETTER_ACTIVE" -eq 1 ]; then
  echo "👉\tGenerate cover letter PDF (DIN 5008)"
  docker_pandoc_run -i \
    -o Temp/letter.pdf \
    --defaults Template/Config/defaults-letter-pdf.yml \
    Temp/letter.md;

  if [ ! -f Temp/letter.pdf ] || [ ! -f "${RESUME_PDF_TEMP}" ]; then
    echo "🚨\tPDF generation failed – cannot merge cover letter"
    exit 1
  fi

  echo "👉\tMerge cover letter after title page"
  sh Scripts/merge-letter-pdf.sh Temp/resume-full.pdf Temp/letter.pdf "${RESUME_PDF_OUTPUT}"
else
  mv "${RESUME_PDF_TEMP}" "${RESUME_PDF_OUTPUT}"
fi

# Generate a singe epub file from all Markdown files in the content directory
echo "👉\tGenerate EPUB for all files"
docker_pandoc_run -i \
  -o Results/resume-${RESUME_FILENAME}${PROFILE_SUFFIX}-${document_git_tag}.epub \
  --defaults Template/Config/defaults-epub.yml \
  --metadata-file Template/Config/metadata-epub.yml \
  -V title="${RESUME_NAME}" \
  -V subtitle="Resume ${document_git_tag}" \
  -V subject="${RESUME_SUBJECT}" \
  -V author="Author: ${RESUME_AUTHOR}" \
  -V titlepage-logo="Content/Media/Cover/Cover-IOT.png" \
  -V description="Resume by ${RESUME_AUTHOR}" \
  -V rights="© ${document_date_year} ${RESUME_NAME}, ${RESUME_LICENSE}" \
  -V ibooks.version="$document_git_tag" \
  -V date="$document_date" \
  ${EPUB_SOURCE};


################################################################################
## Clean up
################################################################################

# Remove the temporary directory
rm -rf Temp
