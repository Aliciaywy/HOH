-- Create Database
CREATE DATABASE IF NOT EXISTS rp_digital_bank;
USE rp_digital_bank;

-- 1. Users
CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  password VARCHAR(255),
  phone_number VARCHAR(20),
  role ENUM('customer', 'staff', 'financial_advisor'),
  date_of_birth DATE,
  nric VARCHAR(20),
  enable_2fa TINYINT(1) DEFAULT 0,
  profile_picture VARCHAR(255) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  email_verified TINYINT(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 2. User Notifications
CREATE TABLE user_notifications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  message TEXT,
  is_read TINYINT(1) DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 3. Product Catalog
CREATE TABLE product_catalog (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR(100),
  product_type VARCHAR(50),
  description TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 4. Accounts
CREATE TABLE accounts (
  account_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  product_id INT,
  full_name VARCHAR(100),
  account_number VARCHAR(9) UNIQUE,
  account_type ENUM('savings', 'fixed_deposit', 'credit_account', 'debit_account'),
  balance DECIMAL(12,2),
  account_status ENUM('active', 'closed', 'suspended'),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (product_id) REFERENCES product_catalog(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 5. Cards
CREATE TABLE cards (
  card_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  product_id INT,
  account_id INT,
  full_name VARCHAR(100),
  card_number VARCHAR(16) UNIQUE,
  card_type ENUM('credit', 'debit'),
  expiry_date DATE,
  cvv VARCHAR(4),
  balance DECIMAL(12,2),
  card_status ENUM('active', 'cancelled', 'expired'),
  issued_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (product_id) REFERENCES product_catalog(product_id),
  FOREIGN KEY (account_id) REFERENCES accounts(account_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 6. Card Applications
CREATE TABLE card_applications (
  application_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  product_id INT,
  full_name VARCHAR(100),
  email VARCHAR(100),
  phone_number VARCHAR(20),
  date_of_birth DATE,
  nric VARCHAR(20),
  nationality VARCHAR(50),
  income_source DECIMAL(10,2) DEFAULT 0.00,
  address VARCHAR(255),
  student_id_upload_path VARCHAR(255),
  card_type ENUM('credit', 'debit'),
  status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
  kyc_verified BOOLEAN DEFAULT FALSE,
  submitted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (product_id) REFERENCES product_catalog(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 7. Consultations
CREATE TABLE consultations (
  consultation_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NULL,
  advisor_id INT NOT NULL,
  appointment_date DATETIME NOT NULL,
  status ENUM('available','booked','accepted','completed','cancelled','pending accept') NOT NULL DEFAULT 'available',
  notes TEXT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  was_accepted_before BOOLEAN NOT NULL DEFAULT FALSE,
  video_link VARCHAR(255) DEFAULT NULL,
  FOREIGN KEY (customer_id) REFERENCES users(user_id),
  FOREIGN KEY (advisor_id) REFERENCES users(user_id),
  INDEX idx_customer_id (customer_id),
  INDEX idx_advisor_id (advisor_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 8. Transactions
CREATE TABLE transactions (
  transaction_id INT AUTO_INCREMENT PRIMARY KEY,
  account_id INT,
  transaction_type ENUM('deposit', 'withdrawal', 'transfer', 'topup', 'spending'),
  amount DECIMAL(12,2),
  description TEXT,
  transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (account_id) REFERENCES accounts(account_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 9. OTP Requests
CREATE TABLE otp_requests (
  otp_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  purpose ENUM('password_reset', 'card_cancel','login_2fa' , 'change_password', 'signup_email_verification') DEFAULT NULL,
  otp_code VARCHAR(10),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  expires_at DATETIME,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 10. Reports
CREATE TABLE reports (
  report_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100),
  description TEXT,
  generated_by INT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (generated_by) REFERENCES users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 11. Budget Goals
CREATE TABLE budget_goals (
  goal_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  goal_name VARCHAR(100),
  category VARCHAR(50) DEFAULT NULL,
  goal_amount DECIMAL(12,2),
  current_savings DECIMAL(12,2),
  target_date DATE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 12. Account Applications
CREATE TABLE account_applications (
  application_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  product_id INT,
  full_name VARCHAR(100),
  email VARCHAR(100),
  phone_number VARCHAR(20),
  date_of_birth DATE,
  nric VARCHAR(20),
  nationality VARCHAR(50),
  income_source DECIMAL(10,2) DEFAULT 0.00,
  address VARCHAR(255),
  student_id_upload_path VARCHAR(255),
  account_type ENUM('savings', 'fixed_deposit', 'credit_account', 'debit_account'),
  status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
  kyc_verified BOOLEAN DEFAULT FALSE,
  submitted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (product_id) REFERENCES product_catalog(product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 13. Credit Quiz Scores
CREATE TABLE credit_quiz_scores (
  quiz_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  score INT,
  taken_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 14. Goal Recurring Transfer
CREATE TABLE goal_recurring_transfer (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  goal_id INT,
  account_id INT,
  amount DECIMAL(12,2),
  frequency ENUM('daily','weekly','monthly'),
  next_transfer_date DATE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (goal_id) REFERENCES budget_goals(goal_id),
  FOREIGN KEY (account_id) REFERENCES accounts(account_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 15. Reward Claims
CREATE TABLE reward_claims (
  claim_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  reward_type VARCHAR(50),
  claimed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- ----

-- === Sample Data ===

-- Product catalog
INSERT INTO product_catalog (product_name, product_type, description)
VALUES 
('SmartStart Student Debit Card', 'debit_card', 'A no-fee debit card for students with spending controls, parental top-up, and learning tools.'),
('EduPerks Student Credit Card', 'credit_card', 'A credit card with low limits and cashback on student essentials. Great for learning credit responsibility.'),
('Savings Account', 'savings', 'A basic savings account with daily interest accrual.'),
('Fixed Deposit Account', 'fixed_deposit', 'A time-bound account with higher interest returns.');

-- Users
INSERT INTO users (full_name, email, password, phone_number, role, date_of_birth, nric)
VALUES 
('Alice Tan', 'alice.staff@rpbank.sg', '1111', '91234567', 'staff', '1985-04-12', 'S1234567A'),
('Ben Lim', 'ben.customer@rpbank.sg', '1111', '98765432', 'customer', '2003-09-15', 'T2345678B'),
('Cindy Lee', 'cindy.fa@rpbank.sg', '1111', '92345678', 'financial_advisor', '1990-07-22', 'S3456789C'),
('Alicia Yeo', '23047113@myrp.edu.sg', '1111', '91234567', 'customer', '2004-08-15', 'S4567890D'),
('Benedict', '23050951@myrp.edu.sg', '1111', '91234567', 'customer', '2004-08-15', 'S4567890E'),
('Bryan Wong', '23043484@myrp.edu.sg', '1111', '91234567', 'customer', '2004-08-15', 'S4567890F'),
('Jelicia Chio', '23048087@myrp.edu.sg', '1111', '91234567', 'customer', '2004-08-15', 'S4567890G');

-- Ben's Savings Account
INSERT INTO accounts (
  user_id, product_id, full_name, account_number, account_type, balance, account_status
) VALUES (
  2, 3, 'Ben Lim', '123456789', 'savings', 2500.00, 'active'
),(1, 3, 'Alice Tan', '987654321', 'savings', 1500.00, 'active');

-- Ben’s Debit Card
INSERT INTO cards (
  user_id, product_id, account_id, full_name, card_number, card_type,
  expiry_date, cvv, balance, card_status
) VALUES (
  2, 1, 1, 'Ben Lim', '4556737586899999', 'debit', '2029-05-31', '456', 150.00, 'active'
);


-- Ben’s Credit Card Application
INSERT INTO card_applications (
    user_id, product_id, full_name, email, phone_number, date_of_birth, nric,
    nationality, income_source, address, student_id_upload_path,
    card_type, status, kyc_verified
) VALUES (
    2, 2, 'Ben Lim', 'ben.customer@rpbank.sg', '98765432', '2003-09-15', 'T2345678B',
    'Singaporean', 0.00, '123 Bukit Timah Road, Singapore 259760', NULL,
    'credit', 'pending', TRUE
);

-- Ben's Consultation with Cindy
INSERT INTO consultations (customer_id, advisor_id, appointment_date, status, notes, was_accepted_before)
VALUES (2, 3, '2025-05-10 14:00:00', 'booked', 'Discuss investment portfolio options.', FALSE);

-- Transaction for Ben
INSERT INTO transactions (account_id, transaction_type, amount, description)
VALUES (1, 'deposit', 1000.00, 'Initial deposit');

-- OTP for Ben
INSERT INTO otp_requests (user_id, purpose, otp_code, expires_at)
VALUES (2, 'card_cancel', '567891', NOW() + INTERVAL 10 MINUTE);

-- Ben’s Budget Goal
INSERT INTO budget_goals (user_id, goal_name, goal_amount, current_savings, target_date)
VALUES (2, 'Holiday in Japan', 3000.00, 500.00, '2025-12-20');
