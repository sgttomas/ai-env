# Mirror Synchronization Template

**Purpose**: Systematic management of bidirectional documentation mirrors preventing fragmentation and chaos  
**Critical Issue**: Mirror systems enable context management but create synchronization complexity  
**Evidence**: vibe-code-challenge demonstrates both the power and risks of mirror systems  
**Template Version**: 1.0

## Template Customization Instructions

**Before using this template:**
1. Replace `[PROJECT_NAME]` with your actual project name
2. Replace `[COMPONENT_A]` and `[COMPONENT_B]` with your specific component names
3. Replace `[FILE_COUNT_A]` and `[FILE_COUNT_B]` with expected mirror file counts
4. Replace `[SYNC_FREQUENCY]` with your synchronization schedule (daily, weekly, etc.)
5. Customize validation rules for your specific mirror structure

---

# Mirror Synchronization Protocol - [PROJECT_NAME]

**Project**: [PROJECT_NAME]  
**Primary Components**: [COMPONENT_A] ↔ [COMPONENT_B]  
**Expected Mirror Size**: [FILE_COUNT_A] files ↔ [FILE_COUNT_B] files  
**Sync Frequency**: [SYNC_FREQUENCY]  
**Protocol Version**: 1.0

## Mirror System Overview

### **The Promise and Peril**

**Mirror System Benefits**:
- Bidirectional knowledge transfer between components
- Complete context available for cross-component work
- Persistent knowledge that survives context limits
- Systematic understanding across project boundaries

**Mirror System Risks**:
- Documentation fragmentation across multiple copies
- Synchronization failures creating conflicting versions
- Update propagation complexity and failures
- Version control confusion and conflict creation

### **Architecture Pattern**
```
[COMPONENT_A]/
├── canonical-docs/                 # Source of truth for Component A
│   ├── README.md
│   ├── API.md
│   └── ARCHITECTURE.md
└── lib/[COMPONENT_B]/              # Mirror of Component B docs
    ├── KNOWLEDGE_TRANSFER_MANIFEST.md
    ├── README.md (mirrored)
    ├── API.md (mirrored)
    └── CLAUDE.md (mirror-specific)

[COMPONENT_B]/  
├── canonical-docs/                 # Source of truth for Component B
│   ├── README.md
│   ├── API.md
│   └── INTEGRATION.md
└── lib/[COMPONENT_A]/              # Mirror of Component A docs
    ├── KNOWLEDGE_TRANSFER_MANIFEST.md
    ├── README.md (mirrored)
    ├── API.md (mirrored)
    └── CLAUDE.md (mirror-specific)
```

## Knowledge Transfer Manifest System

### **Manifest Structure Template**

