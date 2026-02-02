# Task 2: Creating a New MySQL Connection

This document outlines the steps to create a new MySQL connection in MySQL Workbench.

## Connection Setup Steps

### Step 1: Access MySQL Workbench Home Screen
- Open MySQL Workbench
- You should see the home screen with existing connections (if any)

### Step 2: Create New Connection
1. In the MySQL Workbench home screen, locate the **MySQL Connections** section
2. Click the **plus (+) icon** to open the "Setup New Connection" form

### Step 3: Fill in Connection Details

Use the following configuration for Little Lemon's database connection:

```
Connection Name: Little Lemon Database
Connection Method: Standard (TCP/IP)
Hostname: localhost (or your MySQL server IP address)
Port: 3306 (default MySQL port)
Username: littlelemon_admin
Password: [Click "Store in Keychain" or "Store in Vault" for security]
Default Schema: (leave blank initially)
```

### Step 4: Test Connection
1. Click the **"Test Connection"** button
2. If successful, you should see: "Successfully made the MySQL connection"
3. If there are errors, verify:
   - MySQL server is running
   - Username and password are correct
   - Hostname and port are accessible
   - Firewall settings allow the connection

### Step 5: Save Connection
- Click **"OK"** to save the connection
- The new connection will appear in your MySQL Connections list

## Connection Configuration File (Alternative Method)

If you prefer to configure connections via configuration file, you can use:

**Location:** `~/.mysql/workbench/connections.xml` (on macOS/Linux)

Example connection entry:
```xml
<value type="string" key="hostName">localhost</value>
<value type="int" key="port">3306</value>
<value type="string" key="userName">littlelemon_admin</value>
<value type="string" key="defaultSchema"></value>
<value type="string" key="name">Little Lemon Database</value>
```

## Security Best Practices

1. **Use strong passwords** for database users
2. **Store passwords securely** using MySQL Workbench's keychain/vault feature
3. **Limit user privileges** to only what's necessary (though for this demo, full privileges are granted)
4. **Use SSL connections** in production environments
5. **Restrict host access** by specifying specific IP addresses instead of '%'

## Next Steps

Once the connection is established, you can:
- Create and manage database schemas
- Execute SQL queries
- Design database models using the EER Diagram tool
- Import/export data
- Manage server administration tasks
