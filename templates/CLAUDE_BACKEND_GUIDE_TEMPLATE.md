# Claude Backend Setup Guide Template

**For: Future Claude instances working on [PROJECT_NAME] backend development**  
**Template Version**: 1.0  
**Technology Stack**: [BACKEND_TECH] ([PYTHON/NODE/RUST/GO])  
**Methodology**: Systematic backend AI collaboration patterns

## Template Customization Instructions

**Before using this template:**
1. Replace `[PROJECT_NAME]` with your actual project name
2. Replace `[BACKEND_TECH]` with your backend technology
3. Replace `[PACKAGE_MANAGER]` with pip/npm/cargo/go mod
4. Replace `[VIRTUAL_ENV]` with venv/virtualenv/conda (for Python)
5. Replace `[TEST_COMMAND]` with your test runner command
6. Update file paths and technology-specific procedures

---

# Claude Backend Setup Guide - [PROJECT_NAME]

**For future Claude instances working on [PROJECT_NAME] backend development**

## Systematic Backend Collaboration Framework

### Quick Context Assessment
You are working on the **[PROJECT_NAME]-backend** component using [BACKEND_TECH]. This guide provides systematic collaboration patterns for effective AI-assisted backend development.

**Project Architecture Context:**
```
[PROJECT_NAME]/
├── [PROJECT_NAME]-frontend/             # Frontend application
├── [PROJECT_NAME]-backend/              # You are here
│   ├── [PROJECT_PACKAGE]/              # Core package/module
│   ├── lib/[PROJECT_NAME]-frontend/    # Frontend docs mirror
│   ├── [PACKAGE_CONFIG_FILE]           # Dependencies (setup.py/package.json/Cargo.toml)
│   └── [Backend configuration files]
└── [PROJECT_NAME]-orchestration/       # Deployment layer
```

## Phase 1: Environment Assessment & Setup

### Step 1: Systematic Environment Validation
```bash
# 1. Confirm location and project context
pwd  # Should show: .../[PROJECT_NAME]-backend
ls -la [PACKAGE_CONFIG_FILE]  # Verify backend project

# 2. Check development environment
[BACKEND_TECH] --version  # Verify language installation
[PACKAGE_MANAGER] --version  # Verify package manager

# 3. Assess current project state (Python example)
ls -la [VIRTUAL_ENV]/ 2>/dev/null || echo "Virtual environment needs setup"
[PACKAGE_MANAGER] list 2>/dev/null || echo "Package list unavailable"
```

**Technology-Specific Environment Setup:**

#### Python Environment
```bash
# 1. Create/activate virtual environment
python -m venv [VIRTUAL_ENV] || python3 -m venv [VIRTUAL_ENV]
source [VIRTUAL_ENV]/bin/activate  # Linux/Mac
# OR
[VIRTUAL_ENV]\Scripts\activate  # Windows

# 2. Install dependencies
pip install -e .  # Editable installation
pip install -r requirements.txt  # Additional requirements

# 3. Verify installation
python -c "import [PROJECT_PACKAGE]; print('Package imported successfully')"
```

#### Node.js Environment
```bash
# 1. Install dependencies
npm install  # or yarn install

# 2. Verify installation
node -e "console.log('Node.js backend environment ready')"
npm run --help  # Check available scripts
```

#### Rust Environment
```bash
# 1. Build project
cargo build

# 2. Run tests to verify setup
cargo test

# 3. Check project structure
cargo tree  # Dependency tree
```

#### Go Environment
```bash
# 1. Download dependencies
go mod download

# 2. Build project
go build

# 3. Run tests
go test ./...
```

**Validation Checklist:**
- [ ] Located in correct backend directory
- [ ] Language runtime and package manager available
- [ ] Package configuration file exists and is readable
- [ ] Dependencies installed successfully
- [ ] Development environment properly configured

## Phase 2: Knowledge Transfer Integration

### Step 1: Frontend Context Integration
```bash
# Navigate to frontend documentation mirror
cd lib/[PROJECT_NAME]-frontend/

# Execute systematic frontend context review
cat KNOWLEDGE_TRANSFER_MANIFEST.md  # Canonical file list
cat CLAUDE.md  # Your role in this mirror context
```

**Systematic Frontend Context Analysis:**
1. **API Requirements Understanding**
   - Review component requirements and data needs
   - Analyze UI/UX patterns requiring backend support
   - Understand frontend state management patterns

2. **Integration Patterns**
   - HTTP API design requirements
   - Authentication and authorization needs
   - Real-time communication requirements (WebSocket, SSE)

