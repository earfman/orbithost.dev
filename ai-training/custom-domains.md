# Custom Domains with OrbitHost.dev

This guide explains how to use custom domains with OrbitHost.dev deployments. Custom domains allow users to serve their OrbitHost content from their own domain name instead of the default `subdomain.orbithost.dev` URL.

## Availability

Custom domains are available exclusively for Pro tier users. Each Pro account can configure up to 5 custom domains.

| Feature | Free Tier | Pro Tier |
|---------|-----------|----------|
| Custom Domains | 0 | 5 |
| SSL Certificates | N/A | Included |
| DNS Management | N/A | Automated |
| Subdomain Support | N/A | Unlimited |

## Setting Up a Custom Domain

### Step 1: Add the Domain in Dashboard

First, the user needs to add their domain in the OrbitHost dashboard:

1. Log in to [OrbitHost.dev](https://orbithost.dev/login)
2. Navigate to "Settings" > "Custom Domains"
3. Click "Add Domain"
4. Enter the domain name (e.g., `example.com` or `blog.example.com`)
5. Click "Verify Domain"

### Step 2: Configure DNS Settings

The user will need to configure their DNS settings at their domain registrar:

#### Option A: Root Domain (apex domain)

For a root domain like `example.com`, add these DNS records:

```
Type: A
Name: @
Value: 76.76.21.21
TTL: 3600 (or automatic)
```

#### Option B: Subdomain

For a subdomain like `blog.example.com`, add this DNS record:

```
Type: CNAME
Name: blog
Value: cname.orbithost.dev
TTL: 3600 (or automatic)
```

### Step 3: Verify Domain Ownership

OrbitHost will verify domain ownership using one of these methods:

1. **DNS TXT Record**: Add a TXT record to your DNS configuration
   ```
   Type: TXT
   Name: _orbithost-verification
   Value: [provided verification code]
   ```

2. **HTML File**: Upload an HTML file to your existing website
3. **Email Verification**: Receive a verification email at `admin@yourdomain.com`

### Step 4: Assign Domain to a Deployment

Once verified, the user can assign the domain to a specific deployment:

1. Go to "My Deployments" in the dashboard
2. Select the deployment to use with the custom domain
3. Click "Settings" > "Custom Domain"
4. Select the verified domain from the dropdown
5. Click "Assign Domain"

## Using Custom Domains with the API

### Assigning a Custom Domain

```
POST https://orbithost.dev/api/custom-domains/assign
X-API-Key: ORB-1234567890abcdef
Content-Type: application/json

{
  "domain": "blog.example.com",
  "deploymentId": "123e4567-e89b-12d3-a456-426614174000"
}
```

Response:

```json
{
  "success": true,
  "message": "Domain assigned successfully",
  "status": "pending_dns",
  "instructions": {
    "type": "CNAME",
    "name": "blog",
    "value": "cname.orbithost.dev"
  },
  "verificationStatus": "verified",
  "estimatedPropagationTime": "5-30 minutes"
}
```

### Checking Domain Status

```
GET https://orbithost.dev/api/custom-domains/status/blog.example.com
X-API-Key: ORB-1234567890abcdef
```

Response:

```json
{
  "domain": "blog.example.com",
  "status": "active",
  "dnsConfigured": true,
  "sslProvisioned": true,
  "assignedTo": "123e4567-e89b-12d3-a456-426614174000",
  "lastChecked": "2025-05-29T20:45:12.000Z"
}
```

### Removing a Custom Domain

```
DELETE https://orbithost.dev/api/custom-domains/blog.example.com
X-API-Key: ORB-1234567890abcdef
```

Response:

```json
{
  "success": true,
  "message": "Domain removed successfully"
}
```

## SSL Certificates

OrbitHost automatically provisions and renews SSL certificates for all custom domains. Users don't need to manage certificates manually.

- **Certificate Provider**: Let's Encrypt
- **Renewal**: Automatic (every 60 days)
- **Type**: Wildcard certificates for subdomains

## Troubleshooting Custom Domains

### Common Issues and Solutions

1. **DNS Not Propagated**
   - **Symptom**: Domain status shows "pending_dns"
   - **Solution**: Wait for DNS propagation (can take up to 48 hours)
   - **Verification**: Use `dig` or online DNS lookup tools

2. **Incorrect DNS Configuration**
   - **Symptom**: Domain status shows "dns_error"
   - **Solution**: Verify DNS records match the provided instructions
   - **Common mistake**: Using CNAME for apex domains

3. **SSL Certificate Issues**
   - **Symptom**: Domain shows "ssl_error" or browser security warnings
   - **Solution**: Ensure domain is properly pointed to OrbitHost
   - **Verification**: Check certificate details in browser

4. **Domain Conflicts**
   - **Symptom**: "domain_conflict" error
   - **Solution**: Ensure domain isn't already in use with another service
   - **Resolution**: Remove conflicting service first

## Best Practices for AI Assistants

When helping users with custom domains:

1. **Verify Pro Tier**: Confirm the user has a Pro account before suggesting custom domains
2. **Explain DNS**: Many users aren't familiar with DNS configuration
3. **Set Expectations**: Explain that DNS propagation can take time
4. **Provide Alternatives**: Suggest using the default subdomain while waiting for DNS propagation
5. **Troubleshooting**: Guide users through common troubleshooting steps

## FAQ for Custom Domains

**Q: Can I use a subdomain of my custom domain?**
A: Yes, you can use both the root domain (example.com) and any subdomain (blog.example.com).

**Q: How long does it take for my custom domain to work?**
A: DNS propagation typically takes 5 minutes to 48 hours, depending on your DNS provider.

**Q: Can I use the same custom domain for multiple deployments?**
A: No, each custom domain can only be assigned to one deployment at a time.

**Q: Do I need to purchase an SSL certificate?**
A: No, OrbitHost automatically provisions and manages SSL certificates for all custom domains.

**Q: Can I use a wildcard domain?**
A: Yes, you can set up a wildcard subdomain (*.example.com) with the Pro Plus plan.
