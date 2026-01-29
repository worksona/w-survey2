# Formbricks Railway Deployment Guide

## Step-by-Step Deployment

### Step 1: Push to Your GitHub Repository

Since you have the Formbricks code locally, you need to push it to your own GitHub repository so Railway can deploy it.

1. Create a new repository on GitHub (e.g., `formbricks-deploy`)
2. Initialize and push your local code:

```bash
cd /Users/davidolsson/WORKSONA/w-survey2
git remote add origin https://github.com/YOUR_USERNAME/formbricks-deploy.git
git add .
git commit -m "Initial Formbricks setup"
git push -u origin main
```

### Step 2: Deploy on Railway

#### Option A: Deploy from Template (Easiest)
1. Visit: https://railway.app/template/formbricks
2. Click "Deploy Now"
3. Connect your GitHub account
4. Railway will automatically create a project with PostgreSQL database

#### Option B: Deploy from Your Repository
1. Go to: https://railway.app/new
2. Click "Deploy from GitHub repo"
3. Select your formbricks repository
4. Railway will detect the Next.js app automatically

### Step 3: Configure Environment Variables

After deployment starts, go to your Railway project:

1. Click on your `web` service
2. Go to the "Variables" tab
3. Add the following environment variables:

#### Required Variables:

```bash
# Application URLs (Railway will provide your actual domain)
WEBAPP_URL=https://${{RAILWAY_PUBLIC_DOMAIN}}
NEXTAUTH_URL=https://${{RAILWAY_PUBLIC_DOMAIN}}

# Your generated secrets
ENCRYPTION_KEY=your_first_secret_here
NEXTAUTH_SECRET=your_second_secret_here
CRON_SECRET=your_third_secret_here

# Database (automatically configured by Railway if you use their PostgreSQL)
DATABASE_URL=${{Postgres.DATABASE_URL}}

# Disable email features for quick start
EMAIL_VERIFICATION_DISABLED=1
PASSWORD_RESET_DISABLED=1

# Log level
LOG_LEVEL=info

# Email settings (minimal for startup)
MAIL_FROM=noreply@example.com
MAIL_FROM_NAME=Formbricks
SMTP_HOST=localhost
SMTP_PORT=1025
SMTP_USER=smtpUser
SMTP_PASSWORD=smtpPassword
```

### Step 4: Add PostgreSQL Database

If not automatically added:

1. In your Railway project dashboard
2. Click "+ New"
3. Select "Database" → "PostgreSQL"
4. Railway will automatically link it to your service
5. The `DATABASE_URL` will be auto-configured

### Step 5: Deploy and Wait

1. Railway will automatically start building
2. Build process takes 5-10 minutes
3. Watch the build logs in the "Deployments" tab
4. Once complete, Railway will provide a public URL

### Step 6: Access Your Instance

1. Click on "Settings" → "Public Networking"
2. Click "Generate Domain" if not already done
3. Visit your domain (e.g., `https://your-app.up.railway.app`)
4. Create your admin account!

## Important Railway Configuration

### Custom Domain (Optional)

1. In your service settings
2. Go to "Settings" → "Public Networking"
3. Add your custom domain
4. Configure DNS records as shown

### Environment Variable References

Railway supports variable references using `${{SERVICE.VARIABLE}}`:
- `${{RAILWAY_PUBLIC_DOMAIN}}` - Auto-generated domain
- `${{Postgres.DATABASE_URL}}` - PostgreSQL connection string

### Recommended Settings

1. **Auto-Deploy**: Enable in Settings → GitHub → "Deploy on Push"
2. **Health Checks**: Automatically configured for Next.js
3. **Regions**: Choose closest to your users
4. **Instance**: Start with Hobby plan ($5/month)

## Troubleshooting

### Build Failures

**Check Build Logs:**
```
- Missing environment variables
- Node version compatibility (should use Node 18+)
- Database connection issues
```

**Common Fixes:**
- Ensure all required env vars are set
- Check DATABASE_URL is properly referenced
- Verify secrets are 32-character hex strings

### Database Connection Errors

1. Check PostgreSQL service is running
2. Verify `DATABASE_URL` variable is correct
3. Check connection string format:
   ```
   postgresql://user:password@host:5432/dbname
   ```

### Application Not Starting

1. Check deployment logs for errors
2. Verify `WEBAPP_URL` and `NEXTAUTH_URL` match your domain
3. Ensure all required secrets are set

### "Service Unavailable" Error

- Wait 1-2 minutes after deployment
- Check if build completed successfully
- Review health check logs

## Database Migration

Railway automatically runs Prisma migrations on deployment. If you need to manually migrate:

1. Go to your service
2. Open "Settings" → "Raw Editor"
3. Check build command includes migrations

## Monitoring

### View Logs:
1. Click on your service
2. Go to "Observability" tab
3. Real-time logs available

### Metrics:
- CPU usage
- Memory usage
- Request counts
- Response times

## Scaling

### Vertical Scaling:
1. Settings → Resources
2. Upgrade instance size as needed

### Database:
1. Click PostgreSQL service
2. Upgrade plan for more storage/connections

## Backups

### Database Backups:
1. Railway Pro plan includes automated backups
2. Manual backup: Use pg_dump via Railway CLI

```bash
railway run pg_dump $DATABASE_URL > backup.sql
```

## Cost Estimation

### Hobby Plan (~$5-10/month):
- Web service: $5/month
- PostgreSQL: Included
- Bandwidth: 100GB included

### Pro Plan (scales based on usage):
- Pay for what you use
- Better performance
- More resources

## Security Best Practices

1. ✅ Use strong 32-character secrets
2. ✅ Enable Railway's automatic HTTPS
3. ✅ Restrict database access (Railway private networking)
4. ✅ Regular updates (enable auto-deploy)
5. ✅ Monitor logs for suspicious activity

## Next Steps After Deployment

1. **Create Admin Account**: First signup becomes admin
2. **Configure Organization**: Set up your team
3. **Create First Survey**: Use templates or start from scratch
4. **Set Up Integrations**: Slack, Notion, etc.
5. **Invite Team Members**: Collaborate on surveys

## Updating Formbricks

### Automatic Updates:
1. Enable "Deploy on Push" in Railway
2. Pull latest Formbricks changes:
   ```bash
   git remote add upstream https://github.com/formbricks/formbricks.git
   git fetch upstream
   git merge upstream/main
   git push origin main
   ```
3. Railway automatically deploys

### Manual Updates:
1. Make changes locally
2. Commit and push to GitHub
3. Railway automatically rebuilds

## Support Resources

- Railway Docs: https://docs.railway.app
- Formbricks Docs: https://formbricks.com/docs
- Railway Discord: https://discord.gg/railway
- Formbricks GitHub: https://github.com/formbricks/formbricks/issues

## Quick Reference Commands

```bash
# Install Railway CLI
npm i -g @railway/cli

# Login to Railway
railway login

# Link to project
railway link

# View logs
railway logs

# Run commands in Railway environment
railway run [command]

# Add environment variable
railway variables set KEY=value
```

## Environment Variables Checklist

Before deploying, ensure you have:

- ✅ WEBAPP_URL
- ✅ NEXTAUTH_URL  
- ✅ ENCRYPTION_KEY (32-char hex)
- ✅ NEXTAUTH_SECRET (32-char hex)
- ✅ CRON_SECRET (32-char hex)
- ✅ DATABASE_URL (auto-configured)
- ✅ EMAIL_VERIFICATION_DISABLED=1
- ✅ PASSWORD_RESET_DISABLED=1
