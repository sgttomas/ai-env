# Split Apps Architecture — Ready-to-Paste Sections

Use these sections directly in your repository’s `ARCHITECTURE.md`. They turn the generic split-apps template into concise architectural guidance with concrete examples.

## 1) Split-Apps Overview

Pattern: Single-page app (SPA) + stateless API service.
Goal: Isolate UX iteration from API evolution while keeping a stable contract.

## Guiding Principles

- Clean baseline first: evaluate retrofit vs. fresh start; preserve essentials, remove accumulated complexity.
- Elegant minimalism: prefer small, surgical changes with single responsibility and explicit, traceable code.
- Systematic validation: establish baselines, benchmark competitively, and gate via functional, performance, and architectural invariants.
- AI-human collaboration: optimize for AI comprehension (clear paths, cohesive context), maintain structured docs and mirrors for knowledge transfer.
- Invariants: single scheduling gateway (where applicable), no recursive execution paths, no function-cast hacks, clear separation of concerns.
- Avoid anti-patterns: over-engineering, imagined future abstractions, complex toolchains that obscure simple solutions, overly clever code that harms clarity.
- Success signals: competitive performance, reduced complexity, maintainability, reproducibility, and effective AI-collaboration.

## 2) Component Boundaries

- Frontend: `apps/web` — UI, routing, view-state, API client.
- Backend: `apps/api` — REST/GraphQL, auth, domain services, persistence.
- Shared: `packages/shared` — schema/types, utilities, validation.

## 3) Inter-App Contract

- Protocol: HTTPS JSON
- Auth: [cookie | bearer] + CSRF strategy [choose]
- Versioning: SemVer on `packages/shared` and URL or header versioning on the API.
- Backward compatibility window: N minor versions.

```yaml
# openapi.yaml (excerpt)
paths:
  /v1/todos:
    get:
      operationId: listTodos
      responses:
        '200':
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/TodoList'
components:
  schemas:
    Todo:
      type: object
      required: [id, title, done]
      properties:
        id: { type: string }
        title: { type: string, maxLength: 120 }
        done: { type: boolean, default: false }
```

## 4) Data & State Flows

User → Web (`apps/web`) → API Client → API (`apps/api`) → DB
                ↑                              ↓
            Cache/RT updates ← Events (optional)

## 5) Deployment Topology

- Web: static assets on CDN, SSR/edge optional.
- API: container on [orchestrator] with HPA; envs: dev/stage/prod.
- Configs: env-vars only; secrets via [secret-manager].

## 6) Cross-Cutting Concerns

- AuthZ at API boundary; defense-in-depth in services.
- Observability: structured logs (no PII), traces with [otel], RED/SLOs.
- Performance budgets: LCP ≤ 2.5s, p95 API ≤ 300ms.
- Error taxonomy: 4xx client, 5xx server; problem+json for details.
