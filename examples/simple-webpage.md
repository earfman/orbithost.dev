# Simple Webpage Example

This example demonstrates how to deploy a simple HTML webpage to orbithost.dev using the "hey post this to orbithost.dev" command.

## User Request

When a user wants to deploy a simple HTML webpage, they might say something like:

```
Hey post this to orbithost.dev:

<!DOCTYPE html>
<html>
<head>
    <title>My Simple Webpage</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        h1 {
            color: #2c3e50;
        }
        .container {
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <h1>Welcome to My Webpage</h1>
    <div class="container">
        <p>This is a simple webpage deployed through OrbitHost using an AI assistant.</p>
        <p>Key features of OrbitHost:</p>
        <ul>
            <li>Deploy content with a simple command</li>
            <li>Automatic fallback protection</li>
            <li>No technical knowledge required</li>
        </ul>
    </div>
</body>
</html>
```

## AI Assistant Response

The AI assistant should recognize this as HTML content and respond with something like:

```
I'll deploy this HTML webpage to OrbitHost for you. I'll need your email address for deployment notifications. What email should I use?
```

After the user provides their email:

```
Great! I've deployed your webpage to OrbitHost. You can view it at:

https://my-simple-webpage-abc123.orbithost.dev

Your webpage is also protected by OrbitHost's fallback system, ensuring it remains available even during outages. You have 4 fallbacks remaining out of your 5 free fallbacks.

You'll receive an email notification with these details, and you can manage your deployment from the OrbitHost dashboard.
```

## Technical Implementation

Behind the scenes, the AI assistant makes this API call:

```javascript
// API Request
fetch('https://orbithost.dev/api/ai-deploy', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-API-Key': 'AI_DEPLOY_API_KEY'
  },
  body: JSON.stringify({
    content: '<!DOCTYPE html><html>...</html>', // The HTML content
    title: 'My Simple Webpage',
    contentType: 'html',
    authorEmail: 'user@example.com',
    authorName: 'User Name' // Optional
  })
})
.then(response => response.json())
.then(data => {
  // Handle the response
  console.log(data.url); // The deployment URL
  console.log(data.fallback.url); // The fallback URL
});
```

## Response Handling

The API response will look like:

```json
{
  "message": "Deployment created successfully",
  "url": "https://my-simple-webpage-abc123.orbithost.dev",
  "notificationUrl": "/ai-deploy-notification.html?id=deployment-id",
  "fallback": {
    "available": true,
    "url": "https://fallback.orbithost.dev/my-simple-webpage-abc123",
    "quotaExceeded": false,
    "upgradeMessage": null
  },
  "deployment": {
    "id": "deployment-id",
    "title": "My Simple Webpage",
    "subdomain": "my-simple-webpage-abc123",
    "status": "active",
    "createdAt": "2025-05-29T21:25:59Z"
  }
}
```

The AI assistant should extract the relevant information from this response and present it to the user in a friendly format.