**KNOWLEDGE_TRANSFER_MANIFEST.md**:
```markdown
# Knowledge Transfer Manifest - [COMPONENT_A] → [COMPONENT_B]

**Source Component**: [COMPONENT_A]  
**Target Component**: [COMPONENT_B]  
**Mirror Location**: [COMPONENT_B]/lib/[COMPONENT_A]/  
**Total Files**: [FILE_COUNT_A]  
**Last Sync**: [YYYY-MM-DD HH:MM:SS]  
**Sync Status**: [SYNCHRONIZED | PARTIAL | OUTDATED | CONFLICTED]

## File Inventory

### Core Documentation
- [ ] README.md (Last updated: [DATE])
- [ ] API.md (Last updated: [DATE])
- [ ] ARCHITECTURE.md (Last updated: [DATE])
- [ ] TROUBLESHOOTING.md (Last updated: [DATE])

### Configuration Files
- [ ] package.json (Last updated: [DATE])
- [ ] tsconfig.json (Last updated: [DATE])
- [ ] .env.example (Last updated: [DATE])

### Process Documentation
- [ ] CONTRIBUTING.md (Last updated: [DATE])
- [ ] CONTINUOUS_IMPROVEMENT_PLAN.md (Last updated: [DATE])
- [ ] KEY_PROJECT_FILES.md (Last updated: [DATE])

### Mirror-Specific Files
- [ ] CLAUDE.md (Mirror-specific AI collaboration guide)
- [ ] KNOWLEDGE_TRANSFER_MANIFEST.md (This file)

## File Categories

### **FULL_MIRROR** - Complete file mirrored
Files that are copied completely for full context:
- README.md - Complete project overview
- API.md - Full API reference
- ARCHITECTURE.md - Complete architectural documentation

### **SELECTIVE_MIRROR** - Key sections extracted
Files where only essential sections are mirrored:
- TROUBLESHOOTING.md - Common issues relevant to integration
- CONTRIBUTING.md - Collaboration guidelines for cross-component work

### **REFERENCE_ONLY** - Linked but not copied
Files referenced but not mirrored due to size or irrelevance:
- CHANGELOG.md - Too dynamic for effective mirroring
- RELEASE_NOTES_*.md - Component-specific, not relevant to mirrors

### **MIRROR_SPECIFIC** - Created for mirror context
Files that exist only in mirrors:
- CLAUDE.md - AI collaboration guide for cross-component work
- INTEGRATION_GUIDE.md - How to work across components

## Synchronization Status Tracking

### **Status Categories**

**SYNCHRONIZED**: All files current, no conflicts detected
**PARTIAL**: Some files updated, others pending synchronization  
**OUTDATED**: Mirror files older than canonical by >24 hours
**CONFLICTED**: Conflicting versions detected requiring manual resolution

### **Health Indicators**

**File Count Validation**:
- Expected files: [FILE_COUNT_A]
- Current files: [ACTUAL_COUNT]
- Missing files: [MISSING_COUNT]
- Extra files: [EXTRA_COUNT]

**Freshness Validation**:
- Files updated <24h: [FRESH_COUNT]
- Files updated 1-7 days: [RECENT_COUNT]  
- Files updated >7 days: [STALE_COUNT]
- Files never synced: [NEVER_SYNCED_COUNT]

**Integrity Validation**:
- Files matching canonical: [MATCHING_COUNT]
- Files with minor differences: [MINOR_DIFF_COUNT]
- Files with major differences: [MAJOR_DIFF_COUNT]
- Files with conflicts: [CONFLICT_COUNT]
```

## Synchronization Procedures

### **Automated Synchronization Script**

**sync-mirrors.sh**:
```bash
#!/bin/bash
# Mirror synchronization script for [PROJECT_NAME]

set -e

# Configuration
SOURCE_COMPONENT="[COMPONENT_A]"
TARGET_COMPONENT="[COMPONENT_B]"
SOURCE_PATH="../$SOURCE_COMPONENT"
TARGET_MIRROR_PATH="lib/$SOURCE_COMPONENT"
MANIFEST_FILE="$TARGET_MIRROR_PATH/KNOWLEDGE_TRANSFER_MANIFEST.md"

echo "Starting mirror synchronization: $SOURCE_COMPONENT → $TARGET_COMPONENT"

# 1. Validate source component exists
if [ ! -d "$SOURCE_PATH" ]; then
    echo "❌ Source component not found: $SOURCE_PATH"
    exit 1
fi

# 2. Create mirror directory if needed
mkdir -p "$TARGET_MIRROR_PATH"

# 3. Read manifest to get file list
if [ ! -f "$MANIFEST_FILE" ]; then
    echo "⚠️ Manifest not found, creating initial manifest"
    ./scripts/generate-initial-manifest.sh "$SOURCE_COMPONENT" "$TARGET_COMPONENT" > "$MANIFEST_FILE"
fi

# 4. Extract file list from manifest
MIRROR_FILES=$(grep -E "^- \[ \]" "$MANIFEST_FILE" | sed 's/^- \[ \] \([^(]*\).*/\1/' | tr -d ' ')

# 5. Synchronize each file
SYNC_COUNT=0
ERROR_COUNT=0

for file in $MIRROR_FILES; do
    SOURCE_FILE="$SOURCE_PATH/$file"
    TARGET_FILE="$TARGET_MIRROR_PATH/$file"
    
    if [ -f "$SOURCE_FILE" ]; then
        # Check if update needed
        if [ ! -f "$TARGET_FILE" ] || [ "$SOURCE_FILE" -nt "$TARGET_FILE" ]; then
            echo "Syncing: $file"
            cp "$SOURCE_FILE" "$TARGET_FILE"
            SYNC_COUNT=$((SYNC_COUNT + 1))
        fi
    else
        echo "⚠️ Source file not found: $SOURCE_FILE"
        ERROR_COUNT=$((ERROR_COUNT + 1))
    fi
done

# 6. Update manifest with sync timestamp
SYNC_TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
sed -i "s/\*\*Last Sync\*\*: .*/\*\*Last Sync\*\*: $SYNC_TIMESTAMP/" "$MANIFEST_FILE"

# 7. Update sync status
if [ $ERROR_COUNT -eq 0 ]; then
    sed -i "s/\*\*Sync Status\*\*: .*/\*\*Sync Status\*\*: SYNCHRONIZED/" "$MANIFEST_FILE"
else
    sed -i "s/\*\*Sync Status\*\*: .*/\*\*Sync Status\*\*: PARTIAL/" "$MANIFEST_FILE"
fi

echo "✅ Synchronization complete: $SYNC_COUNT files updated, $ERROR_COUNT errors"
```

