#!/usr/bin/env bash
set -euo pipefail

# Simple doc health check for AGENT guides, manifests, and plans.
# Scans a target project for required docs and reports PASS/WARN/FAIL.

ROOT="${1:-projects/vibe-project}"
MAX_AGE_DAYS=${DOC_HEALTH_MAX_AGE_DAYS:-60}

if [[ ! -d "$ROOT" ]]; then
  echo "Usage: bash projects/ai-env/scripts/doc-health.sh <project-dir>" >&2
  exit 2
fi

now_ts=$(date +%s)
age_days() {
  local f="$1"
  if [[ ! -e "$f" ]]; then echo 99999; return; fi
  local mt=$(date -r "$f" +%s 2>/dev/null || stat -c %Y "$f")
  echo $(((now_ts - mt) / 86400))
}

require() {
  local path="$1"; local label="$2"
  if [[ -f "$path" ]]; then
    local days=$(age_days "$path")
    if (( days > MAX_AGE_DAYS )); then
      echo "WARN: $label present but stale (${days}d) -> $path"
      return 1
    else
      echo "OK: $label present (${days}d) -> $path"
      return 0
    fi
  else
    echo "FAIL: $label missing -> $path"
    return 2
  fi
}

echo "Doc Health for: $ROOT (max age ${MAX_AGE_DAYS}d)"
status=0

# Onboarding and AGENT guides at project root
require "$ROOT/AGENT_ONBOARDING_GUIDE.md" "Onboarding guide" || status=$?
require "$ROOT/AGENT_PERFORMANCE_OPTIMIZATION_GUIDE.md" "Performance optimization guide" || status=$?

# Improvement plans (process docs)
require "$ROOT/CONTINUOUS_IMPROVEMENT_PLAN.md" "Continuous improvement plan" || status=$?
require "$ROOT/CONSOLIDATED_IMPROVEMENT_PLAN.md" "Consolidated improvement plan" || status=$?

# Mirrors contain manifests and AGENT.md
while IFS= read -r -d '' mirror; do
  require "$mirror/KNOWLEDGE_TRANSFER_MANIFEST.md" "Manifest in $(basename "$mirror")" || status=$?
  require "$mirror/AGENT.md" "Mirror AGENT guide in $(basename "$mirror")" || status=$?
done < <(find "$ROOT" -type d -path '*/lib/*' -maxdepth 2 -print0)

if (( status > 1 )); then
  echo "Doc Health: FAIL"
  exit 1
elif (( status == 1 )); then
  echo "Doc Health: WARN"
  exit 0
else
  echo "Doc Health: PASS"
  exit 0
fi

