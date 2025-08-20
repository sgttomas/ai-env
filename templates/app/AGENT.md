# AGENT.md
*AI Collaboration Guide for chirality-ai-app Documentation Mirror*

## What This Directory Contains

This `/chirality-semantic-framework/lib/chirality-ai-app/` directory is the **TypeScript application documentation mirror** within the Python framework project. It contains 27 files that document the chirality-ai-app side of the Chirality system.

## Purpose of This Mirror

**Knowledge Transfer Pipeline**: This mirror enables you to understand the TypeScript/Next.js application while working in the Python framework project. It provides:

- Complete API documentation for the REST and GraphQL interfaces you're integrating with
- Architecture patterns showing how the app consumes CF14 semantic operations
- Implementation details of the document generation system
- Neo4j integration patterns from the application perspective

## How to Use This Documentation

When working on the Python framework, reference these docs to:

1. **Understand the Consumer Perspective**: See how the TypeScript app uses the CF14 matrices you generate
2. **Maintain API Compatibility**: Ensure Python exports match what the app expects
3. **Coordinate Features**: Align framework capabilities with app requirements
4. **Debug Integration Issues**: Understand both sides of the integration

## Key Files for Framework Developers

### Integration Points
- **API.md** - REST/GraphQL specs the app implements (what your Python code feeds into)
- **INTEGRATION_ARCHITECTURE.md** - How the app integrates with CF14 semantic operations
- **NEO4J_SEMANTIC_INTEGRATION.md** - Neo4j patterns both projects share
- **GRAPHQL_NEO4J_INTEGRATION_PLAN.md** - Graph layer both projects use

### Understanding the App
- **README.md** - App overview and capabilities
- **ARCHITECTURE.md** - TypeScript/Next.js architecture patterns
- **KEY_DECISIONS.md** - Why the app was built certain ways

### Coordination Documents
- **CONTINUOUS_IMPROVEMENT_PLAN.md** - The app's documentation improvement process
- **KEY_PROJECT_FILES.md** - Status tracking for app documentation
- **KNOWLEDGE_TRANSFER_MANIFEST.md** - The canonical list of files in this mirror

## Relationship to Framework Documentation

**Bidirectional Mirror Structure**:
```
/chirality-semantic-framework/           (Python - You are here)
  └── lib/chirality-ai-app/             (App docs mirror)
      └── AGENT.md                     (This file)

/chirality-ai-app/                      (TypeScript)
  └── lib/chirality-semantic-framework/ (Framework docs mirror)
      └── AGENT.md                     (Explains framework to app developers)
```

## When to Reference These Docs

### During CF14 Development
- Check how matrices are consumed in **NEO4J_SEMANTIC_INTEGRATION.md**
- Verify export formats match app expectations in **API.md**
- Understand document generation flow in **ARCHITECTURE.md**

### During Integration Work
- Review GraphQL schema expectations
- Understand Neo4j node/relationship structures
- Coordinate version releases between Python package and TypeScript app

### During Troubleshooting
- **TROUBLESHOOTING.md** - Common app-side issues that might stem from framework
- **HELP.md** - User issues that might relate to semantic operations
- **CURRENT_STATUS.md** - What's currently implemented vs planned

## Keeping This Mirror Current

This mirror should be updated when:
- Major app features affect framework integration
- API contracts change between projects
- New integration patterns are established
- Documentation improvement cycles complete in the app

The **KNOWLEDGE_TRANSFER_MANIFEST.md** file maintains the canonical list of what should be in this directory.

## Quick Navigation

**For Framework → App Integration**:
1. Start with **INTEGRATION_ARCHITECTURE.md** for the big picture
2. Review **API.md** for specific interfaces
3. Check **NEO4J_SEMANTIC_INTEGRATION.md** for shared graph patterns

**For Understanding App Requirements**:
1. Read **README.md** for app capabilities
2. Review **KEY_DECISIONS.md** for architectural rationale
3. Check **CURRENT_STATUS.md** for implementation state

**For Coordination**:
1. Compare **CONTINUOUS_IMPROVEMENT_PLAN.md** between projects
2. Align **VERSION.md** strategies
3. Coordinate **RELEASE_NOTES** between package and app

## Key Differences from Framework Perspective

The app documentation emphasizes:
- **User Experience**: Frontend, chat interface, streaming
- **Document Generation**: Two-pass generation, RAG enhancement
- **TypeScript Patterns**: React components, Next.js routing
- **Real-time Features**: SSE streaming, WebSocket potential

While framework documentation emphasizes:
- **Semantic Operations**: Matrix multiplication, CF14 protocol
- **Python Patterns**: CLI, SDK, package distribution
- **Mathematical Foundations**: Theoretical underpinnings
- **Batch Processing**: Matrix operations, reasoning traces

## Integration Success Criteria

You know you're using this mirror effectively when:
- Framework changes consider app impact
- Python exports align with TypeScript expectations  
- Integration issues can be debugged from both sides
- Version releases are coordinated between projects

---

*This mirror enables seamless collaboration between the Python semantic framework and TypeScript application components of the Chirality system.*