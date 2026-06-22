# Resume build tasks

# Show available recipes
default:
    @just --list --unsorted

# Build default resume (PDF + EPUB)
build:
    ./Scripts/build.sh

# Build resume with profile override (e.g. `just build-profile iot`)
build-profile profile:
    ./Scripts/build.sh --profile={{profile}}

# Build IoT-focused resume variant
build-iot:
    ./Scripts/build.sh --profile=iot

# Build all variants (same as CI)
build-all: build build-iot

# Remove build artifacts
clean:
    rm -rf Temp Results

# Pull pandoc Docker image
docker-pull:
    docker pull ghcr.io/vergissberlin/pandoc-eisvogel-de

# Show latest git tag (required for versioned output filenames)
tag:
    @git describe --tags --abbrev=0

# List generated files in Results/
ls:
    @ls -lah Results/ 2>/dev/null || echo "No Results/ yet. Run: just build"
