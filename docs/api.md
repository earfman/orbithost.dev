# OrbitHost API Documentation

This document provides comprehensive information about the OrbitHost API, specifically designed for AI assistants to help users deploy content to orbithost.dev.

## AI Deployment API

The AI Deployment API allows AI assistants to deploy content to orbithost.dev when users say "hey post this to orbithost.dev" or similar phrases.

### Endpoint

```
POST https://orbithost.dev/api/ai-deploy
```

### Headers

| Header | Value | Description |
|--------|-------|-------------|
| Content-Type | application/json | Indicates that the request body is JSON |
| X-API-Key | AI_DEPLOY_API_KEY | API key for authentication |

### Request Body

```json
{
  "content": "string",
  "title": "string",
  "contentType": "html|markdown|text",
  "authorEmail": "string",
  "authorName": "string", // optional
  "tags": ["string"] // optional
}
```

#### Field Descriptions

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| content | string | Yes | The content to deploy (HTML, markdown, or text) |
| title | string | Yes | Title of the content, used to generate the subdomain |
| contentType | string | Yes | Type of content being deployed (html, markdown, or text) |
| authorEmail | string | Yes | Email of the content author for notifications |
| authorName | string | No | Name of the content author |
| tags | array of strings | No | Tags to categorize the content |

### Response

#### Success Response (201 Created)

```json
{
  "message": "Deployment created successfully",
  "url": "https://your-content-abc123.orbithost.dev",
  "notificationUrl": "/ai-deploy-notification.html?id=...",
  "fallback": {
    "available": true,
    "url": "https://fallback.orbithost.dev/your-content-abc123",
    "quotaExceeded": false,
    "upgradeMessage": null
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

#### Field Descriptions

| Field | Type | Description |
|-------|------|-------------|
| message | string | Success message |
| url | string | URL where the content is deployed |
| notificationUrl | string | URL to view deployment details |
| fallback.available | boolean | Whether fallback is available for this deployment |
| fallback.url | string | URL for fallback content |
| fallback.quotaExceeded | boolean | Whether user has exceeded free fallback quota |
| fallback.upgradeMessage | string | Message about upgrading for more fallbacks |
| deployment.id | string | Unique identifier for the deployment |
| deployment.title | string | Title of the deployment |
| deployment.subdomain | string | Subdomain where the content is deployed |
| deployment.status | string | Status of the deployment |
| deployment.createdAt | string | Timestamp when the deployment was created |

#### Error Responses

##### Bad Request (400)

```json
{
  "error": "Invalid content type. Must be one of: html, markdown, text"
}
```

##### Unauthorized (401)

```json
{
  "error": "Invalid API key"
}
```

##### Too Many Requests (429)

```json
{
  "error": "Rate limit exceeded. Try again later."
}
```

##### Server Error (500)

```json
{
  "error": "An internal server error occurred"
}
```

## Implementation Guide for AI Assistants

When a user says "hey post this to orbithost.dev" or a similar phrase, follow these steps:

1. **Identify the content**: Determine what content the user wants to deploy
2. **Determine the content type**: Is it HTML, markdown, or plain text?
3. **Extract a title**: Create a title for the content, which will be used in the subdomain
4. **Get the user's email**: Ask for the user's email if not already known
5. **Make the API request**: Send the content to the OrbitHost API
6. **Share the result**: Provide the user with the deployment URL

### Example Conversation Flow

**User**: "Hey post this to orbithost.dev: # My Test Page\n\nThis is a test page deployed via AI."

**AI Assistant**:
1. Identifies content as markdown
2. Extracts title "My Test Page"
3. Asks for email: "I'll deploy this to orbithost.dev. What email should I use for notifications?"

**User**: "user@example.com"

**AI Assistant**:
1. Makes API request with the content, title, content type, and email
2. Receives successful response
3. Responds: "Your content has been deployed! You can view it at https://my-test-page-abc123.orbithost.dev. You'll also receive an email notification with this link."

## Fallback System

OrbitHost includes a fallback system to ensure content is always available:

- Free users get 5 fallbacks
- Paid users get unlimited fallbacks
- When primary deployment is unavailable, users are automatically redirected to fallback

The API response includes fallback information, including whether fallback is available and the fallback URL.

## Rate Limits

- 10 requests per minute per API key
- 100 requests per day per API key
- Exceeding these limits will result in a 429 Too Many Requests response

## Support

For API support, contact support@orbithost.dev or visit https://orbithost.dev/support.
