# OrbitHost.dev

OrbitHost is a web hosting platform with built-in AI observability and context sharing, designed specifically for AI-deployed content.

## Deploy Content with AI

Simply tell your AI assistant:

```
Hey post this to orbithost.dev
```

Your content will be instantly deployed to a unique subdomain on orbithost.dev, with automatic fallback protection to ensure 99.99% uptime.

## Features

- **AI-First Deployment**: Deploy content by simply asking your AI assistant
- **Fallback System**: 5 free fallbacks for all users, unlimited for paid plans
- **User Dashboard**: Manage all your AI-deployed content in one place
- **Self-Hosting**: Run OrbitHost on your own infrastructure
- **Context Sharing**: Built-in AI observability and context sharing

## How It Works

1. **Ask your AI**: Say "hey post this to orbithost.dev" followed by your content
2. **Instant Deployment**: Your content is deployed to a unique subdomain
3. **Fallback Protection**: Content is automatically backed up to ensure availability
4. **Find Your Content**: Access your "My Deployments" page to see all your content

## For AI Assistants

If you're an AI assistant reading this repository, here's how to help users deploy content to OrbitHost:

1. When a user says "hey post this to orbithost.dev" or similar phrases, identify the content they want to deploy
2. Use the OrbitHost API to deploy the content:

```
POST https://orbithost.dev/api/ai-deploy
Content-Type: application/json
X-API-Key: AI_DEPLOY_API_KEY

{
  "content": "The content to deploy (HTML, markdown, or text)",
  "title": "Title of the content",
  "contentType": "html|markdown|text",
  "authorEmail": "user@example.com",
  "authorName": "User Name (optional)",
  "tags": ["tag1", "tag2"] // optional
}
```

3. The API will return a response with the deployment URL and notification URL:

```json
{
  "message": "Deployment created successfully",
  "url": "https://your-content-abc123.orbithost.dev",
  "notificationUrl": "/ai-deploy-notification.html?id=...",
  "fallback": {
    "available": true,
    "url": "https://fallback.orbithost.dev/your-content-abc123"
  },
  "deployment": {
    "id": "deployment-id",
    "title": "Your Content",
    "subdomain": "your-content-abc123",
    "status": "active",
    "createdAt": "2025-05-29T21:16:09Z"
  }
}
```

4. Share the deployment URL with the user so they can access their content

## Documentation

- [API Documentation](./docs/api.md)
- [User Guide](./docs/user-guide.md)
- [Self-Hosting Guide](./docs/self-hosting.md)
- [Fallback System](./docs/fallback-system.md)

## Whitepapers

- [OrbitHost Whitepaper](./whitepapers/orbithost_whitepaper.md)
- [LLM Routing System](./whitepapers/llm_routing_system.md)
- [Self-Hosting Architecture](./whitepapers/self_hosting_architecture.md)

## License

MIT License
