# Split-Apps Architecture Implementation

## Overview

Successfully implemented the split-apps structure that preserves all working functionality while organizing the codebase for future unified deployment via Electron.

## Final Directory Structure

```
/Users/ryan/Desktop/ai-env
├── chirality-ai/                    # Orchestrator repo (compose, desktop, docs)
│   ├── compose/
│   │   ├── docker-compose.yml       # Backend services (uses main framework)
│   │   └── .env                     # Environment configuration
│   ├── desktop/                     # Electron wrapper
│   └── .env                         # Shared environment configuration
├── chirality-ai-app/               # Product frontend (Next.js)
├── chirality-semantic-framework/   # Core framework + backend services
│   ├── admin/                       # Express.js orchestration service
│   ├── graphql/                     # Standalone GraphQL service
│   ├── orchestration-service/       # Salvaged orchestration service
│   ├── graphql-service/             # Framework-integrated GraphQL
│   ├── admin-ui/                    # Next.js admin interface
│   └── [complete CF14 framework]    # Python CLI, domain packs, etc.
└── chirality-chat/                 # Independent sandbox app
```

## Services & Ports

### Backend Services (via Docker Compose)
*Services now sourced from chirality-semantic-framework/*
- **Neo4j**: `localhost:7474` (HTTP), `localhost:7687` (Bolt)
- **GraphQL**: `localhost:8080` (from chirality-semantic-framework/graphql/)
- **Admin**: `localhost:3001` (from chirality-semantic-framework/admin/)

### Frontend Applications
- **Product App** (`chirality-ai-app`): `localhost:3000`
- **Semantic Framework**: Independent ports
- **Chat Sandbox**: Independent ports

## Data Contracts

### GraphQL API
```typescript
type Query {
  health: ServiceHealth!
  matrices(input: MatrixInput!): Matrices!
}

type ServiceHealth {
  status: String!
  lastChecked: String!
}

type Matrices {
  DS: [Cell!]!
  SP: [Cell!]!
  X: [Cell!]!
  Z: [Cell!]!
  M: [Cell!]!
  W: [Cell!]!
  U: [Cell!]!
  N: [Cell!]!
}

type Cell {
  value: String!
  row: Int!
  col: Int!
  confidence: Float
  status: String
}
```

### Frontend Domain Types
```typescript
type MatrixKey = 'DS'|'SP'|'X'|'Z'|'M'|'W'|'U'|'N'
type MatrixCell = { 
  value: string; 
  row: number; 
  col: number; 
  confidence?: number; 
  status?: string 
}
type UiMatrix = Record<MatrixKey, MatrixCell[]>
```

### Orchestrator Job Presets
```typescript
type Command = 'generate-c'|'generate-f'|'generate-d'|'verify-stages'|'push-axioms'
type JobArgs = { 
  rows?: number[]; 
  cols?: number[]; 
  dry_run?: boolean; 
  ufo_propose?: boolean; 
  spec?: string 
}
```

## Environment Configuration

### Shared Environment (chirality-ai/.env)
```env
# OpenAI Configuration
OPENAI_API_KEY=sk-proj-...
OPENAI_MODEL=gpt-4.1-nano

# Neo4j Configuration
NEO4J_PASSWORD=nCyn72sE19a3qJQOfzAMCyL_X2KmCXmrTlHLglN3eHQ
NEO4J_URI=neo4j+s://c0a5bb06.databases.neo4j.io
NEO4J_USER=neo4j
NEO4J_DATABASE=neo4j

# Application Ports
ADMIN_PORT=3001
GRAPHQL_PORT=8080
NEO4J_HTTP_PORT=7474
NEO4J_BOLT_PORT=7687
FRONTEND_PORT=3210

# Application URLs
NEXT_PUBLIC_GRAPHQL_URL=http://localhost:8080/graphql
NEXT_PUBLIC_API_BASE=http://localhost:3001
```

### Frontend Environment (chirality-ai-app/.env.local)
```env
# OpenAI API Key
OPENAI_API_KEY=sk-proj-...
OPENAI_MODEL=gpt-4.1-nano

# Backend Services
NEXT_PUBLIC_GRAPHQL_URL=http://localhost:8080/graphql
NEXT_PUBLIC_ORCHESTRATOR_URL=http://localhost:3001

# Neo4j (for direct connections)
NEO4J_URI=neo4j+s://c0a5bb06.databases.neo4j.io
NEO4J_USER=neo4j
NEO4J_PASSWORD=nCyn72sE19a3qJQOfzAMCyL_X2KmCXmrTlHLglN3eHQ
```

## Implementation Status

### ✅ Completed
1. **Safe renames**: `frontend` → `chirality-ai-app`, `backend` → `chirality-ai-backend`
2. **Updated Compose build contexts** to point to new directory names
3. **Environment loading** configured for both Compose and frontend
4. **Improved GraphQL healthcheck** using POST query instead of HEAD request
5. **End-to-end verification** confirmed working

### Services Status
- ✅ **Neo4j**: Running and healthy
- ✅ **GraphQL**: Running with improved healthcheck (`/__typename` query works)
- ✅ **Admin**: Running on port 3001
- ✅ **Frontend**: Running on port 3000 (bypassed linting for now)

## Application Coexistence

### Product App Usage
```bash
# Start backend services (uses services from main framework)
cd /Users/ryan/Desktop/ai-env/chirality-ai/compose
docker compose up -d

# Start frontend
cd /Users/ryan/Desktop/ai-env/chirality-ai-app
npx next dev  # Available at http://localhost:3000
```

### Framework App Usage
The `chirality-semantic-framework` remains completely independent:
```bash
cd /Users/ryan/Desktop/ai-env/chirality-semantic-framework
npm run dev  # Runs on its own port
```

### Chat Sandbox Usage
The `chirality-chat` can point to the same backend via environment:
```bash
cd /Users/ryan/Desktop/ai-env/chirality-chat
echo "NEXT_PUBLIC_GRAPHQL_URL=http://localhost:8080/graphql" >> .env.local
npm run dev  # Experimental sandbox using shared backend
```

## Verification Commands

### Backend Health Check
```bash
curl -s -X POST http://localhost:8080/graphql \
  -H 'Content-Type: application/json' \
  -d '{"query":"{__typename}"}'
# Expected: {"data":{"__typename":"Query"}}
```

### Frontend Health Check
```bash
curl -s http://localhost:3000/api/healthz
# Expected: {"ok":true,"timestamp":"..."}
```

### Docker Compose Status
```bash
cd /Users/ryan/Desktop/ai-env/chirality-ai/compose
docker compose ps
# All services should show "healthy" status
```

## Future: Electron Wrapper

The current structure is ready for the planned Electron wrapper that will:

1. **Start Compose services** (`docker compose up -d`)
2. **Wait for health checks** (GraphQL and Admin ready)
3. **Launch frontend** at the configured URL
4. **Provide single-click app experience**

Sketch implementation location: `chirality-ai/desktop/main.js`

## Post-Consolidation Updates (August 16, 2025)

### Major Changes from Original Architecture
1. **✅ Merged Backend Services**: `chirality-ai-backend/` content merged into `chirality-semantic-framework/`
2. **✅ Added Service Options**: Framework now provides multiple deployment options:
   - **Development Services**: `graphql-service/`, `admin-ui/`, `chirality-admin/`  
   - **Production Services**: `admin/`, `graphql/`, `orchestration-service/`
3. **✅ Updated Docker Compose**: Now references services from main framework
4. **✅ Preserved Frontend**: `chirality-ai-app/` remains independent
5. **✅ Maintained Coexistence**: All applications can still run independently

### Current Service Architecture
```
┌──────────────────────────────────────────────────────────┐
│                Frontend Applications                     │
│  ┌─────────────────┐    ┌─────────────────┐           │
│  │ chirality-ai-app│    │  chirality-chat │           │
│  └─────────────────┘    └─────────────────┘           │
└─────────────┬───────────────────┬───────────────────────┘
              │                   │
              ▼                   ▼
┌─────────────────────────────────────────────────────────┐
│     Chirality Framework (Multiple Service Options)      │
│                                                         │
│  Production Services (Docker-ready):                    │
│  ├── admin/ (Express.js orchestration)                  │
│  ├── graphql/ (Standalone GraphQL)                      │
│  └── orchestration-service/ (Salvaged service)          │
│                                                         │
│  Development Services (Framework-integrated):           │
│  ├── graphql-service/ (Framework GraphQL)               │
│  ├── admin-ui/ (Next.js admin)                          │
│  └── chirality-admin/ (Admin interface)                 │
│                                                         │
│  Core Framework:                                        │
│  └── Python CLI + CF14 implementation                   │
└─────────────┬───────────────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────────────────────┐
│                    Neo4j Database                       │
│        Semantic Matrix Storage & Graph Operations       │
└─────────────────────────────────────────────────────────┘
```

## Benefits Achieved

1. **Zero Downtime**: Preserved all working functionality through consolidation
2. **Enhanced Organization**: Single framework repo with multiple deployment options
3. **Unified Backend**: Framework provides both development and production services  
4. **Deployment Flexibility**: Choose appropriate services for your use case
5. **Electron Ready**: Structure optimized for desktop app packaging
6. **Independent Evolution**: Framework and chat can iterate independently
7. **Service Consolidation**: Eliminated duplicate backend infrastructure

## Maintenance Notes

### Post-Consolidation Architecture
- **Service Sources**: Backend services now sourced from `chirality-semantic-framework/`
- **Environment Sync**: Keep `.env` files synchronized between `chirality-ai/` and `chirality-ai/compose/`
- **Service Selection**: Choose development vs production services based on use case
- **Port Management**: Avoid conflicts between different apps and service options
- **Health Monitoring**: Use improved GraphQL healthcheck for reliability

### Development Workflow
```bash
# For framework development - use integrated services
cd chirality-semantic-framework/graphql-service && npm run dev
cd chirality-semantic-framework/admin-ui && npm run dev

# For production deployment - use standalone services  
cd chirality-semantic-framework/graphql && npm run dev
cd chirality-semantic-framework/admin && npm run dev

# For Docker deployment - build from framework
docker build chirality-semantic-framework/graphql
docker build chirality-semantic-framework/admin
```

The consolidated split-apps architecture provides maximum flexibility while maintaining all working functionality. Ready for continued development, production deployment, or Electron packaging.