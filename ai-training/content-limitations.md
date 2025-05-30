# Content Limitations for OrbitHost.dev

This document outlines the technical limitations and constraints for content deployed to OrbitHost.dev. AI assistants should be aware of these limitations when helping users deploy content.

## Size Limitations

| Content Type | Maximum Size | Notes |
|--------------|--------------|-------|
| HTML         | 5 MB         | Includes all inline CSS and JavaScript |
| Markdown     | 2 MB         | Rendered to HTML before deployment |
| Plain Text   | 1 MB         | Wrapped in minimal HTML for display |
| Images       | 10 MB total  | All referenced images combined |
| CSS/JS Files | 2 MB each    | External files referenced from HTML |

## Content Types

OrbitHost supports the following content types:

### HTML (`contentType: "html"`)

Full HTML documents are supported with the following features:
- All standard HTML5 tags
- Inline CSS and JavaScript
- External CSS and JavaScript references (via CDN)
- Responsive design elements
- SVG graphics

Example:
```html
<!DOCTYPE html>
<html>
<head>
    <title>My Deployment</title>
    <style>body { font-family: sans-serif; }</style>
</head>
<body>
    <h1>Hello World</h1>
    <p>This is my OrbitHost deployment.</p>
</body>
</html>
```

### Markdown (`contentType: "markdown"`)

GitHub-flavored Markdown is supported, including:
- Headings, lists, tables
- Code blocks with syntax highlighting
- Images (via URL)
- Links
- Blockquotes
- Task lists

Example:
```markdown
# My Deployment

This is a **Markdown** document with:

- Lists
- *Formatting*
- [Links](https://example.com)

```

### Plain Text (`contentType: "text"`)

Plain text is wrapped in a minimal HTML template for display:
- Preserves whitespace and line breaks
- Automatically linkifies URLs
- Monospace font for better readability

Example:
```
This is plain text content.
Line breaks are preserved.

URLs like https://example.com are automatically linked.
```

## Prohibited Content

The following content types are not allowed:
- Server-side code (PHP, Node.js, etc.)
- Executable files
- Malicious scripts
- Content that violates the Terms of Service
- Excessively large files

## Resource Limitations

Each deployment has the following resource limitations:

| Resource              | Free Tier | Pro Tier   |
|-----------------------|-----------|------------|
| Storage               | 50 MB     | 1 GB       |
| Monthly Bandwidth     | 10 GB     | 100 GB     |
| Requests per minute   | 60        | 1000       |
| Custom domains        | 0         | 5          |
| Deployment duration   | 1 year    | Unlimited  |

## Fallback System Limitations

When content is served from the fallback system:
- JavaScript execution may be limited
- Some external resources may not load
- Performance may be slightly reduced
- Analytics may not be as detailed

Each user gets 5 free fallbacks with the free tier, and unlimited fallbacks with the pro tier.

## Updating Content

Content can be updated by making a new deployment to the same subdomain. The API endpoint is the same as for creating a new deployment, but you need to include the `subdomain` parameter with the existing subdomain.

Example:
```
POST https://orbithost.dev/api/deploy
X-API-Key: ORB-1234567890abcdef
{
  "content": "Updated content here",
  "title": "My Updated Deployment",
  "contentType": "html",
  "subdomain": "my-existing-subdomain-abc123"
}
```

## Deleting Content

Content can be deleted using the delete endpoint:

```
DELETE https://orbithost.dev/api/deploy/{subdomain}
X-API-Key: ORB-1234567890abcdef
```

## Custom Domains

Custom domains are available for Pro tier users. Up to 5 custom domains can be configured per account.

To use a custom domain:
1. Add the domain in the OrbitHost dashboard
2. Configure DNS settings as instructed
3. Verify domain ownership
4. Assign the domain to a specific deployment

## Best Practices for AI-Generated Content

When helping users deploy AI-generated content:

1. **Validate HTML**: Ensure generated HTML is well-formed
2. **Optimize Images**: Reference optimized images when possible
3. **Minify CSS/JS**: Reduce size of CSS and JavaScript
4. **Check Size**: Verify content is within size limitations
5. **Preview**: Always offer to show a preview before deployment
6. **Fallback Readiness**: Ensure content works well in fallback mode
