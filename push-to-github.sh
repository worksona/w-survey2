#!/bin/bash

# Script to push Formbricks to your GitHub repository
# Usage: ./push-to-github.sh YOUR_GITHUB_USERNAME YOUR_REPO_NAME

if [ "$#" -ne 2 ]; then
    echo "Usage: ./push-to-github.sh YOUR_GITHUB_USERNAME YOUR_REPO_NAME"
    echo "Example: ./push-to-github.sh johndoe formbricks-deploy"
    exit 1
fi

USERNAME=$1
REPO_NAME=$2

echo "🚀 Setting up repository..."

# Add your GitHub repository as origin
git remote add origin "https://github.com/$USERNAME/$REPO_NAME.git"

echo "📦 Adding deployment documentation..."

# Add the deployment guides
git add DEPLOYMENT_GUIDE.md RAILWAY_DEPLOYMENT.md railway-env-variables.txt DEPLOY_STEPS.md push-to-github.sh

# Commit the guides
git commit -m "Add deployment documentation and guides"

echo "⬆️  Pushing to GitHub..."

# Push to your repository
git push -u origin main

echo "✅ Done! Your code is now on GitHub at: https://github.com/$USERNAME/$REPO_NAME"
echo ""
echo "🎯 Next steps:"
echo "1. Go to https://railway.app/new"
echo "2. Click 'Deploy from GitHub repo'"
echo "3. Select your repository: $REPO_NAME"
echo "4. Follow the instructions in DEPLOY_STEPS.md"
