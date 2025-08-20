# Split Apps Procedures — Pipeline & Runbooks (Ready-to-Paste)

Use these sections directly in your repository’s `PROCEDURES.md` (or “Pipeline & Runbooks”). They provide actionable steps for day-to-day work and delivery.

## A) Project Layout

```
repo/
  apps/
    web/          # frontend
    api/          # backend
  packages/
    shared/       # types/schemas/utils
  infra/
    docker/ k8s/  # deployment manifests
```

## B) Bootstrap & Local Dev

```
# Install
pnpm i           # or npm/yarn

# Start API (apps/api)
pnpm --filter api dev

# Start Web with API proxy (apps/web)
pnpm --filter web dev
```

Vite proxy (`apps/web/vite.config.ts`)

```ts
server: {
  proxy: { '/api': { target: 'http://localhost:4000', changeOrigin: true } }
}
```

Express CORS (`apps/api/src/server.ts`)

```ts
app.use(cors({ origin: 'http://localhost:5173', credentials: true }));
```

## C) Contract-Change Workflow

1) Edit `openapi.yaml` (API) or `packages/shared` types.  
2) Run codegen: `pnpm generate:api` → updates clients/servers.  
3) Bump minor in `packages/shared` if backward compatible; major otherwise.  
4) Update web callers; add/adjust contract tests.  
5) CI enforces: codegen up-to-date, no breaking changes without major.

## D) Testing Matrix

- Web: unit (vitest/jest), e2e (playwright), visual regression [tool].
- API: unit (jest), integration (testcontainers), contract tests (pact).
- Shared: type tests (tsd), schema round-trip tests (zod/ajv).

## E) CI/CD Pipeline (example stages)

1) Setup: cache, install, generate.  
2) Quality: lint, type-check, unit/int tests, contract tests.  
3) Build: web artifacts + API image.  
4) Verify: e2e on ephemeral env.  
5) Deploy: staged rollout + health checks + smoke.  
6) Notify/Record: release notes, version pins.

## F) Release & Rollback

- Release train: weekly; hotfix as needed.  
- Feature flags for risky UI; canaries for API.  
- Rollback: `kubectl rollout undo` or previous image; web: revert CDN alias to prior build.

## G) Troubleshooting

- Port clash: web 5173, api 4000 (configurable).  
- CORS: check Vite proxy + API CORS allowlist.  
- Schema drift: re-run codegen; ensure lockfiles are committed.  
- Auth failures: verify cookie domain / token audience per env.

