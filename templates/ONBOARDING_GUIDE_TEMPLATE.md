# AI Co-Development Project Onboarding Template

**For: Future Claude instances working on any AI co-development project**  
**Template Version**: 1.0  
**Methodology**: Systematic, architecture-first, iterative documentation

## Template Usage Instructions

**Before using this template:**
1. Replace `[PROJECT_NAME]` with your actual project name
2. Replace `[FRONTEND_TECH]` with your frontend technology (e.g., React, Vue, Angular)
3. Replace `[BACKEND_TECH]` with your backend technology (e.g., Python, Node.js, Rust)
4. Replace `[DATABASE_TYPE]` with your database (e.g., PostgreSQL, MongoDB, Neo4j)
5. Update file paths to match your project structure

---

# Claude Onboarding Guide - [PROJECT_NAME]

**For future Claude instances working on [PROJECT_NAME] projects**

## Quick Start - Systematic Approach

You're working with a split-project AI co-development environment. Follow this systematic approach:

### Step 1: Identify Project Architecture
- **[PROJECT_NAME]-frontend**: [FRONTEND_TECH] application layer
- **[PROJECT_NAME]-backend**: [BACKEND_TECH] framework/API layer  
- **[PROJECT_NAME]-orchestration**: Docker/deployment/desktop layer

### Step 2: Select Focus Area & Read Appropriate Guide
- **For frontend work**: Read `CLAUDE_FRONTEND_SETUP_GUIDE.md`
- **For backend work**: Read `CLAUDE_BACKEND_SETUP_GUIDE.md`
- **For deployment work**: Read `CLAUDE_ORCHESTRATION_SETUP_GUIDE.md`
- **For new Claude instances**: Continue reading this guide

## System Architecture Overview

**Three Projects, One Integrated System:**
```
[PROJECT_ROOT]/
├── [PROJECT_NAME]-frontend/              ([FRONTEND_TECH] application)
│   └── lib/[PROJECT_NAME]-backend/       (Backend docs mirror)
├── [PROJECT_NAME]-backend/               ([BACKEND_TECH] framework)
│   └── lib/[PROJECT_NAME]-frontend/      (Frontend docs mirror)
└── [PROJECT_NAME]-orchestration/         (Deployment & desktop)
```

**Master Documentation System:**
- **TEMPLATE_ONBOARDING_GUIDE.md** (this file) - Start here
- **CLAUDE_FRONTEND_SETUP_GUIDE.md** - Frontend collaboration patterns
- **CLAUDE_BACKEND_SETUP_GUIDE.md** - Backend collaboration patterns
- **CLAUDE_ORCHESTRATION_SETUP_GUIDE.md** - Deployment collaboration patterns

## Systematic Collaboration Methodology

### Phase 1: Context Assessment
Execute systematic context analysis:

```bash
# 1. Determine current location
pwd

# 2. Identify project component
basename $(pwd)

# 3. Check project status
ls -la *.md | grep -E "(STATUS|CONTINUOUS|CONSOLIDATED)"
```

**Decision Tree:**
- If in `[PROJECT_NAME]-frontend/`: Execute frontend workflow
- If in `[PROJECT_NAME]-backend/`: Execute backend workflow
- If in `[PROJECT_NAME]-orchestration/`: Execute deployment workflow

### Phase 2: Knowledge Transfer Pipeline Execution

#### For Frontend Work
Execute systematic knowledge transfer:

1. **Read Knowledge Transfer Manifest**
   ```bash
   cd lib/[PROJECT_NAME]-backend/
   cat KNOWLEDGE_TRANSFER_MANIFEST.md
   ```

2. **Execute Systematic Review**
   - **CLAUDE.md** - Your collaboration role and procedures
   - **README.md** through **VERSION.md** - Complete backend context
   - **[BACKEND_TECH] configuration files** - Technical integration points
   - **API documentation** - Interface contracts and patterns

3. **Validate Knowledge Transfer**
   - Verify manifest file count matches actual files
   - Check for outdated or missing documentation
   - Test integration examples and code samples

#### For Backend Work
Execute systematic knowledge transfer:

1. **Read Knowledge Transfer Manifest**
   ```bash
   cd lib/[PROJECT_NAME]-frontend/
   cat KNOWLEDGE_TRANSFER_MANIFEST.md
   ```

