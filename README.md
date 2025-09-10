# n8n with PostgreSQL Docker Setup

This is a complete Docker Compose setup for running n8n with PostgreSQL as the database backend.

## Prerequisites

Before you begin, ensure you have the following installed:
- Docker
- Docker Compose

## First-Time Setup Instructions

### 1. Clone or Navigate to the Project Directory

```bash
cd /Users/brito/n8n/docker-postgres
```

### 2. Review Environment Variables

Check the `.env` file to review the default configuration:

```bash
cat .env
```

For production use, you should change the default passwords:
- `POSTGRES_PASSWORD`: PostgreSQL root password
- `DB_POSTGRESDB_PASSWORD`: Password for n8n database user

### 3. Start the Services

Run the following command to start n8n and PostgreSQL:

```bash
docker-compose up -d
```

This will:
- Pull the required Docker images (if not already present)
- Create containers for n8n and PostgreSQL
- Start the services in the background

### 4. Monitor Startup Progress

View the logs to monitor the startup process:

```bash
# View all logs
docker-compose logs -f

# View specific service logs
docker-compose logs -f n8n
docker-compose logs -f postgres
```

Press `Ctrl+C` to stop following the logs.

### 5. Access n8n

Once the services are running:
1. Open your browser and navigate to [http://localhost:5678](http://localhost:5678)
2. You should see the n8n setup interface
3. Create your owner account by filling in the form

## Project Structure

```
.
├── docker-compose.yml     # Docker Compose configuration
├── .env                    # Environment variables
├── init-data.sh            # Database initialization script
├── manage.sh               # Management script
├── backup.sh               # Backup script
├── GETTING_STARTED.md      # Getting started guide
└── README.md              # This file
```

## Management Commands

### Start Services
```bash
docker-compose up -d
```

### Stop Services
```bash
docker-compose stop
```

### View Service Status
```bash
docker-compose ps
```

### View Logs
```bash
# View all logs
docker-compose logs

# Follow logs in real-time
docker-compose logs -f

# View logs for specific service
docker-compose logs -f n8n
docker-compose logs -f postgres
```

### Stop and Remove Containers
```bash
docker-compose down
```

## Using the Management Script

The project includes a helper script for common operations:

```bash
# Make the script executable (first time only)
chmod +x manage.sh

# Start services
./manage.sh start

# Stop services
./manage.sh stop

# View status
./manage.sh status

# View logs
./manage.sh logs

# Restart services
./manage.sh restart

# Stop and remove containers
./manage.sh down
```

See `./manage.sh` for all available commands.

## Data Persistence

This setup uses Docker named volumes for data persistence:
- `docker-postgres_db_storage`: PostgreSQL data
- `docker-postgres_n8n_storage`: n8n data (encryption key, settings)

These volumes ensure your data persists even when containers are removed.

## Security Considerations

1. **Change Default Passwords**: Before deploying to any environment, especially production, change the default passwords in the `.env` file.

2. **Encryption Key**: On first startup, n8n auto-generates an encryption key. For production use:
   - Generate your own encryption key
   - Set it as `N8N_ENCRYPTION_KEY` environment variable
   - Backup this key securely

3. **Network Security**: The current setup exposes n8n to localhost:5678 only. For production deployments, consider:
   - Using HTTPS with reverse proxy (nginx, traefik)
   - Proper firewall configuration

## Troubleshooting

### Common Issues

1. **Port Conflicts**: If port 5678 or 5432 is already in use, either:
   - Change the port mappings in `docker-compose.yml`
   - Stop conflicting services

2. **Permission Errors**: 
   - Ensure Docker has proper permissions to access the directory
   - Check Docker daemon is running

3. **Database Connection Issues**:
   - Verify PostgreSQL is healthy (`docker-compose logs postgres`)
   - Check database credentials in `.env` file
   - When connecting from n8n to PostgreSQL, use `postgres` as the host instead of `localhost`

### Resetting the Setup

To start fresh (removes all data):

```bash
# Stop services
docker-compose down

# Remove named volumes
docker volume rm docker-postgres_db_storage docker-postgres_n8n_storage

# Start again
docker-compose up -d
```

## Updating

### Update to Latest Versions

```bash
# Pull latest images
docker-compose pull

# Recreate containers
docker-compose up -d
```

## Backup and Restore

Use the provided backup script to create backups:

```bash
# Make script executable (first time only)
chmod +x backup.sh

# Create backup
./backup.sh
```

Backups are stored in the `backups/` directory.

## Additional Resources

- [n8n Documentation](https://docs.n8n.io)
- [Docker Documentation](https://docs.docker.com/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

See `GETTING_STARTED.md` for a quick start guide to using n8n after installation.