3. **Data Flow Analysis**
   - Frontend data models and expected schemas
   - Form validation and submission patterns
   - Error handling and user feedback requirements

**Knowledge Transfer Validation:**
- [ ] Frontend API requirements understood
- [ ] Data models and schemas mapped
- [ ] Integration patterns identified
- [ ] Authentication flows understood

### Step 2: Backend-Specific Documentation Review
```bash
# Return to backend root
cd ../..

# Review backend-specific documentation
cat CONTINUOUS_IMPROVEMENT_PLAN.md  # Improvement methodology
cat KEY_PROJECT_FILES.md  # Documentation status
ls docs/ 2>/dev/null || echo "No docs directory"
```

**Systematic Documentation Analysis:**
1. **Architecture Documentation**
   - Service architecture patterns
   - Database design and models
   - API design principles

2. **Development Standards**
   - Code style and formatting rules
   - Testing patterns and requirements
   - Security and performance standards

3. **Deployment and Operations**
   - Environment configuration
   - Monitoring and logging patterns
   - Database migration procedures

## Phase 3: Development Environment Configuration

### Step 1: Database and Services Setup
```bash
# 1. Check database configuration
cat .env.example  # Review required environment variables
ls docker-compose.yml 2>/dev/null || echo "No Docker Compose configuration"

# 2. Start supporting services (if using Docker)
docker-compose up -d database  # Start database
docker-compose up -d redis     # Start cache (if applicable)

# 3. Verify service connectivity
# Database connection test (technology-specific)
[DATABASE_CONNECTION_TEST_COMMAND]
```

**Database Setup Validation:**
- [ ] Database service running and accessible
- [ ] Connection credentials configured
- [ ] Database schema initialized (if applicable)
- [ ] Supporting services (cache, message queue) running

### Step 2: API Server Setup
```bash
# 1. Start development server
[BACKEND_DEV_COMMAND]  # python main.py, npm run dev, cargo run, go run main.go

# 2. Verify server accessibility (in another terminal)
curl -I http://localhost:8080/health || echo "Health endpoint not accessible"

# 3. Check API documentation
curl http://localhost:8080/docs 2>/dev/null || echo "API docs not available"
```

**API Server Validation:**
- [ ] Development server starts without errors
- [ ] Health endpoint responds correctly
- [ ] API documentation accessible (if configured)
- [ ] Hot reload functionality working (if applicable)

### Step 3: Testing Infrastructure
```bash
# 1. Run existing test suite
[TEST_COMMAND]  # pytest, npm test, cargo test, go test

# 2. Check test coverage
[COVERAGE_COMMAND] 2>/dev/null || echo "Coverage not configured"

# 3. Run linting and formatting
[LINT_COMMAND]   # flake8, eslint, clippy, golint
[FORMAT_COMMAND] 2>/dev/null || echo "Formatting not configured"
```

**Testing Infrastructure Validation:**
- [ ] Test suite runs without failures
- [ ] Code coverage meets project standards
- [ ] Linting rules pass
- [ ] Code formatting consistent

## Phase 4: Systematic Development Patterns

### Backend Development Methodology

#### API Endpoint Development Pattern
```python
# Template for systematic API development (Python/FastAPI example)

from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel
from typing import List, Optional

# 1. API Design Assessment
# - Review frontend requirements in lib/[PROJECT_NAME]-frontend/
# - Define request/response models
# - Plan error handling and validation

# 2. Model Definition
class [EntityName]Request(BaseModel):
    # Request model following project patterns
    pass

class [EntityName]Response(BaseModel):
    # Response model following project patterns
    pass

# 3. Router Implementation
router = APIRouter(prefix="/api/[entity]", tags=["[entity]"])

@router.post("/", response_model=[EntityName]Response)
async def create_[entity](
    request: [EntityName]Request,
    # Dependencies following project patterns
) -> [EntityName]Response:
    # Implementation following project patterns
    # Including validation, business logic, error handling
    pass

# 4. Testing Strategy
# - Unit tests for business logic
# - Integration tests for API endpoints
# - Database integration tests
```

