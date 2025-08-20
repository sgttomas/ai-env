# GitHub Release Creation Instructions

## Manual Release Creation (via GitHub Web Interface)

### For chirality-semantic-framework v14.3.0

1. **Navigate to Repository**
   - Go to https://github.com/sgttomas/Chirality-Framework
   - Click "Releases" (right sidebar)
   - Click "Create a new release"

2. **Release Configuration**
   - **Tag version**: `v14.3.0`
   - **Target**: `main` (should be selected by default)
   - **Release title**: `CF14 Neo4j Integration Release`
   - **Description**: Copy content from `/Users/ryan/Desktop/ai-env/RELEASE_NOTES_v14.3.0.md`

3. **Release Options**
   - ✅ **Set as the latest release**
   - ❌ Set as a pre-release (leave unchecked)
   - ❌ Create a discussion (optional)

### For chirality-ai-app v1.0.0

1. **Navigate to Repository**
   - Go to https://github.com/sgttomas/Chirality-chat
   - Click "Releases" (right sidebar)
   - Click "Create a new release"

2. **Release Configuration**
   - **Tag version**: `v1.0.0`
   - **Target**: `main` (should be selected by default)
   - **Release title**: `First Official Release - CF14-Enhanced Document Generation`
   - **Description**: Copy content from `/Users/ryan/Desktop/ai-env/RELEASE_NOTES_v1.0.0.md`

3. **Release Options**
   - ✅ **Set as the latest release**
   - ❌ Set as a pre-release (leave unchecked)
   - ❌ Create a discussion (optional)

## Automated Release Creation (via GitHub API)

If you have a GitHub Personal Access Token with `repo` scope:

### For chirality-semantic-framework

```bash
curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/sgttomas/Chirality-Framework/releases \
  -d '{
    "tag_name": "v14.3.0",
    "target_commitish": "main",
    "name": "CF14 Neo4j Integration Release",
    "body": "# Chirality Semantic Framework v14.3.0\n\n## 🎯 CF14 Neo4j Integration Release\n\nThis release introduces specialized CF14 semantic matrix export capabilities, enabling seamless integration with the chirality-ai-app document generation system.\n\n### ✨ New Features\n\n#### CF14 Semantic Matrix Export\n- **New Flag**: `--write-cf14-neo4j` for specialized semantic matrix export\n- **Graph Schema**: CF14-optimized `:CFMatrix` and `:CFNode` labels\n- **Stable IDs**: SHA1-based content hashing for idempotent operations\n- **GraphQL Ready**: Direct integration with chirality-ai-app GraphQL API\n\n[... rest of release notes ...]",
    "draft": false,
    "prerelease": false,
    "generate_release_notes": false
  }'
```

### For chirality-ai-app

```bash
curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/sgttomas/Chirality-chat/releases \
  -d '{
    "tag_name": "v1.0.0",
    "target_commitish": "main",
    "name": "First Official Release - CF14-Enhanced Document Generation",
    "body": "# Chirality AI App v1.0.0\n\n## 🎉 First Official Release - CF14-Enhanced Document Generation\n\nThe first stable release of the Chirality AI App, featuring two-pass document generation with optional CF14 semantic enhancement through Neo4j integration.\n\n[... rest of release notes ...]",
    "draft": false,
    "prerelease": false,
    "generate_release_notes": false
  }'
```

## Post-Release Actions

After creating both releases:

1. **Update Documentation**
   - Add release badges to README files
   - Update installation instructions to reference stable versions

2. **Social/Communication**
   - Share release announcements
   - Update any project documentation referencing versions

3. **Package Publishing Preparation**
   - Prepare PyPI publishing for chirality-semantic-framework
   - Consider npm package options for chirality-ai-app

## Verification

After release creation, verify:

1. **Tags Created**: Check that git tags `v14.3.0` and `v1.0.0` exist
2. **Release Pages**: Verify release pages are accessible and well-formatted
3. **Download Links**: Confirm source code archives are available
4. **Latest Release**: Ensure both are marked as "latest" for their repositories

---

**Release Notes Location**: 
- Framework: `/Users/ryan/Desktop/ai-env/RELEASE_NOTES_v14.3.0.md`
- App: `/Users/ryan/Desktop/ai-env/RELEASE_NOTES_v1.0.0.md`