# Markdown Blog Post Example

This example demonstrates how to deploy a markdown blog post to orbithost.dev using the "hey post this to orbithost.dev" command.

## User Request

When a user wants to deploy a markdown blog post, they might say something like:

```
Hey post this to orbithost.dev:

# The Future of AI-Assisted Web Development

## Introduction

As artificial intelligence continues to evolve, its impact on web development is becoming increasingly significant. This blog post explores how AI is transforming the way we build and deploy websites.

## AI-Assisted Deployment

One of the most exciting developments is the ability to deploy content through natural language commands. Platforms like OrbitHost allow users to simply tell their AI assistant to deploy content, eliminating the need for technical knowledge.

## Benefits of AI-Assisted Deployment

- **Accessibility**: Anyone can deploy content without technical skills
- **Speed**: Deploy in seconds rather than minutes or hours
- **Simplicity**: No need to learn complex deployment processes
- **Reliability**: Automatic fallback systems ensure content availability

## The Future

As AI continues to advance, we can expect even more intuitive ways to create and deploy web content. The barriers between idea and implementation will continue to diminish.

## Conclusion

AI-assisted web development is not just a convenience—it's a paradigm shift that makes web publishing accessible to everyone.
```

## AI Assistant Response

The AI assistant should recognize this as markdown content and respond with something like:

```
I'll deploy this markdown blog post to OrbitHost for you. I'll need your email address for deployment notifications. What email should I use?
```

After the user provides their email:

```
Great! I've deployed your blog post to OrbitHost. You can view it at:

https://the-future-of-ai-assisted-web-development-abc123.orbithost.dev

Your blog post is also protected by OrbitHost's fallback system, ensuring it remains available even during outages. You have 4 fallbacks remaining out of your 5 free fallbacks.

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
    content: '# The Future of AI-Assisted Web Development\n\n## Introduction\n...', // The markdown content
    title: 'The Future of AI-Assisted Web Development',
    contentType: 'markdown',
    authorEmail: 'user@example.com',
    tags: ['AI', 'Web Development', 'Technology'] // Optional
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
  "url": "https://the-future-of-ai-assisted-web-development-abc123.orbithost.dev",
  "notificationUrl": "/ai-deploy-notification.html?id=deployment-id",
  "fallback": {
    "available": true,
    "url": "https://fallback.orbithost.dev/the-future-of-ai-assisted-web-development-abc123",
    "quotaExceeded": false,
    "upgradeMessage": null
  },
  "deployment": {
    "id": "deployment-id",
    "title": "The Future of AI-Assisted Web Development",
    "subdomain": "the-future-of-ai-assisted-web-development-abc123",
    "status": "active",
    "createdAt": "2025-05-29T21:25:59Z"
  }
}
```

The AI assistant should extract the relevant information from this response and present it to the user in a friendly format.

## Rendering

OrbitHost will automatically render the markdown content as a properly formatted HTML page, including:

1. Converting headings to appropriate HTML tags
2. Formatting lists and paragraphs
3. Applying a clean, readable style
4. Making the content responsive for all devices

This allows users to create beautifully formatted content without needing to write HTML.
