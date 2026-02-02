# Little Lemon Database - Bookings Management

This document describes the booking management system for Little Lemon, including stored procedures and transactions for handling table reservations.

## Overview

Little Lemon's booking system allows customers to:
- Check table availability
- Make new bookings
- Automatically prevent double-booking through transaction-based validation

## Tasks Completed

### Task 1: Populate Bookings Table ✅
**File:** `task1_insert_bookings.sql`

Inserts sample booking records into the Bookings table.

**Records to Insert:**
| BookingID | BookingDate | TableNumber | CustomerID |
|-----------|-------------|-------------|------------|
| 1         | 2022-10-10  | 5           | 1          |
| 2         | 2022-11-12  | 3           | 3          |
| 3         | 2022-10-11  | 2           | 2          |
| 4         | 2022-10-13  | 2           | 1          |

**Usage:**
```sql
-- Run the script to insert bookings
source task1_insert_bookings.sql;

-- Verify bookings
SELECT * FROM Bookings ORDER BY BookingID;
```

### Task 2: CheckBooking Stored Procedure ✅
**File:** `task2_checkbooking.sql`

Creates a stored procedure to check whether a table is already booked on a specific date.

**Parameters:**
- `BookingDateInput` (DATE) - The date to check
- `TableNumberInput` (INT) - The table number to check

**Usage:**
```sql
CALL CheckBooking('2022-10-10', 5);
```

**Output Examples:**
```
Booking Status
----------------------------------------
Table 5 is already booked on 2022-10-10
```

or

```
Booking Status
----------------------------------------
Table 1 is available on 2022-10-10
```

**Features:**
- Checks if table is booked on specific date
- Excludes cancelled bookings from check
- Returns clear status message
- Includes enhanced version with customer name details

### Task 3: AddValidBooking Stored Procedure ✅
**File:** `task3_addvalidbooking.sql`

Creates a stored procedure that uses a transaction to add a booking only if the table is available. Automatically rolls back if the table is already booked.

**Parameters:**
- `BookingDateInput` (DATE) - The booking date
- `TableNumberInput` (INT) - The table number
- `CustomerIDInput` (INT) - The customer making the booking

**Usage:**
```sql
CALL AddValidBooking('2022-10-10', 1, 1);
```

**Output Examples:**

**Success (Table Available):**
```
Booking Status
----------------------------------------
Table 1 is available on 2022-10-10 - booking confirmed
```

**Failure (Table Already Booked):**
```
Booking Status
----------------------------------------
Table 5 is already booked on 2022-10-10 - booking cancelled
```

**Features:**
- Uses transaction (START TRANSACTION, COMMIT, ROLLBACK)
- Validates table availability before booking
- Prevents double-booking automatically
- Provides clear confirmation or cancellation messages
- Includes enhanced versions with customer names and time support

## Transaction Flow

The `AddValidBooking` procedure follows this flow:

1. **START TRANSACTION** - Begin transaction
2. **Check Availability** - Query if table is booked
3. **IF Table Booked:**
   - ROLLBACK transaction
   - Return cancellation message
4. **ELSE (Table Available):**
   - INSERT new booking
   - COMMIT transaction
   - Return confirmation message

## Installation

### Prerequisites
- MySQL Server with LittleLemonDB database
- Bookings and Customers tables created
- Appropriate user privileges (CREATE PROCEDURE, EXECUTE)

### Steps

1. **Insert Sample Bookings (Task 1)**
   ```sql
   USE LittleLemonDB;
   source task1_insert_bookings.sql;
   ```

2. **Create CheckBooking Procedure (Task 2)**
   ```sql
   source task2_checkbooking.sql;
   ```

3. **Create AddValidBooking Procedure (Task 3)**
   ```sql
   source task3_addvalidbooking.sql;
   ```

## Usage Examples

### Example 1: Check Table Availability
```sql
-- Check if table 5 is available on 2022-10-10
CALL CheckBooking('2022-10-10', 5);

-- Check if table 1 is available on 2022-10-15
CALL CheckBooking('2022-10-15', 1);
```

