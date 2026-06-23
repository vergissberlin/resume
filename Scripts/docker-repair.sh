#!/usr/bin/env sh

# Re-download the pandoc Docker image when local layers are corrupted.

set -e

. Scripts/functions.sh

CACHE_TAR="${TMPDIR:-/tmp}/pandoc-eisvogel-de-repair.tar"

image_ok() {
  docker save "$PANDOC_IMAGE" -o /dev/null 2>/dev/null \
    && docker_pandoc_run pandoc --version >/dev/null 2>&1
}

echo "👉\tRemove cached ${PANDOC_IMAGE}"
docker rmi -f "$PANDOC_IMAGE" >/dev/null 2>&1 || true

echo "👉\tPrune unused images"
docker image prune -af >/dev/null 2>&1 || true

echo "👉\tPull fresh image"
docker_pandoc_pull

if image_ok; then
  echo "✅\t${PANDOC_IMAGE} is ready"
  docker_pandoc_run pandoc --version | head -1
  exit 0
fi

if command -v crane >/dev/null 2>&1; then
  echo "👉\tLayer cache still bad – re-import via crane (bypasses OrbStack cache)"
  rm -f "$CACHE_TAR"
  crane pull "$PANDOC_IMAGE:latest" "$CACHE_TAR"
  docker load -i "$CACHE_TAR"
  rm -f "$CACHE_TAR"
fi

if image_ok; then
  echo "✅\t${PANDOC_IMAGE} is ready (imported via crane)"
  docker_pandoc_run pandoc --version | head -1
  exit 0
fi

echo "🚨\tLocal OrbStack Docker storage is still corrupted."
echo ""
echo "    Fix (OrbStack – resets Docker only, keeps Linux machines):"
echo "      OrbStack app → Settings → Storage → Reset Docker data"
echo "    Or in terminal (destructive – all local images/volumes):"
echo "      orb delete docker"
echo ""
echo "    Then:"
echo "      just docker-pull"
echo "      just build-letter-iot example-gmbh"
exit 1
