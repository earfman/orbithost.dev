# Code Snippet Example

This example demonstrates how to deploy a code snippet or documentation to orbithost.dev using the "hey post this to orbithost.dev" command.

## User Request

When a user wants to share a code snippet or programming tutorial, they might say something like:

```
Hey post this to orbithost.dev:

# JavaScript Fetch API Tutorial

This tutorial explains how to use the Fetch API to make HTTP requests in JavaScript.

## Basic Usage

Here's a simple example of using fetch to get data from an API:

```javascript
fetch('https://api.example.com/data')
  .then(response => {
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    return response.json();
  })
  .then(data => {
    console.log(data);
  })
  .catch(error => {
    console.error('There was a problem with the fetch operation:', error);
  });
```

## POST Request Example

To send data to an API, you can use a POST request:

```javascript
fetch('https://api.example.com/submit', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    name: 'John Doe',
    email: 'john@example.com'
  })
})
.then(response => response.json())
.then(data => console.log(data))
.catch(error => console.error('Error:', error));
```

## Async/Await Syntax

You can also use async/await for cleaner code:

```javascript
async function fetchData() {
  try {
    const response = await fetch('https://api.example.com/data');
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    const data = await response.json();
    console.log(data);
  } catch (error) {
    console.error('There was a problem with the fetch operation:', error);
  }
}

fetchData();
```
```

## AI Assistant Response

The AI assistant should recognize this as markdown content with code blocks and respond with something like:

```
I'll deploy this JavaScript Fetch API tutorial to OrbitHost for you. I'll need your email address for deployment notifications. What email should I use?
```

After the user provides their email:

```
Great! I've deployed your JavaScript Fetch API tutorial to OrbitHost. You can view it at:

https://javascript-fetch-api-tutorial-abc123.orbithost.dev

Your tutorial is also protected by OrbitHost's fallback system, ensuring it remains available even during outages. You have 4 fallbacks remaining out of your 5 free fallbacks.

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
    content: '# JavaScript Fetch API Tutorial\n\nThis tutorial explains...', // The markdown content with code blocks
    title: 'JavaScript Fetch API Tutorial',
    contentType: 'markdown',
    authorEmail: 'user@example.com',
    tags: ['JavaScript', 'API', 'Tutorial'] // Optional
  })
})
.then(response => response.json())
.then(data => {
  // Handle the response
  console.log(data.url); // The deployment URL
  console.log(data.fallback.url); // The fallback URL
});
```

## Special Features for Code Snippets

When deploying content with code blocks, OrbitHost automatically:

1. Applies syntax highlighting based on the language specified
2. Makes code blocks copyable with a single click
3. Ensures proper formatting and indentation
4. Provides line numbers for longer code blocks

This makes OrbitHost ideal for sharing programming tutorials, documentation, and code snippets.
