-- =====================================================
-- Task 2: JOIN Query - Customers with Orders > $150
-- =====================================================
-- Little Lemon needs information from four tables on all customers 
-- with orders that cost more than $150.
-- Extract information from:
-- - Customers: customer id and full name
-- - Orders: order id and cost
-- - Menus: menus name (Note: In current schema, we use MenuItems)
-- - MenuItems: item's name and category

USE LittleLemonDB;

-- Query using JOIN to get all required information
-- Note: Since we don't have a separate Menus table, we'll use MenuItems
-- and show the item name as the "menu name"
SELECT 
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS FullName,
    o.OrderID,
    o.TotalCost AS Cost,
    mi.ItemName AS MenuName,
    mi.ItemName AS ItemName,
    mi.ItemType AS Category
FROM 
    Customers c
INNER JOIN 
    Orders o ON c.CustomerID = o.CustomerID
INNER JOIN 
    OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN 
    MenuItems mi ON oi.MenuItemID = mi.MenuItemID
WHERE 
    o.TotalCost > 150
ORDER BY 
    o.TotalCost ASC;  -- Sorted by lowest cost amount

-- =====================================================
-- Alternative: If you have a Menus table structure
-- =====================================================
-- If your schema has a Menus table that links to MenuItems,
-- use this version instead:
/*
SELECT 
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS FullName,
    o.OrderID,
    o.TotalCost AS Cost,
    m.MenuName,
    mi.ItemName AS ItemName,
    mi.ItemType AS Category
FROM 
    Customers c
INNER JOIN 
    Orders o ON c.CustomerID = o.CustomerID
INNER JOIN 
    OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN 
    MenuItems mi ON oi.MenuItemID = mi.MenuItemID
INNER JOIN 
    Menus m ON mi.MenuItemID = m.MenuItemsID
WHERE 
    o.TotalCost > 150
ORDER BY 
    o.TotalCost ASC;
*/

-- =====================================================
-- Enhanced Query: Shows one row per order with all items
-- =====================================================
-- This version groups items per order and shows them as a comma-separated list
SELECT 
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS FullName,
    o.OrderID,
    o.TotalCost AS Cost,
    GROUP_CONCAT(mi.ItemName SEPARATOR ', ') AS MenuItems,
    GROUP_CONCAT(mi.ItemType SEPARATOR ', ') AS Categories
FROM 
    Customers c
INNER JOIN 
    Orders o ON c.CustomerID = o.CustomerID
INNER JOIN 
    OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN 
    MenuItems mi ON oi.MenuItemID = mi.MenuItemID
WHERE 
    o.TotalCost > 150
GROUP BY 
    c.CustomerID, c.FirstName, c.LastName, o.OrderID, o.TotalCost
ORDER BY 
    o.TotalCost ASC;
