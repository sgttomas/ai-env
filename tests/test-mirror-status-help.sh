#!/usr/bin/env bash
set -euo pipefail

# Smoke test: ensure mirror-status help runs without error

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
MIRROR_SCRIPT="$SCRIPT_DIR/../scripts/mirror-status.sh"

if [[ ! -f "$MIRROR_SCRIPT" ]]; then
  echo "Missing mirror script at $MIRROR_SCRIPT" >&2
  exit 1
fi

bash "$MIRROR_SCRIPT" --help >/dev/null
echo "OK: mirror-status --help exits 0"

