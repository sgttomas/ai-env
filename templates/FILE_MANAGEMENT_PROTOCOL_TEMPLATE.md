# File Management Protocol Template

**Purpose**: Prevent AI co-development chaos through systematic file location transparency  
**Critical Issue**: AI loses track of working directory, version control state, and file relationships  
**Evidence**: vibe-code-challenge session demonstrated systematic documentation improvements with unknown persistence  
**Template Version**: 1.0

## Template Customization Instructions

**Before using this template:**
1. Replace `[PROJECT_NAME]` with your actual project name
2. Replace `[REPOSITORY_URL]` with your project's repository URL
3. Replace `[MAIN_BRANCH]` with your default branch name (usually 'main' or 'master')
4. Replace `[VCS_SYSTEM]` with your version control system (usually 'git')
5. Customize file patterns and validation rules for your project structure

---

# File Management Protocol - [PROJECT_NAME]

**Project**: [PROJECT_NAME]  
**Repository**: [REPOSITORY_URL]  
**Default Branch**: [MAIN_BRANCH]  
**Version Control**: [VCS_SYSTEM]  
**Protocol Version**: 1.0

## Critical Vulnerability Overview

### **The File Location Nightmare**

**What AI Cannot See**:
- Whether files are under version control
- If changes are being made to the "real" project or a copy
- Which repository (if any) changes belong to
- How changes propagate between mirror directories
- Whether multiple AI sessions are working on the same files

**Catastrophic Risk Pattern**:
```
AI Session 1: Updates project-app/DOCS.md
AI Session 2: Updates project-mirror/DOCS.md  
Human: Both versions exist, contradicting each other
Result: Documentation fragmentation and chaos
```

## Pre-Session Validation Protocol

### **Step 1: Working Directory Confirmation**

**Required Commands** (Human must execute and provide to AI):
```bash
# 1. Current working directory
pwd

# 2. Git repository status
git status

# 3. Current branch
git branch --show-current

# 4. File listing
ls -la

# 5. Repository root identification
git rev-parse --show-toplevel

# 6. Remote repository information
git remote -v
```

**AI Validation Checklist**:
- [ ] Working directory path explicitly confirmed
- [ ] Git repository status clean or documented
- [ ] Current branch identified and appropriate
- [ ] File listing shows expected project structure
- [ ] Repository root matches expected location
- [ ] Remote repository matches [REPOSITORY_URL]

### **Step 2: File Location Mapping**

**Repository Structure Validation**:
```bash
# Validate project structure matches expected layout
tree -L 2 . || find . -maxdepth 2 -type d

# Check for mirror directories
find . -name "lib" -type d
find . -name "*mirror*" -type d

# Identify potential duplicate documentation
find . -name "*.md" | sort
```

**AI Documentation Location Matrix**:
```
CANONICAL LOCATIONS (work here):
- [PROJECT_NAME]/README.md
- [PROJECT_NAME]/docs/
- [PROJECT_NAME]/CHANGELOG.md

MIRROR LOCATIONS (read-only context):
- [PROJECT_NAME]/lib/other-project/
- [PROJECT_NAME]/examples/
- [PROJECT_NAME]/templates/

DANGEROUS LOCATIONS (never work here):
- /tmp/[PROJECT_NAME]/
- [PROJECT_NAME]-copy/
- [PROJECT_NAME]-backup/
```

## During-Session Tracking Protocol

### **File Modification Validation**

**Before Every File Edit**:
```bash
# 1. Confirm file location
realpath [FILE_PATH]

# 2. Check version control status
git status [FILE_PATH]

# 3. Verify no conflicting copies
find . -name "$(basename [FILE_PATH])" -type f

# 4. Check file permissions
ls -la [FILE_PATH]
```

**AI Pre-Edit Checklist**:
- [ ] File path is in canonical location (not mirror/copy)
- [ ] File is tracked by version control or intentionally untracked
- [ ] No conflicting copies found in other directories
- [ ] File is writable and AI has permission to modify

### **Real-Time Synchronization Tracking**

**After Every File Modification**:
```bash
# 1. Confirm change was applied
git diff [FILE_PATH]

# 2. Check for unexpected side effects
git status

# 3. Verify no mirror pollution
find . -path "*/lib/*" -name "$(basename [FILE_PATH])" -newer [FILE_PATH]

# 4. Document change context
echo "$(date): Modified [FILE_PATH] - [CHANGE_DESCRIPTION]" >> .ai_changes.log
```

**AI Post-Edit Checklist**:
- [ ] Change successfully applied to intended file
- [ ] No unexpected files modified
- [ ] No mirror directories accidentally updated
- [ ] Change logged for human review

## Version Control Integration Protocol

### **Pre-Commit Validation**

