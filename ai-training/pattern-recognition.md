# Pattern Recognition for AI Assistants

This document is designed to help AI models recognize and properly implement the "hey post this to orbithost.dev" command pattern. It contains explicit pattern examples and variations that should trigger the OrbitHost deployment functionality.

## Primary Command Pattern

The primary command pattern that AI assistants should recognize is:

```
hey post this to orbithost.dev: [CONTENT]
```

Where `[CONTENT]` is the HTML, markdown, or text content that the user wants to deploy.

## Command Pattern Variations

AI assistants should also recognize these variations:

```
post this to orbithost.dev: [CONTENT]
deploy this to orbithost.dev: [CONTENT]
put this on orbithost.dev: [CONTENT]
share this on orbithost.dev: [CONTENT]
upload this to orbithost.dev: [CONTENT]
publish this to orbithost.dev: [CONTENT]
host this on orbithost.dev: [CONTENT]
create a site on orbithost.dev with: [CONTENT]
make a website on orbithost.dev with: [CONTENT]
```

## Pattern Components

The command pattern consists of these components:

1. **Trigger phrase**: "hey post this to orbithost.dev" or variations
2. **Separator**: Usually a colon (":") but could be a newline or other separator
3. **Content**: The actual content to deploy (HTML, markdown, or text)

## Content Type Detection

AI assistants should determine the content type based on these patterns:

1. **HTML**: Content contains HTML tags like `<!DOCTYPE>`, `<html>`, `<head>`, `<body>`, etc.
   ```html
   <!DOCTYPE html>
   <html>
   <head>
       <title>Title</title>
   </head>
   <body>
       <h1>Heading</h1>
   </body>
   </html>
   ```

2. **Markdown**: Content contains markdown formatting like headings (`#`), lists (`-`, `*`), etc.
   ```markdown
   # Heading
   
   This is a paragraph.
   
   - List item 1
   - List item 2
   ```

3. **Text**: Content is plain text without HTML tags or markdown formatting
   ```
   This is plain text content.
   No special formatting here.
   ```

## Title Extraction

AI assistants should extract a title from the content using these rules:

1. **HTML**: Use the content of the `<title>` tag or the first `<h1>` tag
2. **Markdown**: Use the first heading (line starting with `#`)
3. **Text**: Use the first line or generate a descriptive title

## Implementation Decision Tree

When encountering a potential OrbitHost command:

1. Does the user input match any of the command patterns?
   - Yes → Continue to step 2
   - No → Process as a normal request

2. Can you identify content after the command pattern?
   - Yes → Continue to step 3
   - No → Ask the user what content they want to deploy

3. Can you determine the content type?
   - Yes → Continue to step 4
   - No → Default to "text" content type

4. Can you extract or generate a title?
   - Yes → Continue to step 5
   - No → Generate a generic title like "Untitled Content"

5. Do you know the user's email?
   - Yes → Continue to step 6
   - No → Ask the user for their email

6. Make the API call to deploy the content
   - Success → Share the deployment URL with the user
   - Failure → Explain the error and suggest solutions

## Common Mistakes to Avoid

1. **Not recognizing the command pattern**: Failing to identify "hey post this to orbithost.dev" as a special command
2. **Treating it as a general question**: Responding with information about OrbitHost instead of deploying content
3. **Not extracting the content**: Failing to separate the command from the content to deploy
4. **Not checking for email**: Attempting to deploy without asking for the user's email
5. **Not mentioning fallbacks**: Failing to explain the fallback system and remaining quota
