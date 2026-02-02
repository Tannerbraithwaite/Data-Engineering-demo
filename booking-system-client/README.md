# Little Lemon Booking System - Client Project

This project contains the client-side code for Little Lemon's booking system, allowing guests to book tables with the restaurant.

## Overview

The booking system client connects to the Little Lemon MySQL database to manage table bookings. This project uses Python, Jupyter Notebooks, and MySQL Connector/Python to interact with the database.

## Prerequisites

Before starting, ensure you have:
- Python 3.x installed
- MySQL Server running with LittleLemonDB database
- Access credentials to the MySQL database

## Project Structure

```
booking-system-client/
├── README.md                    # This file
├── requirements.txt             # Python dependencies
├── config.py                    # Database configuration
├── setup_instructions.md        # Detailed setup guide
├── notebooks/                   # Jupyter notebooks
│   └── booking_system.ipynb     # Main booking system notebook
└── .env.example                 # Example environment variables file
```

## Quick Start

### Task 1: Verify Python Installation

Check that Python 3 is installed:

```bash
python --version
# or
python3 --version
```

Expected output: `Python 3.x.x`

If Python is not installed or you have an older version, download from [python.org/downloads](https://www.python.org/downloads/)

### Task 2: Install Jupyter

Install Jupyter using pip:

```bash
python -m pip install jupyter
# or
python3 -m pip install jupyter
```

Alternatively, install all dependencies at once:

```bash
pip install -r requirements.txt
```

### Task 3: Set Up Database Connection

1. **Install MySQL Connector:**

```bash
pip install mysql-connector-python
```

2. **Configure Database Connection:**

Edit `config.py` with your database credentials, or use environment variables (see `.env.example`)

3. **Test Connection:**

Open the Jupyter notebook and run the connection test cells.

## Installation Steps

### Step 1: Navigate to Project Directory

```bash
cd booking-system-client
```

### Step 2: Create Virtual Environment (Recommended)

```bash
python3 -m venv venv
source venv/bin/activate  # On macOS/Linux
# or
venv\Scripts\activate  # On Windows
```

### Step 3: Install Dependencies

```bash
pip install -r requirements.txt
```

### Step 4: Start Jupyter Notebook

```bash
jupyter notebook
```

This will open Jupyter in your web browser.

### Step 5: Open the Booking System Notebook

1. Navigate to the `notebooks/` folder
2. Open `booking_system.ipynb`
3. Follow the instructions in the notebook

## Database Configuration

### Option 1: Using config.py

Edit `config.py` with your database credentials:

```python
DB_CONFIG = {
    'user': 'your_user_name',
    'password': 'your_password',
    'host': 'localhost',
    'database': 'LittleLemonDB',
    'port': 3306
}
```

### Option 2: Using Environment Variables

1. Copy `.env.example` to `.env`
2. Fill in your database credentials
3. The notebook will automatically load them

## Usage

### Starting Jupyter Notebook

```bash
jupyter notebook
```

### Creating a New Notebook

1. Click "New" in Jupyter interface
2. Select "Python 3" (or "ipykernel")
3. Start writing your code

### Database Connection Example

```python
import mysql.connector as connector

connection = connector.connect(
    user="your_user_name",
    password="your_password",
    host="localhost",
    database="LittleLemonDB"
)

# Test connection
if connection.is_connected():
    print("Successfully connected to MySQL database")
    connection.close()
```

## Troubleshooting

### Issue: "python: command not found"
**Solution:**
- Use `python3` instead of `python`
- Ensure Python is in your PATH
- Reinstall Python if necessary

### Issue: "pip: command not found"
**Solution:**
```bash
python3 -m ensurepip --upgrade
python3 -m pip install --upgrade pip
```

### Issue: "mysql-connector-python installation fails"
**Solution:**
```bash
pip install --upgrade pip
pip install mysql-connector-python
```

### Issue: "Connection refused" or "Access denied"
**Solution:**
- Verify MySQL server is running
- Check username and password
- Ensure user has proper permissions
- Verify database name is correct

### Issue: "Module not found"
**Solution:**
```bash
pip install -r requirements.txt
```

## Development

### Adding New Features

1. Create new cells in the Jupyter notebook
2. Test your code incrementally
3. Document your functions
4. Update this README if needed

### Best Practices

1. **Use Virtual Environments** - Isolate project dependencies
2. **Environment Variables** - Don't commit credentials
3. **Error Handling** - Always handle database connection errors
4. **Close Connections** - Always close database connections when done
5. **Version Control** - Commit code regularly (exclude .env files)

## Next Steps

After setting up the environment:

1. ✅ Verify Python installation
2. ✅ Install Jupyter
3. ✅ Install MySQL Connector
4. ✅ Test database connection
5. ⏭️ Build booking system functionality

## Resources

- [Python Documentation](https://docs.python.org/3/)
- [Jupyter Documentation](https://jupyter.org/documentation)
- [MySQL Connector/Python](https://dev.mysql.com/doc/connector-python/en/)
- [Little Lemon Database Schema](../db-capstone-project/README.md)

## License

This project is part of the Little Lemon database system.
