# Little Lemon MySQL Environment Setup Guide

This guide walks through the MySQL Workbench setup process for Little Lemon's database system.

## Overview

Little Lemon needs to build a robust relational database system in MySQL. This setup guide covers the initial environment configuration required before database design and development.

## Prerequisites

- MySQL Workbench must be downloaded and installed on your machine
- MySQL Server must be installed and running
- Root access to MySQL Server (for initial user creation)

## Task 1: Creating a New User Account

Creating a new user is the most secure way to connect to your MySQL database.

### Steps to Complete Task 1

1. **Log in to MySQL Server**
   - Open MySQL Workbench
   - Connect using the root user credentials
   - Enter your root password when prompted

2. **Navigate to User Management**
   - In the Navigator section, select the **Administration** tab
   - Click on **Users and Privileges** in the left sidebar

3. **Add New Account**
   - Click the **Add Account** button (or the + icon)
   - This opens the user account creation form

4. **Configure User Details**
   - **Login Name:** `littlelemon_admin` (or your preferred username)
   - **Authentication Type:** Standard
   - **Password:** Enter a strong password (e.g., `SecurePassword123!@#`)
   - **Confirm Password:** Re-enter the password
   - **Limit to Hosts Matching:** `localhost` (or specific IP for production)

5. **Grant Privileges**
   - Select the **Administrative Roles** tab
   - Check **"DBA"** (Database Administrator) to grant all privileges
   - Alternatively, go to **Schema Privileges** tab and grant privileges on specific databases

6. **Apply Changes**
   - Click **Apply** to create the user
   - Verify the user appears in the users list

### SQL Alternative (Command Line)

If you prefer using SQL commands, see `task1_create_user.sql` for the equivalent SQL statements.

## Task 2: Creating a New MySQL Connection

To prepare for building and managing your database, you need to create a new MySQL connection.

### Steps to Complete Task 2

1. **Access MySQL Workbench Home Screen**
   - If you're in a connection, click the home icon or close the current connection
   - You should see the MySQL Workbench home screen

2. **Open Connection Setup**
   - In the **MySQL Connections** section, click the **plus (+) icon**
   - This opens the "Setup New Connection" dialog

3. **Configure Connection Parameters**
   - **Connection Name:** `Little Lemon Database`
   - **Connection Method:** Standard (TCP/IP)
   - **Hostname:** `localhost` (or your MySQL server address)
   - **Port:** `3306` (default MySQL port)
   - **Username:** `littlelemon_admin` (the user created in Task 1)
   - **Password:** Click "Store in Keychain" or "Store in Vault" and enter the password
   - **Default Schema:** Leave blank (will be set later)

4. **Test the Connection**
   - Click the **Test Connection** button
   - If successful, you'll see: "Successfully made the MySQL connection"
   - If it fails, check:
     - MySQL server is running
     - Credentials are correct
     - Network connectivity

5. **Save Connection**
   - Click **OK** to save the connection
   - The connection will appear in your MySQL Connections list

### Connection Details Summary

```
Connection Name: Little Lemon Database
Hostname: localhost
Port: 3306
Username: littlelemon_admin
Authentication: Standard
```

## Verification

After completing both tasks, verify your setup:

1. **Verify User Creation:**
   ```sql
   SELECT user, host FROM mysql.user WHERE user = 'littlelemon_admin';
   ```

2. **Verify Connection:**
   - Double-click the "Little Lemon Database" connection
   - You should successfully connect without errors
   - You should see the Navigator panel with database objects

## Security Considerations

- **Strong Passwords:** Use complex passwords with mixed case, numbers, and special characters
- **Password Storage:** Use MySQL Workbench's secure password storage (Keychain/Vault)
- **Privilege Principle:** In production, grant only necessary privileges, not full DBA access
- **Host Restrictions:** Limit user access to specific hosts/IPs when possible
- **SSL/TLS:** Enable encrypted connections for production environments

## Troubleshooting

### Common Issues

1. **"Access Denied" Error**
   - Verify username and password are correct
   - Check user privileges in MySQL
   - Ensure MySQL server is running

2. **"Can't Connect to Server" Error**
   - Verify MySQL server is running
   - Check hostname and port are correct
   - Verify firewall settings allow connections

3. **Connection Timeout**
   - Check network connectivity
   - Verify MySQL server is accessible
   - Check if MySQL is bound to the correct interface

## Next Steps

Once the environment is set up, you can proceed with:
- Database schema design
- Creating tables and relationships
- Writing SQL queries
- Data modeling with EER diagrams
- Importing/exporting data

## Files in This Directory

- `task1_create_user.sql` - SQL script for creating the user account
- `task2_connection_config.md` - Detailed connection configuration guide
- `SETUP_GUIDE.md` - This comprehensive setup guide

## Conclusion

You have successfully:
- ✅ Created a new user account (`littlelemon_admin`)
- ✅ Set up a new MySQL connection (`Little Lemon Database`)

You are now ready to develop a suitable database system for Little Lemon!
