# API Implementation Examples

This document provides code examples for implementing the OrbitHost AI Deployment API in various programming languages. These examples are particularly useful for AI assistants that need to help users deploy content to orbithost.dev.

## JavaScript/Node.js

```javascript
// Using fetch (browser or Node.js with node-fetch)
async function deployToOrbitHost(content, title, contentType, authorEmail) {
  try {
    const response = await fetch('https://orbithost.dev/api/ai-deploy', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-API-Key': 'YOUR_API_KEY'
      },
      body: JSON.stringify({
        content,
        title,
        contentType, // 'html', 'markdown', or 'text'
        authorEmail,
        authorName: 'Optional Author Name',
        tags: ['tag1', 'tag2'] // optional
      })
    });
    
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
    
    const data = await response.json();
    return {
      deploymentUrl: data.url,
      fallbackUrl: data.fallback.url,
      fallbacksRemaining: 5 - data.fallback.quotaUsed
    };
  } catch (error) {
    console.error('Error deploying to OrbitHost:', error);
    throw error;
  }
}

// Example usage
deployToOrbitHost(
  '# Hello World\n\nThis is a test.',
  'Hello World',
  'markdown',
  'user@example.com'
)
.then(result => {
  console.log(`Deployed to: ${result.deploymentUrl}`);
  console.log(`Fallback URL: ${result.fallbackUrl}`);
  console.log(`Fallbacks remaining: ${result.fallbacksRemaining}`);
})
.catch(error => {
  console.error('Deployment failed:', error);
});
```

## Python

```python
import requests
import json

def deploy_to_orbithost(content, title, content_type, author_email, author_name=None, tags=None):
    """
    Deploy content to OrbitHost.dev
    
    Args:
        content (str): The content to deploy (HTML, markdown, or text)
        title (str): Title of the content
        content_type (str): Type of content ('html', 'markdown', or 'text')
        author_email (str): Email of the content author
        author_name (str, optional): Name of the content author
        tags (list, optional): List of tags for the content
        
    Returns:
        dict: Deployment information including URLs
    """
    url = "https://orbithost.dev/api/ai-deploy"
    
    payload = {
        "content": content,
        "title": title,
        "contentType": content_type,
        "authorEmail": author_email
    }
    
    if author_name:
        payload["authorName"] = author_name
        
    if tags:
        payload["tags"] = tags
    
    headers = {
        "Content-Type": "application/json",
        "X-API-Key": "YOUR_API_KEY"
    }
    
    try:
        response = requests.post(url, headers=headers, data=json.dumps(payload))
        response.raise_for_status()  # Raise exception for 4XX/5XX responses
        
        data = response.json()
        
        return {
            "deployment_url": data["url"],
            "fallback_url": data["fallback"]["url"] if data["fallback"]["available"] else None,
            "fallbacks_remaining": 5 - data.get("fallback", {}).get("quotaUsed", 0)
        }
    
    except requests.exceptions.RequestException as e:
        print(f"Error deploying to OrbitHost: {e}")
        raise

# Example usage
try:
    result = deploy_to_orbithost(
        content="# Hello World\n\nThis is a test.",
        title="Hello World",
        content_type="markdown",
        author_email="user@example.com",
        tags=["test", "example"]
    )
    
    print(f"Deployed to: {result['deployment_url']}")
    print(f"Fallback URL: {result['fallback_url']}")
    print(f"Fallbacks remaining: {result['fallbacks_remaining']}")
    
except Exception as e:
    print(f"Deployment failed: {e}")
```

## Ruby

```ruby
require 'net/http'
require 'uri'
require 'json'

def deploy_to_orbithost(content, title, content_type, author_email, author_name: nil, tags: nil)
  uri = URI.parse('https://orbithost.dev/api/ai-deploy')
  
  payload = {
    content: content,
    title: title,
    contentType: content_type,
    authorEmail: author_email
  }
  
  payload[:authorName] = author_name if author_name
  payload[:tags] = tags if tags
  
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  
  request = Net::HTTP::Post.new(uri.request_uri)
  request['Content-Type'] = 'application/json'
  request['X-API-Key'] = 'YOUR_API_KEY'
  request.body = payload.to_json
  
  begin
    response = http.request(request)
    
    if response.code.to_i >= 400
      raise "HTTP Error: #{response.code} - #{response.body}"
    end
    
    data = JSON.parse(response.body)
    
    {
      deployment_url: data['url'],
      fallback_url: data['fallback']['available'] ? data['fallback']['url'] : nil,
      fallbacks_remaining: 5 - (data['fallback']['quotaUsed'] || 0)
    }
  rescue => e
    puts "Error deploying to OrbitHost: #{e.message}"
    raise
  end
end

# Example usage
begin
  result = deploy_to_orbithost(
    "# Hello World\n\nThis is a test.",
    "Hello World",
    "markdown",
    "user@example.com",
    tags: ["test", "example"]
  )
  
  puts "Deployed to: #{result[:deployment_url]}"
  puts "Fallback URL: #{result[:fallback_url]}"
  puts "Fallbacks remaining: #{result[:fallbacks_remaining]}"
rescue => e
  puts "Deployment failed: #{e.message}"
end
```

