# Deploy Your Formbricks to Railway - Step by Step

## Step 1: Push to Your GitHub Repository

After creating a new repository on GitHub (https://github.com/new), run these commands:

```bash
cd /Users/davidolsson/WORKSONA/w-survey2

# Add your GitHub repository as origin
# Replace YOUR_USERNAME and YOUR_REPO_NAME with your actual values
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git

# Add the deployment guides
git add DEPLOYMENT_GUIDE.md RAILWAY_DEPLOYMENT.md railway-env-variables.txt DEPLOY_STEPS.md

# Commit the guides
git commit -m "Add deployment documentation"

# Push to your repository
git push -u origin main
```

## Step 2: Deploy to Railway

### A. Create New Project on Railway

1. Go to: https://railway.app/new
2. Click **"Deploy from GitHub repo"**
3. Authorize Railway to access your GitHub account
4. Select your `formbricks-deploy` repository
5. Railway will automatically detect it as a Next.js app

### B. Add PostgreSQL Database

1. In your Railway project dashboard
2. Click **"+ New"**
3. Select **"Database"** → **"PostgreSQL"**
4. Railway will automatically provision it
5. Wait for it to deploy (~30 seconds)

### C. Configure Environment Variables

1. Click on your **"web"** service (the main app)
2. Go to the **"Variables"** tab
3. Click **"+ Add Variable"** or **"Raw Editor"**
4. Add the following variables:

```bash
# Application URLs (Railway auto-generates the domain)
WEBAPP_URL=https://${{RAILWAY_PUBLIC_DOMAIN}}
NEXTAUTH_URL=https://${{RAILWAY_PUBLIC_DOMAIN}}

# Your Generated Secrets (REPLACE WITH YOUR ACTUAL SECRETS)
ENCRYPTION_KEY=your_first_secret_here
NEXTAUTH_SECRET=your_second_secret_here
CRON_SECRET=your_third_secret_here

# Database Connection (links to your PostgreSQL service)
DATABASE_URL=${{Postgres.DATABASE_URL}}

# Disable email verification for quick start
EMAIL_VERIFICATION_DISABLED=1
PASSWORD_RESET_DISABLED=1

# Minimal email configuration (required by app)
MAIL_FROM=noreply@example.com
MAIL_FROM_NAME=Formbricks
SMTP_HOST=localhost
SMTP_PORT=1025
SMTP_USER=smtpUser
SMTP_PASSWORD=smtpPassword

# Logging
LOG_LEVEL=info
```

**Important:** Replace `your_first_secret_here`, `your_second_secret_here`, and `your_third_secret_here` with the actual secrets you generated!

### D. Generate Public Domain

1. In your web service, click **"Settings"**
2. Go to **"Public Networking"**
3. Click **"Generate Domain"**
4. Railway will give you a URL like: `https://formbricks-production-xxxx.up.railway.app`

### E. Trigger Deployment

1. Go to the **"Deployments"** tab
2. Click **"Deploy"** if it hasn't started automatically
3. Watch the build logs
4. Build takes approximately 5-10 minutes

## Step 3: Access Your Formbricks Instance

Once deployment is complete:

1. Visit your Railway-generated URL
2. Click **"Sign Up"** to create your admin account
3. Fill in your details
4. You're in! Start creating surveys!

## Troubleshooting

### Build Failed?

**Check these:**
- All environment variables are set correctly
- DATABASE_URL is set to `${{Postgres.DATABASE_URL}}`
- PostgreSQL service is running
- All three secrets are proper 32-character hex strings

### Can't Access the Site?

**Try these:**
- Wait 1-2 minutes after build completes
- Check if domain is properly generated
- Look at deployment logs for errors
- Ensure `WEBAPP_URL` and `NEXTAUTH_URL` match your domain

### Database Connection Error?

**Verify:**
- PostgreSQL service is deployed and running
- `DATABASE_URL` uses the correct reference: `${{Postgres.DATABASE_URL}}`
- Both services are in the same Railway project

## Post-Deployment Configuration

### Enable Auto-Deploy

1. In your web service settings
2. Go to **"Service"** → **"GitHub Repo"**
3. Enable **"Deploy on Push"**
4. Now any push to `main` branch automatically deploys

### Add Custom Domain (Optional)

1. In web service, go to **"Settings"** → **"Public Networking"**
2. Click **"Custom Domain"**
3. Enter your domain (e.g., `surveys.yourdomain.com`)
4. Add the CNAME record to your DNS:
   ```
   CNAME surveys.yourdomain.com → your-app.up.railway.app
   ```

### Set Up Email (Later)

When you're ready to enable email features:

1. Get SMTP credentials (Gmail, SendGrid, Postmark, etc.)
2. Update environment variables:
   ```
   EMAIL_VERIFICATION_DISABLED=0
   PASSWORD_RESET_DISABLED=0
   SMTP_HOST=smtp.your-provider.com
   SMTP_PORT=587
   SMTP_USER=your-email@domain.com
   SMTP_PASSWORD=your-smtp-password
   MAIL_FROM=noreply@yourdomain.com
   ```
3. Redeploy for changes to take effect

## Railway CLI (Optional)

Install Railway CLI for easier management:

```bash
# Install
npm i -g @railway/cli

# Login
railway login

# Link to your project
railway link

# View logs
railway logs

# Open dashboard
railway open
```

## Monitoring Your Deployment

### View Logs:
- Click on your service
- Go to **"Observability"** tab
- See real-time application logs

### Check Metrics:
- CPU usage
- Memory usage
- Request counts

### Database Management:
- Click PostgreSQL service
- View connection info
- Monitor database metrics

## Updating Formbricks

### Pull Latest Updates from Formbricks:

```bash
cd /Users/davidolsson/WORKSONA/w-survey2

# Fetch latest changes from Formbricks
git fetch upstream

# Merge updates (careful - may need to resolve conflicts)
git merge upstream/main

# Push to your repo (triggers auto-deploy if enabled)
git push origin main
```

## Security Checklist

- ✅ All secrets are strong 32-character hex strings
- ✅ Repository is private (recommended)
- ✅ HTTPS enabled (automatic on Railway)
- ✅ Database has restricted access (Railway private networking)
- ✅ Regular backups configured (Railway Pro)

## Cost Estimate

**Hobby Plan (~$5-10/month):**
- Web service: $5/month
- PostgreSQL: Included
- 100GB bandwidth included

**Usage-Based Charges:**
- Additional bandwidth
- Larger database
- More compute resources

## Next Steps After Deployment

1. ✅ Create your admin account
2. ✅ Set up your organization
3. ✅ Create your first survey
4. ✅ Customize branding
5. ✅ Invite team members
6. ✅ Set up integrations (Slack, Notion, etc.)

## Support & Resources

- **Formbricks Docs:** https://formbricks.com/docs
- **Railway Docs:** https://docs.railway.app
- **Formbricks GitHub:** https://github.com/formbricks/formbricks
- **Railway Discord:** https://discord.gg/railway

## Quick Command Reference

```bash
# Generate secrets
openssl rand -hex 32

# Check Railway status
railway status

# View environment variables
railway variables

# Run database migrations manually (if needed)
railway run npx prisma migrate deploy

# Connect to PostgreSQL
railway connect Postgres
```

---

**You're all set!** Follow the steps above and you'll have Formbricks running on Railway in about 15 minutes. 🚀