### **Conflict Detection Script**

**detect-mirror-conflicts.sh**:
```bash
#!/bin/bash
# Detect conflicts between canonical and mirror files

COMPONENT_A="[COMPONENT_A]"
COMPONENT_B="[COMPONENT_B]"
CONFLICTS_FOUND=0

echo "Detecting mirror conflicts between $COMPONENT_A and $COMPONENT_B..."

# Check A → B mirrors
echo "Checking $COMPONENT_A → $COMPONENT_B mirrors..."
if [ -d "$COMPONENT_B/lib/$COMPONENT_A" ]; then
    cd "$COMPONENT_B/lib/$COMPONENT_A"
    
    for mirror_file in *.md; do
        if [ -f "$mirror_file" ] && [ "$mirror_file" != "KNOWLEDGE_TRANSFER_MANIFEST.md" ] && [ "$mirror_file" != "CLAUDE.md" ]; then
            canonical_file="../../../$COMPONENT_A/$mirror_file"
            
            if [ -f "$canonical_file" ]; then
                if ! diff -q "$canonical_file" "$mirror_file" >/dev/null 2>&1; then
                    echo "⚠️ CONFLICT: $canonical_file vs $COMPONENT_B/lib/$COMPONENT_A/$mirror_file"
                    CONFLICTS_FOUND=$((CONFLICTS_FOUND + 1))
                fi
            else
                echo "⚠️ ORPHAN: Mirror file $mirror_file has no canonical source"
                CONFLICTS_FOUND=$((CONFLICTS_FOUND + 1))
            fi
        fi
    done
    
    cd - >/dev/null
fi

# Check B → A mirrors  
echo "Checking $COMPONENT_B → $COMPONENT_A mirrors..."
if [ -d "$COMPONENT_A/lib/$COMPONENT_B" ]; then
    cd "$COMPONENT_A/lib/$COMPONENT_B"
    
    for mirror_file in *.md; do
        if [ -f "$mirror_file" ] && [ "$mirror_file" != "KNOWLEDGE_TRANSFER_MANIFEST.md" ] && [ "$mirror_file" != "CLAUDE.md" ]; then
            canonical_file="../../../$COMPONENT_B/$mirror_file"
            
            if [ -f "$canonical_file" ]; then
                if ! diff -q "$canonical_file" "$mirror_file" >/dev/null 2>&1; then
                    echo "⚠️ CONFLICT: $canonical_file vs $COMPONENT_A/lib/$COMPONENT_B/$mirror_file"
                    CONFLICTS_FOUND=$((CONFLICTS_FOUND + 1))
                fi
            else
                echo "⚠️ ORPHAN: Mirror file $mirror_file has no canonical source"
                CONFLICTS_FOUND=$((CONFLICTS_FOUND + 1))
            fi
        fi
    done
    
    cd - >/dev/null
fi

if [ $CONFLICTS_FOUND -eq 0 ]; then
    echo "✅ No mirror conflicts detected"
    exit 0
else
    echo "❌ $CONFLICTS_FOUND conflicts detected - resolution required"
    exit 1
fi
```

