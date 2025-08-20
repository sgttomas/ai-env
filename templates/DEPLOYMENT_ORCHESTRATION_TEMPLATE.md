# Deployment Orchestration Template

**Purpose**: Systematic deployment and orchestration patterns for AI co-development environments  
**Methodology**: Container-first, environment-agnostic, scalable deployment architecture  
**Scope**: Complete deployment lifecycle from development to production with desktop application support

## Template Customization Instructions

**Before using this template:**
1. Replace `[PROJECT_NAME]` with your actual project name
2. Replace `[FRONTEND_TECH]` with your frontend technology
3. Replace `[BACKEND_TECH]` with your backend technology
4. Replace `[DATABASE_TYPE]` with your database technology
5. Update service configurations for your specific requirements
6. Customize environment variables for your deployment context

---

# Deployment Orchestration - [PROJECT_NAME]

**Project**: [PROJECT_NAME]  
**Architecture**: Split-apps AI co-development environment  
**Deployment Strategy**: Multi-tier with container orchestration  
**Template Version**: 1.0

## Orchestration Architecture Overview

### Core Components
```
[PROJECT_NAME]-orchestration/
├── compose/                     # Docker Compose configurations
│   ├── docker-compose.yml      # Core services
│   ├── docker-compose.dev.yml  # Development overrides
│   ├── docker-compose.prod.yml # Production overrides
│   └── .env.template           # Environment configuration template
├── desktop/                     # Desktop application wrapper
│   ├── src/
│   │   └── main.[js|ts|rs|go]  # Desktop app main entry
│   ├── resources/              # Desktop app resources
│   └── [package configuration] # Package.json, Cargo.toml, etc.
├── kubernetes/                  # Kubernetes deployment manifests
│   ├── namespace.yaml
│   ├── configmap.yaml
│   ├── secrets.yaml
│   ├── deployments/
│   ├── services/
│   └── ingress/
├── scripts/                     # Deployment and utility scripts
│   ├── deploy.sh               # Unified deployment script
│   ├── health-check.sh         # Health monitoring
│   ├── backup.sh               # Data backup procedures
│   └── rollback.sh             # Rollback procedures
└── monitoring/                  # Monitoring and observability
    ├── prometheus/
    ├── grafana/
    └── logs/
```

## Template 1: Docker Compose Configuration

### Core Services Configuration
```yaml
# docker-compose.yml - Core services template
version: '3.8'

networks:
  [PROJECT_NAME]-network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/16

volumes:
  [PROJECT_NAME]-db-data:
    driver: local
  [PROJECT_NAME]-app-data:
    driver: local
  [PROJECT_NAME]-logs:
    driver: local

services:
  database:
    image: [DATABASE_TYPE]:[DATABASE_VERSION]
    container_name: [PROJECT_NAME]-database
    environment:
      # Database-specific environment variables
      [DATABASE_ENV_VARS]
    ports:
      - "${DATABASE_PORT:-5432}:5432"  # Adjust for database type
    volumes:
      - [PROJECT_NAME]-db-data:/var/lib/[database]/data
      - ./database/init:/docker-entrypoint-initdb.d
    networks:
      - [PROJECT_NAME]-network
    healthcheck:
      test: ["CMD-SHELL", "[DATABASE_HEALTH_CHECK_COMMAND]"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 60s
    restart: unless-stopped

  backend:
    build:
      context: ../[PROJECT_NAME]-backend
      dockerfile: Dockerfile
      target: production
    container_name: [PROJECT_NAME]-backend
    environment:
      - DATABASE_URL=${DATABASE_URL}
      - API_PORT=${BACKEND_PORT:-8080}
      - [BACKEND_ENV_VARS]
    ports:
      - "${BACKEND_PORT:-8080}:8080"
    volumes:
      - [PROJECT_NAME]-app-data:/app/data
      - [PROJECT_NAME]-logs:/app/logs
    networks:
      - [PROJECT_NAME]-network
    depends_on:
      database:
        condition: service_healthy
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 60s
    restart: unless-stopped

  frontend:
    build:
      context: ../[PROJECT_NAME]-frontend
      dockerfile: Dockerfile
      target: production
    container_name: [PROJECT_NAME]-frontend
    environment:
      - NEXT_PUBLIC_API_URL=http://backend:8080
      - [FRONTEND_ENV_VARS]
    ports:
      - "${FRONTEND_PORT:-3000}:3000"
    networks:
      - [PROJECT_NAME]-network
    depends_on:
      backend:
        condition: service_healthy
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/api/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 30s
    restart: unless-stopped

  # Optional: Reverse proxy/Load balancer
  proxy:
    image: nginx:alpine
    container_name: [PROJECT_NAME]-proxy
    ports:
      - "${PROXY_PORT:-80}:80"
      - "${PROXY_SSL_PORT:-443}:443"
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
      - ./nginx/ssl:/etc/nginx/ssl:ro
    networks:
      - [PROJECT_NAME]-network
    depends_on:
      - frontend
      - backend
    restart: unless-stopped

  # Optional: Redis cache
  cache:
    image: redis:alpine
    container_name: [PROJECT_NAME]-cache
    ports:
      - "${REDIS_PORT:-6379}:6379"
    volumes:
      - ./redis/redis.conf:/usr/local/etc/redis/redis.conf:ro
    networks:
      - [PROJECT_NAME]-network
    command: redis-server /usr/local/etc/redis/redis.conf
    restart: unless-stopped
```

