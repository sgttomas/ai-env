# AI Environment (Meta‑Project)

Purpose: This is the meta‑project for your AI co‑development environment. It contains the environment‑local mirrors of prompts, scripts, and workflows, plus templates and dev history used to continually improve the system itself.

What lives here
- `prompts/`: Environment‑local prompt libraries and templates (mirror of the standalone `projects/prompts` repo).
- `scripts/`: Environment‑local helper scripts (mirror of `projects/scripts`).
- `workflows/`: Environment‑local playbooks/SOPs (mirror of `projects/workflows`).
- `templates/`: Authoring templates for guides, setup docs, and checklists.
- `devhistory/`: Directory structure, decisions, and improvement notes.
- `src/`, `tests/`: Optional utilities and validation for environment tooling.

How the mirrors work
- Use the mirrors here to iterate quickly within the environment.
- When patterns stabilize, upstream changes to the canonical repos in `projects/prompts`, `projects/scripts`, and `projects/workflows`.
- Keep artifacts close to where they’re used; sync selectively rather than wholesale copying.

When to use this project
- Prototyping new prompts/workflows/scripts tied to the environment.
- Authoring templates for repeated collaboration tasks.
- Capturing decisions and structure in `devhistory/` for traceability.

Why this is a project (not just a folder)
- It uses the same self‑referential, iterative, interlinked documentation formats that each application project uses.
- It is the reference implementation for templates and conventions that other projects adopt.
- Improvements made here (prompts/workflows/scripts/templates) flow outward to the canonical libraries and downstream projects.

Related projects
- `projects/chirality-semantic-framework`: The core meta‑learning framework (start here to understand the system).
- `projects/chirality-ai` and `projects/chirality-ai-app`: Orchestration and application layers that consume environment assets.

See also
- ../../START-HERE.md — Orientation and onboarding flow
- ../../README.md — Environment overview and mirrors
 - ./SYNC-NOTES.md — Mirror‑side checklist to upstream changes
 - ./templates/README.md — Templates index and reusable snippets

Tools
- `scripts/mirror-status.sh`: Summarize pending changes in `prompts/`, `workflows/`, and `scripts/` and verify README cross‑links.
  - Run: `bash scripts/mirror-status.sh --help`
  - Example: `bash scripts/mirror-status.sh --since origin/main`
  - Shortcuts and context:
    - Environment root (operative): `make status/mirrors` (optionally `SINCE=origin/main`)
    - Inside this mirror (in‑situ): `bash scripts/mirror-status.sh`
    - From canonical scripts (normative): `bash ../scripts/src/mirror-status.sh --repo-root . --areas prompts,workflows,scripts`

Context pattern
- Normative → Canonical libraries (`projects/scripts`, `projects/prompts`, `projects/workflows`)
- Operative → Environment‑local mirrors (this project)
- Evaluative → Status/tests (this tool, smoke tests)
- Deliberative → Devhistory/templates guiding improvements
