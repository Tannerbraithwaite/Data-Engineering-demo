-- =====================================================
-- Task 3: Create Stored Procedure with Transaction - AddValidBooking
-- =====================================================
-- Little Lemon needs a stored procedure called AddValidBooking that uses 
-- a transaction to verify a booking and decline reservations for tables 
-- that are already booked under another name.
-- The procedure must rollback if a customer reserves a table that's 
-- already booked under another name.

USE LittleLemonDB;

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS AddValidBooking;

-- Create the AddValidBooking stored procedure with transaction
DELIMITER //

CREATE PROCEDURE AddValidBooking(
    IN BookingDateInput DATE, 
    IN TableNumberInput INT,
    IN CustomerIDInput INT
)
BEGIN
    DECLARE TableBooked INT DEFAULT 0;
    
    -- Start transaction
    START TRANSACTION;
    
    -- Check if the table is already booked on the given date
    SELECT COUNT(*) INTO TableBooked
    FROM Bookings
    WHERE BookingDate = BookingDateInput 
      AND TableNumber = TableNumberInput
      AND Status != 'Cancelled';
    
    -- IF ELSE statement to check if table is already booked
    IF TableBooked > 0 THEN
        -- Table is already booked, rollback the transaction
        ROLLBACK;
        SELECT CONCAT('Table ', TableNumberInput, ' is already booked on ', BookingDateInput, ' - booking cancelled') AS 'Booking Status';
    ELSE
        -- Table is available, insert the new booking
        INSERT INTO Bookings (BookingDate, TableNumber, CustomerID, Status)
        VALUES (BookingDateInput, TableNumberInput, CustomerIDInput, 'Confirmed');
        
        -- Commit the transaction
        COMMIT;
        SELECT CONCAT('Table ', TableNumberInput, ' is available on ', BookingDateInput, ' - booking confirmed') AS 'Booking Status';
    END IF;
END //

DELIMITER ;

-- Test the AddValidBooking procedure
-- Test case 1: Try to book table 5 on 2022-10-10 (should fail - already booked)
CALL AddValidBooking('2022-10-10', 5, 1);

-- Test case 2: Try to book table 1 on 2022-10-10 (should succeed - available)
CALL AddValidBooking('2022-10-10', 1, 1);

-- Test case 3: Try to book table 2 on 2022-10-11 (should fail - already booked)
CALL AddValidBooking('2022-10-11', 2, 2);

-- Test case 4: Try to book table 4 on 2022-10-15 (should succeed - available)
CALL AddValidBooking('2022-10-15', 4, 1);

-- Verify the bookings
SELECT 
    BookingID,
    BookingDate,
    TableNumber,
    CustomerID,
    Status
FROM Bookings
ORDER BY BookingDate, TableNumber;

-- =====================================================
-- Enhanced Version: With Customer Name Validation
-- =====================================================
-- This version includes customer name in the output:
/*
DELIMITER //

CREATE PROCEDURE AddValidBooking(
    IN BookingDateInput DATE, 
    IN TableNumberInput INT,
    IN CustomerIDInput INT
)
BEGIN
    DECLARE TableBooked INT DEFAULT 0;
    DECLARE ExistingCustomerName VARCHAR(200);
    DECLARE NewCustomerName VARCHAR(200);
    
    -- Get the new customer's name
    SELECT CONCAT(FirstName, ' ', LastName) INTO NewCustomerName
    FROM Customers
    WHERE CustomerID = CustomerIDInput;
    
    -- Start transaction
    START TRANSACTION;
    
    -- Check if the table is already booked on the given date
    SELECT COUNT(*), CONCAT(c.FirstName, ' ', c.LastName) INTO TableBooked, ExistingCustomerName
    FROM Bookings b
    INNER JOIN Customers c ON b.CustomerID = c.CustomerID
    WHERE b.BookingDate = BookingDateInput 
      AND b.TableNumber = TableNumberInput
      AND b.Status != 'Cancelled';
    
    -- IF ELSE statement to check if table is already booked
    IF TableBooked > 0 THEN
        -- Table is already booked, rollback the transaction
        ROLLBACK;
        SELECT CONCAT('Table ', TableNumberInput, ' is already booked on ', BookingDateInput, ' by ', ExistingCustomerName, ' - booking cancelled') AS 'Booking Status';
    ELSE
        -- Table is available, insert the new booking
        INSERT INTO Bookings (BookingDate, TableNumber, CustomerID, Status)
        VALUES (BookingDateInput, TableNumberInput, CustomerIDInput, 'Confirmed');
        
        -- Commit the transaction
        COMMIT;
        SELECT CONCAT('Table ', TableNumberInput, ' is available on ', BookingDateInput, ' - booking confirmed for ', NewCustomerName) AS 'Booking Status';
    END IF;
END //

DELIMITER ;
*/

-- =====================================================
-- Alternative: With Booking Time Support
-- =====================================================
-- If you want to support booking time as well:
/*
DELIMITER //

CREATE PROCEDURE AddValidBooking(
    IN BookingDateInput DATE, 
    IN TableNumberInput INT,
    IN CustomerIDInput INT,
    IN BookingTimeInput TIME
)
BEGIN
    DECLARE TableBooked INT DEFAULT 0;
    
    START TRANSACTION;
    
    -- Check if the table is already booked on the given date and time
    SELECT COUNT(*) INTO TableBooked
    FROM Bookings
    WHERE BookingDate = BookingDateInput 
      AND TableNumber = TableNumberInput
      AND BookingTime = BookingTimeInput
      AND Status != 'Cancelled';
    
    IF TableBooked > 0 THEN
        ROLLBACK;
        SELECT CONCAT('Table ', TableNumberInput, ' is already booked on ', BookingDateInput, ' at ', BookingTimeInput, ' - booking cancelled') AS 'Booking Status';
    ELSE
        INSERT INTO Bookings (BookingDate, TableNumber, CustomerID, BookingTime, Status)
        VALUES (BookingDateInput, TableNumberInput, CustomerIDInput, BookingTimeInput, 'Confirmed');
        
        COMMIT;
        SELECT CONCAT('Table ', TableNumberInput, ' is available on ', BookingDateInput, ' at ', BookingTimeInput, ' - booking confirmed') AS 'Booking Status';
    END IF;
END //

DELIMITER ;
*/
