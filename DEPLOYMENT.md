# Environment Setup for Deployment

## Security Configuration

This application uses environment variables to keep sensitive information secure. Follow these steps to set up your environment:

### 1. Environment Variables Setup

1. Copy `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```

2. Update the `.env` file with your actual credentials:
   ```env
   # Email Configuration
   EMAIL_SERVICE=gmail
   EMAIL_USER=your-email@gmail.com
   EMAIL_PASS=your-app-password

   # Database Configuration
   DB_HOST=localhost
   DB_USER=root
   DB_PASSWORD=your-database-password
   DB_NAME=rp_digital_bank

   # Session Secret (generate a random string for security)
   SESSION_SECRET=your-secret-key-here

   # Server Configuration
   PORT=3000
   NODE_ENV=production
   ```

### 2. Gmail App Password Setup

For email functionality, you need to create a Gmail App Password:

1. Go to your Google Account settings
2. Enable 2-Factor Authentication if not already enabled
3. Go to Security → App passwords
4. Generate a new app password for "Mail"
5. Use this 16-character password in your `EMAIL_PASS` environment variable

### 3. Deployment Considerations

#### For Production Deployment:

1. **Never commit `.env` files** - they're already in `.gitignore`
2. **Set environment variables** in your hosting platform:
   - Heroku: Use `heroku config:set`
   - Vercel: Set in dashboard or `vercel.json`
   - AWS: Use environment variables in your service
   - Railway: Set in project settings

3. **Generate a strong session secret**:
   ```javascript
   // Use a random string generator or command:
   // node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
   ```

#### Environment Variables for Different Platforms:

**Heroku:**
```bash
heroku config:set EMAIL_USER=your-email@gmail.com
heroku config:set EMAIL_PASS=your-app-password
heroku config:set SESSION_SECRET=your-session-secret
```

**Railway:**
Set variables in the dashboard under "Variables" tab

**Vercel:**
Set variables in project settings or use `vercel.json`

### 4. Security Best Practices

- ✅ Environment variables are used for all sensitive data
- ✅ `.env` file is in `.gitignore`
- ✅ `.env.example` shows required variables without exposing secrets
- ✅ Gmail App Password is used instead of account password
- ✅ No hardcoded credentials in source code

### 5. Local Development

1. Install dependencies: `npm install`
2. Set up your `.env` file as described above
3. Start the application: `npm start` or `npm run dev`

### 6. Troubleshooting

**Email not working:**
- Verify Gmail App Password is correct
- Check if 2FA is enabled on Gmail account
- Ensure `EMAIL_USER` and `EMAIL_PASS` are set correctly

**Application crashes:**
- Check all required environment variables are set
- Verify database connection settings
- Check server logs for specific error messages