### Development Override Configuration
```yaml
# docker-compose.dev.yml - Development overrides
version: '3.8'

services:
  backend:
    build:
      target: development
    environment:
      - DEBUG=true
      - LOG_LEVEL=debug
      - HOT_RELOAD=true
    volumes:
      - ../[PROJECT_NAME]-backend:/app
      - /app/node_modules  # For Node.js projects
    command: [DEV_COMMAND]  # npm run dev, cargo watch, etc.

  frontend:
    build:
      target: development
    environment:
      - NODE_ENV=development
      - NEXT_PUBLIC_API_URL=http://localhost:8080
    volumes:
      - ../[PROJECT_NAME]-frontend:/app
      - /app/node_modules
      - /app/.next
    command: npm run dev

  database:
    ports:
      - "5432:5432"  # Expose database for local development tools
    environment:
      - [DATABASE_DEV_ENV_VARS]

  # Development tools
  adminer:
    image: adminer
    container_name: [PROJECT_NAME]-adminer
    ports:
      - "8081:8080"
    networks:
      - [PROJECT_NAME]-network
    depends_on:
      - database
```

### Production Override Configuration
```yaml
# docker-compose.prod.yml - Production overrides
version: '3.8'

services:
  backend:
    deploy:
      replicas: 2
      resources:
        limits:
          cpus: '1.0'
          memory: 1G
        reservations:
          cpus: '0.5'
          memory: 512M
    environment:
      - NODE_ENV=production
      - LOG_LEVEL=info
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"

  frontend:
    deploy:
      replicas: 2
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
        reservations:
          cpus: '0.25'
          memory: 256M
    environment:
      - NODE_ENV=production
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"

  database:
    deploy:
      resources:
        limits:
          cpus: '2.0'
          memory: 2G
        reservations:
          cpus: '1.0'
          memory: 1G
    environment:
      - [DATABASE_PROD_ENV_VARS]
    volumes:
      - [PROJECT_NAME]-db-data:/var/lib/[database]/data
      - ./database/backup:/backup
    logging:
      driver: "json-file"
      options:
        max-size: "50m"
        max-file: "5"

  # Production monitoring
  prometheus:
    image: prom/prometheus
    container_name: [PROJECT_NAME]-prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./monitoring/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml
    networks:
      - [PROJECT_NAME]-network

  grafana:
    image: grafana/grafana
    container_name: [PROJECT_NAME]-grafana
    ports:
      - "3001:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=${GRAFANA_PASSWORD:-admin}
    volumes:
      - ./monitoring/grafana:/var/lib/grafana
    networks:
      - [PROJECT_NAME]-network
```

## Template 2: Environment Configuration

