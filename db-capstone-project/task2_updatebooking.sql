-- =====================================================
-- Task 2: Create Stored Procedure - UpdateBooking
-- =====================================================
-- Little Lemon needs a procedure called UpdateBooking to update 
-- existing bookings in the booking table.
-- The procedure should have two input parameters:
-- - booking id
-- - booking date
-- Must include an UPDATE statement inside the procedure.

USE LittleLemonDB;

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS UpdateBooking;

-- Create the UpdateBooking stored procedure
DELIMITER //

CREATE PROCEDURE UpdateBooking(
    IN BookingIDInput INT,
    IN BookingDateInput DATE
)
BEGIN
    -- Update the booking date for the specified booking ID
    UPDATE Bookings
    SET BookingDate = BookingDateInput
    WHERE BookingID = BookingIDInput;
    
    -- Check if any rows were affected
    IF ROW_COUNT() > 0 THEN
        SELECT CONCAT('Booking ', BookingIDInput, ' updated successfully. New booking date: ', BookingDateInput) AS 'Confirmation';
    ELSE
        SELECT CONCAT('Booking ', BookingIDInput, ' not found. No update performed.') AS 'Confirmation';
    END IF;
END //

DELIMITER ;

-- Test the UpdateBooking procedure
-- Example: Update booking ID 1 to new date 2022-12-15
CALL UpdateBooking(1, '2022-12-15');

-- Verify the booking was updated
SELECT * FROM Bookings WHERE BookingID = 1;

-- Test with a non-existent booking ID
CALL UpdateBooking(999, '2022-12-15');

-- =====================================================
-- Enhanced Version: Update Multiple Fields
-- =====================================================
-- This version allows updating booking date, table number, and other fields:
/*
DELIMITER //

CREATE PROCEDURE UpdateBooking(
    IN BookingIDInput INT,
    IN BookingDateInput DATE,
    IN TableNumberInput INT,
    IN NumberOfGuestsInput INT
)
BEGIN
    DECLARE BookingExists INT DEFAULT 0;
    
    -- Check if booking exists
    SELECT COUNT(*) INTO BookingExists
    FROM Bookings
    WHERE BookingID = BookingIDInput;
    
    IF BookingExists = 0 THEN
        SELECT CONCAT('Booking ', BookingIDInput, ' not found. No update performed.') AS 'Confirmation';
    ELSE
        -- Update the booking
        UPDATE Bookings
        SET BookingDate = BookingDateInput,
            TableNumber = TableNumberInput,
            NumberOfGuests = NumberOfGuestsInput
        WHERE BookingID = BookingIDInput;
        
        SELECT CONCAT('Booking ', BookingIDInput, ' updated successfully. New date: ', BookingDateInput, 
                      ', Table: ', TableNumberInput, ', Guests: ', NumberOfGuestsInput) AS 'Confirmation';
    END IF;
END //

DELIMITER ;

-- Usage:
CALL UpdateBooking(1, '2022-12-15', 6, 4);
*/

-- =====================================================
-- Alternative: Update Only Date (Simplified)
-- =====================================================
-- If you only need to update the date:
/*
DELIMITER //

CREATE PROCEDURE UpdateBooking(
    IN BookingIDInput INT,
    IN BookingDateInput DATE
)
BEGIN
    UPDATE Bookings
    SET BookingDate = BookingDateInput
    WHERE BookingID = BookingIDInput;
    
    SELECT CONCAT('Booking ', BookingIDInput, ' updated') AS 'Confirmation';
END //

DELIMITER ;
*/
