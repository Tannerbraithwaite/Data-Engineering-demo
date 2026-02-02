-- =====================================================
-- Task 1: Create Stored Procedure - AddBooking
-- =====================================================
-- Little Lemon needs a procedure called AddBooking to add a new 
-- table booking record.
-- The procedure should include four input parameters:
-- - booking id
-- - customer id
-- - booking date
-- - table number

USE LittleLemonDB;

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS AddBooking;

-- Create the AddBooking stored procedure
DELIMITER //

CREATE PROCEDURE AddBooking(
    IN BookingIDInput INT,
    IN CustomerIDInput INT,
    IN BookingDateInput DATE,
    IN TableNumberInput INT
)
BEGIN
    -- Insert the new booking record
    INSERT INTO Bookings (BookingID, CustomerID, BookingDate, TableNumber, NumberOfGuests, Status)
    VALUES (BookingIDInput, CustomerIDInput, BookingDateInput, TableNumberInput, 2, 'Confirmed');
    
    -- Return confirmation message
    SELECT CONCAT('New booking added: Booking ID ', BookingIDInput, ', Customer ID ', CustomerIDInput, 
                  ', Date ', BookingDateInput, ', Table ', TableNumberInput) AS 'Confirmation';
END //

DELIMITER ;

-- Test the AddBooking procedure
-- Example: Add booking with ID 5, Customer 1, Date 2022-12-10, Table 4
CALL AddBooking(5, 1, '2022-12-10', 4);

-- Verify the booking was added
SELECT * FROM Bookings WHERE BookingID = 5;

-- =====================================================
-- Alternative: If BookingID is AUTO_INCREMENT
-- =====================================================
-- If your BookingID is AUTO_INCREMENT, use this version:
/*
DELIMITER //

CREATE PROCEDURE AddBooking(
    IN CustomerIDInput INT,
    IN BookingDateInput DATE,
    IN TableNumberInput INT,
    IN NumberOfGuestsInput INT
)
BEGIN
    DECLARE NewBookingID INT;
    
    -- Insert the new booking record (BookingID will be auto-generated)
    INSERT INTO Bookings (CustomerID, BookingDate, TableNumber, NumberOfGuests, Status)
    VALUES (CustomerIDInput, BookingDateInput, TableNumberInput, NumberOfGuestsInput, 'Confirmed');
    
    -- Get the newly inserted BookingID
    SET NewBookingID = LAST_INSERT_ID();
    
    -- Return confirmation message
    SELECT CONCAT('New booking added: Booking ID ', NewBookingID, ', Customer ID ', CustomerIDInput, 
                  ', Date ', BookingDateInput, ', Table ', TableNumberInput) AS 'Confirmation';
END //

DELIMITER ;

-- Usage:
CALL AddBooking(1, '2022-12-10', 4, 2);
*/

-- =====================================================
-- Enhanced Version: With Validation
-- =====================================================
-- This version includes validation for customer existence and table availability:
/*
DELIMITER //

CREATE PROCEDURE AddBooking(
    IN BookingIDInput INT,
    IN CustomerIDInput INT,
    IN BookingDateInput DATE,
    IN TableNumberInput INT
)
BEGIN
    DECLARE CustomerExists INT DEFAULT 0;
    DECLARE TableBooked INT DEFAULT 0;
    
    -- Check if customer exists
    SELECT COUNT(*) INTO CustomerExists
    FROM Customers
    WHERE CustomerID = CustomerIDInput;
    
    -- Check if table is already booked on this date
    SELECT COUNT(*) INTO TableBooked
    FROM Bookings
    WHERE BookingDate = BookingDateInput 
      AND TableNumber = TableNumberInput
      AND Status != 'Cancelled';
    
    IF CustomerExists = 0 THEN
        SELECT CONCAT('Error: Customer ID ', CustomerIDInput, ' does not exist') AS 'Confirmation';
    ELSEIF TableBooked > 0 THEN
        SELECT CONCAT('Error: Table ', TableNumberInput, ' is already booked on ', BookingDateInput) AS 'Confirmation';
    ELSE
        -- Insert the new booking record
        INSERT INTO Bookings (BookingID, CustomerID, BookingDate, TableNumber, NumberOfGuests, Status)
        VALUES (BookingIDInput, CustomerIDInput, BookingDateInput, TableNumberInput, 2, 'Confirmed');
        
        SELECT CONCAT('New booking added: Booking ID ', BookingIDInput, ', Customer ID ', CustomerIDInput, 
                      ', Date ', BookingDateInput, ', Table ', TableNumberInput) AS 'Confirmation';
    END IF;
END //

DELIMITER ;
*/
