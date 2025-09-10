# n8n with PostgreSQL - Simple Setup Guide

This guide is designed for those who want to use n8n with PostgreSQL.

## Quick Start

### 1. Start the Services

Double-click on the `start-n8n` script or run this command in Terminal:

```bash

./manage.sh start

```

### 2. Access n8n

Open your web browser and go to: http://localhost:5678

### 3. Set Up Your Account

- Create your owner account by filling in the form
- This is your admin account for n8n

## Using Webhooks (Like the Chat Feature)

If you want to use features like chat that require webhooks, follow these steps:

### 1. Make Your Workflow Active

In the n8n interface:

- Find the workflow you want to use
- Look for the "Active" toggle in the top-right corner
- Make sure it's turned ON (green color)

### 2. Find Your Webhook URL

- Open the workflow
- Click on the "Webhook" node
- Copy the "Production URL" - it will look like:

`http://localhost:5678/webhook/8443e597-d4f1-485e-b8a8-3537e91a1ef5`

### 3. Use the Webhook

You can now share this URL with others or use it in other applications.

## Common Tasks

### Starting n8n

```bash

./manage.sh start

```

### Stopping n8n

```bash

./manage.sh stop

```

### Checking if n8n is Running

```bash

./manage.sh status

```

### Viewing Logs (for troubleshooting)

```bash

./manage.sh logs

```

## Troubleshooting

### "Webhook not registered" Error

This is the most common issue. To fix it:

1. Go to http://localhost:5678
2. Find your workflow
3. Make sure the "Active" toggle is ON (green)
4. Save the workflow

### Can't Access http://localhost:5678

1. Make sure you started the services with `./manage.sh start`
2. Check that port 5678 isn't being used by another application

### Need Help?

- Check the logs: `./manage.sh logs`
- Restart everything: `./manage.sh restart`

## Important Notes

- Your data is saved automatically
- You can stop and start n8n safely - your workflows will still be there
- The first time you run n8n, it might take a minute to start up

## For Advanced Users

If you need to change passwords or other settings, see the main README.md file.
