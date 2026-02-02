-- =====================================================
-- Task 3: Create Stored Procedure - CancelBooking
-- =====================================================
-- Little Lemon needs a procedure called CancelBooking to cancel 
-- or remove a booking.
-- The procedure should have one input parameter:
-- - booking id
-- Must write a DELETE statement inside the procedure.

USE LittleLemonDB;

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS CancelBooking;

-- Create the CancelBooking stored procedure
DELIMITER //

CREATE PROCEDURE CancelBooking(IN BookingIDInput INT)
BEGIN
    -- Delete the booking record
    DELETE FROM Bookings
    WHERE BookingID = BookingIDInput;
    
    -- Check if any rows were affected
    IF ROW_COUNT() > 0 THEN
        SELECT CONCAT('Booking ', BookingIDInput, ' cancelled') AS 'Confirmation';
    ELSE
        SELECT CONCAT('Booking ', BookingIDInput, ' not found') AS 'Confirmation';
    END IF;
END //

DELIMITER ;

-- Test the CancelBooking procedure
-- Example: Cancel booking ID 5
CALL CancelBooking(5);

-- Verify the booking was deleted
SELECT * FROM Bookings WHERE BookingID = 5;

-- Test with a non-existent booking ID
CALL CancelBooking(999);

-- =====================================================
-- Alternative: Soft Delete (Recommended for Production)
-- =====================================================
-- Instead of hard delete, update the status to 'Cancelled':
/*
DELIMITER //

CREATE PROCEDURE CancelBooking(IN BookingIDInput INT)
BEGIN
    DECLARE BookingExists INT DEFAULT 0;
    
    -- Check if booking exists
    SELECT COUNT(*) INTO BookingExists
    FROM Bookings
    WHERE BookingID = BookingIDInput;
    
    IF BookingExists = 0 THEN
        SELECT CONCAT('Booking ', BookingIDInput, ' not found') AS 'Confirmation';
    ELSE
        -- Update status to Cancelled instead of deleting
        UPDATE Bookings
        SET Status = 'Cancelled'
        WHERE BookingID = BookingIDInput;
        
        SELECT CONCAT('Booking ', BookingIDInput, ' cancelled') AS 'Confirmation';
    END IF;
END //

DELIMITER ;
*/

-- =====================================================
-- Enhanced Version: With Transaction and Related Records
-- =====================================================
-- This version handles related records and uses transactions:
/*
DELIMITER //

CREATE PROCEDURE CancelBooking(IN BookingIDInput INT)
BEGIN
    DECLARE BookingExists INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error occurred while cancelling booking' AS 'Confirmation';
    END;
    
    -- Check if booking exists
    SELECT COUNT(*) INTO BookingExists
    FROM Bookings
    WHERE BookingID = BookingIDInput;
    
    IF BookingExists = 0 THEN
        SELECT CONCAT('Booking ', BookingIDInput, ' not found') AS 'Confirmation';
    ELSE
        START TRANSACTION;
        
        -- If there are related orders, you might want to handle them
        -- For now, just delete the booking
        DELETE FROM Bookings
        WHERE BookingID = BookingIDInput;
        
        COMMIT;
        SELECT CONCAT('Booking ', BookingIDInput, ' cancelled') AS 'Confirmation';
    END IF;
END //

DELIMITER ;
*/
