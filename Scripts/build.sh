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
for arg in "$@"; do
  case $arg in
    --profile=*) PROFILE="${arg#*=}" ;;
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

# Profile suffix for output filenames (empty for default profile)
PROFILE_SUFFIX=""
if [ -n "$PROFILE" ]; then
  PROFILE_SUFFIX="-${PROFILE}"
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
    docker pull ghcr.io/vergissberlin/pandoc-eisvogel-de
fi


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

################################################################################
## Generate Multiple Documents
################################################################################

## Generate separate PDF files for each Markdown file in the content directory
echo "\n✅\tGenerate PDF for each file"

# Generate PDF files
for file in Temp/*.md; do
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
    docker run -v $PWD:/data ghcr.io/vergissberlin/pandoc-eisvogel-de ${file} \
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

# Combine all Markdown files from Temp into a single Markdown file
echo "👉\tCombine all Markdown files into a single Markdown file"
cat Temp/*.md > Temp/combined.md

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

# Generate a single PDF file from all Markdown files in the content directory
echo "👉\tGenerate PDF for all files"
docker run -i -v $PWD:/data ghcr.io/vergissberlin/pandoc-eisvogel-de \
  -o Results/resume-${RESUME_FILENAME}${PROFILE_SUFFIX}-${document_git_tag}.pdf \
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

# Generate a singe epub file from all Markdown files in the content directory
echo "👉\tGenerate EPUB for all files"
docker run -i -v $PWD:/data ghcr.io/vergissberlin/pandoc-eisvogel-de \
  -o Results/resume-${RESUME_FILENAME}${PROFILE_SUFFIX}-${document_git_tag}.epub \
  --defaults Template/Config/defaults-epub.yml \
  --metadata-file Template/Config/metadata-epub.yml \
  -V title="${RESUME_NAME}" \
  -V subtitle="Resume ${document_git_tag}" \
  -V subject="${RESUME_SUBJECT}" \
  -V author="Author: ${RESUME_AUTHOR}" \
  -V titlepage-logo="Content/Media/andrelademann.png" \
  -V description="Resume by ${RESUME_AUTHOR}" \
  -V rights="© ${document_date_year} ${RESUME_NAME}, ${RESUME_LICENSE}" \
  -V ibooks.version="$document_git_tag" \
  -V date="$document_date" \
  Temp/combined.md;


################################################################################
## Clean up
################################################################################

# Remove the temporary directory
rm -rf Temp
