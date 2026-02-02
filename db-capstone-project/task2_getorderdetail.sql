-- =====================================================
-- Task 2: Create Prepared Statement - GetOrderDetail
-- =====================================================
-- Little Lemon needs a prepared statement called GetOrderDetail
-- that accepts one input argument, the CustomerID value.
-- The statement should return the order id, the quantity, and 
-- the order cost from the Orders table.
-- This helps reduce parsing time and secure the database from SQL injections.

USE LittleLemonDB;

-- Drop the prepared statement if it already exists
PREPARE GetOrderDetail FROM 
'SELECT 
    o.OrderID,
    COALESCE(SUM(oi.Quantity), 0) AS Quantity,
    o.TotalCost AS Cost
FROM 
    Orders o
LEFT JOIN 
    OrderItems oi ON o.OrderID = oi.OrderID
WHERE 
    o.CustomerID = ?
GROUP BY 
    o.OrderID, o.TotalCost';

-- Create a variable called id and assign it value of 1
SET @id = 1;

-- Execute the GetOrderDetail prepared statement
EXECUTE GetOrderDetail USING @id;

-- =====================================================
-- Alternative: If your schema has Quantity directly in Orders table
-- =====================================================
-- Uncomment and use this version if your Orders table has a Quantity column:
/*
PREPARE GetOrderDetail FROM 
'SELECT 
    OrderID,
    Quantity,
    TotalCost AS Cost
FROM 
    Orders
WHERE 
    CustomerID = ?';

SET @id = 1;
EXECUTE GetOrderDetail USING @id;
*/

-- =====================================================
-- Test with different Customer IDs
-- =====================================================
-- Test with CustomerID = 2
SET @id = 2;
EXECUTE GetOrderDetail USING @id;

-- Test with CustomerID = 3
SET @id = 3;
EXECUTE GetOrderDetail USING @id;

-- =====================================================
-- Deallocate the prepared statement (optional)
-- =====================================================
-- Uncomment to deallocate when done:
-- DEALLOCATE PREPARE GetOrderDetail;
