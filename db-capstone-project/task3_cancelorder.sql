-- =====================================================
-- Task 3: Create Stored Procedure - CancelOrder
-- =====================================================
-- Little Lemon wants to use this stored procedure to delete 
-- an order record based on the user input of the order id.
-- This allows canceling any order by specifying the order id 
-- value in the procedure parameter without typing the entire SQL delete statement.

USE LittleLemonDB;

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS CancelOrder;

-- Create the CancelOrder stored procedure
-- Note: Due to foreign key constraints, we may need to delete
-- related records in OrderItems and OrderDeliveryStatus first
DELIMITER //

CREATE PROCEDURE CancelOrder(IN OrderIDInput INT)
BEGIN
    -- Start transaction for data integrity
    START TRANSACTION;
    
    -- Delete related order items first (due to foreign key constraints)
    DELETE FROM OrderItems WHERE OrderID = OrderIDInput;
    
    -- Delete related delivery status if exists
    DELETE FROM OrderDeliveryStatus WHERE OrderID = OrderIDInput;
    
    -- Delete the order
    DELETE FROM Orders WHERE OrderID = OrderIDInput;
    
    -- Check if any rows were affected
    IF ROW_COUNT() > 0 THEN
        COMMIT;
        SELECT CONCAT('Order ', OrderIDInput, ' is cancelled') AS Confirmation;
    ELSE
        ROLLBACK;
        SELECT CONCAT('Order ', OrderIDInput, ' not found') AS Confirmation;
    END IF;
END //

DELIMITER ;

-- Test the CancelOrder procedure
-- Note: Be careful when testing - this will delete data!
-- Uncomment to test:
-- CALL CancelOrder(1);

-- =====================================================
-- Alternative: Soft Delete (Recommended for Production)
-- =====================================================
-- Instead of hard delete, update the order status to 'Cancelled':
/*
DELIMITER //

CREATE PROCEDURE CancelOrder(IN OrderIDInput INT)
BEGIN
    DECLARE order_exists INT DEFAULT 0;
    
    -- Check if order exists
    SELECT COUNT(*) INTO order_exists 
    FROM Orders 
    WHERE OrderID = OrderIDInput;
    
    IF order_exists > 0 THEN
        -- Update order status to Cancelled instead of deleting
        UPDATE Orders 
        SET Status = 'Cancelled' 
        WHERE OrderID = OrderIDInput;
        
        SELECT CONCAT('Order ', OrderIDInput, ' is cancelled') AS Confirmation;
    ELSE
        SELECT CONCAT('Order ', OrderIDInput, ' not found') AS Confirmation;
    END IF;
END //

DELIMITER ;
*/

-- =====================================================
-- Enhanced Version: With Validation and Error Handling
-- =====================================================
-- This version includes better error handling:
/*
DELIMITER //

CREATE PROCEDURE CancelOrder(IN OrderIDInput INT)
BEGIN
    DECLARE order_exists INT DEFAULT 0;
    DECLARE order_status VARCHAR(50);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error occurred while cancelling order' AS Error;
    END;
    
    START TRANSACTION;
    
    -- Check if order exists
    SELECT COUNT(*), Status INTO order_exists, order_status
    FROM Orders 
    WHERE OrderID = OrderIDInput;
    
    IF order_exists = 0 THEN
        ROLLBACK;
        SELECT CONCAT('Order ', OrderIDInput, ' not found') AS Confirmation;
    ELSEIF order_status = 'Cancelled' THEN
        ROLLBACK;
        SELECT CONCAT('Order ', OrderIDInput, ' is already cancelled') AS Confirmation;
    ELSE
        -- Delete related records
        DELETE FROM OrderItems WHERE OrderID = OrderIDInput;
        DELETE FROM OrderDeliveryStatus WHERE OrderID = OrderIDInput;
        DELETE FROM Orders WHERE OrderID = OrderIDInput;
        
        COMMIT;
        SELECT CONCAT('Order ', OrderIDInput, ' is cancelled successfully') AS Confirmation;
    END IF;
END //

DELIMITER ;
*/
