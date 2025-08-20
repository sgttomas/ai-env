# Generic Split-Apps Template (Meta)

This template has been split into two living documents: Architecture (concepts, invariants) and Procedures (how to do the work). The previously embedded specifics now live as ready-to-paste examples.

## Split Plan (what moves where)

Architecture (`ARCHITECTURE.md`)
- Problem statement & scope of split apps
- Component boundaries (frontend ↔ backend ↔ shared libs)
- Contracts: API surface, events, shared types, versioning policy
- Data & state flows (sequence diagrams)
- Deployment topology & environments
- Cross-cutting concerns (authn/z, observability, performance budgets)

Procedures / Runbooks (`PROCEDURES.md`)
- Project layout & bootstrap steps
- Local dev workflow (start both apps, proxies, env)
- “Change the contract” workflow (OpenAPI/types bump)
- Testing matrix (unit/int/e2e/contract/visual)
- CI/CD pipeline (build, cache, test, artifact, deploy)
- Release, rollback, and hotfix
- Troubleshooting playbook (ports, CORS, env drift)

## Ready-to-Paste Examples

- Architecture examples: `lib/templates/ARCHITECTURE_SPLIT_APPS_EXAMPLES.md`
- Procedures & runbooks: `lib/templates/PROCEDURES_SPLIT_APPS_RUNBOOKS.md`
- Optional appendix & migration checklist: `lib/templates/SPLIT_APPS_APPENDIX.md`

## How to Use

1) Create or open `ARCHITECTURE.md` and `PROCEDURES.md` in your repo.  
2) Paste from the example files above and adapt to your stack (e.g., pnpm vs npm, Vite vs Next, Express vs FastAPI).  
3) Set a compatibility window and versioning policy in the Architecture doc.  
4) Wire local proxies/CORS, codegen, and CI gates as described in Procedures.  
5) Use the appendix for SSR/GraphQL/Events variants and for the migration checklist.

## Notes

- Keeping concepts and operations separate improves clarity and maintainability.  
- Examples are intentionally concrete to accelerate adoption but remain stack-agnostic with clear substitution points.  
- If you previously referenced this file for specifics, switch to the two example docs above.
