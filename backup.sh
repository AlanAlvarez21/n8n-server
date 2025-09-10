#!/bin/bash

# n8n Backup Script

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Create backups directory if it doesn't exist
BACKUP_DIR="./backups"
mkdir -p "$BACKUP_DIR"

# Generate timestamp for backup filename
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/n8n_backup_$TIMESTAMP.tar.gz"

print_status "Creating backup of n8n data..."

# Check if docker is installed
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed."
    exit 1
fi

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null; then
    print_error "Docker Compose is not installed."
    exit 1
fi

# Create temporary directory for backup
TEMP_DIR="/tmp/n8n_backup_$TIMESTAMP"
mkdir -p "$TEMP_DIR"

# Copy n8n storage volume
print_status "Backing up n8n storage volume..."
docker run --rm \
    -v docker-postgres_n8n_storage:/source \
    -v "$TEMP_DIR:/target" \
    alpine tar czf /target/n8n_storage.tar.gz -C /source .

# Copy database data
print_status "Backing up PostgreSQL database..."
# Create a database dump
docker-compose exec -T postgres pg_dumpall -U postgres > "$TEMP_DIR/db_dump.sql"

# Create final archive
print_status "Creating final backup archive..."
tar czf "$BACKUP_FILE" -C "$TEMP_DIR" .

# Clean up temporary directory
rm -rf "$TEMP_DIR"

print_status "Backup completed successfully!"
print_status "Backup file: $BACKUP_FILE"
print_status "Size: $(du -h "$BACKUP_FILE" | cut -f1)"

echo ""
print_status "To restore from this backup, you would:"
print_status "1. Stop the services: docker-compose down"
print_status "2. Remove existing volumes if starting fresh"
print_status "3. Start services: docker-compose up -d"
print_status "4. Restore n8n storage: docker run --rm -v docker-postgres_n8n_storage:/target -v \$(pwd):/source alpine tar xzf /source/backups/n8n_backup_XXXX.tar.gz -C /target"
print_status "5. Restore database: docker-compose exec -T postgres psql -U postgres -f /path/to/db_dump.sql"