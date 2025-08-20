# Chirality Semantic Framework v14.3.0

## 🎯 CF14 Neo4j Integration Release

This release introduces specialized CF14 semantic matrix export capabilities, enabling seamless integration with the chirality-ai-app document generation system.

### ✨ New Features

#### CF14 Semantic Matrix Export
- **New Flag**: `--write-cf14-neo4j` for specialized semantic matrix export
- **Graph Schema**: CF14-optimized `:CFMatrix` and `:CFNode` labels
- **Stable IDs**: SHA1-based content hashing for idempotent operations
- **GraphQL Ready**: Direct integration with chirality-ai-app GraphQL API

#### Enhanced CLI Interface
```bash
# Export CF14 matrices to Neo4j
python -m chirality.cli run \
  --thread "demo:test" \
  --A chirality/tests/fixtures/A.json \
  --B chirality/tests/fixtures/B.json \
  --resolver echo --write-cf14-neo4j
```

### 🏗️ Architecture Improvements
- **Two-Layer Integration**: CF14 semantic layer + document generation layer
- **Semantic Context**: A,B,C,D,F,J matrices available for document enhancement
- **Idempotent Operations**: Re-running exports doesn't create duplicates

### 📚 Documentation Updates
- **CF14 Export Workflow**: Complete testing and validation procedures
- **Integration Guide**: Step-by-step setup with chirality-ai-app
- **Graph Schema**: Detailed Neo4j structure documentation
- **AI Collaboration**: Enhanced CLAUDE.md with export guidance

### 🔧 Technical Details
- **Graph Labels**: `:CFMatrix` nodes with kind, name, timestamp
- **Semantic Nodes**: `:CFNode` with content, coordinates, stable IDs
- **Relationships**: `[:CONTAINS]` linking matrices to semantic content
- **Compatibility**: Maintains backward compatibility with existing `--write-neo4j`

### 🚀 Getting Started
1. Install dependencies: `pip install -r requirements.txt`
2. Set up Neo4j (optional): Use docker-compose from chirality-ai-app
3. Export matrices: Use `--write-cf14-neo4j` flag
4. Query via GraphQL: Connect with chirality-ai-app for enhanced document generation

### 🔗 Integration with chirality-ai-app
This release is designed to work seamlessly with chirality-ai-app v1.0.0, providing CF14 semantic context for enhanced document generation.

### 📖 Documentation
- [README.md](README.md) - Updated with CF14 export instructions
- [CLAUDE.md](CLAUDE.md) - AI collaboration guide with export workflow
- [API.md](API.md) - Complete interface documentation

### 🔧 Files Added/Modified
- `chirality/exporters/neo4j_cf14_exporter.py` - New CF14 exporter
- `chirality/cli.py` - Added `--write-cf14-neo4j` flag
- `README.md` - Enhanced Neo4j integration section
- `CLAUDE.md` - Added CF14 export testing workflow
- `KEY_PROJECT_FILES.md` - Updated status tracking

---

**Installation**: `pip install -e .` or direct usage with `python -m chirality.cli`
**Compatibility**: Python 3.9+, Neo4j 5+ (optional)
**License**: MIT