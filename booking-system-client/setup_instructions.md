# Little Lemon Booking System - Setup Instructions

This document provides detailed step-by-step instructions for setting up the booking system client project.

## Task 1: Verify Python Installation

### Step 1: Open Terminal/Command Prompt

- **macOS/Linux:** Open Terminal
- **Windows:** Open Command Prompt or PowerShell

### Step 2: Check Python Version

Type the following command:

```bash
python --version
```

**Expected Output:**
```
Python 3.x.x
```

### Alternative Commands

If `python` doesn't work, try:

```bash
python3 --version
# or
py --version
```

### If Python is Not Installed

1. Navigate to [python.org/downloads](https://www.python.org/downloads/)
2. Download Python 3.x for your operating system
3. Run the installer
4. **Important:** Check "Add Python to PATH" during installation
5. Restart your terminal
6. Verify installation: `python --version`

### If Python Version is 2.x

You need Python 3.x. Follow the installation steps above.

## Task 2: Install Jupyter

### Step 1: Install Jupyter

Run the following command:

```bash
python -m pip install jupyter
```

**Alternative (if using python3):**

```bash
python3 -m pip install jupyter
```

### Step 2: Verify Installation

```bash
jupyter --version
```

**Expected Output:**
```
jupyter core     : 4.x.x
jupyter-notebook : 6.x.x
...
```

### Step 3: Start Jupyter Notebook

```bash
jupyter notebook
```

This will:
- Start the Jupyter server
- Open your default web browser
- Display the Jupyter interface

### Step 4: Create a New Notebook

1. In the Jupyter interface, click **"New"** button
2. Select **"Python 3"** (or **"ipykernel"**)
3. A new notebook tab will open
4. You can now write and execute Python code

### Alternative: Install All Dependencies

Instead of installing Jupyter separately, you can install all dependencies at once:

```bash
pip install -r requirements.txt
```

## Task 3: Set Up Database Connection

### Step 1: Install MySQL Connector

In your terminal, run:

```bash
pip install mysql-connector-python
```

**Or in Jupyter Notebook cell:**

```python
!pip install mysql-connector-python
```

### Step 2: Import the Connector

In your Jupyter notebook, create a new cell and type:

```python
import mysql.connector as connector
```

### Step 3: Test Database Connection

Create a new cell with the following code:

```python
# Test database connection
connection = connector.connect(
    user="your_user_name",  # Replace with your MySQL username
    password="your_password",  # Replace with your MySQL password
    host="localhost",
    database="LittleLemonDB"
)

# Verify connection
if connection.is_connected():
    print("Successfully connected to MySQL database")
    
    # Get database info
    db_info = connection.get_server_info()
    print(f"MySQL Server version: {db_info}")
    
    # Close connection
    connection.close()
    print("Connection closed")
else:
    print("Failed to connect to MySQL database")
```

### Step 4: Update Credentials

Replace the following in the connection code:
- `your_user_name` → Your MySQL username (e.g., `littlelemon_admin`)
- `your_password` → Your MySQL password

### Using Configuration File

Instead of hardcoding credentials, you can use the `config.py` file:

```python
from config import DB_CONFIG
import mysql.connector as connector

connection = connector.connect(**DB_CONFIG)

if connection.is_connected():
    print("Successfully connected to MySQL database")
    connection.close()
```

## Complete Setup Checklist

- [ ] Python 3.x installed and verified
- [ ] Jupyter installed and verified
- [ ] MySQL Connector/Python installed
- [ ] Database credentials configured
- [ ] Database connection tested successfully
- [ ] Jupyter notebook created and ready

## Common Issues and Solutions

### Issue 1: "python: command not found"

**Solution:**
- Use `python3` instead of `python`
- Add Python to your system PATH
- Reinstall Python with "Add to PATH" option

### Issue 2: "pip: command not found"

**Solution:**
```bash
python3 -m ensurepip --upgrade
python3 -m pip install --upgrade pip
```

### Issue 3: "ModuleNotFoundError: No module named 'mysql'"

**Solution:**
```bash
pip install mysql-connector-python
# or
python3 -m pip install mysql-connector-python
```

### Issue 4: "Access denied for user"

**Solution:**
- Verify username and password are correct
- Ensure MySQL user has proper permissions
- Check if user exists: `SELECT user FROM mysql.user;`

### Issue 5: "Can't connect to MySQL server"

**Solution:**
- Verify MySQL server is running
- Check host and port (default: localhost:3306)
- Verify firewall settings allow connection

### Issue 6: "Unknown database 'LittleLemonDB'"

**Solution:**
- Create the database first (see `../db-capstone-project/LittleLemonDB.sql`)
- Verify database name is correct
- Check user has access to the database

## Next Steps

After completing all three tasks:

1. ✅ Python installed and verified
2. ✅ Jupyter installed and running
3. ✅ MySQL Connector installed
4. ✅ Database connection established
5. ⏭️ Ready to build booking system functionality

## Additional Resources

- [Python Installation Guide](https://www.python.org/downloads/)
- [Jupyter Documentation](https://jupyter.org/documentation)
- [MySQL Connector/Python Documentation](https://dev.mysql.com/doc/connector-python/en/)
- [Virtual Environments Guide](https://docs.python.org/3/tutorial/venv.html)

## Security Notes

⚠️ **Important Security Reminders:**

1. **Never commit credentials** to version control
2. **Use environment variables** or `.env` files for sensitive data
3. **Add `.env` to `.gitignore`** to prevent accidental commits
4. **Use strong passwords** for database users
5. **Limit database user permissions** to only what's needed

## Conclusion

You have now successfully:
- ✅ Verified Python installation
- ✅ Installed Jupyter Notebook
- ✅ Installed MySQL Connector/Python
- ✅ Established database connection

Your working environment is now configured and ready for building Little Lemon's booking system!