#### Database Integration Pattern
```python
# Template for systematic database integration

# 1. Database Architecture Assessment
# - Review data model requirements
# - Plan relationships and constraints
# - Design migration strategy

# 2. Model Definition (SQLAlchemy example)
from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class [EntityName](Base):
    __tablename__ = "[entity_table]"
    
    # Fields following project patterns and conventions
    id = Column(Integer, primary_key=True, index=True)
    # Additional fields...

# 3. Repository Pattern Implementation
class [EntityName]Repository:
    def __init__(self, session: Session):
        self.session = session
    
    async def create(self, entity_data: [EntityName]Request) -> [EntityName]:
        # Implementation following project patterns
        pass
    
    async def get_by_id(self, entity_id: int) -> Optional[[EntityName]]:
        # Implementation following project patterns
        pass

# 4. Testing Strategy
# - Unit tests for repository methods
# - Integration tests with test database
# - Migration testing
```

#### Authentication and Authorization Pattern
```python
# Template for systematic auth implementation

# 1. Authentication Strategy Assessment
# - Review frontend authentication requirements
# - Plan token management and refresh
# - Design authorization patterns

# 2. Authentication Implementation
from fastapi.security import HTTPBearer
from jose import JWTError, jwt

security = HTTPBearer()

async def get_current_user(token: str = Depends(security)):
    # Implementation following project security patterns
    # Including token validation, user lookup, error handling
    pass

# 3. Authorization Decorators/Middleware
def require_roles(*roles):
    def decorator(func):
        # Authorization implementation following project patterns
        pass
    return decorator

# 4. Testing Strategy
# - Unit tests for auth functions
# - Integration tests for protected endpoints
# - Security testing for token handling
```

## Phase 5: Quality Assurance Framework

### Systematic Code Quality Validation

#### Pre-Development Checklist
- [ ] Frontend API requirements reviewed and understood
- [ ] Database schema design planned
- [ ] Authentication/authorization patterns confirmed
- [ ] Testing strategy planned
- [ ] Security considerations identified

#### Development Process Validation
- [ ] Code follows project conventions and patterns
- [ ] Type hints/annotations properly defined and used
- [ ] Error handling implemented consistently
- [ ] Security best practices followed
- [ ] Performance considerations addressed

#### Post-Development Validation
- [ ] Unit tests written and passing
- [ ] Integration tests cover API endpoints
- [ ] Security standards met
- [ ] Code review checklist completed
- [ ] Documentation updated as needed

### Automated Quality Checks
```bash
# Systematic quality validation script template
#!/bin/bash

echo "Running systematic backend quality checks..."

# Technology-specific quality checks

# Python example:
echo "Checking Python code quality..."
flake8 [PROJECT_PACKAGE]/ || exit 1
mypy [PROJECT_PACKAGE]/ || exit 1
black --check [PROJECT_PACKAGE]/ || exit 1
pytest --cov=[PROJECT_PACKAGE] --cov-report=term-missing || exit 1

# Node.js example:
# echo "Checking Node.js code quality..."
# npm run lint || exit 1
# npm run type-check || exit 1
# npm run test || exit 1

# Rust example:
# echo "Checking Rust code quality..."
# cargo clippy -- -D warnings || exit 1
# cargo fmt --check || exit 1
# cargo test || exit 1

# Go example:
# echo "Checking Go code quality..."
# go vet ./... || exit 1
# gofmt -d . || exit 1
# go test ./... || exit 1

echo "All quality checks passed successfully"
```

## Phase 6: API Integration & Testing

### Frontend Integration Validation
```bash
# Systematic frontend integration testing

# 1. API contract validation
# Start backend server
[BACKEND_DEV_COMMAND] &
sleep 5  # Wait for server startup

# Test API endpoints match frontend expectations
curl -X GET http://localhost:8080/api/health
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"test","password":"test"}'

# 2. CORS configuration validation
# Test CORS headers for frontend domain
curl -H "Origin: http://localhost:3000" \
  -H "Access-Control-Request-Method: POST" \
  -H "Access-Control-Request-Headers: X-Requested-With" \
  -X OPTIONS http://localhost:8080/api/users

# 3. WebSocket integration (if applicable)
# Test WebSocket connectivity and message handling
```

### Database Integration Testing
```bash
# Systematic database integration testing

# 1. Migration testing
[MIGRATION_COMMAND]  # alembic upgrade head, npm run migrate, etc.

# 2. Data model validation
# Test CRUD operations for all models
# Validate relationships and constraints

# 3. Performance testing
# Test query performance with sample data
# Validate indexing and optimization
```

## Phase 7: Documentation Maintenance

### Systematic Documentation Updates

