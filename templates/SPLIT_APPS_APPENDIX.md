# Split Apps Appendix

Optional inserts you can drop into either `ARCHITECTURE.md` or `PROCEDURES.md` as needed, plus a migration checklist for moving from the old generic template.

## Optional Appendix Inserts

- SSR variant (Next.js) routing notes
- GraphQL variant (schema registry, persisted queries)
- Events/Kafka variant (outbox pattern, idempotency)
- Polyrepo vs Monorepo trade-offs & tooling

## Migration Checklist (from the generic template)

- Copy “Boundaries/Contracts/Topology” to `ARCHITECTURE.md`.
- Move “Layout/Dev/CI/Release/Troubleshooting” to `PROCEDURES.md`.
- Create `packages/shared` and wire codegen.
- Add proxy+CORS snippets; document ports.
- Add testing matrix & CI gates.
- Document versioning + compatibility window.