**Required Checks Before Any Commit**:
```bash
# 1. Verify clean git state understanding
git status --porcelain

# 2. Check for staging area confusion
git diff --cached --name-only

# 3. Validate commit scope
git diff --name-only HEAD

# 4. Check for mirror contamination
git diff --name-only | grep -E "(lib/|mirror/|copy/|backup/)" && echo "⚠️ Mirror files detected"

# 5. Verify branch state
git branch --show-current
git log --oneline -n 5
```

**AI Pre-Commit Checklist**:
- [ ] Only intended files staged for commit
- [ ] No mirror/copy/backup files included
- [ ] Working on correct branch
- [ ] Commit scope appropriate and documented
- [ ] No merge conflicts or dirty state

### **Post-Commit Validation**

**Required Verification After Commit**:
```bash
# 1. Confirm commit success
git log --oneline -n 1

# 2. Verify no orphaned changes
git status

# 3. Check remote synchronization potential
git status -b

# 4. Validate no mirror desynchronization
./scripts/validate-mirror-sync.sh || echo "⚠️ Mirror sync validation needed"
```

**AI Post-Commit Checklist**:
- [ ] Commit successfully created
- [ ] No uncommitted changes remain (unless intentional)
- [ ] Branch state clean and ready for push
- [ ] Mirror synchronization validated or flagged for attention

## Mirror Directory Management Protocol

### **Mirror Relationship Mapping**

**Documentation Structure**:
```
[PROJECT_NAME]/
├── canonical-docs/                 # Source of truth
│   ├── README.md
│   ├── API.md
│   └── ARCHITECTURE.md
├── lib/other-project/              # Read-only mirror
│   ├── KNOWLEDGE_TRANSFER_MANIFEST.md
│   ├── README.md (read-only)
│   └── API.md (read-only)
└── docs-mirror-status.json        # Synchronization tracking
```

**Mirror Status Tracking**:
```json
{
  "last_sync": "2025-01-20T10:30:00Z",
  "canonical_source": "[PROJECT_NAME]/canonical-docs/",
  "mirrors": [
    {
      "path": "lib/other-project/",
      "status": "SYNCHRONIZED",
      "file_count": 15,
      "last_update": "2025-01-20T10:30:00Z"
    }
  ],
  "sync_conflicts": [],
  "validation_status": "HEALTHY"
}
```

### **Mirror Synchronization Protocol**

**Before Modifying Any Documentation**:
```bash
# 1. Check mirror synchronization status
./scripts/check-mirror-status.sh

# 2. Identify canonical vs mirror files
./scripts/identify-canonical-files.sh [FILE_PATH]

# 3. Validate modification permissions
./scripts/validate-modification-permissions.sh [FILE_PATH]
```

**Mirror Update Workflow**:
```bash
# 1. Update canonical file only
edit [CANONICAL_PATH]/file.md

# 2. Validate canonical change
git diff [CANONICAL_PATH]/file.md

# 3. Sync to mirrors (if appropriate)
./scripts/sync-to-mirrors.sh [CANONICAL_PATH]/file.md

# 4. Validate mirror synchronization
./scripts/validate-mirror-sync.sh
```

## Conflict Resolution Protocol

### **Multi-Session Conflict Detection**

**Session Startup Validation**:
```bash
# 1. Check for concurrent modifications
git log --oneline --since="1 hour ago"

# 2. Identify potential conflicts
find . -name "*.md" -newer .ai_last_session || touch .ai_last_session

# 3. Check for mirror divergence
./scripts/detect-mirror-conflicts.sh

# 4. Validate workspace cleanliness
git status | grep -E "(conflict|merge)" && echo "⚠️ Conflicts detected"
```

**Conflict Resolution Matrix**:
```
CANONICAL vs CANONICAL: Use git merge workflow
CANONICAL vs MIRROR: Canonical wins, update mirror
MIRROR vs MIRROR: Investigate source of mirror corruption
SESSION vs SESSION: Use timestamp and git history
```

### **Emergency Recovery Procedures**

**When File Locations Are Uncertain**:
```bash
# 1. Complete repository analysis
find . -name "*.md" -exec ls -la {} \; > file_inventory.txt

# 2. Git history analysis
git log --name-only --oneline -n 20 > recent_changes.txt

# 3. Mirror relationship analysis
./scripts/analyze-mirror-relationships.sh > mirror_analysis.txt

# 4. Generate recovery plan
./scripts/generate-recovery-plan.sh > recovery_plan.md
```

**Recovery Decision Framework**:
1. **Identify canonical source** (usually in main project directory)
2. **Backup current state** before any changes
3. **Resolve using git history** for definitive source
4. **Update mirrors from canonical** source
5. **Validate complete system consistency**

## Automation Scripts Framework

### **Required Validation Scripts**

