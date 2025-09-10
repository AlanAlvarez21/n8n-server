# Getting Started with n8n and PostgreSQL

Welcome to your new n8n installation with PostgreSQL!

## Accessing n8n

1. Open your browser and go to [http://localhost:5678](http://localhost:5678)
2. You'll see the n8n setup screen where you can create your owner account

## Basic Operations

### Starting the Services
```bash
# Start in detached mode (runs in background)
./manage.sh start

# Or use docker-compose directly
docker-compose up -d
```

### Stopping the Services
```bash
# Stop services
./manage.sh stop

# Or use docker-compose directly
docker-compose stop
```

### Viewing Logs
```bash
# View all logs
./manage.sh logs

# View logs for specific service
./manage.sh logs n8n
./manage.sh logs postgres
```

## Next Steps

1. **Create your Owner Account**
   - Visit http://localhost:5678
   - Fill in the form to create your owner account
   - This account will have admin privileges

2. **Explore the Interface**
   - Take the guided tour if prompted
   - Check out the workflow templates
   - Familiarize yourself with the node-based editor

3. **Create Your First Workflow**
   - Try a simple workflow like:
     * HTTP Request node to fetch data from an API
     * JSON node to parse the response
     * Debug node to output the result

4. **Connect to External Services**
   - Configure credentials for services you want to integrate with
   - n8n supports hundreds of apps and services

## Useful Management Commands

```bash
# Check status of services
./manage.sh status

# Restart services
./manage.sh restart

# Stop and remove containers (data is preserved)
./manage.sh down

# Reset everything (WARNING: Deletes all data!)
./manage.sh reset
```

## Backup Your Data

Regular backups are important! Use the backup script:
```bash
./backup.sh
```

This creates a timestamped backup in the `backups/` directory.

## Configuration

The setup uses environment variables in the `.env` file. You can modify:
- Database credentials
- n8n configuration
- Port mappings

See `README.md` for more detailed configuration options.

## Need Help?

- [n8n Documentation](https://docs.n8n.io)
- [n8n Community Forum](https://community.n8n.io)
- [Video Tutorials](https://www.youtube.com/c/n8n-io)

Enjoy automating your workflows with n8n!