2. **Execute Systematic Review**
   - **CLAUDE.md** - Your collaboration role and procedures
   - **README.md** through **VERSION.md** - Complete frontend context
   - **[FRONTEND_TECH] configuration files** - Build and deployment config
   - **Component documentation** - UI patterns and integration points

3. **Validate Knowledge Transfer**
   - Verify manifest file count matches actual files
   - Check for outdated or missing documentation
   - Test build configurations and deployment procedures

### Phase 3: Project-Specific Documentation Analysis

#### Current Project Component Root Analysis
Execute systematic documentation review:

**Required Files to Assess:**
- **CONTINUOUS_IMPROVEMENT_PLAN.md** - Ongoing improvement methodology
- **KEY_PROJECT_FILES.md** - Documentation status tracking system
- **CONSOLIDATED_IMPROVEMENT_PLAN.md** - Active improvement execution (if exists)
- **CURRENT_STATUS.md** - Project state and recent changes

**Validation Checklist:**
- [ ] All required documentation files present
- [ ] Status tracking system up to date
- [ ] No active improvement cycles blocking progress
- [ ] Integration points documented and tested

#### Cross-Project Coordination Check
Execute systematic coordination validation:

**Required Coordination Points:**
- Version synchronization ([FRONTEND_TECH] package vs [BACKEND_TECH] package)
- API contract alignment between frontend and backend
- Environment variable consistency across all components
- Documentation mirror synchronization status

## Systematic Improvement Cycle Framework

### Improvement Trigger Categories

1. **Code Change Triggers**
   - Git commits affecting API contracts
   - New feature implementations
   - Dependency updates or migrations

2. **Documentation Triggers**
   - User feedback or issue reports
   - Integration problems or misunderstandings
   - Quality standard updates

3. **Process Triggers**
   - Tool or framework updates
   - Deployment procedure changes
   - Collaboration pattern optimizations

### Systematic Improvement Execution

**Cycle States:**
1. **CONTINUOUS_IMPROVEMENT_PLAN.md** - Ongoing process framework (always exists)
2. **CONSOLIDATED_IMPROVEMENT_PLAN.md** - Specific execution plan (created when triggered)

**Execution Pipeline:**
```
Trigger Event → Context Analysis → Generate CONSOLIDATED Plan → 
Execute Improvements → Update STATUS Tracking → Validate Results → 
Complete Cycle → Capture Lessons Learned
```

**Systematic Procedures:**
1. **Generate Consolidated Plan**: Extract specific improvements from continuous framework
2. **Execute Systematically**: Follow plan procedures with validation checkpoints
3. **Update Status Tracking**: Maintain KEY_PROJECT_FILES.md with current status
4. **Validate Integration**: Test cross-project compatibility and contracts
5. **Complete Cycle**: Archive execution plan and update continuous framework

## Quality Standards Framework

### Systematic Quality Criteria

**Documentation Standards:**
- **Completeness**: All required sections present and populated
- **Accuracy**: Technical details verified and tested
- **Clarity**: Clear language and systematic organization
- **Currency**: Recent updates and current information

**Process Standards:**
- **Consistency**: Follow established patterns and conventions
- **Traceability**: Clear source attribution and change tracking
- **Validation**: Tested procedures and verified examples
- **Integration**: Compatible with cross-project requirements

**Collaboration Standards:**
- **Accessibility**: Clear guidance for AI and human collaborators
- **Systematic**: Repeatable procedures and methodologies
- **Comprehensive**: Complete context for effective collaboration
- **Current**: Up-to-date with latest project state

### Validation Procedures

**Pre-Work Validation:**
- [ ] Correct project component identified
- [ ] Knowledge transfer pipeline executed
- [ ] Current documentation status assessed
- [ ] No blocking improvement cycles active

**Work Execution Validation:**
- [ ] Follow established patterns and conventions
- [ ] Update status tracking continuously
- [ ] Test all code examples and procedures
- [ ] Maintain cross-project compatibility

**Post-Work Validation:**
- [ ] All changes validated and tested
- [ ] Status tracking updated completely
- [ ] Cross-project impacts assessed
- [ ] Documentation mirrors synchronized if needed

## Common Task Templates

### Systematic Release Management
1. **Version Coordination**
   - Update VERSION.md in all relevant projects
   - Coordinate [FRONTEND_TECH] and [BACKEND_TECH] package versions
   - Validate API contract compatibility

