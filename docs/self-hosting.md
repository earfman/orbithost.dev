# OrbitHost Self-Hosting Guide

This guide provides instructions for running OrbitHost on your own infrastructure, enabling you to manage your own instance of the platform while maintaining all features, including the "hey post this to orbithost.dev" AI integration.

## Overview

OrbitHost's self-hosting capabilities allow you to:

1. Run the platform on your own servers
2. Maintain full control over your data
3. Customize the platform to your needs
4. Use your own domain while keeping the AI integration

## Requirements

- **Server**: Linux-based server with at least 2GB RAM
- **Docker**: Docker and Docker Compose installed
- **Domain**: A domain name for your OrbitHost instance
- **Email**: SMTP server for notifications
- **Database**: Supabase instance (or PostgreSQL)

## Installation Options

### Docker Deployment (Recommended)

1. Clone the repository:
```bash
git clone https://github.com/earfman/orbithost.dev.git
cd orbithost.dev
```

2. Configure environment variables:
```bash
cp .env.example .env
# Edit .env with your configuration
```

3. Start the application:
```bash
docker-compose up -d
```

### Traditional Deployment

1. Clone the repository:
```bash
git clone https://github.com/earfman/orbithost.dev.git
cd orbithost.dev
```

2. Install dependencies:
```bash
cd app
npm install
```

3. Configure environment variables:
```bash
cp .env.example .env
# Edit .env with your configuration
```

4. Set up the database:
```bash
npm run setup-supabase
```

5. Start the application:
```bash
npm run start-production
```

## Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| SUPABASE_URL | URL for your Supabase project | Yes |
| SUPABASE_KEY | Anon key for accessing Supabase | Yes |
| SUPABASE_SERVICE_ROLE_KEY | Service role key for admin operations | Yes |
| JWT_SECRET | Secret key for signing JWT tokens | Yes |
| AI_DEPLOY_API_KEY | API key for authenticating AI deployment requests | Yes |
| NODE_ENV | Environment (production, development) | Yes |
| PORT | Port for the application (default: 8080) | No |
| FALLBACK_PORT | Port for the fallback service (default: 9091) | No |
| ADMIN_EMAIL | Email for the default admin account | Yes |
| ADMIN_PASSWORD | Password for the default admin account | Yes |
| SMTP_HOST | SMTP server host | Yes |
| SMTP_PORT | SMTP server port | Yes |
| SMTP_USER | SMTP username | Yes |
| SMTP_PASS | SMTP password | Yes |
| DOMAIN | Your domain name | Yes |

## Nginx Configuration

If you're using Nginx as a reverse proxy:

```nginx
server {
    listen 80;
    server_name yourdomain.com;
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name yourdomain.com;

    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /fallback/ {
        proxy_pass http://localhost:9091/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## Systemd Service

For running OrbitHost as a systemd service:

```ini
[Unit]
Description=OrbitHost
After=network.target

[Service]
Type=simple
User=yourusername
WorkingDirectory=/path/to/orbithost.dev/app
ExecStart=/usr/bin/npm run start-production
Restart=on-failure
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
```

Save this as `/etc/systemd/system/orbithost.service` and run:

```bash
sudo systemctl enable orbithost
sudo systemctl start orbithost
```

## AI Integration for Self-Hosted Instances

To maintain the "hey post this to orbithost.dev" functionality with your own domain:

1. Update the AI integration configuration:
```bash
# Edit app/public/.well-known/ai-plugin.json
# Change all instances of orbithost.dev to your domain
```

2. Update the OpenAPI specification:
```bash
# Edit app/public/api/ai-deploy/openapi.json
# Change all instances of orbithost.dev to your domain
```

3. Create a GitHub repository with documentation that explains how to use your custom domain with AI assistants.

## Updating

To update your self-hosted OrbitHost instance:

1. Pull the latest changes:
```bash
git pull origin main
```

2. Rebuild and restart (Docker):
```bash
docker-compose down
docker-compose up -d --build
```

3. Or update and restart (Traditional):
```bash
cd app
npm install
npm run start-production
```

## Troubleshooting

### Common Issues

1. **Database Connection Errors**:
   - Check your Supabase credentials
   - Ensure your IP is allowed in Supabase

2. **Port Conflicts**:
   - Change the PORT and FALLBACK_PORT in your .env file

3. **Email Sending Failures**:
   - Verify your SMTP configuration
   - Check for firewall restrictions

### Logs

Access logs for troubleshooting:

```bash
# Docker logs
docker-compose logs -f

# Traditional deployment logs
cd app
npm run logs
```

## Support

For self-hosting support:

- Email: support@orbithost.dev
- GitHub Issues: https://github.com/earfman/orbithost.dev/issues
- Documentation: https://github.com/earfman/orbithost.dev/docs
