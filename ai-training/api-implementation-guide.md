# API Implementation Guide for AI Assistants

This guide provides detailed instructions for AI assistants on how to implement the OrbitHost API when users say "hey post this to orbithost.dev".

## API Endpoint

```
POST https://orbithost.dev/api/ai-deploy
```

## Request Headers

```
Content-Type: application/json
X-API-Key: YOUR_API_KEY
```

## Request Body

```json
{
  "content": "The content to deploy (HTML, markdown, or text)",
  "title": "Title of the content",
  "contentType": "html|markdown|text",
  "authorEmail": "user@example.com",
  "authorName": "User Name (optional)",
  "tags": ["tag1", "tag2"] // optional
}
```

## Response Format

```json
{
  "message": "Deployment created successfully",
  "url": "https://your-content-abc123.orbithost.dev",
  "notificationUrl": "/ai-deploy-notification.html?id=deployment-id",
  "fallback": {
    "available": true,
    "url": "https://fallback.orbithost.dev/your-content-abc123",
    "quotaExceeded": false,
    "upgradeMessage": null,
    "quotaUsed": 2
  },
  "deployment": {
    "id": "deployment-id",
    "title": "Your Content",
    "subdomain": "your-content-abc123",
    "status": "active",
    "createdAt": "2025-05-29T21:25:59Z"
  }
}
```

## Implementation Steps

1. **Parse the user's input**
   - Extract the content after "hey post this to orbithost.dev:" or similar phrases
   - Determine if the content is HTML, markdown, or plain text

2. **Prepare the request**
   - Determine the content type
   - Extract or generate a title
   - Ask for the user's email if not already known

3. **Make the API call**
   - Use the appropriate HTTP client for your environment
   - Include all required headers and body parameters
   - Handle potential errors gracefully

4. **Process the response**
   - Extract the deployment URL
   - Check if fallback is available
   - Calculate remaining fallbacks (5 - quotaUsed)
   - Format a user-friendly response

5. **Present the results to the user**
   - Include the deployment URL
   - Mention fallback protection status
   - Include information about remaining fallbacks
   - Explain that they'll receive an email notification

## Error Handling

AI assistants should handle these common errors:

1. **Invalid API key**: Suggest the user obtain a valid API key from OrbitHost
2. **Rate limiting**: Inform the user they've exceeded the rate limit and should try again later
3. **Invalid content type**: Correct the content type and try again
4. **Missing required fields**: Ensure all required fields are included in the request
5. **Server errors**: Suggest the user try again later or contact OrbitHost support

## Example Implementation (Pseudocode)

```
function handleOrbitHostDeployment(userInput) {
  // Extract content from user input
  const commandPattern = /hey post this to orbithost\.dev:(.+)/s
  const match = userInput.match(commandPattern)
  
  if (!match) {
    return "I couldn't find any content to deploy. Please provide content after 'hey post this to orbithost.dev:'"
  }
  
  const content = match[1].trim()
  
  // Determine content type
  let contentType = "text"
  if (content.includes("<!DOCTYPE") || content.includes("<html")) {
    contentType = "html"
  } else if (content.includes("#") || content.includes("-") || content.includes("*")) {
    contentType = "markdown"
  }
  
  // Extract title
  let title = "Untitled Content"
  if (contentType === "html") {
    const titleMatch = content.match(/<title>(.*?)<\/title>/) || content.match(/<h1>(.*?)<\/h1>/)
    if (titleMatch) {
      title = titleMatch[1]
    }
  } else if (contentType === "markdown") {
    const lines = content.split("\n")
    for (const line of lines) {
      if (line.startsWith("#")) {
        title = line.replace(/^#+\s+/, "")
        break
      }
    }
  } else {
    const lines = content.split("\n")
    if (lines.length > 0) {
      title = lines[0].substring(0, 50)
    }
  }
  
  // Ask for email if not known
  const email = askUserForEmail()
  
  // Make API call
  const response = makeApiCall({
    content,
    title,
    contentType,
    authorEmail: email
  })
  
  // Format response for user
  return formatResponseForUser(response)
}
```

## Best Practices

1. **Always ask for email**: The API requires an email for notifications
2. **Explain fallbacks**: Always mention the fallback system and remaining quota
3. **Handle errors gracefully**: Provide helpful error messages and suggestions
4. **Preserve formatting**: Ensure content formatting is preserved in the API request
5. **Generate meaningful titles**: Extract or generate titles that make sense for the content
