-- =====================================================
-- Task 3: Subquery with ANY Operator
-- =====================================================
-- Little Lemon needs to find all menu items for which more than 2 orders 
-- have been placed using a subquery.
-- Use the ANY operator in a subquery:
-- - Outer query: select the menu name from the menus table
-- - Inner query: check if any item quantity in the order table is more than 2

USE LittleLemonDB;

-- Query using subquery with ANY operator
-- Note: Since we don't have a separate Menus table, we'll query MenuItems directly
-- The subquery checks if any order item has a quantity > 2
SELECT 
    ItemName AS MenuName
FROM 
    MenuItems
WHERE 
    MenuItemID = ANY (
        SELECT MenuItemID 
        FROM OrderItems 
        WHERE Quantity > 2
    )
ORDER BY 
    ItemName;

-- =====================================================
-- Alternative: If you have a Menus table
-- =====================================================
-- If your schema has a Menus table, use this version:
/*
SELECT 
    MenuName
FROM 
    Menus
WHERE 
    MenuItemsID = ANY (
        SELECT MenuItemID 
        FROM OrderItems 
        WHERE Quantity > 2
    )
ORDER BY 
    MenuName;
*/

-- =====================================================
-- Enhanced Query: Shows menu items with order count
-- =====================================================
-- This version shows which menu items have more than 2 orders
-- and includes the count of orders for each item
SELECT 
    mi.ItemName AS MenuName,
    mi.ItemType AS Category,
    COUNT(DISTINCT oi.OrderID) AS OrderCount
FROM 
    MenuItems mi
INNER JOIN 
    OrderItems oi ON mi.MenuItemID = oi.MenuItemID
WHERE 
    oi.Quantity > 2
GROUP BY 
    mi.ItemName, mi.ItemType
HAVING 
    COUNT(DISTINCT oi.OrderID) > 0
ORDER BY 
    mi.ItemName;

-- =====================================================
-- Alternative interpretation: Menu items ordered more than 2 times total
-- =====================================================
-- If the requirement means menu items that appear in more than 2 different orders:
/*
SELECT 
    ItemName AS MenuName
FROM 
    MenuItems
WHERE 
    MenuItemID IN (
        SELECT MenuItemID 
        FROM OrderItems 
        GROUP BY MenuItemID
        HAVING COUNT(DISTINCT OrderID) > 2
    )
ORDER BY 
    ItemName;
*/
