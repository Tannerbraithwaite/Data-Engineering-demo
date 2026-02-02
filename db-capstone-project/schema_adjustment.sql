-- =====================================================
-- Schema Adjustment Script (Optional)
-- =====================================================
-- This script adds a Menus table and adjusts the Orders table
-- to match the task requirements more closely.
-- Use this if you need to match the exact schema described in the task.

USE LittleLemonDB;

-- =====================================================
-- Option 1: Add Menus Table (if needed)
-- =====================================================
-- Create Menus table that links to MenuItems
CREATE TABLE IF NOT EXISTS Menus (
    MenuID INT AUTO_INCREMENT PRIMARY KEY,
    MenuName VARCHAR(255) NOT NULL,
    MenuItemsID INT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (MenuItemsID) REFERENCES MenuItems(MenuItemID) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX idx_menu_item (MenuItemsID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Populate Menus table with sample data
INSERT INTO Menus (MenuName, MenuItemsID) 
SELECT 
    CONCAT(Cuisine, ' - ', ItemType) AS MenuName,
    MenuItemID AS MenuItemsID
FROM MenuItems
ON DUPLICATE KEY UPDATE MenuName = VALUES(MenuName);

-- =====================================================
-- Option 2: Add Quantity column to Orders table (if needed)
-- =====================================================
-- Add Quantity column to Orders table for simplified queries
-- This represents the total quantity of items in the order
ALTER TABLE Orders 
ADD COLUMN IF NOT EXISTS Quantity INT DEFAULT 0;

-- Update Quantity based on OrderItems
UPDATE Orders o
SET Quantity = (
    SELECT COALESCE(SUM(oi.Quantity), 0)
    FROM OrderItems oi
    WHERE oi.OrderID = o.OrderID
);

-- =====================================================
-- Verification Queries
-- =====================================================

-- Check Menus table
SELECT * FROM Menus LIMIT 10;

-- Check Orders with Quantity
SELECT OrderID, Quantity, TotalCost FROM Orders;