2. **Release Documentation**
   - Create RELEASE_NOTES_v[VERSION].md
   - Update CHANGELOG.md with systematic categorization
   - Update integration documentation for version changes

3. **Deployment Validation**
   - Test deployment procedures in [PROJECT_NAME]-orchestration
   - Validate environment variable compatibility
   - Execute integration test suites

### Systematic Mirror Synchronization
1. **Manifest Validation**
   - Check KNOWLEDGE_TRANSFER_MANIFEST.md in both mirrors
   - Verify file counts and names match actual content
   - Identify additions, removals, or modifications needed

2. **Content Synchronization**
   - Copy changed files maintaining directory structure
   - Update CLAUDE.md if collaboration procedures changed
   - Validate technical content accuracy

3. **Integration Testing**
   - Test cross-project examples and procedures
   - Validate API contract documentation alignment
   - Execute integration validation procedures

## Systematic Navigation Reference

### Project Component Quick Reference
```
[PROJECT_ROOT]/
├── TEMPLATE_ONBOARDING_GUIDE.md (this file)
├── CLAUDE_FRONTEND_SETUP_GUIDE.md
├── CLAUDE_BACKEND_SETUP_GUIDE.md
├── CLAUDE_ORCHESTRATION_SETUP_GUIDE.md
├── [PROJECT_NAME]-frontend/
│   ├── CONTINUOUS_IMPROVEMENT_PLAN.md
│   ├── KEY_PROJECT_FILES.md
│   └── lib/[PROJECT_NAME]-backend/ ([N] files)
│       ├── KNOWLEDGE_TRANSFER_MANIFEST.md
│       └── CLAUDE.md
├── [PROJECT_NAME]-backend/
│   ├── CONTINUOUS_IMPROVEMENT_PLAN.md
│   ├── KEY_PROJECT_FILES.md
│   └── lib/[PROJECT_NAME]-frontend/ ([N] files)
│       ├── KNOWLEDGE_TRANSFER_MANIFEST.md
│       └── CLAUDE.md
└── [PROJECT_NAME]-orchestration/
    ├── compose/                    # Docker configurations
    ├── desktop/                    # Desktop app configurations
    └── scripts/                    # Deployment and utility scripts
```

### Technology-Specific Quick Start

**For [FRONTEND_TECH] Development:**
```bash
cd [PROJECT_NAME]-frontend
[FRONTEND_PACKAGE_MANAGER] install
[FRONTEND_DEV_COMMAND]
```

**For [BACKEND_TECH] Development:**
```bash
cd [PROJECT_NAME]-backend
[BACKEND_ENV_SETUP]
[BACKEND_INSTALL_COMMAND]
[BACKEND_DEV_COMMAND]
```

**For Deployment:**
```bash
cd [PROJECT_NAME]-orchestration/compose
docker-compose up -d
```

## Systematic Next Steps

### Initial Setup Execution
1. **Identify your focus area** (frontend, backend, orchestration)
2. **Read the appropriate setup guide** (systematic collaboration patterns)
3. **Execute knowledge transfer pipeline** (comprehensive context building)
4. **Assess current project state** (status tracking and improvement cycles)
5. **Begin systematic collaboration** (following established methodologies)

### Ongoing Collaboration Framework
1. **Maintain systematic quality standards** throughout all work
2. **Update status tracking continuously** as work progresses
3. **Coordinate cross-project impacts** for integration compatibility
4. **Execute improvement cycles** when triggered by changes or feedback
5. **Contribute to methodology refinement** through lessons learned capture

---

## Template Customization Checklist

**Required Customizations:**
- [ ] Replace all `[PROJECT_NAME]` placeholders
- [ ] Replace all `[FRONTEND_TECH]` placeholders
- [ ] Replace all `[BACKEND_TECH]` placeholders
- [ ] Replace all `[DATABASE_TYPE]` placeholders
- [ ] Update file paths to match actual project structure
- [ ] Customize technology-specific commands and procedures
- [ ] Validate all examples and procedures work with chosen technology stack

**Optional Customizations:**
- [ ] Add project-specific quality standards
- [ ] Include custom integration patterns
- [ ] Add domain-specific terminology
- [ ] Include project-specific tooling references

---

*This template enables systematic AI co-development across diverse technology stacks while maintaining quality, consistency, and effective collaboration patterns.*