# Mirror Side: Upstreaming Changes to Canonical Repos

This project contains mirrors of reusable libraries used across the environment:
- Mirror prompts → `projects/ai-env/prompts/` → upstream to `projects/prompts/`
- Mirror workflows → `projects/ai-env/workflows/` → upstream to `projects/workflows/`
- Mirror scripts → `projects/ai-env/scripts/` → upstream to `projects/scripts/`

Use this checklist when you’re ready to upstream environment‑local improvements.

## 0) Confirm Git Contexts
- This project is its own Git repo: `projects/ai-env/.git`
- Canonical libraries are separate repos (each has its own `.git`).

## 1) Identify What Changed
```bash
# In this repo (mirror side)
git status -- prompts/ workflows/ scripts/
```
- Collect any related notes/examples that justify the change.

## 2) Validate for Reuse
- Remove environment‑specific names/paths; generalize wording.
- Keep items small and composable; avoid giant docs/scripts.
- Ensure usage notes exist (what, when, how) at the top.

## 3) Upstream to Canonical
- Open the matching canonical repo in `projects/<name>/`.
- Follow its SYNC.md for detailed steps:
  - `projects/prompts/SYNC.md`
  - `projects/workflows/SYNC.md`
  - `projects/scripts/SYNC.md`
- Create a feature branch there, port the changes, and adapt links/paths.

## 4) Cross‑Link and PR
- Ensure cross‑links exist to `../../START-HERE.md` and `../../README.md` where relevant.
- Open a PR in the canonical repo with:
  - Intent and scope
  - Usage/examples
  - Notes on downstream consumers (apps/workflows)

## 5) Back‑propagate (Optional)
- If canonical edits improved the content, sync those refinements back into this mirror.

Tips
- Prefer linking over duplicating content to reduce drift.
- Keep canonical sets lean; keep domain‑specific variants here in the mirror.

## Routine Practice (Lightweight)

- Before and after a work session, run: `make status/mirrors` (optionally `SINCE=origin/main`).
- Paste notable sync outcomes here with a date, e.g.:
  - [YYYY-MM-DD] Prompts: 2 files updated (mirror → canonical); linked to PR XYZ
  - [YYYY-MM-DD] Workflows: Added acceptance criteria examples; synced to canonical
- Use `projects/ai-env/scripts/doc-health.sh <project-dir>` to spot missing AGENT guides/manifests/plans.
