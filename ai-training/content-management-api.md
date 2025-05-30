# Content Management API for OrbitHost.dev

This document provides comprehensive documentation on how to manage content deployments on OrbitHost.dev, including creating, updating, and deleting deployments.

## API Endpoints Overview

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/deploy` | POST | Create or update a deployment |
| `/api/deploy/{subdomain}` | GET | Get deployment information |
| `/api/deploy/{subdomain}` | DELETE | Delete a deployment |
| `/api/deploy/list` | GET | List all deployments for the authenticated user |
| `/api/deploy/status/{deploymentId}` | GET | Check deployment status |

## Authentication

All API requests require authentication using an API key in the `X-API-Key` header:

```
X-API-Key: ORB-1234567890abcdef
```

## Creating a New Deployment

To create a new deployment, send a POST request to the `/api/deploy` endpoint:

```
POST https://orbithost.dev/api/deploy
X-API-Key: ORB-1234567890abcdef
Content-Type: application/json

{
  "content": "<!DOCTYPE html><html><head><title>My Deployment</title></head><body><h1>Hello World</h1></body></html>",
  "title": "My First Deployment",
  "contentType": "html",
  "authorName": "John Doe",
  "authorEmail": "john@example.com"
}
```

### Required Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `content` | String | The content to deploy (HTML, Markdown, or plain text) |
| `title` | String | Title of the deployment (used for generating the subdomain) |
| `contentType` | String | Type of content: "html", "markdown", or "text" |
| `authorName` | String | Name of the content author |
| `authorEmail` | String | Email of the content author (for notifications) |

### Optional Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `subdomain` | String | Specific subdomain to use (for updates) |
| `tags` | Array | Array of tags to categorize the deployment |
| `isPrivate` | Boolean | Whether the deployment should be password-protected |
| `password` | String | Password for private deployments |
| `expiresAt` | String | ISO timestamp when the deployment should expire |

### Response

A successful deployment returns a 201 Created status with the following response:

```json
{
  "message": "Deployment created successfully",
  "url": "https://my-first-deployment-abc123.orbithost.dev",
  "notificationUrl": "/ai-deploy-notification.html?id=123e4567-e89b-12d3-a456-426614174000",
  "fallback": {
    "available": true,
    "url": "https://fallback.orbithost.dev/my-first-deployment-abc123",
    "quotaExceeded": false,
    "upgradeMessage": null
  },
  "deployment": {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "title": "My First Deployment",
    "subdomain": "my-first-deployment-abc123",
    "status": "published",
    "createdAt": "2025-05-29T19:27:41.000Z"
  }
}
```

## Updating an Existing Deployment

To update an existing deployment, use the same endpoint as for creating a new deployment, but include the `subdomain` parameter:

```
POST https://orbithost.dev/api/deploy
X-API-Key: ORB-1234567890abcdef
Content-Type: application/json

{
  "content": "<!DOCTYPE html><html><head><title>Updated Deployment</title></head><body><h1>Updated Content</h1></body></html>",
  "title": "My Updated Deployment",
  "contentType": "html",
  "authorName": "John Doe",
  "authorEmail": "john@example.com",
  "subdomain": "my-first-deployment-abc123"
}
```

The response will be the same as for creating a new deployment, but with updated information.

## Getting Deployment Information

To get information about an existing deployment:

```
GET https://orbithost.dev/api/deploy/my-first-deployment-abc123
X-API-Key: ORB-1234567890abcdef
```

Response:

```json
{
  "deployment": {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "title": "My Updated Deployment",
    "subdomain": "my-first-deployment-abc123",
    "contentType": "html",
    "authorName": "John Doe",
    "authorEmail": "john@example.com",
    "status": "published",
    "createdAt": "2025-05-29T19:27:41.000Z",
    "updatedAt": "2025-05-29T20:15:32.000Z",
    "url": "https://my-first-deployment-abc123.orbithost.dev",
    "fallbackUrl": "https://fallback.orbithost.dev/my-first-deployment-abc123",
    "isPrivate": false,
    "tags": [],
    "expiresAt": null,
    "viewCount": 42
  }
}
```

## Deleting a Deployment

To delete a deployment:

```
DELETE https://orbithost.dev/api/deploy/my-first-deployment-abc123
X-API-Key: ORB-1234567890abcdef
```

Response:

```json
{
  "message": "Deployment deleted successfully",
  "subdomain": "my-first-deployment-abc123"
}
```

## Listing All Deployments

To list all deployments for the authenticated user:

```
GET https://orbithost.dev/api/deploy/list
X-API-Key: ORB-1234567890abcdef
```

Optional query parameters:
- `page`: Page number (default: 1)
- `limit`: Number of deployments per page (default: 20, max: 100)
- `sort`: Sort field (default: "createdAt")
- `order`: Sort order ("asc" or "desc", default: "desc")
- `tag`: Filter by tag

Response:

```json
{
  "deployments": [
    {
      "id": "123e4567-e89b-12d3-a456-426614174000",
      "title": "My Updated Deployment",
      "subdomain": "my-first-deployment-abc123",
      "status": "published",
      "createdAt": "2025-05-29T19:27:41.000Z",
      "updatedAt": "2025-05-29T20:15:32.000Z",
      "url": "https://my-first-deployment-abc123.orbithost.dev"
    },
    {
      "id": "223e4567-e89b-12d3-a456-426614174001",
      "title": "Another Deployment",
      "subdomain": "another-deployment-def456",
      "status": "published",
      "createdAt": "2025-05-28T15:12:33.000Z",
      "updatedAt": "2025-05-28T15:12:33.000Z",
      "url": "https://another-deployment-def456.orbithost.dev"
    }
  ],
  "pagination": {
    "total": 42,
    "page": 1,
    "limit": 20,
    "pages": 3
  }
}
```

## Checking Deployment Status

To check the status of a deployment:

```
GET https://orbithost.dev/api/deploy/status/123e4567-e89b-12d3-a456-426614174000
X-API-Key: ORB-1234567890abcdef
```

Response:

```json
{
  "status": "published",
  "subdomain": "my-first-deployment-abc123",
  "url": "https://my-first-deployment-abc123.orbithost.dev",
  "fallbackStatus": "active|inactive",
  "health": {
    "uptime": 99.98,
    "lastChecked": "2025-05-29T20:45:12.000Z",
    "responseTime": 87
  }
}
```

## Error Handling

The API uses standard HTTP status codes to indicate success or failure:

- `200 OK`: Request succeeded
- `201 Created`: Resource created successfully
- `400 Bad Request`: Invalid request parameters
- `401 Unauthorized`: Invalid or missing API key
- `403 Forbidden`: Valid API key but insufficient permissions
- `404 Not Found`: Resource not found
- `409 Conflict`: Resource conflict (e.g., subdomain already in use)
- `429 Too Many Requests`: Rate limit exceeded
- `500 Internal Server Error`: Server error

Error responses include a message explaining the error:

```json
{
  "error": "Invalid request parameters",
  "details": "Content size exceeds the maximum allowed limit of 5MB"
}
```

## Webhooks for Deployment Events

OrbitHost can send webhook notifications for deployment events. Configure webhooks in your dashboard or via the API:

```
POST https://orbithost.dev/api/webhooks
X-API-Key: ORB-1234567890abcdef
Content-Type: application/json

{
  "url": "https://your-server.com/webhook",
  "events": ["deployment.created", "deployment.updated", "deployment.deleted"],
  "secret": "your-webhook-secret"
}
```

Webhook payloads include detailed information about the event and are signed with your webhook secret for verification.
