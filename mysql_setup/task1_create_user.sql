-- Task 1: Creating a New User Account for Little Lemon
-- This script demonstrates the SQL commands that would be executed in MySQL Workbench
-- to create a new user account with full privileges.

-- Step 1: Log in to MySQL Server using the root user (done via MySQL Workbench UI)
-- Step 2: Navigate to Administration tab > Users and Privileges > Add Account

-- Step 3: Create new user with meaningful username and strong password
-- Note: In production, use a strong password and store it securely
CREATE USER 'littlelemon_admin'@'localhost' IDENTIFIED BY 'SecurePassword123!@#';

-- Step 4: Grant the new user the right to perform all tasks
-- Grant all privileges on all databases
GRANT ALL PRIVILEGES ON *.* TO 'littlelemon_admin'@'localhost' WITH GRANT OPTION;

-- Apply the changes
FLUSH PRIVILEGES;

-- Verify the user was created successfully
SELECT user, host FROM mysql.user WHERE user = 'littlelemon_admin';

-- Show granted privileges
SHOW GRANTS FOR 'littlelemon_admin'@'localhost';
