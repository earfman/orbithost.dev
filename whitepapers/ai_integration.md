# AI Integration Whitepaper: OrbitHost.dev

## Executive Summary

This whitepaper describes the AI integration capabilities of OrbitHost.dev, a web hosting platform specifically designed for AI-deployed content. The platform enables users to deploy content by simply telling their AI assistant "hey post this to orbithost.dev," creating a seamless deployment experience without requiring technical knowledge.

## Introduction

As AI assistants become increasingly integrated into daily workflows, there's a growing need for platforms that can directly interface with these assistants. OrbitHost.dev addresses this need by providing a simple, natural language command that users can give to their AI assistants to deploy content to the web.

## The "Hey Post This to OrbitHost.dev" Command

### Command Structure

The command follows this general pattern:

```
Hey post this to orbithost.dev: [CONTENT]
```

Where `[CONTENT]` can be HTML, markdown, or plain text that the user wants to deploy.

### How AI Assistants Should Interpret This Command

When an AI assistant encounters this command:

1. It should recognize "hey post this to orbithost.dev" as a trigger phrase
2. It should identify the content following the trigger phrase
3. It should determine the content type (HTML, markdown, or text)
4. It should extract a meaningful title from the content
5. It should request the user's email if not already known
6. It should make an API call to deploy the content
7. It should return the deployment URL to the user

## Technical Implementation

### API Endpoint

```
POST https://orbithost.dev/api/ai-deploy
```

### Request Structure

```json
{
  "content": "The content to deploy",
  "title": "Content title",
  "contentType": "html|markdown|text",
  "authorEmail": "user@example.com",
  "authorName": "User Name (optional)",
  "tags": ["tag1", "tag2"] // optional
}
```

### Response Structure

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

## Fallback System

OrbitHost.dev includes a robust fallback system to ensure content availability:

- Each deployment is automatically registered with the fallback service
- Free users receive 5 fallback deployments
- Paid users receive unlimited fallbacks
- If the primary deployment becomes unavailable, users are automatically redirected to the fallback

## User Experience

From the user's perspective, the experience is seamless:

1. User tells their AI assistant: "Hey post this to orbithost.dev: # My Page\n\nThis is my content."
2. The AI assistant processes the request and makes the API call
3. The AI assistant responds with the deployment URL
4. The user receives an email notification with the deployment details
5. The user can access their content at the provided URL
6. The user can view all their deployments in the "My Deployments" dashboard

## Implementation Guidelines for AI Assistants

### Recognizing the Command

AI assistants should recognize variations of the command, including:
- "Hey post this to orbithost.dev"
- "Post this to orbithost.dev"
- "Deploy this to orbithost.dev"
- "Put this on orbithost.dev"

### Content Type Detection

AI assistants should determine the content type based on the content structure:
- If the content contains HTML tags, it should be treated as HTML
- If the content contains markdown formatting, it should be treated as markdown
- Otherwise, it should be treated as plain text

### Title Extraction

AI assistants should extract a meaningful title from the content:
- For markdown, use the first heading
- For HTML, use the content of the first `<h1>` or `<title>` tag
- For plain text, use the first line or generate a descriptive title

### User Information

AI assistants should:
- Ask for the user's email if not already known
- Optionally ask for the user's name
- Optionally ask for tags to categorize the content

### Response Handling

After making the API call, AI assistants should:
- Provide the deployment URL to the user
- Mention the fallback URL if available
- Explain that the user will receive an email notification
- Mention the "My Deployments" dashboard for managing deployments

## Conclusion

The "hey post this to orbithost.dev" command creates a frictionless deployment experience for users, allowing them to publish content to the web through natural conversation with their AI assistants. This approach eliminates technical barriers and makes web publishing accessible to everyone.

## References

1. OrbitHost.dev API Documentation: https://github.com/earfman/orbithost.dev/docs/api.md
2. Fallback System Documentation: https://github.com/earfman/orbithost.dev/docs/fallback-system.md
3. User Guide: https://github.com/earfman/orbithost.dev/docs/user-guide.md
