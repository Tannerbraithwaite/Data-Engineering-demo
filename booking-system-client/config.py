# Little Lemon Booking System - Database Configuration
# Update these values with your MySQL database credentials

DB_CONFIG = {
    'user': 'littlelemon_admin',  # Change to your MySQL username
    'password': 'SecurePassword123!@#',  # Change to your MySQL password
    'host': 'localhost',  # Change if MySQL is on a different host
    'db': 'LittleLemonDB',  # Database name (using 'db' parameter)
    'port': 3306  # Default MySQL port
}

# Alternative: Load from environment variables
# Uncomment the following lines if using .env file
"""
import os
from dotenv import load_dotenv

load_dotenv()

DB_CONFIG = {
    'user': os.getenv('DB_USER', 'littlelemon_admin'),
    'password': os.getenv('DB_PASSWORD', ''),
    'host': os.getenv('DB_HOST', 'localhost'),
    'db': os.getenv('DB_NAME', 'LittleLemonDB'),  # Using 'db' parameter
    'port': int(os.getenv('DB_PORT', 3306))
}
"""
