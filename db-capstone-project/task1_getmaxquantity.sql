-- =====================================================
-- Task 1: Create Stored Procedure - GetMaxQuantity
-- =====================================================
-- Little Lemon needs a procedure that displays the maximum 
-- ordered quantity in the Orders table.
-- This procedure allows reuse of logic without retyping code.

USE LittleLemonDB;

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS GetMaxQuantity;

-- Create the GetMaxQuantity stored procedure
-- Note: In the current schema, quantity is stored in OrderItems table
-- This procedure finds the maximum quantity across all order items
DELIMITER //

CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(Quantity) AS 'Max Quantity in Order'
    FROM OrderItems;
END //

DELIMITER ;

-- Call the procedure
CALL GetMaxQuantity();

-- =====================================================
-- Alternative: If your schema has Quantity directly in Orders table
-- =====================================================
-- Uncomment and use this version if your Orders table has a Quantity column:
/*
DELIMITER //

CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(Quantity) AS 'Max Quantity in Order'
    FROM Orders;
END //

DELIMITER ;

CALL GetMaxQuantity();
*/

-- =====================================================
-- Enhanced Version: Shows order details with max quantity
-- =====================================================
-- This version shows which order has the maximum quantity:
/*
DELIMITER //

CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT 
        oi.OrderID,
        o.OrderDate,
        oi.Quantity AS 'Max Quantity in Order',
        oi.MenuItemID,
        mi.ItemName
    FROM OrderItems oi
    INNER JOIN Orders o ON oi.OrderID = o.OrderID
    INNER JOIN MenuItems mi ON oi.MenuItemID = mi.MenuItemID
    WHERE oi.Quantity = (SELECT MAX(Quantity) FROM OrderItems)
    LIMIT 1;
END //

DELIMITER ;
*/