### **Mirror Health Check Script**

**check-mirror-health.sh**:
```bash
#!/bin/bash
# Comprehensive mirror system health check

COMPONENT_A="[COMPONENT_A]"
COMPONENT_B="[COMPONENT_B]"

echo "=== Mirror System Health Check ==="

# 1. Check mirror directory structure
echo "1. Checking mirror directory structure..."

if [ -d "$COMPONENT_A/lib/$COMPONENT_B" ]; then
    echo "✅ $COMPONENT_A/lib/$COMPONENT_B exists"
else
    echo "❌ $COMPONENT_A/lib/$COMPONENT_B missing"
fi

if [ -d "$COMPONENT_B/lib/$COMPONENT_A" ]; then
    echo "✅ $COMPONENT_B/lib/$COMPONENT_A exists"
else
    echo "❌ $COMPONENT_B/lib/$COMPONENT_A missing"
fi

# 2. Check manifest files
echo "2. Checking manifest files..."

for manifest in "$COMPONENT_A/lib/$COMPONENT_B/KNOWLEDGE_TRANSFER_MANIFEST.md" "$COMPONENT_B/lib/$COMPONENT_A/KNOWLEDGE_TRANSFER_MANIFEST.md"; do
    if [ -f "$manifest" ]; then
        echo "✅ $manifest exists"
        
        # Check manifest completeness
        if grep -q "Last Sync" "$manifest" && grep -q "Sync Status" "$manifest"; then
            echo "✅ $manifest has required metadata"
        else
            echo "⚠️ $manifest missing required metadata"
        fi
    else
        echo "❌ $manifest missing"
    fi
done

# 3. Check file counts
echo "3. Checking file counts..."

A_CANONICAL_COUNT=$(find "$COMPONENT_A" -name "*.md" -not -path "*/lib/*" | wc -l)
B_CANONICAL_COUNT=$(find "$COMPONENT_B" -name "*.md" -not -path "*/lib/*" | wc -l)

A_MIRROR_COUNT=$(find "$COMPONENT_B/lib/$COMPONENT_A" -name "*.md" 2>/dev/null | wc -l)
B_MIRROR_COUNT=$(find "$COMPONENT_A/lib/$COMPONENT_B" -name "*.md" 2>/dev/null | wc -l)

echo "$COMPONENT_A canonical files: $A_CANONICAL_COUNT"
echo "$COMPONENT_A mirror files: $A_MIRROR_COUNT"
echo "$COMPONENT_B canonical files: $B_CANONICAL_COUNT"  
echo "$COMPONENT_B mirror files: $B_MIRROR_COUNT"

# 4. Check sync freshness
echo "4. Checking sync freshness..."

# Files older than 24 hours are considered stale
STALE_THRESHOLD=1440 # minutes

find_stale_files() {
    local mirror_dir="$1"
    local component_name="$2"
    
    if [ -d "$mirror_dir" ]; then
        STALE_COUNT=$(find "$mirror_dir" -name "*.md" -not -name "CLAUDE.md" -not -name "KNOWLEDGE_TRANSFER_MANIFEST.md" -mmin +$STALE_THRESHOLD | wc -l)
        echo "$component_name mirror stale files (>24h): $STALE_COUNT"
    fi
}

find_stale_files "$COMPONENT_A/lib/$COMPONENT_B" "$COMPONENT_B"
find_stale_files "$COMPONENT_B/lib/$COMPONENT_A" "$COMPONENT_A"

# 5. Run conflict detection
echo "5. Running conflict detection..."
./scripts/detect-mirror-conflicts.sh

echo "=== Health Check Complete ==="
```

