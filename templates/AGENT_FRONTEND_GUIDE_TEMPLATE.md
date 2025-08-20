# Claude Frontend Setup Guide Template

**For: Future Claude instances working on [PROJECT_NAME] frontend development**  
**Template Version**: 1.0  
**Technology Stack**: [FRONTEND_TECH] ([REACT/VUE/ANGULAR/SVELTE])  
**Methodology**: Systematic frontend AI collaboration patterns

## Template Customization Instructions

**Before using this template:**
1. Replace `[PROJECT_NAME]` with your actual project name
2. Replace `[FRONTEND_TECH]` with your frontend technology
3. Replace `[PACKAGE_MANAGER]` with npm/yarn/pnpm
4. Replace `[BUILD_COMMAND]` with your build command
5. Replace `[DEV_COMMAND]` with your development server command
6. Update file paths and technology-specific procedures

---

# Claude Frontend Setup Guide - [PROJECT_NAME]

**For future Claude instances working on [PROJECT_NAME] frontend development**

## Systematic Frontend Collaboration Framework

### Quick Context Assessment
You are working on the **[PROJECT_NAME]-frontend** component using [FRONTEND_TECH]. This guide provides systematic collaboration patterns for effective AI-assisted frontend development.

**Project Architecture Context:**
```
[PROJECT_NAME]/
├── [PROJECT_NAME]-frontend/              # You are here
│   ├── src/                             # Source code
│   ├── lib/[PROJECT_NAME]-backend/      # Backend docs mirror
│   ├── package.json                     # Dependencies
│   └── [Frontend configuration files]
├── [PROJECT_NAME]-backend/              # Backend API/framework
└── [PROJECT_NAME]-orchestration/        # Deployment layer
```

## Phase 1: Environment Assessment & Setup

### Step 1: Systematic Environment Validation
```bash
# 1. Confirm location and project context
pwd  # Should show: .../[PROJECT_NAME]-frontend
ls -la package.json  # Verify frontend project

# 2. Check development environment
node --version  # Verify Node.js installation
[PACKAGE_MANAGER] --version  # Verify package manager

# 3. Assess current project state
ls -la node_modules/ 2>/dev/null || echo "Dependencies need installation"
[PACKAGE_MANAGER] list --depth=0 2>/dev/null || echo "Package list unavailable"
```

**Validation Checklist:**
- [ ] Located in correct frontend directory
- [ ] Node.js and package manager available
- [ ] package.json exists and is readable
- [ ] Development environment properly configured

### Step 2: Dependency Management
```bash
# 1. Install/update dependencies
[PACKAGE_MANAGER] install

# 2. Check for security vulnerabilities
[PACKAGE_MANAGER] audit

# 3. Verify development server functionality
[PACKAGE_MANAGER] run [DEV_COMMAND] --help
```

**Quality Standards:**
- All dependencies installed without errors
- No high-severity security vulnerabilities
- Development commands available and functional

## Phase 2: Knowledge Transfer Integration

### Step 1: Backend Context Integration
```bash
# Navigate to backend documentation mirror
cd lib/[PROJECT_NAME]-backend/

# Execute systematic backend context review
cat KNOWLEDGE_TRANSFER_MANIFEST.md  # Canonical file list
cat AGENT.md  # Your role in this mirror context
```

**Systematic Backend Context Analysis:**
1. **API Contract Understanding**
   - Review API.md for endpoint specifications
   - Analyze data models and schemas
   - Understand authentication patterns

2. **Integration Patterns**
   - HTTP client configuration patterns
   - Error handling strategies
   - State management integration

3. **Development Workflow Alignment**
   - Backend development workflow understanding
   - Integration testing patterns
   - Deployment coordination requirements

**Knowledge Transfer Validation:**
- [ ] Backend API contracts understood
- [ ] Data models and schemas mapped
- [ ] Integration patterns identified
- [ ] Development workflows aligned

### Step 2: Frontend-Specific Documentation Review
```bash
# Return to frontend root
cd ../..

# Review frontend-specific documentation
cat CONTINUOUS_IMPROVEMENT_PLAN.md  # Improvement methodology
cat KEY_PROJECT_FILES.md  # Documentation status
ls docs/  # Additional documentation
```

**Systematic Documentation Analysis:**
1. **Architecture Documentation**
   - Component architecture patterns
   - State management approach
   - Routing and navigation patterns

2. **Development Standards**
   - Code style and formatting rules
   - Testing patterns and requirements
   - Build and deployment procedures

3. **Quality Standards**
   - Performance requirements
   - Accessibility standards
   - Security considerations

## Phase 3: Development Environment Configuration

