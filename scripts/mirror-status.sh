#!/usr/bin/env bash
set -euo pipefail

show_help() {
  cat <<'EOF'
mirror-status.sh — summarize mirror changes for prompts/workflows/scripts

Usage:
  bash mirror-status.sh [--mirror-root PATH] [--since REV] [--drift-root PATH] [--dry-run]

Options:
  --mirror-root PATH  Path to mirror repo root (defaults to script's repo)
  --since REV         Show name-status diff since a Git ref (e.g., origin/main)
  --drift-root PATH   Compare file drift vs a canonical root (name + hash)
  --dry-run           Compute only; never modify anything (default behavior)
  --help              Show this help

What it does:
  - Runs git status for prompts/, workflows/, scripts/ within the mirror repo
  - Prints counts and file lists per area
  - If --since is provided, shows name-status diffs since the given ref
  - Warns if expected cross-links are missing in mirror README

Safe by default: no write operations are performed.
EOF
}

# Defaults
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# Mirror root defaults to the git toplevel of the script location if available, otherwise two levels up
if git -C "$SCRIPT_DIR/.." rev-parse --show-toplevel >/dev/null 2>&1; then
  DEFAULT_MIRROR_ROOT="$(git -C "$SCRIPT_DIR/.." rev-parse --show-toplevel)"
else
  DEFAULT_MIRROR_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
fi

MIRROR_ROOT="$DEFAULT_MIRROR_ROOT"
SINCE_REV=""
DRY_RUN=1
DRIFT_ROOT=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --mirror-root)
      MIRROR_ROOT="$2"; shift 2 ;;
    --since)
      SINCE_REV="$2"; shift 2 ;;
    --dry-run)
      DRY_RUN=1; shift ;;
    --drift-root)
      DRIFT_ROOT="$2"; shift 2 ;;
    --help|-h)
      show_help; exit 0 ;;
    *)
      echo "Unknown argument: $1" >&2
      show_help; exit 2 ;;
  esac
done

if [[ ! -d "$MIRROR_ROOT" ]]; then
  echo "Mirror root does not exist: $MIRROR_ROOT" >&2
  exit 1
fi

if ! git -C "$MIRROR_ROOT" rev-parse --git-dir >/dev/null 2>&1; then
  echo "Not a Git repo: $MIRROR_ROOT" >&2
  exit 1
fi

echo "Mirror root: $MIRROR_ROOT"

areas=(prompts workflows scripts)
total_changes=0
for area in "${areas[@]}"; do
  if [[ -d "$MIRROR_ROOT/$area" ]]; then
    echo "--- $area/"
    status_out="$(git -C "$MIRROR_ROOT" status --porcelain -- "$area/" || true)"
    if [[ -n "$status_out" ]]; then
      echo "$status_out"
      count=$(printf "%s\n" "$status_out" | wc -l | tr -d ' ')
      echo "($count change(s))"
      total_changes=$(( total_changes + count ))
    else
      echo "(clean)"
    fi

    if [[ -n "$SINCE_REV" ]]; then
      echo "Diff since $SINCE_REV:"
      git -C "$MIRROR_ROOT" diff --name-status "$SINCE_REV" -- "$area/" || true
    fi
  else
    echo "--- $area/ (missing)"
  fi
done

echo "Total changes across mirrors: $total_changes"

# Cross-link checks in mirror README
readme_path="$MIRROR_ROOT/README.md"
if [[ -f "$readme_path" ]]; then
  missing_links=()
  grep -q "START-HERE.md" "$readme_path" || missing_links+=("START-HERE.md")
  grep -q "README.md — Environment" "$readme_path" || grep -q "../../README.md" "$readme_path" || missing_links+=("../../README.md")
  grep -q "SYNC-NOTES.md" "$readme_path" || missing_links+=("SYNC-NOTES.md")

  if (( ${#missing_links[@]} > 0 )); then
    echo "WARN: Mirror README is missing cross-link(s): ${missing_links[*]}" >&2
  else
    echo "Mirror README cross-links look good."
  fi
else
  echo "WARN: Mirror README not found at $readme_path" >&2
fi

# Optional drift check vs DRIFT_ROOT
if [[ -n "$DRIFT_ROOT" ]]; then
  if ! git -C "$DRIFT_ROOT" rev-parse --git-dir >/dev/null 2>&1; then
    echo "WARN: --drift-root is not a Git repo: $DRIFT_ROOT" >&2
  fi
  echo "\nDrift check vs: $DRIFT_ROOT"
  for area in "${areas[@]}"; do
    area_trimmed="${area//[[:space:]]/}"
    echo "--- Drift: $area_trimmed/"
    if [[ ! -d "$MIRROR_ROOT/$area_trimmed" ]] && [[ ! -d "$DRIFT_ROOT/$area_trimmed" ]]; then
      echo "(missing in both)"; continue
    fi
    mapfile -t list_m < <(cd "$MIRROR_ROOT" && find "$area_trimmed" -type f -print | LC_ALL=C sort || true)
    mapfile -t list_c < <(cd "$DRIFT_ROOT" && find "$area_trimmed" -type f -print | LC_ALL=C sort || true)
    tmp_m=$(mktemp); tmp_c=$(mktemp)
    printf "%s\n" "${list_m[@]}" > "$tmp_m"
    printf "%s\n" "${list_c[@]}" > "$tmp_c"
    only_m=$(comm -23 "$tmp_m" "$tmp_c" | wc -l | tr -d ' ')
    only_c=$(comm -13 "$tmp_m" "$tmp_c" | wc -l | tr -d ' ')
    echo "Only in mirror: $only_m"
    echo "Only in canonical: $only_c"
    mapfile -t common < <(comm -12 "$tmp_m" "$tmp_c")
    diff_hash=0
    for p in "${common[@]}"; do
      [[ -n "$p" ]] || continue
      h1=$(shasum -a 1 "$MIRROR_ROOT/$p" | awk '{print $1}')
      h2=$(shasum -a 1 "$DRIFT_ROOT/$p" | awk '{print $1}')
      if [[ "$h1" != "$h2" ]]; then
        diff_hash=$((diff_hash+1))
      fi
    done
    echo "Hash diffs on common files: $diff_hash"
    rm -f "$tmp_m" "$tmp_c"
  done
fi

exit 0
