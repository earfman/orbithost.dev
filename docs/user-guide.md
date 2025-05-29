# OrbitHost User Guide

Welcome to OrbitHost! This guide will help you get started with deploying content using AI assistants and managing your deployments.

## Deploying Content with AI

### The "Hey Post This to OrbitHost.dev" Command

The easiest way to deploy content to OrbitHost is by using the "hey post this to orbithost.dev" command with your AI assistant. Here's how it works:

1. Start a conversation with your AI assistant
2. Say "hey post this to orbithost.dev:" followed by your content
3. The AI will deploy your content and provide you with a URL

#### Example:

```
You: Hey post this to orbithost.dev:
# My Test Page

This is a simple test page that I'm deploying through my AI assistant.

## Features
- Instant deployment
- No technical knowledge required
- Automatic fallback protection
```

Your AI assistant will process this request, deploy your content to a unique subdomain on orbithost.dev, and provide you with the URL.

### Supported Content Types

OrbitHost supports three content types:

1. **HTML**: For full web pages with HTML markup
2. **Markdown**: For simple formatting (like the example above)
3. **Plain Text**: For unformatted text content

Your AI assistant will automatically detect the content type based on what you provide.

### Email Notifications

When you deploy content, you'll receive an email notification with:
- The URL of your deployment
- A link to view deployment details
- Information about fallback protection

## Managing Your Deployments

### My Deployments Dashboard

After deploying content, you can manage all your deployments from the "My Deployments" dashboard:

1. Go to https://orbithost.dev/dashboard
2. Log in with your account
3. Click on "My Deployments" in the navigation menu

From this dashboard, you can:
- View all your deployments
- Edit deployment details
- Delete deployments
- View deployment analytics

### User Account

To access all features of OrbitHost, you'll need to create an account:

1. Go to https://orbithost.dev/signup
2. Enter your email and password
3. Verify your email address
4. Log in to access your dashboard

## Fallback System

OrbitHost includes a robust fallback system to ensure your content is always available:

- **Free users**: 5 free fallbacks
- **Paid users**: Unlimited fallbacks

When your primary deployment is unavailable, users are automatically redirected to the fallback version of your content.

### How Fallbacks Work

1. When you deploy content, a simplified version is automatically created as a fallback
2. If your primary deployment becomes unavailable, the fallback is served instead
3. The transition is seamless for users visiting your content

### Upgrading for More Fallbacks

If you need more than 5 fallbacks:

1. Go to https://orbithost.dev/dashboard
2. Click on "Upgrade Plan"
3. Choose a paid plan that includes unlimited fallbacks
4. Complete the payment process

## Self-Hosting

If you want to run OrbitHost on your own infrastructure:

1. Go to https://orbithost.dev/self-hosting
2. Fill out the self-hosting request form
3. Our team will contact you with instructions

## Support

If you need help with OrbitHost:

- **Email**: support@orbithost.dev
- **Documentation**: https://orbithost.dev/docs
- **GitHub**: https://github.com/earfman/orbithost.dev

## FAQ

### Q: Is there a limit to how much content I can deploy?
A: Free users can deploy up to 100MB of content. Paid users have higher limits depending on their plan.

### Q: Can I use a custom domain?
A: Yes, paid plans include the ability to use custom domains.

### Q: How long does my content stay online?
A: Free deployments stay online for 30 days. Paid deployments stay online indefinitely.

### Q: Can I deploy dynamic content?
A: Currently, OrbitHost only supports static content (HTML, markdown, text). Dynamic functionality requires custom code.

### Q: How do I update my deployed content?
A: You can update content by deploying to the same title, or by using the edit feature in the dashboard.