## Java

```java
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper;

public class OrbitHostClient {
    
    private static final String API_URL = "https://orbithost.dev/api/ai-deploy";
    private static final String API_KEY = "YOUR_API_KEY";
    
    public static Map<String, Object> deployToOrbitHost(
            String content, 
            String title, 
            String contentType, 
            String authorEmail, 
            String authorName, 
            List<String> tags) throws IOException, InterruptedException {
        
        ObjectMapper mapper = new ObjectMapper();
        
        Map<String, Object> payload = new HashMap<>();
        payload.put("content", content);
        payload.put("title", title);
        payload.put("contentType", contentType);
        payload.put("authorEmail", authorEmail);
        
        if (authorName != null) {
            payload.put("authorName", authorName);
        }
        
        if (tags != null && !tags.isEmpty()) {
            payload.put("tags", tags);
        }
        
        String requestBody = mapper.writeValueAsString(payload);
        
        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(API_URL))
                .header("Content-Type", "application/json")
                .header("X-API-Key", API_KEY)
                .POST(HttpRequest.BodyPublishers.ofString(requestBody))
                .build();
        
        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
        
        if (response.statusCode() >= 400) {
            throw new IOException("HTTP Error: " + response.statusCode() + " - " + response.body());
        }
        
        Map<String, Object> responseData = mapper.readValue(response.body(), Map.class);
        Map<String, Object> fallback = (Map<String, Object>) responseData.get("fallback");
        
        Map<String, Object> result = new HashMap<>();
        result.put("deploymentUrl", responseData.get("url"));
        result.put("fallbackUrl", fallback.get("available").equals(true) ? fallback.get("url") : null);
        
        Integer quotaUsed = fallback.containsKey("quotaUsed") ? (Integer) fallback.get("quotaUsed") : 0;
        result.put("fallbacksRemaining", 5 - quotaUsed);
        
        return result;
    }
    
    public static void main(String[] args) {
        try {
            Map<String, Object> result = deployToOrbitHost(
                "# Hello World\n\nThis is a test.",
                "Hello World",
                "markdown",
                "user@example.com",
                null,
                List.of("test", "example")
            );
            
            System.out.println("Deployed to: " + result.get("deploymentUrl"));
            System.out.println("Fallback URL: " + result.get("fallbackUrl"));
            System.out.println("Fallbacks remaining: " + result.get("fallbacksRemaining"));
            
        } catch (Exception e) {
            System.err.println("Deployment failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
```

## PHP

```php
<?php

function deployToOrbitHost($content, $title, $contentType, $authorEmail, $authorName = null, $tags = null) {
    $url = 'https://orbithost.dev/api/ai-deploy';
    
    $payload = [
        'content' => $content,
        'title' => $title,
        'contentType' => $contentType,
        'authorEmail' => $authorEmail
    ];
    
    if ($authorName) {
        $payload['authorName'] = $authorName;
    }
    
    if ($tags) {
        $payload['tags'] = $tags;
    }
    
    $ch = curl_init($url);
    
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payload));
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Content-Type: application/json',
        'X-API-Key: YOUR_API_KEY'
    ]);
    
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    
    if (curl_errno($ch)) {
        $error = curl_error($ch);
        curl_close($ch);
        throw new Exception("cURL Error: $error");
    }
    
    curl_close($ch);
    
    if ($httpCode >= 400) {
        throw new Exception("HTTP Error: $httpCode - $response");
    }
    
    $data = json_decode($response, true);
    
    $quotaUsed = isset($data['fallback']['quotaUsed']) ? $data['fallback']['quotaUsed'] : 0;
    
    return [
        'deploymentUrl' => $data['url'],
        'fallbackUrl' => $data['fallback']['available'] ? $data['fallback']['url'] : null,
        'fallbacksRemaining' => 5 - $quotaUsed
    ];
}

// Example usage
try {
    $result = deployToOrbitHost(
        "# Hello World\n\nThis is a test.",
        "Hello World",
        "markdown",
        "user@example.com",
        null,
        ["test", "example"]
    );
    
    echo "Deployed to: " . $result['deploymentUrl'] . "\n";
    echo "Fallback URL: " . $result['fallbackUrl'] . "\n";
    echo "Fallbacks remaining: " . $result['fallbacksRemaining'] . "\n";
    
} catch (Exception $e) {
    echo "Deployment failed: " . $e->getMessage() . "\n";
}
```

## Implementation Notes for AI Assistants

When implementing the OrbitHost API in your responses:

1. **Replace the API Key**: Always instruct users to replace `'YOUR_API_KEY'` with their actual API key
2. **Content Type Detection**: Help users determine the appropriate content type based on their content
3. **Error Handling**: Implement proper error handling to provide useful feedback
4. **Fallback Information**: Always include information about the fallback system and remaining quota
5. **User Experience**: Format your responses to clearly show the deployment URL and next steps

These examples can be adapted for various programming languages and frameworks to help users integrate the "hey post this to orbithost.dev" feature into their applications.