## Conflict Resolution Procedures

### **Conflict Resolution Matrix**

| Conflict Type | Resolution Strategy | Priority | Action |
|---------------|-------------------|----------|--------|
| **Canonical vs Mirror** | Canonical wins | HIGH | Update mirror from canonical |
| **Mirror vs Mirror** | Investigate source | CRITICAL | Check for mirror corruption |
| **Outdated Mirror** | Refresh from canonical | MEDIUM | Run synchronization |
| **Orphaned Mirror** | Remove or link | LOW | Clean up or establish source |

### **Manual Conflict Resolution**

**resolve-conflicts.sh**:
```bash
#!/bin/bash
# Manual conflict resolution tool

CONFLICT_FILE="$1"
CANONICAL_PATH="$2"
MIRROR_PATH="$3"

if [ -z "$CONFLICT_FILE" ] || [ -z "$CANONICAL_PATH" ] || [ -z "$MIRROR_PATH" ]; then
    echo "Usage: $0 <conflict_file> <canonical_path> <mirror_path>"
    exit 1
fi

echo "Resolving conflict for: $CONFLICT_FILE"
echo "Canonical: $CANONICAL_PATH"
echo "Mirror: $MIRROR_PATH"

# 1. Show differences
echo "=== DIFFERENCES ==="
diff -u "$CANONICAL_PATH" "$MIRROR_PATH" || true

# 2. Resolution options
echo ""
echo "Resolution options:"
echo "1. Use canonical version (recommended)"
echo "2. Use mirror version"
echo "3. Manual merge"
echo "4. Skip resolution"

read -p "Choose option (1-4): " choice

case $choice in
    1)
        echo "Using canonical version..."
        cp "$CANONICAL_PATH" "$MIRROR_PATH"
        echo "✅ Conflict resolved: canonical → mirror"
        ;;
    2)
        echo "⚠️ Using mirror version (not recommended)..."
        cp "$MIRROR_PATH" "$CANONICAL_PATH"
        echo "Mirror version copied to canonical"
        ;;
    3)
        echo "Opening files for manual merge..."
        ${EDITOR:-nano} "$CANONICAL_PATH" "$MIRROR_PATH"
        echo "Manual merge completed"
        ;;
    4)
        echo "Skipping resolution"
        exit 0
        ;;
    *)
        echo "Invalid option"
        exit 1
        ;;
esac
```

## Mirror-Specific Documentation

### **CLAUDE.md for Mirrors**

Template for mirror-specific AI collaboration guides:

```markdown
# CLAUDE.md - [COMPONENT_A] Context within [COMPONENT_B]

## Mirror Purpose
This directory contains complete [COMPONENT_A] documentation for understanding integration and cross-component collaboration while working on [COMPONENT_B].

## Integration Patterns
When working on [COMPONENT_B] components that integrate with [COMPONENT_A]:
1. **Review [COMPONENT_A] API**: Check API.md for interface contracts
2. **Understand Architecture**: Review ARCHITECTURE.md for system design
3. **Check Integration Points**: Focus on areas affecting [COMPONENT_B]

## Cross-Component Development
- **API Changes**: Coordinate with [COMPONENT_A] team for interface updates
- **Data Flow**: Understand how data moves between components
- **Error Handling**: Ensure consistent error patterns across components

## Mirror Maintenance
- **Last Sync**: [SYNC_TIMESTAMP]
- **Sync Frequency**: [SYNC_FREQUENCY]
- **Health Status**: [HEALTH_STATUS]
- **Conflict Count**: [CONFLICT_COUNT]

## Context Limitations
This is a **read-only mirror** for context. For [COMPONENT_A] modifications:
1. Work in the canonical [COMPONENT_A] directory
2. Sync changes to this mirror after updates
3. Never edit mirror files directly
```

