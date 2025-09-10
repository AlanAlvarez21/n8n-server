# n8n Docker Setup with PostgreSQL

This repository contains a complete Docker Compose setup for running n8n with PostgreSQL as the database backend.

## Prerequisites

Before you begin, ensure you have the following installed:
- Docker
- Docker Compose

## Setup Instructions

1. Clone this repository:
   ```bash
   git clone https://github.com/AlanAlvarez21/n8n-docker-postgres.git
   cd n8n-docker-postgres
   ```

2. Copy the example environment file and update the values:
   ```bash
   cp .env.example .env
   # Edit .env file to change default passwords
   ```

3. Start the services:
   ```bash
   ./manage.sh start
   ```

4. Access n8n at [http://localhost:5678](http://localhost:5678)

## Management Commands

- Start services: `./manage.sh start`
- Stop services: `./manage.sh stop`
- View logs: `./manage.sh logs`
- Restart services: `./manage.sh restart`

## Data Persistence and Backup

This setup uses PostgreSQL as the database backend and Docker volumes for data persistence, which means your workflows and credentials will persist even if the containers are restarted or recreated.

### License Persistence

To persist your n8n license across container restarts, add your license key to the `.env` file as `N8N_LICENSE=your-license-key`. The license will then be passed to the container as an environment variable and will persist across container restarts.

### Backup Your Workflows

To create a backup of your workflows and credentials:

```bash
./backup-workflows.sh
```

This will create:
- A PostgreSQL database dump in the `./backups` directory
- JSON exports of workflows and credentials

### Restore Your Workflows

To restore from a backup:

```bash
./restore-workflows.sh <backup_timestamp>
```

For example:
```bash
./restore-workflows.sh 20251201_143022
```

### Scheduled Backups

You can set up automatic daily backups by adding this to your crontab:

```bash
# Run daily backup at 2:00 AM
0 2 * * * cd /path/to/n8n-docker-postgres && ./scheduled-backup.sh >> ./backups/backup.log 2>&1
```

## Webhooks

To use webhooks (like chat functionality):
1. Make sure your workflow is active (toggle in the top-right corner)
2. Use the webhook URL provided in the Webhook node

## For Non-Engineers

If you're not an engineer but need to use this system, check out our simplified guide:
[Non-Engineer Guide](README_NON_ENGINEERS.md)

## Additional Resources

- [n8n Documentation](https://docs.n8n.io)
- [Docker Documentation](https://docs.docker.com/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)