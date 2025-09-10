
# n8n with PostgreSQL - Simple Setup Guide

This guide helps you run **n8n** with a **PostgreSQL** database using Docker.

---

## Prerequisites

Before you start, make sure you have **one of the following installed** on your system:

* [Docker Desktop](https://www.docker.com/products/docker-desktop/) (Windows / macOS / Linux)
* or [Docker Engine](https://docs.docker.com/engine/install/) (Linux)

⚠️ Without Docker installed, the commands in this guide will not work.

---

## Quick Start

### 1. Start the Services

Run the following command in your terminal:

**bash**

```
./manage.sh start
```

This will start both PostgreSQL and n8n using Docker Compose.

### 2. Access n8n

Open your web browser and go to:

👉 [http://localhost:5678](http://localhost:5678/)

### 3. Set Up Your Account

Fill in the form to create your owner (admin) account. This account has full access to your n8n instance.

---

## Using Webhooks (e.g., Chat Feature)

Some features (like chat) require webhooks.

1. **Make Your Workflow Active**
   * Open the n8n interface
   * Find the workflow you want to use
   * Switch the "Active" toggle to ON (green)
2. **Find Your Webhook URL**
   * Open the workflow
   * Click the Webhook node
   * Copy the Production URL, e.g.:
     **text**

     ```
     http://localhost:5678/webhook/8443e597-d4f1-485e-b8a8-3537e91a1ef5
     ```
3. **Use the Webhook**
   * Share it with others, or
   * Integrate it into another application

---

## Common Tasks

| Task             | Command                 |
| ---------------- | ----------------------- |
| Start n8n        | `./manage.sh start`   |
| Stop n8n         | `./manage.sh stop`    |
| Check Status     | `./manage.sh status`  |
| View Logs        | `./manage.sh logs`    |
| Restart Services | `./manage.sh restart` |

---

## Troubleshooting

### "Webhook not registered" Error

* Go to [http://localhost:5678](http://localhost:5678/)
* Open the workflow
* Ensure the Active toggle is ON (green)
* Save the workflow

### Can't Access [http://localhost:5678](http://localhost:5678/)

* Verify services are running: `./manage.sh start`
* Make sure port 5678 isn't used by another app (`docker ps` or `lsof -i :5678`)

### Need More Help?

* View logs: `./manage.sh logs`
* Restart everything: `./manage.sh restart`

---

## Important Notes

* Your data is persisted in Docker volumes → safe to stop/start services
* First startup may take a minute while containers initialize
* Passwords and environment variables can be configured in the `.env` file

---

## For Advanced Users

* To customize database credentials or n8n settings, edit the `.env` file
* For production use:
  * Run behind a reverse proxy (Nginx/Traefik)
  * Use a domain name (e.g., [n8n.mydomain.com](https://n8n.mydomain.com/))
  * Enable HTTPS with Let's Encrypt certificates
