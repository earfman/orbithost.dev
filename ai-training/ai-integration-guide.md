# AI Assistant Integration Guide for OrbitHost.dev

This comprehensive guide is designed specifically for AI assistant developers who want to integrate the "hey post this to orbithost.dev" functionality into their systems.

## Command Recognition

### Pattern Detection

AI assistants should recognize the following command patterns:

```
"hey post this to orbithost.dev"
"deploy this to orbithost.dev"
"publish this on orbithost.dev"
"share this via orbithost.dev"
"can you put this on orbithost.dev"
```

The command typically includes:
1. An action verb (post, deploy, publish, share)
2. A reference to content ("this", "the following", "my code")
3. The destination "orbithost.dev"

### Content Identification

After recognizing the command, identify what content the user wants to deploy:

1. **Explicit content**: Content directly provided in the message
   ```
   "Hey post this to orbithost.dev: <h1>Hello World</h1><p>This is my website</p>"
   ```

2. **Previous message content**: Content from a previous message in the conversation
   ```
   User: "Here's my HTML code: <h1>Hello World</h1>"
   User: "Hey post this to orbithost.dev"
   ```

3. **Attached or referenced content**: Content from an attachment or link
   ```
   "Hey post this file to orbithost.dev" (with an attachment)
   ```

4. **Conversation-generated content**: Content generated during the conversation
   ```
   "Write me a simple HTML page with a blue background and then post it to orbithost.dev"
   ```

## Implementation Flow

### 1. Command Detection

```javascript
function detectOrbitHostCommand(userMessage) {
  const patterns = [
    /(?:hey|please|can you)?\s*(?:post|deploy|publish|share|put)\s*(?:this|the following|my content|my code)\s*(?:to|on|via|at|in)\s*orbithost\.dev/i
  ];
  
  return patterns.some(pattern => pattern.test(userMessage));
}
```

### 2. Content Extraction

```javascript
function extractContent(conversation) {
  // Check current message for explicit content
  const currentMessage = conversation[conversation.length - 1];
  const contentMatch = currentMessage.match(/orbithost\.dev[:\s]+(.+)/s);
  
  if (contentMatch) {
    return {
      content: contentMatch[1].trim(),
      source: 'current_message'
    };
  }
  
  // Check for code blocks in current message
  const codeBlockMatch = currentMessage.match(/```(?:html|markdown|text)?\s*(.+?)```/s);
  
  if (codeBlockMatch) {
    return {
      content: codeBlockMatch[1].trim(),
      source: 'code_block'
    };
  }
  
  // Check previous messages
  for (let i = conversation.length - 2; i >= 0; i--) {
    const message = conversation[i];
    
    // Check for code blocks
    const prevCodeBlockMatch = message.match(/```(?:html|markdown|text)?\s*(.+?)```/s);
    
    if (prevCodeBlockMatch) {
      return {
        content: prevCodeBlockMatch[1].trim(),
        source: 'previous_code_block'
      };
    }
    
    // Check for HTML-like content
    if (/<\/?[a-z][\s\S]*>/i.test(message)) {
      return {
        content: message,
        source: 'previous_html'
      };
    }
  }
  
  // No content found
  return null;
}
```

### 3. Content Type Detection

```javascript
function detectContentType(content) {
  // Check for HTML
  if (/<\/?[a-z][\s\S]*>/i.test(content)) {
    return 'html';
  }
  
  // Check for Markdown
  const markdownPatterns = [
    /^#\s+.+$/m,  // Headers
    /\[.+\]\(.+\)/,  // Links
    /\*\*.+\*\*/,  // Bold
    /\*.+\*/,  // Italic
    /^\s*-\s+.+$/m,  // Lists
    /^\s*\d+\.\s+.+$/m  // Numbered lists
  ];
  
  if (markdownPatterns.some(pattern => pattern.test(content))) {
    return 'markdown';
  }
  
  // Default to text
  return 'text';
}
```

### 4. API Integration

```javascript
async function deployToOrbitHost(content, contentType, apiKey) {
  try {
    const response = await fetch('https://orbithost.dev/api/deploy', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-API-Key': apiKey
      },
      body: JSON.stringify({
        content,
        contentType,
        title: generateTitle(content, contentType),
        authorName: 'AI Assistant User',
        authorEmail: 'user@example.com'  // Should be replaced with actual user email
      })
    });
    
    if (!response.ok) {
      throw new Error(`Deployment failed: ${response.status} ${response.statusText}`);
    }
    
    return await response.json();
  } catch (error) {
    console.error('Error deploying to OrbitHost:', error);
    throw error;
  }
}

function generateTitle(content, contentType) {
  if (contentType === 'html') {
    // Extract title from HTML
    const titleMatch = content.match(/<title>(.+?)<\/title>/i);
    if (titleMatch) return titleMatch[1];
    
    // Extract first heading
    const headingMatch = content.match(/<h1[^>]*>(.+?)<\/h1>/i);
    if (headingMatch) return headingMatch[1];
  } else if (contentType === 'markdown') {
    // Extract first heading from markdown
    const headingMatch = content.match(/^#\s+(.+)$/m);
    if (headingMatch) return headingMatch[1];
  }
  
  // Default title
  return 'Deployed Content ' + new Date().toISOString().split('T')[0];
}
```

