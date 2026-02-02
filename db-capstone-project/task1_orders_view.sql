-- =====================================================
-- Task 1: Create Virtual Table (VIEW) - OrdersView
-- =====================================================
-- Little Lemon needs a virtual table called OrdersView that focuses on 
-- OrderID, Quantity and Cost columns within the Orders table 
-- for all orders with a quantity greater than 2.

-- Note: In the current schema, Quantity is stored in OrderItems table.
-- This view aggregates quantities per order to match the task requirements.

USE LittleLemonDB;

-- Drop the view if it already exists
DROP VIEW IF EXISTS OrdersView;

-- Create the OrdersView virtual table
-- This view shows OrderID, total Quantity (sum of all items in the order), and TotalCost
-- Filtered to show only orders where the total quantity is greater than 2
CREATE VIEW OrdersView AS
SELECT 
    o.OrderID,
    SUM(oi.Quantity) AS Quantity,
    o.TotalCost AS Cost
FROM 
    Orders o
INNER JOIN 
    OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY 
    o.OrderID, o.TotalCost
HAVING 
    SUM(oi.Quantity) > 2;

-- Query the OrdersView table
SELECT * FROM OrdersView;

-- =====================================================
-- Alternative: If your schema has Quantity directly in Orders table
-- =====================================================
-- Uncomment and use this version if your Orders table has a Quantity column:
/*
CREATE VIEW OrdersView AS
SELECT 
    OrderID,
    Quantity,
    TotalCost AS Cost
FROM 
    Orders
WHERE 
    Quantity > 2;
*/
