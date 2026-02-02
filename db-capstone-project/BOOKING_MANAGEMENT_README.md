# Little Lemon Database - Booking Management Procedures

This document describes the stored procedures for managing bookings: adding, updating, and canceling bookings in the Little Lemon database.

## Overview

Little Lemon's booking management system provides three core stored procedures for CRUD (Create, Read, Update, Delete) operations on bookings:
- **AddBooking** - Add new booking records
- **UpdateBooking** - Update existing booking records
- **CancelBooking** - Cancel/delete booking records

## Tasks Completed

### Task 1: AddBooking Stored Procedure ✅
**File:** `task1_addbooking.sql`

Creates a stored procedure to add a new table booking record.

**Parameters:**
- `BookingIDInput` (INT) - The booking ID
- `CustomerIDInput` (INT) - The customer ID
- `BookingDateInput` (DATE) - The booking date
- `TableNumberInput` (INT) - The table number

**Usage:**
```sql
CALL AddBooking(5, 1, '2022-12-10', 4);
```

**Output:**
```
Confirmation
----------------------------------------
New booking added: Booking ID 5, Customer ID 1, Date 2022-12-10, Table 4
```

**Features:**
- Inserts new booking with specified parameters
- Sets default NumberOfGuests to 2
- Sets Status to 'Confirmed'
- Returns confirmation message
- Includes alternative version for AUTO_INCREMENT BookingID
- Includes enhanced version with validation

### Task 2: UpdateBooking Stored Procedure ✅
**File:** `task2_updatebooking.sql`

Creates a stored procedure to update existing bookings in the booking table.

**Parameters:**
- `BookingIDInput` (INT) - The booking ID to update
- `BookingDateInput` (DATE) - The new booking date

**Usage:**
```sql
CALL UpdateBooking(1, '2022-12-15');
```

**Output:**
```
Confirmation
----------------------------------------
Booking 1 updated successfully. New booking date: 2022-12-15
```

**Features:**
- Updates booking date for specified booking ID
- Checks if booking exists before updating
- Returns confirmation or error message
- Includes enhanced version for updating multiple fields
- Handles non-existent bookings gracefully

### Task 3: CancelBooking Stored Procedure ✅
**File:** `task3_cancelbooking.sql`

Creates a stored procedure to cancel or remove a booking.

**Parameters:**
- `BookingIDInput` (INT) - The booking ID to cancel

**Usage:**
```sql
CALL CancelBooking(5);
```

**Output:**
```
Confirmation
----------------------------------------
Booking 5 cancelled
```

**Features:**
- Deletes booking record from database
- Checks if booking exists before deleting
- Returns confirmation or error message
- Includes soft-delete alternative (recommended for production)
- Includes enhanced version with transaction support

## Installation

### Prerequisites
- MySQL Server with LittleLemonDB database
- Bookings and Customers tables created
- Appropriate user privileges (CREATE PROCEDURE, EXECUTE)

### Steps

1. **Create AddBooking Procedure**
   ```sql
   USE LittleLemonDB;
   source task1_addbooking.sql;
   ```

2. **Create UpdateBooking Procedure**
   ```sql
   source task2_updatebooking.sql;
   ```

3. **Create CancelBooking Procedure**
   ```sql
   source task3_cancelbooking.sql;
   ```

## Usage Examples

### Example 1: Add a New Booking
```sql
-- Add a new booking
CALL AddBooking(6, 2, '2022-12-20', 3);

-- Verify the booking was added
SELECT * FROM Bookings WHERE BookingID = 6;
```

### Example 2: Update an Existing Booking
```sql
-- Update booking date for booking ID 1
CALL UpdateBooking(1, '2022-12-25');

-- Verify the update
SELECT * FROM Bookings WHERE BookingID = 1;
```

### Example 3: Cancel a Booking
```sql
-- Cancel booking ID 5
CALL CancelBooking(5);

-- Verify the booking was deleted
SELECT * FROM Bookings WHERE BookingID = 5;
```

### Example 4: Complete Booking Workflow
```sql
-- 1. Add a new booking
CALL AddBooking(7, 3, '2022-12-30', 5);

-- 2. Update the booking date
CALL UpdateBooking(7, '2023-01-05');

-- 3. Cancel the booking
CALL CancelBooking(7);
```

## Procedure Details

### AddBooking Procedure

**Basic Structure:**
```sql
CREATE PROCEDURE AddBooking(
    IN BookingIDInput INT,
    IN CustomerIDInput INT,
    IN BookingDateInput DATE,
    IN TableNumberInput INT
)
BEGIN
    INSERT INTO Bookings (BookingID, CustomerID, BookingDate, TableNumber, NumberOfGuests, Status)
    VALUES (BookingIDInput, CustomerIDInput, BookingDateInput, TableNumberInput, 2, 'Confirmed');
    
    SELECT CONCAT('New booking added: Booking ID ', BookingIDInput, ...) AS 'Confirmation';
END
```

