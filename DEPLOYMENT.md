# Deployment Guide for ature.ru

This guide will help you deploy ATURE Studio to your `ature.ru` domain.

## Option 1: Deploy with Vercel (Recommended - Easiest)

### Step 1: Install Vercel CLI (if not already installed)
```bash
npm install -g vercel
```

### Step 2: Login to Vercel
```bash
vercel login
```

### Step 3: Deploy from the ature-app directory
**IMPORTANT:** You must deploy from inside the `ature-app` directory:

```bash
cd ature-app
vercel
```

Follow the prompts:
- Set up and deploy? **Yes**
- Which scope? (Select your account)
- Link to existing project? **No**
- What's your project's name? **ature-studio** (or any name)
- In which directory is your code located? **./** (should be `.` since you're already in ature-app)

### Alternative: Deploy from root and configure Root Directory

If you want to deploy from the root `furniture-matcher` directory:

1. Deploy from root:
```bash
cd /Users/andrew/furniture-matcher
vercel
```

2. **After first deployment**, go to Vercel Dashboard:
   - Select your project
   - Go to **Settings** → **General**
   - Under **Root Directory**, click **Edit**
   - Set it to: `ature-app`
   - Click **Save**

3. Redeploy:
```bash
vercel --prod
```

### Step 4: Add Custom Domain

1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Select your project
3. Go to **Settings** → **Domains**
4. Click **Add Domain**
5. Enter `ature.ru` and `www.ature.ru`
6. Follow the DNS configuration instructions

### Step 5: Configure DNS

In your domain registrar (where you bought ature.ru), add these DNS records:

**For apex domain (ature.ru):**
- Type: `A`
- Name: `@`
- Value: `76.76.21.21` (Vercel's IP - check Vercel dashboard for current IP)

**For www subdomain:**
- Type: `CNAME`
- Name: `www`
- Value: `cname.vercel-dns.com` (or the value shown in Vercel dashboard)

**Alternative (using CNAME for apex):**
Some registrars support CNAME flattening. If yours does:
- Type: `CNAME`
- Name: `@`
- Value: `cname.vercel-dns.com`

### Step 6: SSL Certificate
Vercel automatically provisions SSL certificates via Let's Encrypt. This usually takes a few minutes after DNS propagation.

---

## Option 2: Deploy with Netlify

### Step 1: Install Netlify CLI
```bash
npm install -g netlify-cli
```

### Step 2: Build the project
```bash
cd ature-app
npm run build
```

### Step 3: Deploy
```bash
netlify deploy --prod
```

### Step 4: Add Custom Domain
1. Go to [Netlify Dashboard](https://app.netlify.com)
2. Select your site
3. Go to **Domain settings**
4. Click **Add custom domain**
5. Enter `ature.ru`
6. Follow DNS configuration instructions

---

## Option 3: Deploy to VPS/Server

### Step 1: Build the project
```bash
cd ature-app
npm run build
```

### Step 2: Upload dist folder
Upload the `dist` folder to your server (via FTP, SCP, or rsync).

### Step 3: Configure Nginx

Create an Nginx configuration file:

```nginx
server {
    listen 80;
    server_name ature.ru www.ature.ru;

    root /path/to/your/dist;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    # Cache static assets
    location /assets {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
```

### Step 4: Set up SSL with Let's Encrypt
```bash
sudo certbot --nginx -d ature.ru -d www.ature.ru
```

---

## Testing the Build Locally

Before deploying, test the production build:

```bash
cd ature-app
npm run build
npm run preview
```

Visit `http://localhost:4173` to test.

---

## Environment Variables (if needed later)

If you need to add environment variables:
- **Vercel**: Settings → Environment Variables
- **Netlify**: Site settings → Build & deploy → Environment variables

---

## Troubleshooting

### 404 errors on routes
- Make sure the `vercel.json` rewrite rules are in place (for Vercel)
- For other platforms, ensure all routes redirect to `index.html`

### Domain not working
- Wait 24-48 hours for DNS propagation
- Check DNS records with: `dig ature.ru` or `nslookup ature.ru`
- Verify SSL certificate is issued (check browser padlock icon)

### Build errors
- Run `npm run build` locally to see errors
- Check Node.js version (should be 18+)
- Clear `node_modules` and reinstall: `rm -rf node_modules package-lock.json && npm install`

---

## Quick Deploy Commands

**Vercel:**
```bash
vercel --prod
```

**Netlify:**
```bash
netlify deploy --prod
```

**Rebuild and redeploy:**
```bash
npm run build && vercel --prod
```

