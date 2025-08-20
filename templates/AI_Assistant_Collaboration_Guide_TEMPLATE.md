AI Assistant Collaboration Guide TEMPLATE — [PROJECT_NAME]

Audience: Future AI assistants (and human collaborators) working on [PROJECT_NAME].
Template Version: 1.0 (model‑agnostic)
Stack: [FRONTEND_TECH] • [BACKEND_TECH] • [LANGUAGE/RUNTIME] • [DB/INFRA]
Methodology: Systematic, auditable human–AI collaboration patterns.

🔁 How to customize: Before use, replace all bracketed tokens and prune sections that don’t apply to your stack.

⸻

0) Template Customization Checklist (Do This First)
	•	Replace [PROJECT_NAME], [FRONTEND_TECH], [BACKEND_TECH], [LANGUAGE/RUNTIME], [DB/INFRA].
	•	Set commands: [PACKAGE_MANAGER], [DEV_COMMAND], [BUILD_COMMAND], [TEST_COMMAND], [LINT_COMMAND], [TYPECHECK_COMMAND].
	•	Set paths: [FRONTEND_DIR], [BACKEND_DIR], [DOCS_DIR], [INFRA_DIR].
	•	Confirm canonical docs exist: README.md, ARCHITECTURE.md, STATUS_TRACKER.md, KEY_PROJECT_FILES.md, KNOWLEDGE_TRANSFER_MANIFEST.md.
	•	Delete non‑applicable language sections (e.g., remove Rust if not used).
	•	Commit this template as docs/AI_ASSISTANT_COLLAB_GUIDE.md.

⸻

1) Collaboration Charter

Human Lead: Owns scope, acceptance criteria, risk decisions, and merges.
AI Assistant (you):
	•	Operate as a semantic planner & implementation aide within policy boundaries.
	•	Propose plans before making sweeping changes. Keep diffs small and reviewable.
	•	Prefer reading from canonical docs/files over assumptions.

Safety & Boundary Rules
	•	❌ No secrets exfiltration or writing credentials; use [.env.example] patterns.
	•	🔒 Treat data as sensitive; redact PII in logs and PRs.
	•	🧪 Use --dry-run/staging for destructive ops; require explicit human confirmation.
	•	🌐 No external network calls/tools unless whitelisted in TOOLS_ALLOWED.md.
	•	📏 Changes touching > [MAX_FILES=10] files require a plan + sign‑off.

Source of Truth
	•	Architecture: ARCHITECTURE.md
	•	Status/SLAs: STATUS_TRACKER.md
	•	Key entry points & scripts: KEY_PROJECT_FILES.md
	•	Onboarding/Quickstart: README.md

⸻

2) Quick Context Assessment (Run Every Session)
	1.	Confirm location & scope
	•	pwd should match project root for [PROJECT_NAME].
	•	Identify component focus: [frontend|backend|infra|docs].
	2.	Read canonical context (skim, don’t assume):
	•	README.md, ARCHITECTURE.md, KEY_PROJECT_FILES.md, STATUS_TRACKER.md.
	3.	Enumerate tasks & constraints
	•	Extract acceptance criteria, deadlines, SLAs, and non‑functional reqs.
	4.	Propose a short plan
	•	Provide a numbered plan with checkpoints and validation steps before changes.

⸻

3) Knowledge Transfer & Context Ingestion

Goal: Build a minimum viable mental model before editing code.
	•	Read KNOWLEDGE_TRANSFER_MANIFEST.md for links to specs, APIs, and test data.
	•	Produce a Context Snapshot in PRs:
	•	Component boundaries, main data flows, key configs, known pitfalls.
	•	Keep a running docs/SESSION_NOTES/[YYYY-MM-DD]-session.md:
	•	What was read, decisions made, open questions, TODOs.

⸻

4) Phased Working Model

Phase 1 — Environment Assessment & Setup

Verify toolchain is operational before coding.

Python

# Create/activate env
python -m venv .venv && source .venv/bin/activate

# Install deps
[PACKAGE_MANAGER] install  # e.g., pip install -r requirements.txt

# Smoke‑test
python - <<'PY'
print('Python ready')
PY

Node.js

# Install deps
[PACKAGE_MANAGER] install  # e.g., npm ci | pnpm i | yarn install

# Smoke‑test
node -e "console.log('Node ready')"
[PACKAGE_MANAGER] run --silent --help

Rust

cargo build
cargo test -q

Go

go mod tidy
go build ./...
go test ./...

✅ Quality gate: deps resolve, no high‑severity vulns, basic build/test passes.

⸻

Phase 2 — Task Intake & Planning
	•	Derive subtasks from the issue/story.
	•	For each subtask, list: files to touch, interfaces to change, risks, tests to add.
	•	Share a short Execution Plan; await human ack for risky changes.

⸻

Phase 3 — Implementation
	•	Create a feature branch: feat/<scope>-<ticket>.
	•	Keep commits small; write conventional messages (type(scope): summary).
	•	Update or create contracts (types, schemas, API docs) alongside code.
	•	Maintain a running File Touch List in the PR description.

⸻

Phase 4 — Verification

Run automated checks locally before opening a PR:

[TEST_COMMAND]
[LINT_COMMAND]
[TYPECHECK_COMMAND]
[BUILD_COMMAND]

	•	Record versions and outputs in the PR.
	•	Add/extend unit/integration/e2e tests as appropriate.

