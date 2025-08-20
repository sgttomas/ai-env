# Project Quadrants (Drop‑in Snippet)

Purpose: Copy this section into any project README to anchor how the project is defined (normative), executed (operative), validated (evaluative), and evolved (deliberative).

Usage: Paste into your README and replace placeholders like `{{project_name}}`. Adjust the relative link to the environment doc if needed.

## Project Quadrants — {{project_name}}

- Normative: What standards or reusable forms does {{project_name}} define or adopt?
  - Examples: API contracts, prompt formats, workflow patterns, coding conventions
  - Links: environment model (adjust path): `docs/CO-DEV-QUADRANTS.md`
- Operative: How does work run here in practice?
  - Examples: mirrors/consumers used, run scripts, local dev flow, CI entrypoint
- Evaluative: How is correctness and quality verified?
  - Examples: smoke tests, status helpers, benchmarks, acceptance criteria
- Deliberative: How do we capture decisions and evolve?
  - Examples: devhistory, ADRs, improvement plans, templates used

Quick checks
- [ ] README links to `docs/CO-DEV-QUADRANTS.md` (adjust path as needed)
- [ ] Smoke test present for key interfaces or scripts
- [ ] Mirror ↔ canonical links documented (if applicable)
- [ ] Recent decisions captured in devhistory/ or ADRs

Notes
- Keep this section concise (1–2 bullets per quadrant); link to detailed docs instead of duplicating.
- The environment model: `docs/CO-DEV-QUADRANTS.md` (relative path depends on project location).
