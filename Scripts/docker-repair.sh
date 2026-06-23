#!/usr/bin/env sh

# Re-download the pandoc Docker image when local layers are corrupted.

set -e

. Scripts/functions.sh

echo "👉\tRemove cached ${PANDOC_IMAGE}"
docker rmi -f "$PANDOC_IMAGE" >/dev/null 2>&1 || true

echo "👉\tPrune unused images"
docker image prune -af >/dev/null 2>&1 || true

echo "👉\tPull fresh image"
docker_pandoc_pull

if docker save "$PANDOC_IMAGE" -o /dev/null 2>/dev/null; then
  :
else
  echo "🚨\tImage still corrupted after re-pull (checksum failed)."
  echo "    OrbStack: Settings → Reset Docker data, then: just docker-pull"
  echo "    Or: orbctl reset -y  (removes all Docker data)"
  exit 1
fi

if docker_pandoc_run pandoc --version >/dev/null 2>&1; then
  echo "✅\t${PANDOC_IMAGE} is ready"
  docker_pandoc_run pandoc --version | head -1
else
  echo "🚨\tImage pulled but pandoc still cannot run."
  echo "    Check amd64 emulation or reset OrbStack Docker data."
  exit 1
fi