### Environment Variables Template
```bash
# .env.template - Copy to .env and customize
# Core Application Configuration
PROJECT_NAME=[PROJECT_NAME]
ENVIRONMENT=development  # development, staging, production

# Service Ports
FRONTEND_PORT=3000
BACKEND_PORT=8080
DATABASE_PORT=5432
REDIS_PORT=6379
PROXY_PORT=80
PROXY_SSL_PORT=443

# Database Configuration
DATABASE_URL=[DATABASE_CONNECTION_STRING]
DATABASE_NAME=[PROJECT_NAME]_db
DATABASE_USER=[PROJECT_NAME]_user
DATABASE_PASSWORD=secure_password_here
DATABASE_ROOT_PASSWORD=secure_root_password_here

# Backend Configuration
JWT_SECRET=your_jwt_secret_here
API_KEY=your_api_key_here
CORS_ORIGIN=http://localhost:3000

# Frontend Configuration
NEXT_PUBLIC_API_URL=http://localhost:8080
NEXT_PUBLIC_WS_URL=ws://localhost:8080/ws
NEXT_PUBLIC_ENVIRONMENT=development

# External Services
EXTERNAL_API_KEY=your_external_api_key
EXTERNAL_SERVICE_URL=https://api.external-service.com

# Monitoring and Logging
LOG_LEVEL=info
GRAFANA_PASSWORD=admin
PROMETHEUS_RETENTION=15d

# Security
SSL_CERT_PATH=/etc/nginx/ssl/cert.pem
SSL_KEY_PATH=/etc/nginx/ssl/key.pem

# Feature Flags
FEATURE_ADVANCED_MODE=true
FEATURE_BETA_TESTING=false
FEATURE_MONITORING=true

# Development Tools (dev environment only)
DEBUG=false
HOT_RELOAD=false
```

### Environment Validation Script
```bash
#!/bin/bash
# validate-env.sh - Environment validation script

set -e

ENV_FILE=".env"
TEMPLATE_FILE=".env.template"

echo "Validating environment configuration..."

# 1. Check if .env file exists
if [ ! -f "$ENV_FILE" ]; then
    echo "❌ .env file not found. Copy from .env.template and customize."
    exit 1
fi

# 2. Check for required variables
REQUIRED_VARS=(
    "PROJECT_NAME"
    "DATABASE_URL"
    "JWT_SECRET"
    "FRONTEND_PORT"
    "BACKEND_PORT"
)

for var in "${REQUIRED_VARS[@]}"; do
    if ! grep -q "^$var=" "$ENV_FILE"; then
        echo "❌ Required environment variable missing: $var"
        exit 1
    fi
    
    # Check if variable has a value
    value=$(grep "^$var=" "$ENV_FILE" | cut -d= -f2-)
    if [ -z "$value" ] || [ "$value" = "your_value_here" ]; then
        echo "❌ Environment variable needs value: $var"
        exit 1
    fi
done

# 3. Validate database connection
echo "Testing database connection..."
DATABASE_URL=$(grep "^DATABASE_URL=" "$ENV_FILE" | cut -d= -f2-)
# Add database-specific connection test
# [DATABASE_CONNECTION_TEST_COMMAND]

# 4. Validate port availability
echo "Checking port availability..."
FRONTEND_PORT=$(grep "^FRONTEND_PORT=" "$ENV_FILE" | cut -d= -f2-)
BACKEND_PORT=$(grep "^BACKEND_PORT=" "$ENV_FILE" | cut -d= -f2-)

if lsof -Pi :$FRONTEND_PORT -sTCP:LISTEN -t >/dev/null; then
    echo "⚠️  Port $FRONTEND_PORT is already in use"
fi

if lsof -Pi :$BACKEND_PORT -sTCP:LISTEN -t >/dev/null; then
    echo "⚠️  Port $BACKEND_PORT is already in use"
fi

echo "✅ Environment validation completed successfully"
```

## Template 3: Desktop Application Configuration

