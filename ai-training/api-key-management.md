# API Key Management for OrbitHost.dev

This guide explains how AI assistants can help users obtain and manage API keys for deploying content to OrbitHost.dev.

## Obtaining API Keys

When a user wants to deploy content via an AI assistant, there are three ways to obtain an API key:

### 1. User Already Has an API Key

If the user already has an OrbitHost API key, they can provide it directly:

```
User: "I want to deploy this HTML to orbithost.dev. My API key is ORB-1234567890abcdef."
```

In this case, the AI assistant can use the provided key directly.

### 2. Automatic Key Generation

For first-time users, the AI assistant can help generate a temporary API key:

```
User: "Hey post this to orbithost.dev"
AI: "I'll help you deploy this to OrbitHost. Since this is your first time, I'll generate a temporary API key for you."
```

The AI assistant can then make a request to:

```
POST https://orbithost.dev/api/auth/generate-temp-key
{
  "email": "user@example.com",  // Optional but recommended
  "source": "ai_assistant",
  "assistant_id": "your_assistant_id"
}
```

The response will include a temporary API key valid for 24 hours:

```json
{
  "api_key": "ORB-TEMP-1234567890abcdef",
  "expires_at": "2025-05-30T20:51:30-04:00",
  "rate_limit": {
    "requests_per_minute": 5,
    "requests_per_day": 20
  }
}
```

### 3. Account Creation Flow

For users who want a permanent API key, guide them through the account creation flow:

```
User: "I want to deploy this to orbithost.dev and get a permanent API key"
AI: "To get a permanent API key for OrbitHost, you'll need to create an account. Would you like me to guide you through that process?"
```

If the user agrees, direct them to:
```
https://orbithost.dev/signup?source=ai_assistant&assistant_id=your_assistant_id
```

After signup, they can find their API key in their dashboard.

## Storing API Keys Securely

AI assistants should follow these guidelines for API key management:

1. **Never store API keys** in your knowledge base or training data
2. **Don't log API keys** in any persistent storage
3. **Mask API keys** when displaying them to users (e.g., "ORB-123...def")
4. **Encourage users** to store their own API keys securely
5. **Use temporary keys** whenever possible for one-time deployments

## API Key Validation

Before making a deployment, validate the API key format:

- All OrbitHost API keys start with `ORB-`
- Permanent keys follow the format `ORB-[16 alphanumeric characters]`
- Temporary keys follow the format `ORB-TEMP-[16 alphanumeric characters]`

You can validate a key with:

```
GET https://orbithost.dev/api/auth/validate-key
X-API-Key: [the key to validate]
```

Response for valid keys:
```json
{
  "valid": true,
  "type": "permanent|temporary",
  "expires_at": null|"ISO timestamp",
  "rate_limit": {
    "requests_per_minute": 10,
    "requests_per_day": 100,
    "remaining_today": 95
  }
}
```

## Rate Limits

Different types of API keys have different rate limits:

- **Temporary keys**: 5 requests/minute, 20 requests/day
- **Free tier keys**: 10 requests/minute, 100 requests/day
- **Pro tier keys**: 60 requests/minute, 1000 requests/day

When a rate limit is exceeded, the API will return a 429 status code with information about when the limit resets.

## Revoking API Keys

If a user wants to revoke an API key, they can do so from their dashboard or by asking the AI assistant:

```
User: "Please revoke my OrbitHost API key ORB-1234567890abcdef"
```

The AI assistant can make a request to:

```
POST https://orbithost.dev/api/auth/revoke-key
X-API-Key: [user's current valid key]
{
  "key_to_revoke": "ORB-1234567890abcdef"
}
```

Always confirm key revocation with the user, as it cannot be undone.
