# HOH Digital Banking System

A comprehensive digital banking application built with Node.js, Express.js, and MySQL for Republic Polytechnic students.

## 🏦 Features

### Multi-Role Authentication
- **Customer Portal**: Account management, card applications, budget goals, financial consultations
- **Staff Portal**: Account approvals, card management, user management, analytics
- **Financial Advisor Portal**: Consultation scheduling, client notes, budget tools

### Core Banking Features
- **Account Management**: Savings and Fixed Deposit accounts
- **Card Services**: Credit and Debit card applications and management
- **Money Transfer**: Secure fund transfers between accounts
- **Budget Goals**: Personal financial goal setting and tracking
- **Financial Education**: Quiz system and educational resources

### Advanced Features
- **Financial Consultations**: Video consultation booking system with advisors
- **Analytics Dashboard**: Transaction analytics and spending insights
- **Email Notifications**: Automated email system for all banking activities
- **2FA Security**: Two-factor authentication support
- **File Uploads**: Document upload for KYC verification

## 🛠 Technology Stack

- **Backend**: Node.js, Express.js
- **Database**: MySQL
- **Template Engine**: EJS
- **Email Service**: Nodemailer with Gmail
- **File Upload**: Multer
- **Security**: bcrypt, express-session
- **Task Scheduling**: node-cron

## 📁 Project Structure

```
├── app.js                 # Main application file
├── db.js                  # Database configuration
├── FYP.sql               # Complete database schema and sample data
├── package.json          # Dependencies and scripts
├── .env.example          # Environment variables template
├── .gitignore           # Git ignore rules
├── DEPLOYMENT.md        # Deployment instructions
├── controllers/         # Authentication controllers
├── views/              # EJS templates
├── public/            # Static assets
└── examples/          # Additional code examples
```

## 🚀 Quick Start

### Prerequisites
- Node.js (v16 or higher)
- MySQL Server
- Gmail account with App Password for email features

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd "RP Digital Bank"
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Database Setup**
   ```bash
   # Import the database schema
   mysql -u root -p < FYP.sql
   ```

4. **Environment Configuration**
   ```bash
   # Copy environment template
   cp .env.example .env
   
   # Edit .env with your credentials
   # Add your MySQL password and Gmail credentials
   ```

5. **Start the application**
   ```bash
   npm start
   ```

6. **Access the application**
   - Open browser to `http://localhost:3000`
   - Use sample accounts from database or create new ones

## 👥 Sample User Accounts

The database includes sample users for testing:

| Role | Email | Password | Description |
|------|-------|----------|-------------|
| Staff | alice.staff@rpbank.sg | 1111 | Staff member for approvals |
| Customer | ben.customer@rpbank.sg | 1111 | Customer with accounts/cards |
| Advisor | cindy.fa@rpbank.sg | 1111 | Financial advisor |
| Student | 23047113@myrp.edu.sg | 1111 | RP student account |

## 🔒 Security Features

- ✅ Environment variables for sensitive data
- ✅ Password hashing with bcrypt
- ✅ Session-based authentication
- ✅ SQL injection protection
- ✅ XSS protection
- ✅ CSRF protection
- ✅ Email verification system
- ✅ 2FA support

## 📧 Email Configuration

The system uses Gmail SMTP for email notifications:
- Account approvals/rejections
- Card status updates
- OTP verification
- Consultation confirmations
- Password reset emails

## 🎯 Key Functionalities

### For Customers
- Register and verify email
- Apply for savings/fixed deposit accounts
- Apply for credit/debit cards
- Transfer money between accounts
- Set and track budget goals
- Book financial consultations
- View transaction history
- Take financial education quizzes

### For Staff
- Review and approve account applications
- Manage card applications
- Monitor user activities
- Generate reports and analytics
- Manage user accounts

### For Financial Advisors
- Create consultation time slots
- Accept/reschedule appointments
- Add consultation notes
- Track completed consultations
- Access budget planning tools

## 🚀 Deployment

See [DEPLOYMENT.md](DEPLOYMENT.md) for detailed deployment instructions including:
- Production environment setup
- Database configuration
- Email service configuration
- Security considerations

## 📱 API Endpoints

The application includes comprehensive REST API endpoints for all banking operations. Key endpoints include:

- `/login/*` - Authentication routes
- `/customer/*` - Customer portal routes
- `/staff/*` - Staff portal routes  
- `/advisor/*` - Financial advisor routes
- `/api/*` - API endpoints for data

## 🤝 Contributing

This is a Final Year Project for Republic Polytechnic. For contributions or issues, please contact the development team.

## 📄 License

This project is developed as part of academic requirements at Republic Polytechnic.

## 🙏 Acknowledgments

- Republic Polytechnic School of Infocomm
- Project supervisors and mentors
- Open source community for excellent libraries

---

**Team Members:**
- Alicia Yeo (23047113@myrp.edu.sg)
- Benedict (23050951@myrp.edu.sg)  
- Bryan Wong (23043484@myrp.edu.sg)
- Jelicia Chio (23048087@myrp.edu.sg)

**Institution:** Republic Polytechnic, Singapore