**Considerations:**
- If BookingID is AUTO_INCREMENT, use the alternative version
- Consider adding validation for customer existence
- Consider checking table availability before adding

### UpdateBooking Procedure

**Basic Structure:**
```sql
CREATE PROCEDURE UpdateBooking(
    IN BookingIDInput INT,
    IN BookingDateInput DATE
)
BEGIN
    UPDATE Bookings
    SET BookingDate = BookingDateInput
    WHERE BookingID = BookingIDInput;
    
    SELECT CONCAT('Booking ', BookingIDInput, ' updated successfully...') AS 'Confirmation';
END
```

**Considerations:**
- Only updates booking date (as per requirements)
- Enhanced version allows updating multiple fields
- Validates booking existence before updating

### CancelBooking Procedure

**Basic Structure:**
```sql
CREATE PROCEDURE CancelBooking(IN BookingIDInput INT)
BEGIN
    DELETE FROM Bookings
    WHERE BookingID = BookingIDInput;
    
    SELECT CONCAT('Booking ', BookingIDInput, ' cancelled') AS 'Confirmation';
END
```

**Considerations:**
- Performs hard delete (permanently removes record)
- For production, consider soft delete (update status to 'Cancelled')
- May need to handle related records (orders, etc.)

## Best Practices

### Data Integrity
1. **Validate Inputs** - Check customer exists, table is valid, date is valid
2. **Check Availability** - Verify table is available before adding/updating
3. **Use Transactions** - For operations affecting multiple tables
4. **Handle Errors** - Provide clear error messages

### Soft Delete vs Hard Delete
- **Hard Delete** (current implementation): Permanently removes record
  - Pros: Clean database, no orphaned records
  - Cons: Loss of historical data, cannot recover
  
- **Soft Delete** (recommended for production): Updates status to 'Cancelled'
  - Pros: Preserves history, can recover, better for reporting
  - Cons: Requires filtering in queries

### Security
1. **Input Validation** - Validate all parameters
2. **SQL Injection Prevention** - Stored procedures help prevent injection
3. **Access Control** - Limit who can create/modify bookings
4. **Audit Trail** - Log booking changes

## Troubleshooting

### Issue: "Booking ID already exists" (AddBooking)
**Solution:**
- Check if BookingID already exists before inserting
- Use AUTO_INCREMENT version if BookingID should be auto-generated
- Or use a different BookingID

### Issue: "Booking not found" (UpdateBooking/CancelBooking)
**Solution:**
- Verify BookingID exists: `SELECT * FROM Bookings WHERE BookingID = X;`
- Check if booking was already deleted
- Ensure correct BookingID is being used

### Issue: "Foreign key constraint fails" (AddBooking)
**Solution:**
- Ensure CustomerID exists in Customers table
- Verify customer ID is correct
- Check foreign key constraints

### Issue: "Procedure not found"
**Solution:**
```sql
-- Verify procedure exists
SHOW PROCEDURE STATUS WHERE Db = 'LittleLemonDB';

-- Recreate if needed
DROP PROCEDURE IF EXISTS AddBooking;
-- Then run the CREATE PROCEDURE statement again
```

## Alternative Implementations

### AUTO_INCREMENT BookingID
If your BookingID is AUTO_INCREMENT, use the alternative version that:
- Doesn't require BookingID parameter
- Uses LAST_INSERT_ID() to get the new ID
- Returns the generated BookingID in confirmation

### Soft Delete for CancelBooking
For production environments, consider using soft delete:
```sql
UPDATE Bookings
SET Status = 'Cancelled'
WHERE BookingID = BookingIDInput;
```
This preserves historical data and allows for reporting.

### Enhanced Validation
Add validation for:
- Customer existence
- Table availability
- Date validity (not in past, within business hours)
- Table number validity
- Number of guests vs table capacity

## Related Procedures

These procedures work alongside:
- **CheckBooking** - Check table availability
- **AddValidBooking** - Add booking with transaction validation

See `BOOKINGS_README.md` for more booking management procedures.

## Conclusion

The booking management procedures provide:
- ✅ Add new bookings (AddBooking)
- ✅ Update existing bookings (UpdateBooking)
- ✅ Cancel/delete bookings (CancelBooking)
- ✅ Clear confirmation messages
- ✅ Error handling
- ✅ Alternative implementations for different needs

Little Lemon can now efficiently manage bookings with these stored procedures.