### Electron Desktop App Template
```javascript
// main.js - Electron main process template
const { app, BrowserWindow, Menu, shell } = require('electron');
const { spawn } = require('child_process');
const path = require('path');
const fs = require('fs');

// Application configuration
const APP_CONFIG = {
  name: '[PROJECT_NAME]',
  version: '1.0.0',
  backend_url: 'http://localhost:8080',
  frontend_url: 'http://localhost:3000',
  compose_path: '../compose'
};

let mainWindow;
let backendProcess;
let servicesStarted = false;

// Utility functions
async function startDockerServices() {
  return new Promise((resolve, reject) => {
    console.log('Starting Docker services...');
    
    const dockerCompose = spawn('docker-compose', [
      '-f', 'docker-compose.yml',
      '-f', 'docker-compose.dev.yml',
      'up', '-d'
    ], {
      cwd: path.join(__dirname, APP_CONFIG.compose_path),
      stdio: 'pipe'
    });

    let output = '';
    dockerCompose.stdout.on('data', (data) => {
      output += data.toString();
      console.log('Docker:', data.toString());
    });

    dockerCompose.stderr.on('data', (data) => {
      output += data.toString();
      console.error('Docker Error:', data.toString());
    });

    dockerCompose.on('close', (code) => {
      if (code === 0) {
        console.log('Docker services started successfully');
        servicesStarted = true;
        resolve(output);
      } else {
        reject(new Error(`Docker services failed to start (exit code: ${code})`));
      }
    });
  });
}

async function waitForServices() {
  const maxRetries = 30;
  const retryInterval = 2000;
  
  for (let i = 0; i < maxRetries; i++) {
    try {
      // Check backend health
      const response = await fetch(`${APP_CONFIG.backend_url}/health`);
      if (response.ok) {
        console.log('Services are ready!');
        return true;
      }
    } catch (error) {
      console.log(`Waiting for services... (${i + 1}/${maxRetries})`);
    }
    
    await new Promise(resolve => setTimeout(resolve, retryInterval));
  }
  
  throw new Error('Services failed to start within timeout period');
}

async function stopDockerServices() {
  return new Promise((resolve) => {
    if (!servicesStarted) {
      resolve();
      return;
    }
    
    console.log('Stopping Docker services...');
    
    const dockerCompose = spawn('docker-compose', [
      '-f', 'docker-compose.yml',
      '-f', 'docker-compose.dev.yml',
      'down'
    ], {
      cwd: path.join(__dirname, APP_CONFIG.compose_path)
    });

    dockerCompose.on('close', (code) => {
      console.log('Docker services stopped');
      servicesStarted = false;
      resolve();
    });
  });
}

// Application window management
function createMainWindow() {
  mainWindow = new BrowserWindow({
    width: 1200,
    height: 800,
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
      enableRemoteModule: false,
      webSecurity: true
    },
    icon: path.join(__dirname, 'resources/icon.png'),
    show: false  // Don't show until ready
  });

  // Load the frontend application
  mainWindow.loadURL(APP_CONFIG.frontend_url);

  // Show window when ready
  mainWindow.once('ready-to-show', () => {
    mainWindow.show();
    
    // Open DevTools in development
    if (process.env.NODE_ENV === 'development') {
      mainWindow.webContents.openDevTools();
    }
  });

  // Handle window closed
  mainWindow.on('closed', () => {
    mainWindow = null;
  });

  // Handle external links
  mainWindow.webContents.setWindowOpenHandler(({ url }) => {
    shell.openExternal(url);
    return { action: 'deny' };
  });
}

function createMenu() {
  const template = [
    {
      label: 'File',
      submenu: [
        {
          label: 'Quit',
          accelerator: process.platform === 'darwin' ? 'Cmd+Q' : 'Ctrl+Q',
          click: () => {
            app.quit();
          }
        }
      ]
    },
    {
      label: 'View',
      submenu: [
        { role: 'reload' },
        { role: 'forceReload' },
        { role: 'toggleDevTools' },
        { type: 'separator' },
        { role: 'resetZoom' },
        { role: 'zoomIn' },
        { role: 'zoomOut' },
        { type: 'separator' },
        { role: 'togglefullscreen' }
      ]
    },
    {
      label: 'Help',
      submenu: [
        {
          label: 'About',
          click: () => {
            // Show about dialog
          }
        }
      ]
    }
  ];

  const menu = Menu.buildFromTemplate(template);
  Menu.setApplicationMenu(menu);
}

// Application lifecycle
app.whenReady().then(async () => {
  try {
    // Create splash screen or loading indicator
    console.log('Starting [PROJECT_NAME] Desktop Application...');
    
    // Start Docker services
    await startDockerServices();
    
    // Wait for services to be ready
    await waitForServices();
    
    // Create main window
    createMainWindow();
    createMenu();
    
    console.log('[PROJECT_NAME] Desktop Application started successfully');
  } catch (error) {
    console.error('Failed to start application:', error);
    
    // Show error dialog
    const { dialog } = require('electron');
    dialog.showErrorBox(
      'Startup Error',
      `Failed to start [PROJECT_NAME]: ${error.message}`
    );
    
    app.quit();
  }
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('activate', () => {
  if (BrowserWindow.getAllWindows().length === 0) {
    createMainWindow();
  }
});

app.on('before-quit', async (event) => {
  if (servicesStarted) {
    event.preventDefault();
    
    try {
      await stopDockerServices();
    } catch (error) {
      console.error('Error stopping services:', error);
    }
    
    app.quit();
  }
});

// Handle uncaught exceptions
process.on('uncaughtException', (error) => {
  console.error('Uncaught Exception:', error);
});

process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled Rejection at:', promise, 'reason:', reason);
});
```

