# 🚀 Deploy HOH Banking App to Railway

This guide will help you deploy your banking application to Railway so it's accessible online at a custom URL.

## Prerequisites
- GitHub repository with your code (✅ Done)
- Railway account (free)

## Step 1: Create Railway Account
1. Go to [railway.app](https://railway.app)
2. Sign up with your GitHub account
3. Verify your email

## Step 2: Deploy Your App

### 2.1 Create New Project
1. Click "Start a New Project"
2. Select "Deploy from GitHub repo"
3. Choose your `HOH` repository
4. Railway will detect it's a Node.js app

### 2.2 Add MySQL Database
1. In your Railway project dashboard
2. Click "New Service" → "Database" → "MySQL"
3. Railway will provision a MySQL database

### 2.3 Configure Environment Variables
In Railway dashboard, go to your app service → Variables tab:

```
NODE_ENV=production
EMAIL_USER=your-email@gmail.com
EMAIL_PASS=your-gmail-app-password
SESSION_SECRET=your-random-secret-key-here
```

The database variables will be automatically provided by Railway.

### 2.4 Import Database
1. Connect to Railway MySQL using provided credentials
2. Import your `FYP.sql` file:
   ```sql
   -- Use Railway's provided database name
   USE railway;
   -- Then run all your table creation and data insertion commands
   ```

## Step 3: Access Your Live App
1. Railway will provide a URL like: `https://your-app-name.railway.app`
2. Your banking app will be accessible at this URL
3. You can also configure a custom domain

## Step 4: Automatic Deployments
- Every time you push to GitHub, Railway automatically redeploys
- Your app stays in sync with your repository

## Alternative: Render Deployment

If you prefer Render:

1. Go to [render.com](https://render.com)
2. Connect GitHub repository
3. Add PostgreSQL database
4. Configure environment variables
5. Deploy

## Environment Variables Needed:

```
PORT=3000 (Railway sets this automatically)
NODE_ENV=production
DB_HOST=(provided by Railway)
DB_USER=(provided by Railway)
DB_PASSWORD=(provided by Railway)
DB_NAME=railway
EMAIL_USER=your-gmail@gmail.com
EMAIL_PASS=your-gmail-app-password
SESSION_SECRET=your-secret-key
```

## Custom Domain (Optional)
- Purchase domain from any registrar
- Configure DNS in Railway dashboard
- Your app will be accessible at your custom domain

## Cost
- Railway: Free tier with reasonable limits
- Render: Free tier available
- Both have paid plans for production use

---

After deployment, your banking app will be live and accessible from anywhere! 🌐
