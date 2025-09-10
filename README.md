
# n8n Docker Setup

This repository contains a complete Docker Compose setup for running n8n with PostgreSQL as the database backend.

## Prerequisites

Before you begin, ensure you have the following installed:

- Docker
- Docker Compose

## Local Setup Instructions

1. Clone this repository:

   ```bash
   git clone https://github.com/AlanAlvarez21/n8n-docker-setup.git
   cd n8n-docker-setup
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

## Deploying to a VPS (e.g., Render)

To deploy n8n to a VPS platform like Render, follow these steps:

### 1. Prepare Docker Image

Build and push the Docker image to a container registry:

```bash
# Build the image for linux/amd64 platform
docker build --platform linux/amd64 -t ghcr.io/your-username/n8n-app:latest .

# Push to container registry
docker push ghcr.io/your-username/n8n-app:latest
```

### 2. Deploy to Render

You can deploy using either the Render Dashboard or the Render CLI:

**Option A: Using Render Dashboard**

1. Create a new Web Service on Render
2. Connect your GitHub repository or use an existing Docker image
3. Set the following environment variables:
   - `N8N_PROTOCOL`: `https`
   - `N8N_HOST`: `your-app-name.onrender.com`
   - `N8N_PORT`: `5678`
   - `N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS`: `true` (optional but recommended)

**Option B: Using Render CLI**

```bash
# Install Render CLI
brew install render

# Login to Render
render login

# Deploy the service
render services create --name n8n-app --type web

# Deploy the image
render deploys create YOUR_SERVICE_ID --image ghcr.io/your-username/n8n-app:latest
```

### 3. Configure Environment Variables

Set these essential environment variables in your VPS platform:

- `N8N_PROTOCOL`: `https` (for HTTPS) or `http` (for HTTP)
- `N8N_HOST`: Your domain or Render-provided URL
- `N8N_PORT`: `5678`
- `N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS`: `true`

### 4. Database Considerations

For production deployments, consider using an external database:

- Set up a PostgreSQL database on Render or another provider
- Configure the following environment variables:
  - `DB_TYPE`: `postgresdb`
  - `DB_POSTGRESDB_HOST`: Database host
  - `DB_POSTGRESDB_PORT`: Database port (usually 5432)
  - `DB_POSTGRESDB_DATABASE`: Database name
  - `DB_POSTGRESDB_USER`: Database user
  - `DB_POSTGRESDB_PASSWORD`: Database password

## Management Commands

- Start services: `./manage.sh start`
- Stop services: `./manage.sh stop`
- View logs: `./manage.sh logs`
- Restart services: `./manage.sh restart`

## Webhooks

To use webhooks (like chat functionality):

1. Make sure your workflow is active (toggle in the top-right corner)
2. Use the webhook URL provided in the Webhook node

## Post-Deployment Steps

After successfully deploying n8n to your VPS:

1. **Access the Web Interface**

   - Visit your deployed URL (e.g., https://your-app-name.onrender.com)
   - Create your first user account
2. **Configure Security**

   - Set up user authentication
   - Configure API credentials for third-party services
   - Review and set appropriate permissions
3. **Import/Export Workflows**

   - Export existing workflows from local setup: `./export-workflows.sh`
   - Import workflows to production environment: `./import-workflows.sh`
   - Test all workflows to ensure they work correctly
4. **Monitor and Maintain**

   - Regularly check logs for errors
   - Monitor resource usage
   - Keep n8n updated to the latest version
   - Backup your workflows and credentials regularly
5. **Scale as Needed**

   - Monitor performance and adjust resources
   - Consider using multiple instances for high availability
   - Set up monitoring and alerting for critical workflows

## For Non-Engineers

If you're not an engineer but need to use this system, check out our simplified guide:
[Non-Engineer Guide](README_NON_ENGINEERS.md)

## Additional Resources

- [n8n Documentation](https://docs.n8n.io)
- [Docker Documentation](https://docs.docker.com/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
