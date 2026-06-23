# Resume build tasks

# Show available recipes
default: _help

[private]
_help:
    #!/usr/bin/env bash
    set -euo pipefail
    C=$'\033[36m' G=$'\033[32m' Y=$'\033[33m' M=$'\033[35m' B=$'\033[34m' X=$'\033[1m' D=$'\033[2m' Z=$'\033[0m'
    printf '\n%s%sresume%s %s— build tasks%s\n\n' "$X" "$C" "$Z" "$D" "$Z"
    printf '  %sbuild%s              %sDefault PDF + EPUB%s\n' "$G" "$Z" "$D" "$Z"
    printf '  %sbuild-iot%s           %sIoT profile variant%s\n' "$G" "$Z" "$D" "$Z"
    printf '  %sbuild-profile%s %s<name>%s  %sCustom profile override%s\n' "$G" "$Z" "$Y" "$Z" "$D" "$Z"
    printf '  %sbuild-letter%s %s<slug>%s   %sDefault + cover letter%s\n' "$G" "$Z" "$Y" "$Z" "$D" "$Z"
    printf '  %sbuild-letter-iot%s %s<slug>%s %sIoT + cover letter%s\n' "$G" "$Z" "$Y" "$Z" "$D" "$Z"
    printf '  %sbuild-letter-profile%s %s<slug> <profile>%s %sProfile + cover letter%s\n' "$G" "$Z" "$Y" "$Z" "$D" "$Z"
    printf '  %sbuild-all%s          %sAll variants (CI parity)%s\n' "$G" "$Z" "$D" "$Z"
    printf '  %sclean%s              %sRemove Temp/ and Results/%s\n' "$Y" "$Z" "$D" "$Z"
    printf '  %sdocker-pull%s        %sFetch pandoc image%s\n' "$M" "$Z" "$D" "$Z"
    printf '  %sdocker-repair%s      %sFix corrupted pandoc image cache%s\n' "$M" "$Z" "$D" "$Z"
    printf '  %stag%s                %sShow latest git tag%s\n' "$B" "$Z" "$D" "$Z"
    printf '  %sls%s                 %sList generated files%s\n' "$C" "$Z" "$D" "$Z"
    printf '\n'

[private]
_msg label color:
    #!/usr/bin/env bash
    set -euo pipefail
    case '{{color}}' in
      cyan)    C=$'\033[36m' ;;
      green)   C=$'\033[32m' ;;
      yellow)  C=$'\033[33m' ;;
      magenta) C=$'\033[35m' ;;
      blue)    C=$'\033[34m' ;;
      *)       C=$'\033[37m' ;;
    esac
    X=$'\033[1m' Z=$'\033[0m'
    printf '\n%s%s▶ %s%s\n\n' "$X" "$C" '{{label}}' "$Z"

# Build default resume (PDF + EPUB)
build: (_msg "Building default resume…" "cyan")
    #!/usr/bin/env bash
    set -euo pipefail
    ./Scripts/build.sh
    G=$'\033[32m' D=$'\033[2m' Z=$'\033[0m'
    printf '\n%s✓%s Default build complete. %sjust ls%s\n\n' "$G" "$Z" "$D" "$Z"

# Build resume with profile override (e.g. `just build-profile iot`)
build-profile profile: (_msg "Building profile: {{profile}}" "magenta")
    #!/usr/bin/env bash
    set -euo pipefail
    ./Scripts/build.sh --profile={{profile}}
    G=$'\033[32m' D=$'\033[2m' Z=$'\033[0m'
    printf '\n%s✓%s Profile {{profile}} complete. %sjust ls%s\n\n' "$G" "$Z" "$D" "$Z"

# Build IoT-focused resume variant
build-iot: (_msg "Building IoT profile…" "magenta")
    #!/usr/bin/env bash
    set -euo pipefail
    ./Scripts/build.sh --profile=iot
    G=$'\033[32m' D=$'\033[2m' Z=$'\033[0m'
    printf '\n%s✓%s IoT build complete. %sjust ls%s\n\n' "$G" "$Z" "$D" "$Z"

# Build default resume with local cover letter (e.g. `just build-letter acme-gmbh`)
build-letter letter: (_msg "Building default + letter: {{letter}}" "cyan")
    #!/usr/bin/env bash
    set -euo pipefail
    ./Scripts/build.sh --letter={{letter}}
    G=$'\033[32m' D=$'\033[2m' Z=$'\033[0m'
    printf '\n%s✓%s Build with letter {{letter}} complete. %sjust ls%s\n\n' "$G" "$Z" "$D" "$Z"

