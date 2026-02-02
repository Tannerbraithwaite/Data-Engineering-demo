# Little Lemon Database Capstone Project

This folder contains the complete database implementation for Little Lemon's relational database system.

## Project Overview

Little Lemon needs a robust relational database system in MySQL to store and manage large amounts of data about:
- Bookings
- Orders
- Order delivery status
- Menu items
- Customer details
- Staff information

## Project Structure

```
db-capstone-project/
├── README.md                      # This file
├── ER_DIAGRAM_DESIGN.md           # Task 1: ER Diagram design documentation
├── LittleLemonDB.sql              # Task 2: Complete database schema (forward engineered)
├── task3_show_databases.sql       # Task 3: SQL to show all databases
├── QUERIES_README.md              # Documentation for query tasks
├── task1_orders_view.sql          # Query Task 1: Create virtual table (VIEW)
├── task2_join_query.sql           # Query Task 2: JOIN query for orders > $150
├── task3_subquery.sql             # Query Task 3: Subquery with ANY operator
├── task1_getmaxquantity.sql        # Procedure Task 1: GetMaxQuantity stored procedure
├── task2_getorderdetail.sql        # Procedure Task 2: GetOrderDetail prepared statement
├── task3_cancelorder.sql           # Procedure Task 3: CancelOrder stored procedure
├── task1_insert_bookings.sql      # Booking Task 1: Insert booking records
├── task2_checkbooking.sql          # Booking Task 2: CheckBooking stored procedure
├── task3_addvalidbooking.sql       # Booking Task 3: AddValidBooking with transaction
├── task1_addbooking.sql            # Booking Management Task 1: AddBooking procedure
├── task2_updatebooking.sql         # Booking Management Task 2: UpdateBooking procedure
├── task3_cancelbooking.sql         # Booking Management Task 3: CancelBooking procedure
├── QUERIES_README.md               # Documentation for query tasks
├── PROCEDURES_README.md            # Documentation for stored procedures and prepared statements
├── BOOKINGS_README.md              # Documentation for booking management tasks
├── BOOKING_MANAGEMENT_README.md    # Documentation for booking CRUD procedures
├── schema_adjustment.sql           # Optional schema adjustments
└── (LittleLemonDM.png)            # ER Diagram visual export (to be created in MySQL Workbench)
```

## Tasks Completed

### Task 1: ER Diagram Design ✅
- Created normalized ER diagram adhering to 1NF, 2NF, and 3NF
- Identified all entities, attributes, primary keys, and foreign keys
- Defined data types and constraints
- **Model Name:** LittleLemonDM
- **Export Format:** PNG (to be exported from MySQL Workbench)

See `ER_DIAGRAM_DESIGN.md` for complete design documentation.

### Task 2: Database Implementation ✅
- Forward engineered the data model into MySQL server
- **Database Name:** LittleLemonDB
- Created all tables with proper relationships
- Included sample data for testing

See `LittleLemonDB.sql` for the complete schema implementation.

### Task 3: Show Databases ✅
- Created SQL script to show all databases in MySQL server
- Includes verification query to check if LittleLemonDB exists

See `task3_show_databases.sql` for the SQL queries.

## Database Schema

### Tables

1. **Customers** - Customer information and contact details
2. **Staff** - Staff information including roles and salaries
3. **Bookings** - Restaurant table bookings
4. **MenuItems** - Menu items (starters, courses, drinks, desserts)
5. **Orders** - Customer orders
6. **OrderItems** - Individual items within orders
7. **OrderDeliveryStatus** - Delivery status tracking

### Relationships

- Customers → Bookings (1:M)
- Customers → Orders (1:M)
- Bookings → Orders (1:0..1)
- Orders → OrderItems (1:M)
- Orders → OrderDeliveryStatus (1:1)
- MenuItems → OrderItems (1:M)
- Staff → Orders (1:M)

## Installation Instructions

### Prerequisites
- MySQL Server installed and running
- MySQL Workbench installed
- Access to MySQL server with appropriate privileges

### Steps to Implement

1. **Open MySQL Workbench**
   - Connect to your MySQL server

2. **Create the Database**
   - Open `LittleLemonDB.sql` in MySQL Workbench
   - Execute the entire script (or run it from command line)
   - This will create the database and all tables

3. **Verify Installation**
   - Run `task3_show_databases.sql` to verify the database exists
   - Check that all tables were created successfully

4. **View ER Diagram** (Optional)
   - Import the model into MySQL Workbench Model Editor
   - Export as PNG: LittleLemonDM.png

### Command Line Installation

```bash
# Connect to MySQL
mysql -u root -p

# Run the SQL script
source /path/to/db-capstone-project/LittleLemonDB.sql

# Or directly
mysql -u root -p < LittleLemonDB.sql
```

## Normalization

The database design follows normalization principles:

- **1NF (First Normal Form):** All attributes are atomic, no repeating groups
- **2NF (Second Normal Form):** All non-key attributes fully depend on primary key
- **3NF (Third Normal Form):** No transitive dependencies

## Sample Data

The `LittleLemonDB.sql` file includes sample data for:
- 3 customers
- 4 staff members
- 9 menu items
- 3 bookings
- 3 orders with order items
- 3 delivery status records