### Desktop Package Configuration
```json
{
  "name": "[PROJECT_NAME]-desktop",
  "version": "1.0.0",
  "description": "[PROJECT_NAME] Desktop Application",
  "main": "src/main.js",
  "scripts": {
    "start": "electron .",
    "dev": "NODE_ENV=development electron .",
    "build": "electron-builder",
    "build:win": "electron-builder --win",
    "build:mac": "electron-builder --mac",
    "build:linux": "electron-builder --linux",
    "pack": "electron-builder --dir",
    "dist": "electron-builder --publish=never"
  },
  "build": {
    "appId": "com.[organization].[PROJECT_NAME]",
    "productName": "[PROJECT_NAME]",
    "directories": {
      "output": "dist"
    },
    "files": [
      "src/**/*",
      "resources/**/*",
      "node_modules/**/*"
    ],
    "mac": {
      "category": "public.app-category.productivity",
      "target": "dmg"
    },
    "win": {
      "target": "nsis"
    },
    "linux": {
      "target": "AppImage"
    }
  },
  "dependencies": {
    "electron": "^latest"
  },
  "devDependencies": {
    "electron-builder": "^latest"
  }
}
```

## Template 4: Deployment Scripts

### Unified Deployment Script
```bash
#!/bin/bash
# deploy.sh - Unified deployment script

set -e

PROJECT_NAME="[PROJECT_NAME]"
ENVIRONMENT="${1:-development}"
COMPOSE_FILES="-f docker-compose.yml"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

show_usage() {
    echo "Usage: $0 [environment]"
    echo "Environments: development, staging, production"
    echo ""
    echo "Examples:"
    echo "  $0                    # Deploy development environment"
    echo "  $0 development        # Deploy development environment"
    echo "  $0 staging            # Deploy staging environment"
    echo "  $0 production         # Deploy production environment"
}

validate_environment() {
    case $ENVIRONMENT in
        development)
            COMPOSE_FILES="$COMPOSE_FILES -f docker-compose.dev.yml"
            ;;
        staging)
            COMPOSE_FILES="$COMPOSE_FILES -f docker-compose.staging.yml"
            ;;
        production)
            COMPOSE_FILES="$COMPOSE_FILES -f docker-compose.prod.yml"
            ;;
        *)
            log_error "Invalid environment: $ENVIRONMENT"
            show_usage
            exit 1
            ;;
    esac
}

check_prerequisites() {
    log_info "Checking prerequisites..."
    
    # Check Docker
    if ! command -v docker &> /dev/null; then
        log_error "Docker is not installed"
        exit 1
    fi
    
    # Check Docker Compose
    if ! command -v docker-compose &> /dev/null; then
        log_error "Docker Compose is not installed"
        exit 1
    fi
    
    # Check if Docker daemon is running
    if ! docker info &> /dev/null; then
        log_error "Docker daemon is not running"
        exit 1
    fi
    
    # Validate environment configuration
    if [ ! -f ".env" ]; then
        log_error ".env file not found. Copy from .env.template and customize."
        exit 1
    fi
    
    # Run environment validation
    if ! ./scripts/validate-env.sh; then
        log_error "Environment validation failed"
        exit 1
    fi
    
    log_info "Prerequisites check passed"
}

build_images() {
    log_info "Building Docker images..."
    
    # Build backend image
    log_info "Building backend image..."
    docker-compose $COMPOSE_FILES build backend
    
    # Build frontend image
    log_info "Building frontend image..."
    docker-compose $COMPOSE_FILES build frontend
    
    log_info "Docker images built successfully"
}

start_services() {
    log_info "Starting services..."
    
    # Start services with dependencies
    docker-compose $COMPOSE_FILES up -d
    
    log_info "Services started"
}

wait_for_health() {
    log_info "Waiting for services to be healthy..."
    
    # Wait for backend health
    local backend_url="http://localhost:${BACKEND_PORT:-8080}/health"
    local max_attempts=30
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        if curl -f "$backend_url" &> /dev/null; then
            log_info "Backend is healthy"
            break
        fi
        
        if [ $attempt -eq $max_attempts ]; then
            log_error "Backend failed to become healthy within timeout"
            exit 1
        fi
        
        log_info "Waiting for backend... (attempt $attempt/$max_attempts)"
        sleep 5
        ((attempt++))
    done
    
    # Wait for frontend health
    local frontend_url="http://localhost:${FRONTEND_PORT:-3000}"
    attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        if curl -f "$frontend_url" &> /dev/null; then
            log_info "Frontend is healthy"
            break
        fi
        
        if [ $attempt -eq $max_attempts ]; then
            log_error "Frontend failed to become healthy within timeout"
            exit 1
        fi
        
        log_info "Waiting for frontend... (attempt $attempt/$max_attempts)"
        sleep 5
        ((attempt++))
    done
    
    log_info "All services are healthy"
}

run_health_checks() {
    log_info "Running comprehensive health checks..."
    
    # Run health check script
    if [ -f "./scripts/health-check.sh" ]; then
        ./scripts/health-check.sh
    else
        log_warn "health-check.sh not found, skipping comprehensive health checks"
    fi
}

show_deployment_info() {
    log_info "Deployment completed successfully!"
    echo ""
    echo "Environment: $ENVIRONMENT"
    echo "Frontend URL: http://localhost:${FRONTEND_PORT:-3000}"
    echo "Backend URL: http://localhost:${BACKEND_PORT:-8080}"
    echo ""
    echo "To view logs: docker-compose $COMPOSE_FILES logs -f"
    echo "To stop services: docker-compose $COMPOSE_FILES down"
    echo ""
}

# Main deployment flow
main() {
    log_info "Starting $PROJECT_NAME deployment (environment: $ENVIRONMENT)"
    
    validate_environment
    check_prerequisites
    build_images
    start_services
    wait_for_health
    run_health_checks
    show_deployment_info
}

# Handle script arguments
case ${1:-} in
    -h|--help)
        show_usage
        exit 0
        ;;
    *)
        main
        ;;
esac
```

