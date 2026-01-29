# Formbricks Cloud Deployment Guide

This guide will help you deploy Formbricks to a cloud platform for your own use.

## Prerequisites

- GitHub account
- Account on your chosen cloud platform (Railway, RepoCloud, or Zeabur)
- Basic understanding of environment variables

## Deployment Options

### Option 1: Railway (Recommended for ease of use)

Railway provides automatic deployments, databases, and environment management.

#### Steps:

1. **Visit Railway Template**
   - Go to: https://railway.app/template/formbricks
   - Click "Deploy Now"

2. **Configure Environment Variables**
   
   Required variables:
   ```
   WEBAPP_URL=https://your-app.railway.app
   NEXTAUTH_URL=https://your-app.railway.app
   ENCRYPTION_KEY=<generate with: openssl rand -hex 32>
   NEXTAUTH_SECRET=<generate with: openssl rand -hex 32>
   CRON_SECRET=<generate with: openssl rand -hex 32>
   DATABASE_URL=<auto-configured by Railway>
   ```

   Optional but recommended:
   ```
   EMAIL_VERIFICATION_DISABLED=1
   PASSWORD_RESET_DISABLED=1
   ```

3. **Deploy**
   - Railway will automatically provision PostgreSQL
   - Build and deploy the application
   - Provide you with a public URL

4. **Access Your Instance**
   - Visit the URL provided by Railway
   - Create your first account
   - Start creating surveys!

### Option 2: Zeabur

Zeabur offers similar one-click deployment.

#### Steps:

1. **Visit Zeabur Template**
   - Go to: https://zeabur.com/templates/OKNLMY
   - Click "Deploy"

2. **Configure Environment Variables**
   - Use the same variables as Railway (see above)
   - Zeabur will auto-configure database connection

3. **Deploy & Access**
   - Wait for build to complete
   - Access your instance via the provided URL

### Option 3: RepoCloud

1. **Visit RepoCloud**
   - Go to their Formbricks deployment page
   - Follow similar steps as Railway

## Environment Variables Guide

### Mandatory Variables

- `WEBAPP_URL`: The public URL where your Formbricks instance will be accessible
- `NEXTAUTH_URL`: Same as WEBAPP_URL
- `ENCRYPTION_KEY`: For encrypting sensitive data (32-byte hex string)
- `NEXTAUTH_SECRET`: For NextAuth.js session encryption (32-byte hex string)
- `CRON_SECRET`: For securing cron job endpoints (32-byte hex string)
- `DATABASE_URL`: PostgreSQL connection string (auto-configured on most platforms)

### Optional Variables

#### Email Setup (if you want email verification)
```
MAIL_FROM=noreply@yourdomain.com
MAIL_FROM_NAME=Your Company Surveys
SMTP_HOST=your-smtp-host
SMTP_PORT=587
SMTP_USER=your-smtp-username
SMTP_PASSWORD=your-smtp-password
EMAIL_VERIFICATION_DISABLED=0
PASSWORD_RESET_DISABLED=0
```

#### S3 Storage (for file uploads in serverless environments)
```
S3_ACCESS_KEY=your-access-key
S3_SECRET_KEY=your-secret-key
S3_REGION=us-east-1
S3_BUCKET_NAME=your-bucket-name
```

#### OAuth Providers
```
GITHUB_ID=your-github-oauth-id
GITHUB_SECRET=your-github-oauth-secret

GOOGLE_CLIENT_ID=your-google-client-id
GOOGLE_CLIENT_SECRET=your-google-client-secret
```

## Generating Secrets

Generate secure secrets using one of these methods:

### Using OpenSSL (Mac/Linux):
```bash
openssl rand -hex 32
```

### Using Node.js:
```bash
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

### Using Online Generator:
- Visit: https://generate-secret.vercel.app/32

## Post-Deployment Steps

1. **Create Admin Account**
   - Visit your deployed URL
   - Sign up with your email
   - The first account becomes the admin

2. **Configure Organization**
   - Set up your organization name
   - Invite team members if needed

3. **Create Your First Survey**
   - Explore templates
   - Create a survey
   - Start collecting responses!

## Custom Domain Setup

### Railway:
1. Go to your project settings
2. Add custom domain
3. Configure DNS records as instructed

### Zeabur:
1. Navigate to domain settings
2. Add your domain
3. Update DNS records

## Troubleshooting

### Build Failures
- Check environment variables are set correctly
- Ensure DATABASE_URL is properly configured
- Review build logs in your platform dashboard

### Database Connection Issues
- Verify DATABASE_URL format
- Check if PostgreSQL service is running
- Ensure database is accessible from the app

### Email Not Sending
- Verify SMTP credentials
- Check SMTP port and host
- Test with a simple SMTP testing tool first

## Updating Your Deployment

### Railway/Zeabur:
- Connect your GitHub repository
- Enable auto-deployments
- Push changes to trigger new deployments

## Security Best Practices

1. **Use strong secrets** - Generate unique 32-byte hex strings
2. **Enable HTTPS** - Most platforms provide this by default
3. **Restrict database access** - Use private networking when available
4. **Regular backups** - Set up automated database backups
5. **Update regularly** - Keep Formbricks updated to latest version

## Cost Estimates

### Railway:
- Free tier available
- Hobby plan: ~$5-10/month
- Pro plan: ~$20+/month based on usage

### Zeabur:
- Similar pricing to Railway
- Pay-as-you-go model

### RepoCloud:
- Check their pricing page for current rates

## Next Steps

- Customize your surveys
- Set up integrations (Slack, Notion, Zapier)
- Configure analytics
- Invite team members
- Explore advanced features

## Support

- Formbricks Documentation: https://formbricks.com/docs
- GitHub Issues: https://github.com/formbricks/formbricks/issues
- Community Discord: Check Formbricks website

## License

Formbricks is licensed under AGPLv3. For commercial use or white-labeling, contact Formbricks team.