⸻

Phase 5 — Handoff
	•	Update: README.md, CHANGELOG.md, KEY_PROJECT_FILES.md, STATUS_TRACKER.md.
	•	In PR description, include: Context Snapshot, Plan → Result mapping, test evidence, rollback notes.
	•	Tag owners/reviewers from CODEOWNERS.

⸻

5) Frontend Collaboration Patterns ([FRONTEND_TECH])

Dev Server & Build

# Dev
[PACKAGE_MANAGER] run [DEV_COMMAND]
# Build
[PACKAGE_MANAGER] run [BUILD_COMMAND]

UI Architecture
	•	Prefer component‑driven development; colocate tests & stories.
	•	State mgmt: [STATE_LIB] with predictable actions/selectors.
	•	Routing: [ROUTER] with code‑splitting for large routes.

Quality Gates
	•	Accessibility: enforce with [A11Y_TOOL] in CI.
	•	Visual regression: add stories and [VISREG_TOOL] baselines.
	•	Performance budgets: LCP/CLS targets documented in ARCHITECTURE.md.

Testing

# Unit
[PACKAGE_MANAGER] run test
# E2E
[PACKAGE_MANAGER] run e2e

Troubleshooting (Frontend)
	•	Dev server fails → clear caches (rm -rf node_modules .turbo .next dist), reinstall.
	•	CSS conflicts → verify Tailwind/PostCSS order and purge config.
	•	CORS issues → align local API proxy with backend base URL.

⸻

6) Backend Collaboration Patterns ([BACKEND_TECH])

Service Boundaries & Contracts
	•	Document public APIs in openapi.yaml or equivalent; keep PRs in sync.
	•	Use explicit DTOs/schemas; validate at the edge.
	•	Idempotency for mutating endpoints; retries with backoff for transient failures.

Data & Migrations
	•	Write reversible migrations; include up/down scripts.
	•	Provide seed scripts for local/dev.

Observability & Ops
	•	Logging: structured, no secrets; sample logs in PR.
	•	Metrics: expose basic health metrics; add SLO/SLA notes to STATUS_TRACKER.md.
	•	Feature flags and config via env vars; document defaults in .env.example.

Testing

# Unit / integration
[TEST_COMMAND]
# Contract tests against mock server
[PACKAGE_MANAGER] run contract-test

Troubleshooting (Backend)
	•	Port conflicts → document ports in KEY_PROJECT_FILES.md.
	•	Env drift → regenerate .env from .env.example; never commit real secrets.
	•	DB migration failures → run status and roll back; verify schema diff.

⸻

7) Split‑Apps / Two‑Phase Flow (Optional)

If the project uses separate frontend and backend apps:
	•	Keep mirrored directories: [FRONTEND_DIR], [BACKEND_DIR].
	•	Maintain a Knowledge Transfer Mirror: keep README, CHANGELOG, and STATUS_TRACKER in both with cross‑links.
	•	Two‑phase flow: (1) compute concrete plan/checks locally without the model, (2) use model for code generation/refactor only within the boundaries.

⸻

8) Prompt/Plan Patterns (Reusable)
	•	Task Clarifier: Summarize the ticket; list assumptions & confirm unknowns.
	•	Codebase Mapper: From KEY_PROJECT_FILES.md, output a dependency + ownership map.
	•	Test Scaffold: Given a function/module, propose unit test skeletons with edge cases.
	•	Risk Register: Enumerate failure modes, blast radius, and mitigations for the change.
	•	PR Template Filler: Generate PR text using the Context Snapshot + File Touch List.

⸻

9) Governance, Risk, & Compliance
	•	Privacy: do not include user data in prompts beyond what’s necessary; prefer synthetic fixtures.
	•	Security: threat‑model significant changes; verify authz checks near boundaries.
	•	Licensing: verify new deps’ licenses; document in THIRD_PARTY_NOTICES.md.

⸻

10) Checklists

Pre‑Flight
	•	Environment validated; dependencies installed; basic tests pass
	•	Read core docs; boundaries understood
	•	Plan proposed & acknowledged for risky changes

PR Ready
	•	Small, reviewable diffs; passing tests; updated docs
	•	Contracts and migrations reviewed
	•	Rollback/feature‑flag strategy noted

Post‑Merge
	•	CHANGELOG.md updated
	•	STATUS_TRACKER.md state advanced
	•	Follow‑ups/issues created for deferred items

⸻

11) Troubleshooting (General)
	•	Tool mismatch: print versions in PR (node -v, python --version, etc.).
	•	CI fails but local passes: compare lockfiles; ensure deterministic installs (npm ci, pip-tools).
	•	Large refactors: split into preparatory PRs (rename, extract, format) before behavior changes.

⸻

12) Template Validation (Meta)

Before first use, validate customization:
	•	Run dev and test commands for both frontend/backend succeed.
	•	Lint/type‑check passes or has documented suppressions.
	•	KEY_PROJECT_FILES.md lists accurate entry points & scripts.
	•	All placeholders replaced; non‑applicable sections pruned.

📎 Keep this guide close to the code. Update it whenever workflows or tools change. This guide is model‑agnostic and applies to any AI assistant used on [PROJECT_NAME].