## Usage Examples

### Show all databases
```sql
SHOW DATABASES;
```

### Use the database
```sql
USE LittleLemonDB;
```

### View all tables
```sql
SHOW TABLES;
```

### View table structure
```sql
DESCRIBE Customers;
```

### Query sample data
```sql
-- View all customers
SELECT * FROM Customers;

-- View all orders with customer names
SELECT o.OrderID, c.FirstName, c.LastName, o.OrderDate, o.TotalCost
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;

-- View menu items by type
SELECT ItemType, ItemName, Price
FROM MenuItems
ORDER BY ItemType, ItemName;
```

## Database Features

- ✅ Fully normalized (3NF)
- ✅ Foreign key constraints
- ✅ Check constraints for data validation
- ✅ Indexes for performance
- ✅ Proper data types
- ✅ Default values
- ✅ Timestamps for audit trail
- ✅ Sample data included

## Query Tasks

Additional SQL query tasks have been completed:

### Query Task 1: Virtual Table (VIEW) ✅
- Created `OrdersView` virtual table
- Shows OrderID, Quantity, and Cost for orders with quantity > 2
- See `task1_orders_view.sql` and `QUERIES_README.md`

### Query Task 2: JOIN Query ✅
- Extracts data from 4 tables (Customers, Orders, Menus, MenuItems)
- Filters customers with orders > $150
- Sorted by lowest cost
- See `task2_join_query.sql` and `QUERIES_README.md`

### Query Task 3: Subquery with ANY ✅
- Finds menu items with more than 2 orders
- Uses subquery with ANY operator
- See `task3_subquery.sql` and `QUERIES_README.md`

For detailed query documentation, see `QUERIES_README.md`.

### Stored Procedures and Prepared Statements Tasks

Additional optimization tasks using stored procedures and prepared statements:

### Procedure Task 1: GetMaxQuantity ✅
- Created stored procedure to display maximum ordered quantity
- Reusable logic without retyping code
- See `task1_getmaxquantity.sql` and `PROCEDURES_README.md`

### Procedure Task 2: GetOrderDetail ✅
- Created prepared statement that accepts CustomerID
- Returns order id, quantity, and order cost
- Reduces parsing time and secures against SQL injection
- See `task2_getorderdetail.sql` and `PROCEDURES_README.md`

### Procedure Task 3: CancelOrder ✅
- Created stored procedure to delete order by order ID
- Includes transaction handling and confirmation messages
- See `task3_cancelorder.sql` and `PROCEDURES_README.md`

For detailed procedures documentation, see `PROCEDURES_README.md`.

### Booking Management Tasks

Additional tasks for managing table bookings with transactions:

### Booking Task 1: Insert Booking Records ✅
- Populated Bookings table with sample booking records
- Includes verification queries
- See `task1_insert_bookings.sql` and `BOOKINGS_README.md`

### Booking Task 2: CheckBooking Procedure ✅
- Created stored procedure to check table availability
- Accepts booking date and table number as parameters
- Returns clear status message
- See `task2_checkbooking.sql` and `BOOKINGS_README.md`

### Booking Task 3: AddValidBooking Procedure ✅
- Created stored procedure with transaction support
- Validates table availability before booking
- Automatically rolls back if table is already booked
- Prevents double-booking with integrity checks
- See `task3_addvalidbooking.sql` and `BOOKINGS_README.md`

For detailed booking management documentation, see `BOOKINGS_README.md`.

### Booking CRUD Procedures

Additional stored procedures for managing bookings (add, update, delete):

### Booking Management Task 1: AddBooking Procedure ✅
- Created stored procedure to add new booking records
- Accepts booking id, customer id, booking date, and table number
- Returns confirmation message
- See `task1_addbooking.sql` and `BOOKING_MANAGEMENT_README.md`

### Booking Management Task 2: UpdateBooking Procedure ✅
- Created stored procedure to update existing bookings
- Accepts booking id and new booking date
- Includes UPDATE statement and confirmation message
- See `task2_updatebooking.sql` and `BOOKING_MANAGEMENT_README.md`

### Booking Management Task 3: CancelBooking Procedure ✅
- Created stored procedure to cancel/delete bookings
- Accepts booking id as parameter
- Includes DELETE statement and confirmation message
- See `task3_cancelbooking.sql` and `BOOKING_MANAGEMENT_README.md`

For detailed booking CRUD procedures documentation, see `BOOKING_MANAGEMENT_README.md`.

## Next Steps

After implementing the database, you can:
1. Create additional indexes based on query patterns
2. Add views for common queries
3. Create stored procedures for complex operations
4. Set up triggers for automated tasks
5. Implement backup and recovery procedures
6. Add user roles and permissions
7. Run the query tasks to generate reports

## Notes

- The database uses InnoDB engine for transaction support
- UTF8MB4 character set for international character support
- All monetary values use DECIMAL(10,2) for precision
- Foreign keys use appropriate ON DELETE/UPDATE actions

## Conclusion

This capstone project successfully:
- ✅ Created a normalized ER diagram (LittleLemonDM)
- ✅ Implemented the database in MySQL (LittleLemonDB)
- ✅ Verified database creation with SQL queries

The database is ready for use and can be extended with additional features as needed.
