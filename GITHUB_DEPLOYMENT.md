# GitHub + Vercel Deployment Guide

This guide will help you deploy ATURE Studio to `ature.ru` via GitHub and Vercel.

## Step 1: Prepare Your Repository

Your repository structure is already set up correctly:
```
furniture-matcher/
├── vercel.json          (Root config - handles subdirectory)
├── .gitignore          (Root gitignore)
└── ature-app/          (Your React app)
    ├── vercel.json     (App-specific config)
    ├── package.json
    ├── src/
    └── ...
```

## Step 2: Push to GitHub

If you haven't already, initialize git and push to GitHub:

```bash
cd /Users/andrew/furniture-matcher

# Initialize git (if not already done)
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit: ATURE Studio app"

# Add your GitHub repository as remote
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git

# Push to GitHub
git push -u origin main
```

**Note:** Replace `YOUR_USERNAME` and `YOUR_REPO_NAME` with your actual GitHub repository details.

## Step 3: Connect GitHub to Vercel

1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Click **"Add New..."** → **"Project"**
3. Click **"Import Git Repository"**
4. Select **"GitHub"** and authorize Vercel if needed
5. Find and select your repository (`furniture-matcher` or whatever you named it)
6. Click **"Import"**

## Step 4: Configure Project Settings in Vercel

**IMPORTANT:** Before clicking "Deploy", configure these settings:

### A. Set Root Directory

1. In the project configuration screen, find **"Root Directory"**
2. Click **"Edit"** or the folder icon
3. Enter: `ature-app`
4. This tells Vercel where your `package.json` is located

### B. Verify Build Settings

Vercel should auto-detect:
- **Framework Preset:** Vite
- **Build Command:** `npm run build` (will run from `ature-app` directory)
- **Output Directory:** `dist`
- **Install Command:** `npm install`

If these are correct, you're good to go!

### C. Environment Variables (if needed later)

If you need API keys or environment variables later:
- Add them in **"Environment Variables"** section
- They'll be available as `import.meta.env.VITE_YOUR_VAR`

## Step 5: Deploy

1. Click **"Deploy"**
2. Wait for the build to complete (usually 1-2 minutes)
3. Your app will be live at a Vercel URL like: `your-project.vercel.app`

## Step 6: Add Custom Domain (ature.ru)

Once deployment succeeds:

1. Go to your project in Vercel Dashboard
2. Click **"Settings"** → **"Domains"**
3. Click **"Add Domain"**
4. Enter: `ature.ru`
5. Click **"Add"**
6. Also add: `www.ature.ru`

### Configure DNS

Vercel will show you DNS records to add. Go to your domain registrar and add:

**For apex domain (ature.ru):**
- Type: `A`
- Name: `@`
- Value: `76.76.21.21` (or the IP shown in Vercel)

**For www subdomain:**
- Type: `CNAME`
- Name: `www`
- Value: `cname.vercel-dns.com` (or the value shown in Vercel)

**Wait for DNS propagation** (5 minutes to 48 hours)

Vercel will automatically provision an SSL certificate via Let's Encrypt.

## Step 7: Automatic Deployments

From now on:
- Every push to `main` branch = automatic deployment
- Vercel creates preview deployments for pull requests
- You can manually redeploy from the Vercel Dashboard

## Troubleshooting

### Build fails with "Cannot find /src/main.jsx"
- **Solution:** Make sure Root Directory is set to `ature-app` in Vercel Dashboard

### Build fails with "Cannot find package.json"
- **Solution:** Verify Root Directory is `ature-app`, not `.` or empty

### Domain not working
- Wait 24-48 hours for DNS propagation
- Check DNS records: `dig ature.ru` or use online DNS checker
- Verify SSL certificate is issued (check browser padlock)

### Need to update deployment
- Just push to GitHub: `git push`
- Vercel will automatically redeploy

## Quick Commands Reference

```bash
# Make changes locally
cd /Users/andrew/furniture-matcher/ature-app
# ... make your changes ...

# Commit and push
cd /Users/andrew/furniture-matcher
git add .
git commit -m "Your commit message"
git push
# Vercel will auto-deploy!
```

## Your Repository is Ready! ✅

Everything is configured:
- ✅ `vercel.json` at root (handles subdirectory)
- ✅ `vercel.json` in `ature-app` (app config)
- ✅ `.gitignore` files
- ✅ Build configuration ready

Just push to GitHub and connect to Vercel!