### Health Check Script
```bash
#!/bin/bash
# health-check.sh - Comprehensive health monitoring

set -e

PROJECT_NAME="[PROJECT_NAME]"
HEALTH_REPORT="/tmp/${PROJECT_NAME}-health-report.txt"

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() {
    echo -e "${GREEN}[HEALTH]${NC} $1"
    echo "[$(date)] INFO: $1" >> "$HEALTH_REPORT"
}

log_warn() {
    echo -e "${YELLOW}[HEALTH]${NC} $1"
    echo "[$(date)] WARN: $1" >> "$HEALTH_REPORT"
}

log_error() {
    echo -e "${RED}[HEALTH]${NC} $1"
    echo "[$(date)] ERROR: $1" >> "$HEALTH_REPORT"
}

# Initialize health report
echo "Health Check Report - $(date)" > "$HEALTH_REPORT"
echo "========================================" >> "$HEALTH_REPORT"

check_container_health() {
    log_info "Checking container health..."
    
    local containers=(
        "${PROJECT_NAME}-database"
        "${PROJECT_NAME}-backend"
        "${PROJECT_NAME}-frontend"
    )
    
    local all_healthy=true
    
    for container in "${containers[@]}"; do
        if docker ps --filter "name=$container" --filter "status=running" | grep -q "$container"; then
            local health_status=$(docker inspect --format='{{.State.Health.Status}}' "$container" 2>/dev/null || echo "unknown")
            
            case $health_status in
                "healthy")
                    log_info "Container $container is healthy"
                    ;;
                "unhealthy")
                    log_error "Container $container is unhealthy"
                    all_healthy=false
                    ;;
                "starting")
                    log_warn "Container $container is still starting"
                    ;;
                *)
                    log_warn "Container $container health status unknown"
                    ;;
            esac
        else
            log_error "Container $container is not running"
            all_healthy=false
        fi
    done
    
    if [ "$all_healthy" = true ]; then
        log_info "All containers are healthy"
        return 0
    else
        log_error "Some containers are not healthy"
        return 1
    fi
}

check_service_endpoints() {
    log_info "Checking service endpoints..."
    
    local services=(
        "Frontend:http://localhost:${FRONTEND_PORT:-3000}"
        "Backend:http://localhost:${BACKEND_PORT:-8080}/health"
        "Backend API:http://localhost:${BACKEND_PORT:-8080}/api/health"
    )
    
    local all_responsive=true
    
    for service in "${services[@]}"; do
        local name="${service%:*}"
        local url="${service#*:}"
        
        if curl -f -s --max-time 10 "$url" > /dev/null; then
            log_info "$name endpoint is responsive"
        else
            log_error "$name endpoint is not responsive: $url"
            all_responsive=false
        fi
    done
    
    if [ "$all_responsive" = true ]; then
        log_info "All service endpoints are responsive"
        return 0
    else
        log_error "Some service endpoints are not responsive"
        return 1
    fi
}

check_database_connectivity() {
    log_info "Checking database connectivity..."
    
    # Database-specific connectivity check
    local db_container="${PROJECT_NAME}-database"
    
    if docker exec "$db_container" [DATABASE_CONNECTIVITY_COMMAND] &> /dev/null; then
        log_info "Database connectivity check passed"
        return 0
    else
        log_error "Database connectivity check failed"
        return 1
    fi
}

check_resource_usage() {
    log_info "Checking resource usage..."
    
    # Check disk space
    local disk_usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
    if [ "$disk_usage" -gt 80 ]; then
        log_warn "Disk usage is high: ${disk_usage}%"
    else
        log_info "Disk usage is acceptable: ${disk_usage}%"
    fi
    
    # Check memory usage
    local memory_usage=$(free | awk 'NR==2{printf "%.0f", $3*100/$2}')
    if [ "$memory_usage" -gt 80 ]; then
        log_warn "Memory usage is high: ${memory_usage}%"
    else
        log_info "Memory usage is acceptable: ${memory_usage}%"
    fi
    
    # Check container resource usage
    docker stats --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}" | while read line; do
        echo "[$(date)] STATS: $line" >> "$HEALTH_REPORT"
    done
}

check_logs_for_errors() {
    log_info "Checking logs for errors..."
    
    local error_count=0
    local containers=(
        "${PROJECT_NAME}-backend"
        "${PROJECT_NAME}-frontend"
    )
    
    for container in "${containers[@]}"; do
        local errors=$(docker logs "$container" --since="5m" 2>&1 | grep -i error | wc -l)
        if [ "$errors" -gt 0 ]; then
            log_warn "Found $errors error(s) in $container logs (last 5 minutes)"
            error_count=$((error_count + errors))
        fi
    done
    
    if [ "$error_count" -eq 0 ]; then
        log_info "No recent errors found in logs"
    else
        log_warn "Total errors found in logs: $error_count"
    fi
}

generate_health_summary() {
    echo ""
    echo "========================================" >> "$HEALTH_REPORT"
    echo "Health Check Summary - $(date)" >> "$HEALTH_REPORT"
    echo "========================================" >> "$HEALTH_REPORT"
    
    log_info "Health check completed. Report saved to: $HEALTH_REPORT"
    
    # Show summary
    echo ""
    echo "Health Check Summary:"
    echo "- Container Health: $(check_container_health && echo "✅ PASS" || echo "❌ FAIL")"
    echo "- Service Endpoints: $(check_service_endpoints && echo "✅ PASS" || echo "❌ FAIL")"
    echo "- Database Connectivity: $(check_database_connectivity && echo "✅ PASS" || echo "❌ FAIL")"
    echo "- Resource Usage: ✅ CHECKED"
    echo "- Error Logs: ✅ CHECKED"
    echo ""
    echo "Full report: $HEALTH_REPORT"
}

# Main health check execution
main() {
    log_info "Starting comprehensive health check for $PROJECT_NAME"
    
    check_container_health
    check_service_endpoints
    check_database_connectivity
    check_resource_usage
    check_logs_for_errors
    generate_health_summary
}

main "$@"
```

---

## Template Customization Validation

### Required Customizations Completed
- [ ] All `[PROJECT_NAME]` placeholders replaced
- [ ] All technology stack placeholders replaced ([FRONTEND_TECH], [BACKEND_TECH], [DATABASE_TYPE])
- [ ] Service configurations customized for specific requirements
- [ ] Environment variables configured appropriately
- [ ] Health check commands customized for technology stack
- [ ] Desktop application configuration customized (if applicable)
- [ ] Deployment scripts tested and validated

### System Validation
- [ ] Docker Compose configurations tested in development environment
- [ ] Environment validation scripts tested
- [ ] Health check scripts validated with actual services
- [ ] Desktop application builds and runs successfully (if applicable)
- [ ] Deployment scripts execute without errors
- [ ] Resource monitoring and alerting configured

---

*This deployment orchestration template provides comprehensive, scalable deployment infrastructure for AI co-development environments with support for multiple deployment targets and comprehensive monitoring capabilities.*