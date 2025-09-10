#!/bin/bash

# n8n Docker Management Script

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

# Function to check if docker is installed
check_docker() {
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    if ! command -v docker-compose &> /dev/null; then
        print_error "Docker Compose is not installed. Please install Docker Compose first."
        exit 1
    fi
}

# Function to check if services are running
check_running() {
    if docker-compose ps | grep -q "Up"; then
        return 0
    else
        return 1
    fi
}

# Main script logic
case "$1" in
    start)
        check_docker
        print_status "Starting n8n and PostgreSQL services..."
        docker-compose up -d
        
        if [ $? -eq 0 ]; then
            print_status "Services started successfully!"
            print_status "Access n8n at: http://localhost:5678"
        else
            print_error "Failed to start services"
            exit 1
        fi
        ;;
        
    stop)
        check_docker
        print_status "Stopping n8n and PostgreSQL services..."
        docker-compose stop
        
        if [ $? -eq 0 ]; then
            print_status "Services stopped successfully!"
        else
            print_error "Failed to stop services"
            exit 1
        fi
        ;;
        
    restart)
        check_docker
        print_status "Restarting n8n and PostgreSQL services..."
        docker-compose restart
        
        if [ $? -eq 0 ]; then
            print_status "Services restarted successfully!"
            if check_running; then
                print_status "Access n8n at: http://localhost:5678"
            fi
        else
            print_error "Failed to restart services"
            exit 1
        fi
        ;;
        
    status)
        check_docker
        print_status "Checking service status..."
        docker-compose ps
        ;;
        
    logs)
        check_docker
        if [ -z "$2" ]; then
            print_status "Showing all logs..."
            docker-compose logs -f
        else
            print_status "Showing logs for $2..."
            docker-compose logs -f $2
        fi
        ;;
        
    down)
        check_docker
        print_status "Stopping and removing containers..."
        docker-compose down
        
        if [ $? -eq 0 ]; then
            print_status "Containers stopped and removed successfully!"
        else
            print_error "Failed to stop and remove containers"
            exit 1
        fi
        ;;
        
    reset)
        check_docker
        print_warning "This will remove ALL data including workflows and credentials!"
        read -p "Are you sure you want to continue? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_status "Stopping services..."
            docker-compose down
            
            print_status "Removing data volumes..."
            docker volume rm docker-postgres_db_storage docker-postgres_n8n_storage >/dev/null 2>&1 || true
            
            print_status "Data reset complete. Run './manage.sh start' to start fresh."
        else
            print_status "Reset cancelled."
        fi
        ;;
        
    *)
        echo "n8n Docker Management Script"
        echo ""
        echo "Usage: ./manage.sh [command]"
        echo ""
        echo "Commands:"
        echo "  start     - Start n8n and PostgreSQL services"
        echo "  stop      - Stop n8n and PostgreSQL services"
        echo "  restart   - Restart n8n and PostgreSQL services"
        echo "  status    - Show status of services"
        echo "  logs      - Show logs (add service name for specific service)"
        echo "  down      - Stop and remove containers"
        echo "  reset     - Reset all data (WARNING: This deletes everything!)"
        echo ""
        echo "Examples:"
        echo "  ./manage.sh start"
        echo "  ./manage.sh logs n8n"
        echo "  ./manage.sh logs postgres"
        ;;
esac