### Step 1: Development Server Setup
```bash
# 1. Start development server
[PACKAGE_MANAGER] run [DEV_COMMAND]

# 2. Verify server accessibility (in another terminal)
curl -I http://localhost:3000 || echo "Server not accessible"

# 3. Check build process
[PACKAGE_MANAGER] run build
```

**Development Environment Validation:**
- [ ] Development server starts without errors
- [ ] Application accessible via browser
- [ ] Hot reload functionality working
- [ ] Build process completes successfully

### Step 2: Testing Infrastructure
```bash
# 1. Run existing test suite
[PACKAGE_MANAGER] run test

# 2. Check test coverage
[PACKAGE_MANAGER] run test:coverage 2>/dev/null || echo "Coverage not configured"

# 3. Run linting and formatting
[PACKAGE_MANAGER] run lint
[PACKAGE_MANAGER] run format 2>/dev/null || echo "Formatting not configured"
```

**Testing Infrastructure Validation:**
- [ ] Test suite runs without failures
- [ ] Code coverage meets project standards
- [ ] Linting rules pass
- [ ] Code formatting consistent

## Phase 4: Systematic Development Patterns

### Frontend Development Methodology

#### Component Development Pattern
```javascript
// Template for systematic component development

// 1. Component Architecture Assessment
// - Identify component purpose and scope
// - Map required props and state
// - Plan integration with existing components

// 2. Implementation Approach
// - Follow existing component patterns
// - Implement with TypeScript/PropTypes for type safety
// - Include accessibility considerations

// 3. Testing Strategy
// - Unit tests for component logic
// - Integration tests for component interactions
// - Accessibility testing for compliance

// Example Component Template:
import React from 'react';
// Import statements following project patterns

interface [ComponentName]Props {
  // Type definitions following project conventions
}

export const [ComponentName]: React.FC<[ComponentName]Props> = ({
  // Props destructuring
}) => {
  // Component implementation following project patterns
  
  return (
    // JSX following project conventions
  );
};

// Export following project patterns
export default [ComponentName];
```

#### State Management Integration
```javascript
// Template for systematic state management

// 1. State Architecture Assessment
// - Identify state scope (local/global)
// - Map state dependencies
// - Plan state update patterns

// 2. Implementation Approach
// - Follow project state management patterns ([REDUX/ZUSTAND/CONTEXT])
// - Implement with proper TypeScript types
// - Include error handling and loading states

// 3. Integration Testing
// - Test state updates and side effects
// - Validate state persistence if applicable
// - Test error conditions and edge cases
```

#### API Integration Pattern
```javascript
// Template for systematic API integration

// 1. API Integration Assessment
// - Review backend API documentation in lib/[PROJECT_NAME]-backend/
// - Identify required endpoints and data models
// - Plan error handling and loading states

// 2. Implementation Approach
// - Use project HTTP client patterns
// - Implement proper TypeScript types for requests/responses
// - Follow project authentication patterns

// 3. Testing Strategy
// - Mock API responses for unit tests
// - Integration tests with backend API
// - Error condition testing and validation

// Example API Integration:
import { apiClient } from './lib/api';  // Project API client
import { [DataType] } from './types';   // Project type definitions

export const use[EntityName] = () => {
  // Implementation following project patterns
  // Including loading states, error handling, caching
};
```

## Phase 5: Quality Assurance Framework

### Systematic Code Quality Validation

#### Pre-Development Checklist
- [ ] Backend API contracts reviewed and understood
- [ ] Component architecture patterns identified
- [ ] State management approach confirmed
- [ ] Testing strategy planned
- [ ] Accessibility requirements understood

#### Development Process Validation
- [ ] Code follows project conventions and patterns
- [ ] TypeScript types properly defined and used
- [ ] Component props and interfaces documented
- [ ] Error handling implemented consistently
- [ ] Performance considerations addressed

#### Post-Development Validation
- [ ] Unit tests written and passing
- [ ] Integration tests cover component interactions
- [ ] Accessibility standards met
- [ ] Code review checklist completed
- [ ] Documentation updated as needed

### Automated Quality Checks
```bash
# Systematic quality validation script
#!/bin/bash

echo "Running systematic frontend quality checks..."

# 1. Type checking
echo "Checking TypeScript types..."
npx tsc --noEmit || exit 1

# 2. Linting validation
echo "Running ESLint..."
[PACKAGE_MANAGER] run lint || exit 1

# 3. Test execution
echo "Running test suite..."
[PACKAGE_MANAGER] run test -- --watchAll=false || exit 1

# 4. Build validation
echo "Validating build process..."
[PACKAGE_MANAGER] run build || exit 1

# 5. Bundle analysis (if configured)
echo "Analyzing bundle size..."
[PACKAGE_MANAGER] run analyze 2>/dev/null || echo "Bundle analysis not configured"

echo "All quality checks passed successfully"
```

