#!/usr/bin/env bash
set -euo pipefail

# Run a command across child repos in projects/*
# Usage: bash projects/ai-env/scripts/all-repos.sh [--include PAT] [--exclude PAT] -- <cmd...>

include_pat="*"
exclude_pat=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --include) include_pat="$2"; shift 2;;
    --exclude) exclude_pat="$2"; shift 2;;
    --) shift; break;;
    *) echo "Unknown arg: $1" >&2; exit 2;;
  esac
done

if [[ $# -eq 0 ]]; then
  echo "Provide a command after --, e.g.: -- git status -s" >&2
  exit 2
fi

cmd=("$@")

for repo in projects/*; do
  [[ -d "$repo/.git" ]] || continue
  name="$(basename "$repo")"
  [[ "$name" == $include_pat ]] || continue
  if [[ -n "$exclude_pat" && "$name" == $exclude_pat ]]; then continue; fi
  echo "== $repo =="
  (cd "$repo" && "${cmd[@]}") || true
  echo "---"
done