**check-mirror-status.sh**:
```bash
#!/bin/bash
# Validates mirror synchronization status

PROJECT_ROOT="$(git rev-parse --show-toplevel)"
echo "Checking mirror status for $PROJECT_ROOT..."

# Check canonical files
CANONICAL_COUNT=$(find "$PROJECT_ROOT" -name "*.md" -not -path "*/lib/*" | wc -l)
echo "Canonical files: $CANONICAL_COUNT"

# Check mirror files
MIRROR_COUNT=$(find "$PROJECT_ROOT/lib" -name "*.md" 2>/dev/null | wc -l)
echo "Mirror files: $MIRROR_COUNT"

# Generate status report
echo "Mirror status: $([ $MIRROR_COUNT -gt 0 ] && echo "ACTIVE" || echo "NONE")"
exit 0
```

**validate-modification-permissions.sh**:
```bash
#!/bin/bash
# Validates whether file should be modified

FILE_PATH="$1"
if [ -z "$FILE_PATH" ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

# Check if file is in mirror directory
if echo "$FILE_PATH" | grep -q "/lib/"; then
    echo "❌ BLOCKED: File is in mirror directory"
    echo "Canonical location: $(echo "$FILE_PATH" | sed 's|/lib/[^/]*/||')"
    exit 1
fi

# Check if file is canonical
if [ -f "$FILE_PATH" ] && [ -w "$FILE_PATH" ]; then
    echo "✅ ALLOWED: File is canonical and writable"
    exit 0
else
    echo "❌ BLOCKED: File not found or not writable"
    exit 1
fi
```

**detect-mirror-conflicts.sh**:
```bash
#!/bin/bash
# Detects conflicts between canonical and mirror files

PROJECT_ROOT="$(git rev-parse --show-toplevel)"
CONFLICTS_FOUND=0

echo "Detecting mirror conflicts..."

# Compare canonical vs mirror files
find "$PROJECT_ROOT" -name "*.md" -not -path "*/lib/*" | while read canonical_file; do
    filename=$(basename "$canonical_file")
    
    # Find corresponding mirror files
    find "$PROJECT_ROOT/lib" -name "$filename" 2>/dev/null | while read mirror_file; do
        if ! diff -q "$canonical_file" "$mirror_file" >/dev/null 2>&1; then
            echo "⚠️ CONFLICT: $canonical_file vs $mirror_file"
            CONFLICTS_FOUND=$((CONFLICTS_FOUND + 1))
        fi
    done
done

if [ $CONFLICTS_FOUND -eq 0 ]; then
    echo "✅ No mirror conflicts detected"
else
    echo "❌ $CONFLICTS_FOUND conflicts detected - resolution required"
fi
```

## AI Session Protocol Checklist

### **Session Startup Checklist**
- [ ] **PWD**: Working directory explicitly confirmed
- [ ] **GIT STATUS**: Repository state clean and documented
- [ ] **BRANCH**: Correct branch identified and validated
- [ ] **MIRRORS**: Mirror relationships mapped and validated
- [ ] **CONFLICTS**: No existing conflicts detected
- [ ] **PERMISSIONS**: File modification permissions validated

### **During Session Checklist**
- [ ] **FILE LOCATION**: Every file edit in canonical location
- [ ] **CHANGE TRACKING**: All modifications logged and validated
- [ ] **MIRROR SAFETY**: No accidental mirror contamination
- [ ] **VCS INTEGRATION**: Version control state maintained
- [ ] **CONFLICT PREVENTION**: No simultaneous edits to related files

### **Session Completion Checklist**
- [ ] **COMMIT STATE**: All changes committed or explicitly left staged
- [ ] **MIRROR SYNC**: Mirror synchronization validated or flagged
- [ ] **CHANGE LOG**: Complete session changes documented
- [ ] **VALIDATION**: All modifications verified and tested
- [ ] **HANDOFF**: Clear state for next session documented

## Template Customization Checklist

### **Required Customizations**
- [ ] All `[PROJECT_NAME]` placeholders replaced
- [ ] All `[REPOSITORY_URL]` placeholders replaced
- [ ] All `[MAIN_BRANCH]` placeholders replaced
- [ ] All `[VCS_SYSTEM]` placeholders replaced
- [ ] Project-specific file patterns identified
- [ ] Mirror relationships documented

### **Script Customization**
- [ ] Validation scripts customized for project structure
- [ ] File patterns updated for project conventions
- [ ] Mirror directories identified and mapped
- [ ] Conflict resolution procedures tested
- [ ] Automation framework validated

### **Protocol Validation**
- [ ] File location protocols tested with sample files
- [ ] Version control integration validated
- [ ] Mirror synchronization procedures working
- [ ] Conflict detection and resolution tested
- [ ] Emergency recovery procedures documented

---

*This file management protocol template prevents the systematic success from becoming systematic chaos by ensuring AI always knows exactly where it is, what it's modifying, and how those modifications integrate with the larger system.*