## Phase 6: Integration & Deployment Coordination

### Backend Integration Validation
```bash
# Systematic backend integration testing

# 1. API contract validation
# Verify API endpoints match frontend expectations
curl -X GET http://localhost:8080/api/health

# 2. Data model validation
# Test data serialization/deserialization
# Validate TypeScript types against API responses

# 3. Authentication flow testing
# Test login/logout functionality
# Validate token handling and refresh
```

### Deployment Preparation
```bash
# Systematic deployment preparation

# 1. Environment configuration
# Verify environment variables set correctly
echo $NEXT_PUBLIC_API_URL  # Example environment variable

# 2. Build optimization
# Verify production build optimizations
[PACKAGE_MANAGER] run build:prod 2>/dev/null || [PACKAGE_MANAGER] run build

# 3. Deployment validation
# Test deployment-specific configurations
# Validate asset handling and routing
```

## Phase 7: Documentation Maintenance

### Systematic Documentation Updates

#### Component Documentation
```markdown
# Component Documentation Template

## [ComponentName]

**Purpose**: [Clear description of component purpose]
**Location**: `src/components/[path]/[ComponentName].tsx`
**Dependencies**: [List of key dependencies]

### Props Interface
```typescript
interface [ComponentName]Props {
  // Include all props with descriptions
}
```

### Usage Examples
```typescript
// Include realistic usage examples
```

### Testing
- Unit tests: `__tests__/[ComponentName].test.tsx`
- Integration tests: [Description of integration test coverage]
- Accessibility: [Accessibility compliance notes]

### Maintenance Notes
- [Any special maintenance considerations]
- [Performance optimization notes]
- [Known limitations or technical debt]
```

#### Status Tracking Updates
```bash
# Update KEY_PROJECT_FILES.md systematically
# Include new components, updated files, testing status
# Maintain current status of all frontend documentation
```

## Technology-Specific Patterns

### [FRONTEND_TECH] Best Practices
```javascript
// Technology-specific implementation patterns
// Customize based on chosen frontend framework

// React-specific patterns:
// - Hooks usage and custom hook patterns
// - Context API patterns
// - Component composition patterns

// Vue-specific patterns:
// - Composition API patterns
// - Pinia state management
// - Component communication patterns

// Angular-specific patterns:
// - Service injection patterns
// - RxJS observable patterns
// - Module organization patterns

// Svelte-specific patterns:
// - Store patterns
// - Component communication
// - Build optimization patterns
```

### Build System Integration
```javascript
// Build system configuration patterns
// Customize based on build tool (Webpack, Vite, etc.)

// Webpack configuration patterns
// Vite configuration patterns
// Build optimization strategies
// Asset handling patterns
```

## Continuous Improvement Integration

### Improvement Trigger Identification
1. **Performance Issues**: Bundle size, load times, runtime performance
2. **User Experience Issues**: Accessibility, usability, responsiveness
3. **Development Efficiency**: Build times, developer experience, tooling
4. **Code Quality Issues**: Technical debt, complexity, maintainability

### Systematic Improvement Execution
1. **Assessment**: Analyze improvement triggers and impacts
2. **Planning**: Create specific improvement plan from CONTINUOUS_IMPROVEMENT_PLAN
3. **Implementation**: Execute improvements following quality standards
4. **Validation**: Test improvements and validate quality standards
5. **Documentation**: Update documentation and status tracking

## Troubleshooting Guide

### Common Frontend Issues
1. **Dependency Issues**
   - Clear node_modules and package-lock.json
   - Reinstall dependencies
   - Check for version conflicts

2. **Build Issues**
   - Check TypeScript configuration
   - Validate import paths
   - Review bundle size and optimization

3. **Runtime Issues**
   - Check browser console for errors
   - Validate API integration
   - Review state management patterns

4. **Testing Issues**
   - Update test configurations
   - Mock external dependencies
   - Validate test environment setup

---

## Template Customization Validation

**Required Customizations Completed:**
- [ ] All `[PROJECT_NAME]` placeholders replaced
- [ ] All `[FRONTEND_TECH]` placeholders replaced
- [ ] All `[PACKAGE_MANAGER]` placeholders replaced
- [ ] All build and development commands updated
- [ ] Technology-specific patterns customized
- [ ] File paths updated to match project structure
- [ ] Integration patterns match backend API

**Quality Validation:**
- [ ] All procedures tested with actual project
- [ ] Code examples execute successfully
- [ ] Integration points validated
- [ ] Documentation accuracy verified

---

*This template provides systematic AI collaboration patterns for frontend development while maintaining quality standards and integration compatibility across diverse technology stacks.*