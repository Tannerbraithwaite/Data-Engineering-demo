-- =====================================================
-- Task 2: Create Stored Procedure - CheckBooking
-- =====================================================
-- Little Lemon needs a stored procedure called CheckBooking to check 
-- whether a table in the restaurant is already booked.
-- The procedure should have two input parameters: booking date and table number.

USE LittleLemonDB;

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS CheckBooking;

-- Create the CheckBooking stored procedure
DELIMITER //

CREATE PROCEDURE CheckBooking(IN BookingDateInput DATE, IN TableNumberInput INT)
BEGIN
    DECLARE TableStatus VARCHAR(100);
    
    -- Check if the table is already booked on the given date
    SELECT COUNT(*) INTO @booking_count
    FROM Bookings
    WHERE BookingDate = BookingDateInput 
      AND TableNumber = TableNumberInput
      AND Status != 'Cancelled';  -- Exclude cancelled bookings
    
    -- Set the status message based on the count
    IF @booking_count > 0 THEN
        SET TableStatus = CONCAT('Table ', TableNumberInput, ' is already booked on ', BookingDateInput);
    ELSE
        SET TableStatus = CONCAT('Table ', TableNumberInput, ' is available on ', BookingDateInput);
    END IF;
    
    -- Return the status
    SELECT TableStatus AS 'Booking Status';
END //

DELIMITER ;

-- Test the CheckBooking procedure
-- Test case 1: Check table 5 on 2022-10-10 (should be booked)
CALL CheckBooking('2022-10-10', 5);

-- Test case 2: Check table 3 on 2022-11-12 (should be booked)
CALL CheckBooking('2022-11-12', 3);

-- Test case 3: Check table 1 on 2022-10-10 (should be available)
CALL CheckBooking('2022-10-10', 1);

-- Test case 4: Check table 5 on 2022-10-15 (should be available)
CALL CheckBooking('2022-10-15', 5);

-- =====================================================
-- Enhanced Version: Shows booking details if table is booked
-- =====================================================
-- This version shows who has the booking if the table is already booked:
/*
DELIMITER //

CREATE PROCEDURE CheckBooking(IN BookingDateInput DATE, IN TableNumberInput INT)
BEGIN
    DECLARE TableStatus VARCHAR(100);
    DECLARE CustomerName VARCHAR(200);
    
    -- Check if the table is already booked on the given date
    SELECT COUNT(*), CONCAT(c.FirstName, ' ', c.LastName) INTO @booking_count, CustomerName
    FROM Bookings b
    INNER JOIN Customers c ON b.CustomerID = c.CustomerID
    WHERE b.BookingDate = BookingDateInput 
      AND b.TableNumber = TableNumberInput
      AND b.Status != 'Cancelled';
    
    -- Set the status message based on the count
    IF @booking_count > 0 THEN
        SET TableStatus = CONCAT('Table ', TableNumberInput, ' is already booked on ', BookingDateInput, ' by ', CustomerName);
    ELSE
        SET TableStatus = CONCAT('Table ', TableNumberInput, ' is available on ', BookingDateInput);
    END IF;
    
    -- Return the status
    SELECT TableStatus AS 'Booking Status';
END //

DELIMITER ;
*/
