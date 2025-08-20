#!/usr/bin/env bash

set -e

mkdir -p chirality-chat
cd chirality-chat

# -------------------------
# Core project files
# -------------------------
cat > package.json <<'EOF'
{
  "name": "chirality-chat",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "smoke:rest": "node scripts/smoke-rest.mjs"
  },
  "dependencies": {
    "next": "15.2.3",
    "react": "^18.3.1",
    "react-dom": "^18.3.1",
    "neo4j-driver": "^5.22.0"
  },
  "devDependencies": {
    "typescript": "^5.4.5"
  }
}
EOF

cat > tsconfig.json <<'EOF'
{
  "compilerOptions": {
    "lib": ["dom", "dom.iterable", "es6"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
EOF

echo 'module.exports = {};' > .eslintrc.cjs
echo '{}' > .prettierrc
echo 'module.exports = { reactStrictMode: true };' > next.config.js
echo '# Chirality-chat' > README.md

mkdir -p public && touch public/favicon.ico

# -------------------------
# .env.local scaffolding
# -------------------------
cat > .env.local <<'EOF'
# Neo4j database connection settings
NEO4J_URI=bolt://localhost:7687
NEO4J_USER=neo4j
NEO4J_PASSWORD=your_password_here
EOF

# -------------------------
# Neo4j Driver
# -------------------------
mkdir -p src/lib
cat > src/lib/neo4j.ts <<'EOF'
import neo4j, { Driver } from 'neo4j-driver';

declare global {
  // eslint-disable-next-line no-var
  var __neo4jDriver: Driver | null | undefined;
}

export function getNeo4jDriver(): Driver {
  if (globalThis.__neo4jDriver) return globalThis.__neo4jDriver;

  const { NEO4J_URI, NEO4J_USER, NEO4J_PASSWORD } = process.env;
  if (!NEO4J_URI || !NEO4J_USER || !NEO4J_PASSWORD) {
    throw new Error('Missing Neo4j environment variables');
  }

  const driver = neo4j.driver(
    NEO4J_URI,
    neo4j.auth.basic(NEO4J_USER, NEO4J_PASSWORD)
  );
  globalThis.__neo4jDriver = driver;
  return driver;
}
EOF

# -------------------------
# API Routes
# -------------------------
mkdir -p src/app/api/{healthz,readyz,neo4j/query}

# /api/healthz
cat > src/app/api/healthz/route.ts <<'EOF'
import { NextResponse } from 'next/server';

export const runtime = 'nodejs';

export async function GET() {
  return NextResponse.json({ ok: true, timestamp: new Date().toISOString() });
}
EOF

# /api/readyz
cat > src/app/api/readyz/route.ts <<'EOF'
import { NextResponse } from 'next/server';
import { getNeo4jDriver } from '@/lib/neo4j';

export const runtime = 'nodejs';

export async function GET() {
  try {
    const driver = getNeo4jDriver();
    await driver.verifyConnectivity();
    return NextResponse.json({ ready: true });
  } catch (err: any) {
    return NextResponse.json(
      { ready: false, error: err?.message ?? 'Connectivity check failed' },
      { status: 500 }
    );
  }
}
EOF

# /api/neo4j/query — ping + example query
cat > src/app/api/neo4j/query/route.ts <<'EOF'
import { NextRequest, NextResponse } from 'next/server';
import { getNeo4jDriver } from '@/lib/neo4j';

export const runtime = 'nodejs';

export async function POST(req: NextRequest) {
  try {
    const body = await req.json().catch(() => ({}));
    const queryType = body?.query_type;

    // Ping mode — no DB needed
    if (queryType === 'ping') {
      return NextResponse.json({ ok: true, timestamp: new Date().toISOString() });
    }

    // Example query mode — requires DB
    if (queryType === 'example') {
      const driver = getNeo4jDriver();
      const session = driver.session();
      try {
        const result = await session.run('RETURN "Hello from Neo4j" AS message');
        const message = result.records[0]?.get('message') ?? null;
        return NextResponse.json({ ok: true, message });
      } finally {
        await session.close();
      }
    }

    return NextResponse.json({ ok: false, error: 'Unknown query_type' }, { status: 400 });
  } catch (err: any) {
    return NextResponse.json(
      { ok: false, error: err?.message ?? 'Unhandled error' },
      { status: 500 }
    );
  }
}
EOF

# -------------------------
# Basic Next.js pages
# -------------------------
mkdir -p src/app
cat > src/app/layout.tsx <<'EOF'
import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'Chirality Chat',
  description: 'Semantic framework chat interface',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
EOF

cat > src/app/page.tsx <<'EOF'
export default function Home() {
  return (
    <main className="container mx-auto p-4">
      <h1 className="text-2xl font-bold mb-4">Chirality Chat</h1>
      <p>Semantic framework chat interface</p>
      
      <div className="mt-8 space-y-2">
        <h2 className="text-lg font-semibold">Health Checks</h2>
        <div className="space-x-4">
          <a href="/api/healthz" className="text-blue-500 underline">Health</a>
          <a href="/api/readyz" className="text-blue-500 underline">Ready</a>
        </div>
      </div>
    </main>
  )
}
EOF

cat > src/app/globals.css <<'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

body {
  font-family: system-ui, -apple-system, sans-serif;
}
EOF

# -------------------------
# Smoke Test Script
# -------------------------
mkdir -p scripts
cat > scripts/smoke-rest.mjs <<'EOF'
const res = await fetch('http://localhost:3000/api/healthz');
console.log('Healthz:', res.status, await res.json());

const pingRes = await fetch('http://localhost:3000/api/neo4j/query', {
  method: 'POST',
  headers: { 'content-type': 'application/json' },
  body: JSON.stringify({ query_type: 'ping' })
});
console.log('Neo4j Ping:', pingRes.status, await pingRes.json());
EOF

echo "✅ Chirality-chat baseline created with /healthz, /readyz, /api/neo4j/query (ping + example), and .env.local scaffolding!"
echo "Run: cd chirality-chat && npm install && npm run dev"