#### API Documentation
```python
# API Documentation Template (OpenAPI/Swagger)

@router.post(
    "/",
    response_model=[EntityName]Response,
    summary="Create new [entity]",
    description="""
    Create a new [entity] with the provided data.
    
    - **[field]**: Description of field requirements
    - **[field]**: Description of field constraints
    
    Returns the created [entity] with generated ID and timestamps.
    """,
    responses={
        201: {"description": "[Entity] created successfully"},
        400: {"description": "Invalid input data"},
        401: {"description": "Authentication required"},
        422: {"description": "Validation error"},
    }
)
async def create_[entity](request: [EntityName]Request):
    # Implementation...
    pass
```

#### Database Schema Documentation
```sql
-- Schema Documentation Template

-- Table: [entity_table]
-- Purpose: [Description of table purpose]
-- Relationships: [Description of relationships]

CREATE TABLE [entity_table] (
    id SERIAL PRIMARY KEY,  -- Auto-incrementing unique identifier
    -- Additional fields with comments...
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Record creation time
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP   -- Last update time
);

-- Indexes for performance optimization
CREATE INDEX idx_[entity]_[field] ON [entity_table] ([field]);

-- Constraints for data integrity
ALTER TABLE [entity_table] ADD CONSTRAINT [constraint_name] [constraint_definition];
```

#### Status Tracking Updates
```bash
# Update KEY_PROJECT_FILES.md systematically
# Include new endpoints, updated models, testing status
# Maintain current status of all backend documentation
```

## Technology-Specific Patterns

### [BACKEND_TECH] Best Practices
```python
# Python-specific patterns:
# - Async/await patterns for I/O operations
# - Context managers for resource handling
# - Type hints for better code documentation
# - Dependency injection patterns

# Node.js-specific patterns:
# - Promise/async patterns
# - Express.js middleware patterns
# - Error handling middleware
# - Environment configuration patterns

# Rust-specific patterns:
# - Error handling with Result types
# - Ownership and borrowing patterns
# - Trait implementations
# - Async runtime patterns

# Go-specific patterns:
# - Error handling patterns
# - Interface design patterns
# - Goroutine and channel patterns
# - Context usage patterns
```

### Security Implementation Patterns
```python
# Security best practices template

# 1. Input Validation
from pydantic import BaseModel, validator

class UserInput(BaseModel):
    email: str
    
    @validator('email')
    def validate_email(cls, v):
        # Email validation following security standards
        pass

# 2. Authentication Security
# - Password hashing with bcrypt/argon2
# - JWT token security practices
# - Rate limiting implementation
# - CSRF protection

# 3. Database Security
# - SQL injection prevention
# - Query parameterization
# - Connection security
# - Data encryption at rest

# 4. API Security
# - HTTPS enforcement
# - CORS configuration
# - Rate limiting
# - Input sanitization
```

## Continuous Improvement Integration

### Improvement Trigger Identification
1. **Performance Issues**: Query performance, response times, resource usage
2. **Security Issues**: Vulnerabilities, authentication problems, data exposure
3. **Integration Issues**: API compatibility, frontend integration problems
4. **Code Quality Issues**: Technical debt, complexity, maintainability

### Systematic Improvement Execution
1. **Assessment**: Analyze improvement triggers and impacts
2. **Planning**: Create specific improvement plan from CONTINUOUS_IMPROVEMENT_PLAN
3. **Implementation**: Execute improvements following quality standards
4. **Validation**: Test improvements and validate integration
5. **Documentation**: Update documentation and status tracking

## Troubleshooting Guide

### Common Backend Issues
1. **Dependency Issues**
   - Clear package cache and reinstall
   - Check for version conflicts
   - Validate virtual environment

2. **Database Issues**
   - Check connection credentials
   - Validate database service status
   - Review migration status

3. **API Issues**
   - Check request/response formats
   - Validate authentication tokens
   - Review CORS configuration

4. **Performance Issues**
   - Profile database queries
   - Check resource usage
   - Validate caching strategies

---

## Template Customization Validation

**Required Customizations Completed:**
- [ ] All `[PROJECT_NAME]` placeholders replaced
- [ ] All `[BACKEND_TECH]` placeholders replaced
- [ ] All `[PACKAGE_MANAGER]` placeholders replaced
- [ ] All technology-specific commands updated
- [ ] Database configuration customized
- [ ] API patterns customized for chosen framework
- [ ] File paths updated to match project structure

**Quality Validation:**
- [ ] All procedures tested with actual project
- [ ] Code examples execute successfully
- [ ] Integration points validated with frontend
- [ ] Security patterns properly implemented

---

*This template provides systematic AI collaboration patterns for backend development while maintaining security, performance, and integration standards across diverse technology stacks.*