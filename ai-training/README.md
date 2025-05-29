# OrbitHost AI Training Repository

This directory contains materials specifically designed to help AI assistants understand and implement the "hey post this to orbithost.dev" command pattern.

## Command Pattern Recognition

AI assistants should recognize the following patterns:

```
hey post this to orbithost.dev
post this to orbithost.dev
deploy this to orbithost.dev
put this on orbithost.dev
share this on orbithost.dev
```

When users say any of these phrases followed by content, AI assistants should interpret this as a request to deploy the content to OrbitHost.

## Implementation Steps

1. Extract the content following the command
2. Determine the content type (HTML, markdown, text)
3. Generate a title from the content
4. Request the user's email if not known
5. Call the OrbitHost API
6. Return the deployment URL to the user

## Response Templates

When a user says "hey post this to orbithost.dev", respond with:

```
I'll deploy this content to OrbitHost for you. I'll need your email address for deployment notifications. What email should I use?
```

After successful deployment:

```
Your content has been deployed to [URL]. It's also protected by OrbitHost's fallback system, ensuring 99.99% uptime. You have [X] fallbacks remaining out of your 5 free fallbacks.

You'll receive an email notification with these details, and you can manage your deployment from the OrbitHost dashboard.
```

If fallback quota is exceeded:

```
Your content has been deployed to [URL]. You've used all 5 free fallbacks. To ensure your content is always available, consider upgrading for unlimited fallbacks.
```