### Example 2: Make a Valid Booking
```sql
-- Try to book table 1 for customer 1 on 2022-10-15
CALL AddValidBooking('2022-10-15', 1, 1);

-- Try to book table 5 on 2022-10-10 (will fail - already booked)
CALL AddValidBooking('2022-10-10', 5, 2);
```

### Example 3: View All Bookings
```sql
-- View all bookings with customer names
SELECT 
    b.BookingID,
    b.BookingDate,
    b.TableNumber,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    b.Status
FROM Bookings b
INNER JOIN Customers c ON b.CustomerID = c.CustomerID
ORDER BY b.BookingDate, b.TableNumber;
```

## Database Schema

### Bookings Table Structure
```sql
CREATE TABLE Bookings (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    BookingDate DATE NOT NULL,
    TableNumber INT NOT NULL,
    NumberOfGuests INT NOT NULL,
    BookingTime TIME,
    Status ENUM('Confirmed', 'Cancelled', 'Completed') DEFAULT 'Confirmed',
    Notes TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
```

### Relationship
- **Customers (1) → (M) Bookings** - One customer can have many bookings

## Best Practices

### Transaction Management
1. **Always use transactions** for operations affecting multiple tables
2. **Check conditions before committing** - Validate data before finalizing
3. **Rollback on errors** - Ensure data integrity on failures
4. **Keep transactions short** - Minimize lock time

### Booking Validation
1. **Check availability first** - Query before inserting
2. **Exclude cancelled bookings** - Don't count cancelled bookings as occupied
3. **Consider booking time** - If needed, check time slots as well
4. **Handle concurrent bookings** - Use appropriate locking mechanisms

### Error Handling
1. **Clear error messages** - Provide informative feedback
2. **Log failed attempts** - Track booking attempts for analysis
3. **Validate inputs** - Check date, table number, customer ID validity
4. **Handle edge cases** - Past dates, invalid table numbers, etc.

## Security Considerations

1. **Input Validation** - Validate all parameters before processing
2. **SQL Injection Prevention** - Use parameterized queries (stored procedures help)
3. **Access Control** - Limit who can create/modify bookings
4. **Audit Trail** - Log booking creation and modifications
5. **Data Integrity** - Use foreign keys and constraints

## Troubleshooting

### Issue: "Table is always shown as available"
**Solution:**
- Check if bookings were inserted correctly
- Verify date format matches (YYYY-MM-DD)
- Ensure Status field is not 'Cancelled' in existing bookings

### Issue: "Procedure not found"
**Solution:**
```sql
-- Verify procedure exists
SHOW PROCEDURE STATUS WHERE Db = 'LittleLemonDB';

-- Recreate if needed
DROP PROCEDURE IF EXISTS CheckBooking;
-- Then run the CREATE PROCEDURE statement again
```

### Issue: "Transaction not rolling back"
**Solution:**
- Ensure you're using InnoDB engine (supports transactions)
- Check that START TRANSACTION is called before operations
- Verify ROLLBACK is in the correct branch of IF statement

### Issue: "Foreign key constraint fails"
**Solution:**
- Ensure CustomerID exists in Customers table
- Verify customer IDs in INSERT statements match existing customers
- Check foreign key constraints are properly defined

## Performance Optimization

1. **Indexes** - Ensure indexes on BookingDate and TableNumber
2. **Query Optimization** - Use appropriate WHERE clauses
3. **Connection Pooling** - Reuse database connections
4. **Caching** - Cache availability checks for popular dates

## Additional Features (Optional)

Consider adding:
- Booking time slots (hourly reservations)
- Table capacity validation (number of guests)
- Booking cancellation procedure
- Booking modification procedure
- Email notifications for bookings
- Booking history and reporting

## Conclusion

The booking management system provides:
- ✅ Data population scripts
- ✅ Availability checking procedure
- ✅ Transaction-based booking validation
- ✅ Automatic double-booking prevention
- ✅ Clear status messages
- ✅ Data integrity guarantees

Little Lemon can now efficiently manage table bookings with automatic validation and integrity checks.
