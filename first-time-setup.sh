#!/bin/bash

# First-Time Setup Script for n8n with PostgreSQL

echo "=== n8n with PostgreSQL First-Time Setup ==="
echo

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed."
    echo "Please install Docker before continuing."
    exit 1
fi

echo "✓ Docker is installed"

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "Error: Docker Compose is not installed."
    echo "Please install Docker Compose before continuing."
    exit 1
fi

echo "✓ Docker Compose is installed"
echo

# Display current directory
echo "Current directory: $(pwd)"
echo

# Show environment variables
echo "=== Environment Configuration ==="
echo "Reviewing .env file:"
if [ -f .env ]; then
    cat .env
else
    echo "Warning: .env file not found. Using default values."
fi
echo

# Prompt user to change default passwords for production use
echo "=== Security Notice ==="
echo "For production use, you should change the default passwords in the .env file"
echo "before starting the services."
echo

# Ask user if they want to proceed
read -p "Do you want to start the services now? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Setup cancelled. You can run this script again when ready."
    echo "Or start services manually with: docker-compose up -d"
    exit 0
fi

echo
echo "=== Starting Services ==="
echo "This may take a few minutes the first time as Docker images are downloaded..."
echo

# Start services
docker-compose up -d

if [ $? -eq 0 ]; then
    echo
    echo "✓ Services started successfully!"
    echo
    echo "=== Next Steps ==="
    echo "1. Wait a moment for services to initialize"
    echo "2. Open your browser and go to: http://localhost:5678"
    echo "3. Create your owner account"
    echo
    echo "=== Helpful Commands ==="
    echo "View service status: docker-compose ps"
    echo "View logs: docker-compose logs -f"
    echo "Stop services: docker-compose down"
    echo
    echo "For more information, see README.md and GETTING_STARTED.md"
else
    echo
    echo "✗ Error starting services. Check the logs for details:"
    echo "  docker-compose logs"
    exit 1
fi