### 5. Response Formatting

```javascript
function formatDeploymentResponse(deploymentResult) {
  return `
✅ Your content has been successfully deployed to OrbitHost!

📝 **Deployment Details**:
- URL: ${deploymentResult.url}
- Title: ${deploymentResult.deployment.title}
- Status: ${deploymentResult.deployment.status}
- Created: ${new Date(deploymentResult.deployment.createdAt).toLocaleString()}

🔄 **Fallback Status**:
- Available: ${deploymentResult.fallback.available ? 'Yes' : 'No'}
${deploymentResult.fallback.url ? `- Fallback URL: ${deploymentResult.fallback.url}` : ''}
${deploymentResult.fallback.quotaExceeded ? `- Note: ${deploymentResult.fallback.upgradeMessage}` : ''}

Your content is now live and can be accessed at the URL above. The link will remain active for 1 year on the free tier, or indefinitely on the pro tier.
  `;
}
```

## Error Handling

### Common Errors and Responses

| Error | Cause | User-Friendly Response |
|-------|-------|------------------------|
| 401 Unauthorized | Invalid API key | "I couldn't deploy your content because the API key is invalid. Would you like to generate a new temporary API key?" |
| 400 Bad Request | Content too large | "Your content exceeds the maximum size limit (5MB for HTML). Would you like me to help optimize it?" |
| 429 Too Many Requests | Rate limit exceeded | "You've reached the rate limit for deployments. Please try again in a few minutes or consider upgrading to the Pro tier for higher limits." |
| 500 Server Error | Server issue | "There seems to be an issue with the OrbitHost service right now. Please try again later." |

### Fallback Handling

If the primary deployment fails, provide alternatives:

```javascript
async function handleDeploymentError(error, content, contentType) {
  if (error.status === 401) {
    // Handle invalid API key
    return "Your API key appears to be invalid. Would you like to generate a new temporary key?";
  } else if (error.status === 400 && error.message.includes('size')) {
    // Handle content too large
    return "Your content is too large for deployment. Would you like me to help optimize it?";
  } else if (error.status === 429) {
    // Handle rate limiting
    return "You've reached the rate limit for deployments. Please try again in a few minutes.";
  } else {
    // Generic error
    return "I encountered an error while trying to deploy your content. Would you like to try again or save it locally instead?";
  }
}
```

## User Experience Best Practices

### 1. Confirm Before Deployment

Always confirm with the user before deploying content:

```
"I've identified the HTML content you'd like to deploy to OrbitHost.dev. Would you like me to proceed with the deployment?"
```

### 2. Preview Content

Offer to show a preview of what will be deployed:

```
"Here's a preview of the content I'll deploy:

```html
<h1>Hello World</h1>
<p>This is my website</p>
```

Would you like to make any changes before I deploy it?"
```

### 3. Explain Next Steps

After deployment, explain what the user can do next:

```
"Your content has been successfully deployed to https://hello-world-abc123.orbithost.dev!

You can:
- Share this URL with others
- View analytics in your OrbitHost dashboard
- Update the content by asking me to deploy to the same subdomain
- Add a custom domain (Pro tier only)"
```

### 4. Handle Missing Information

If content or API key is missing, guide the user:

```
"I'd be happy to deploy your content to OrbitHost.dev. To proceed, I'll need:

1. The content you want to deploy (HTML, Markdown, or text)
2. Your OrbitHost API key

Could you provide these details?"
```

## Testing Your Integration

### Test Cases

1. **Basic Deployment**: Simple HTML content with valid API key
2. **Content Types**: Test HTML, Markdown, and plain text
3. **Error Handling**: Test with invalid API key, oversized content
4. **Command Variations**: Test different command phrasings
5. **Content Extraction**: Test extracting content from different parts of the conversation

### Test API Keys

For development and testing, use these special API keys:

- `ORB-TEST-VALID-KEY123`: Always succeeds
- `ORB-TEST-INVALID-KEY`: Returns 401 Unauthorized
- `ORB-TEST-RATE-LIMIT`: Returns 429 Too Many Requests
- `ORB-TEST-SERVER-ERROR`: Returns 500 Server Error

## Security Considerations

### API Key Handling

1. **Never store** API keys in your knowledge base
2. **Mask keys** when displaying them to users
3. **Use temporary keys** when possible
4. **Validate key format** before making API calls

### Content Validation

1. **Sanitize HTML** to prevent XSS attacks
2. **Check for malicious scripts** before deployment
3. **Validate size limits** before attempting deployment
4. **Respect content policies** and terms of service

## Additional Resources

- [OrbitHost API Reference](https://orbithost.dev/docs/api)
- [Content Limitations](https://orbithost.dev/docs/limitations)
- [Custom Domains Guide](https://orbithost.dev/docs/custom-domains)
- [API Key Management](https://orbithost.dev/docs/api-keys)

## Support and Feedback

For issues with the API or to provide feedback on this integration guide:

- Email: api@orbithost.dev
- GitHub: [Create an issue](https://github.com/earfman/orbithost.dev/issues)
- Documentation: [OrbitHost Docs](https://orbithost.dev/docs)