## Validation and Monitoring

### **Automated Health Monitoring**

**monitor-mirrors.sh** (run via cron):
```bash
#!/bin/bash
# Automated mirror health monitoring

LOG_FILE="/tmp/mirror-health-$(date +%Y%m%d).log"
ALERT_THRESHOLD=5 # conflicts

echo "$(date): Starting mirror health check" >> "$LOG_FILE"

# Run health check
HEALTH_RESULT=$(./scripts/check-mirror-health.sh 2>&1)
echo "$HEALTH_RESULT" >> "$LOG_FILE"

# Check for critical issues
CONFLICT_COUNT=$(echo "$HEALTH_RESULT" | grep -o "[0-9]\+ conflicts detected" | grep -o "[0-9]\+" || echo "0")

if [ "$CONFLICT_COUNT" -gt "$ALERT_THRESHOLD" ]; then
    echo "$(date): ALERT - $CONFLICT_COUNT conflicts detected (threshold: $ALERT_THRESHOLD)" >> "$LOG_FILE"
    
    # Optional: Send notification
    # ./scripts/send-alert.sh "Mirror conflicts detected: $CONFLICT_COUNT"
fi

# Check sync freshness
STALE_COUNT=$(echo "$HEALTH_RESULT" | grep "stale files" | grep -o "[0-9]\+" | head -1 || echo "0")

if [ "$STALE_COUNT" -gt "0" ]; then
    echo "$(date): WARNING - $STALE_COUNT stale mirror files detected" >> "$LOG_FILE"
fi

echo "$(date): Mirror health check complete" >> "$LOG_FILE"
```

### **Continuous Integration Hooks**

**pre-commit hook** for mirror validation:
```bash
#!/bin/bash
# Pre-commit hook to validate mirror consistency

echo "Validating mirror consistency..."

# Check if any mirrored files are being committed
MIRROR_FILES=$(git diff --cached --name-only | grep "/lib/" || true)

if [ -n "$MIRROR_FILES" ]; then
    echo "⚠️ WARNING: Mirror files detected in commit:"
    echo "$MIRROR_FILES"
    echo ""
    echo "Mirror files should not be committed directly."
    echo "Please commit canonical files and sync mirrors separately."
    exit 1
fi

# Run conflict detection
if ! ./scripts/detect-mirror-conflicts.sh >/dev/null 2>&1; then
    echo "❌ Mirror conflicts detected - resolve before committing"
    exit 1
fi

echo "✅ Mirror validation passed"
```

## Template Customization Checklist

### **Required Customizations**
- [ ] All `[PROJECT_NAME]` placeholders replaced
- [ ] All `[COMPONENT_A]` and `[COMPONENT_B]` placeholders replaced
- [ ] All `[FILE_COUNT_A]` and `[FILE_COUNT_B]` placeholders replaced
- [ ] All `[SYNC_FREQUENCY]` placeholders replaced
- [ ] Mirror directory paths updated for actual project structure
- [ ] File lists customized for actual mirrored content

### **Script Customization**
- [ ] Synchronization scripts tested with actual project structure
- [ ] Conflict detection adapted to specific file types and patterns
- [ ] Health monitoring configured for project-specific requirements
- [ ] Resolution procedures tested with sample conflicts
- [ ] Automation hooks integrated with project workflow

### **Validation Framework**
- [ ] Mirror manifests created and populated
- [ ] Synchronization procedures tested and validated
- [ ] Conflict resolution procedures documented and tested
- [ ] Health monitoring operational and alerting configured
- [ ] Integration with version control and CI/CD validated

---

*This mirror synchronization template prevents the chaos that can result from bidirectional documentation systems by providing systematic procedures for maintaining consistency, detecting conflicts, and resolving issues while preserving the benefits of comprehensive context management.*