# Build IoT resume with cover letter (e.g. `just build-letter-iot acme-gmbh`)
build-letter-iot letter: (_msg "Building IoT + letter: {{letter}}" "magenta")
    #!/usr/bin/env bash
    set -euo pipefail
    ./Scripts/build.sh --profile=iot --letter={{letter}}
    G=$'\033[32m' D=$'\033[2m' Z=$'\033[0m'
    printf '\n%s✓%s IoT build with letter {{letter}} complete. %sjust ls%s\n\n' "$G" "$Z" "$D" "$Z"

# Build profile with cover letter (e.g. `just build-letter-profile acme-gmbh iot`)
build-letter-profile letter profile: (_msg "Building {{profile}} + letter: {{letter}}" "magenta")
    #!/usr/bin/env bash
    set -euo pipefail
    ./Scripts/build.sh --profile={{profile}} --letter={{letter}}
    G=$'\033[32m' D=$'\033[2m' Z=$'\033[0m'
    printf '\n%s✓%s Profile {{profile}} with letter {{letter}} complete. %sjust ls%s\n\n' "$G" "$Z" "$D" "$Z"

# Build all variants (same as CI)
build-all:
    #!/usr/bin/env bash
    set -euo pipefail
    X=$'\033[1m' B=$'\033[34m' G=$'\033[32m' Z=$'\033[0m'
    printf '\n%s%s▶ Building all variants…%s\n' "$X" "$B" "$Z"
    just build
    just build-iot
    printf '%s✓%s All builds complete.\n\n' "$G" "$Z"

# Remove build artifacts
clean:
    #!/usr/bin/env bash
    set -euo pipefail
    Y=$'\033[33m' G=$'\033[32m' D=$'\033[2m' Z=$'\033[0m'
    printf '%s▶%s Cleaning %sTemp/%s and %sResults/%s… ' "$Y" "$Z" "$D" "$Z" "$D" "$Z"
    rm -rf Temp Results
    printf '%sdone%s\n' "$G" "$Z"

# Pull pandoc Docker image (amd64 on Apple Silicon)
docker-pull:
    #!/usr/bin/env bash
    set -euo pipefail
    M=$'\033[35m' G=$'\033[32m' R=$'\033[31m' D=$'\033[2m' Z=$'\033[0m'
    platform=""
    case "$(uname -m)" in
      arm64|aarch64) platform="--platform linux/amd64" ;;
    esac
    printf '%s▶%s Pulling %sghcr.io/vergissberlin/pandoc-eisvogel-de%s…\n' "$M" "$Z" "$D" "$Z"
    # shellcheck disable=SC2086
    docker pull $platform ghcr.io/vergissberlin/pandoc-eisvogel-de
    if ! docker run --rm $platform ghcr.io/vergissberlin/pandoc-eisvogel-de pandoc --version >/dev/null 2>&1; then
      printf '%s✗%s Image pulled but container cannot run.\n' "$R" "$Z" >&2
      printf '  Try: %sjust docker-repair%s\n' "$G" "$Z" >&2
      exit 1
    fi
    printf '%s✓%s Image ready.\n' "$G" "$Z"

# Fix corrupted local pandoc image (checksum / empty binary)
docker-repair:
    #!/usr/bin/env bash
    set -euo pipefail
    sh Scripts/docker-repair.sh

# Show latest git tag (required for versioned output filenames)
tag:
    #!/usr/bin/env bash
    set -euo pipefail
    G=$'\033[32m' R=$'\033[31m' Y=$'\033[33m' B=$'\033[1m' Z=$'\033[0m'
    if tag=$(git describe --tags --abbrev=0 2>/dev/null); then
      printf '%s✓%s latest tag: %s%s%s\n' "$G" "$Z" "$B" "$tag" "$Z"
    else
      printf '%s✗%s no git tag found — try: %sgit tag 1.0.0%s\n' "$R" "$Z" "$Y" "$Z" >&2
      exit 1
    fi

# List generated files in Results/
ls:
    #!/usr/bin/env bash
    set -euo pipefail
    C=$'\033[36m' G=$'\033[32m' D=$'\033[2m' Z=$'\033[0m'
    if [ -d Results ] && [ -n "$(ls -A Results 2>/dev/null)" ]; then
      printf '\n%sResults/%s\n' "$C" "$Z"
      if ls --color=auto -lah Results/ 2>/dev/null; then
        :
      else
        CLICOLOR=1 ls -lahG Results/
      fi
      printf '\n'
    else
      printf '%sNo Results/ yet.%s Run: %sjust build%s\n' "$D" "$Z" "$G" "$Z"
    fi
