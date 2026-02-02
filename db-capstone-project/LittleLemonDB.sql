-- =====================================================
-- Little Lemon Database - Complete Schema Implementation
-- Database: LittleLemonDB
-- Task 2: Forward Engineering from ER Diagram
-- =====================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS LittleLemonDB;
USE LittleLemonDB;

-- =====================================================
-- Table 1: Customers
-- Purpose: Store customer information and contact details
-- =====================================================
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Address VARCHAR(255),
    City VARCHAR(100),
    PostalCode VARCHAR(20),
    Country VARCHAR(100) DEFAULT 'UK',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email (Email),
    INDEX idx_phone (Phone)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Table 2: Staff
-- Purpose: Store staff information including roles and salaries
-- =====================================================
CREATE TABLE Staff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL CHECK (Salary > 0),
    Email VARCHAR(255) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    HireDate DATE,
    Department VARCHAR(50),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email (Email),
    INDEX idx_role (Role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Table 3: Bookings
-- Purpose: Store information about booked tables in the restaurant
-- =====================================================
CREATE TABLE Bookings (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    BookingDate DATE NOT NULL,
    TableNumber INT NOT NULL CHECK (TableNumber > 0),
    NumberOfGuests INT NOT NULL CHECK (NumberOfGuests > 0),
    BookingTime TIME,
    Status ENUM('Confirmed', 'Cancelled', 'Completed') DEFAULT 'Confirmed',
    Notes TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_booking_date (BookingDate),
    INDEX idx_table_number (TableNumber),
    INDEX idx_customer (CustomerID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Table 4: MenuItems
-- Purpose: Store information about menu items (cuisines, starters, courses, drinks, desserts)
-- =====================================================
CREATE TABLE MenuItems (
    MenuItemID INT AUTO_INCREMENT PRIMARY KEY,
    ItemName VARCHAR(255) NOT NULL UNIQUE,
    ItemType ENUM('Starter', 'Main Course', 'Dessert', 'Drink') NOT NULL,
    Cuisine VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0),
    Description TEXT,
    IsAvailable BOOLEAN DEFAULT TRUE,
    PreparationTime INT, -- in minutes
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_item_type (ItemType),
    INDEX idx_cuisine (Cuisine),
    INDEX idx_available (IsAvailable)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Table 5: Orders
-- Purpose: Store information about each order
-- =====================================================
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    BookingID INT NULL,
    OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    TotalCost DECIMAL(10,2) NOT NULL CHECK (TotalCost >= 0),
    Status ENUM('Pending', 'Preparing', 'Ready', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    StaffID INT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID) ON DELETE SET NULL ON UPDATE CASCADE,
    INDEX idx_order_date (OrderDate),
    INDEX idx_customer (CustomerID),
    INDEX idx_booking (BookingID),
    INDEX idx_status (Status),
    INDEX idx_staff (StaffID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Table 6: OrderItems
-- Purpose: Store individual items within each order (resolves many-to-many relationship)
-- =====================================================
CREATE TABLE OrderItems (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    MenuItemID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2) NOT NULL CHECK (UnitPrice > 0),
    Subtotal DECIMAL(10,2) NOT NULL CHECK (Subtotal > 0),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (MenuItemID) REFERENCES MenuItems(MenuItemID) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_order (OrderID),
    INDEX idx_menu_item (MenuItemID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Table 7: OrderDeliveryStatus
-- Purpose: Store information about the delivery status of each order
-- =====================================================
CREATE TABLE OrderDeliveryStatus (
    DeliveryID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL UNIQUE,
    DeliveryDate DATETIME,
    Status ENUM('Pending', 'In Transit', 'Delivered', 'Failed', 'Cancelled') NOT NULL DEFAULT 'Pending',
    DeliveryAddress VARCHAR(255),
    DeliveryNotes TEXT,
    EstimatedDeliveryTime DATETIME,
    ActualDeliveryTime DATETIME,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX idx_delivery_date (DeliveryDate),
    INDEX idx_status (Status),
    INDEX idx_order (OrderID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Sample Data Insertion (Optional - for testing)
-- =====================================================

-- Insert Sample Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address, City, PostalCode, Country) VALUES
('John', 'Smith', 'john.smith@email.com', '07123456789', '123 Main St', 'London', 'SW1A 1AA', 'UK'),
('Emma', 'Johnson', 'emma.johnson@email.com', '07987654321', '456 Oak Ave', 'Manchester', 'M1 1AB', 'UK'),
('Michael', 'Brown', 'michael.brown@email.com', '07555123456', '789 Elm Rd', 'Birmingham', 'B1 1CD', 'UK');

-- Insert Sample Staff
INSERT INTO Staff (FirstName, LastName, Role, Salary, Email, Phone, HireDate, Department) VALUES
('Sarah', 'Williams', 'Manager', 45000.00, 'sarah.williams@littlelemon.com', '07111111111', '2020-01-15', 'Management'),
('David', 'Jones', 'Chef', 38000.00, 'david.jones@littlelemon.com', '07222222222', '2021-03-20', 'Kitchen'),
('Lisa', 'Taylor', 'Waiter', 22000.00, 'lisa.taylor@littlelemon.com', '07333333333', '2022-06-10', 'Service'),
('James', 'Anderson', 'Waiter', 22000.00, 'james.anderson@littlelemon.com', '07444444444', '2022-07-15', 'Service');

-- Insert Sample Menu Items
INSERT INTO MenuItems (ItemName, ItemType, Cuisine, Price, Description, IsAvailable, PreparationTime) VALUES
('Greek Salad', 'Starter', 'Greek', 8.50, 'Fresh mixed greens with feta cheese and olives', TRUE, 10),
('Bruschetta', 'Starter', 'Italian', 7.50, 'Toasted bread with tomatoes and basil', TRUE, 8),
('Grilled Chicken', 'Main Course', 'Mediterranean', 18.50, 'Herb-marinated grilled chicken breast', TRUE, 25),
('Pasta Carbonara', 'Main Course', 'Italian', 16.00, 'Creamy pasta with bacon and parmesan', TRUE, 20),
('Tiramisu', 'Dessert', 'Italian', 7.00, 'Classic Italian coffee-flavored dessert', TRUE, 5),
('Baklava', 'Dessert', 'Greek', 6.50, 'Sweet pastry with honey and nuts', TRUE, 5),
('Wine Red', 'Drink', 'International', 12.00, 'House red wine', TRUE, 2),
('Wine White', 'Drink', 'International', 12.00, 'House white wine', TRUE, 2),
('Lemonade', 'Drink', 'International', 3.50, 'Fresh lemonade', TRUE, 3);

-- Insert Sample Bookings
INSERT INTO Bookings (CustomerID, BookingDate, TableNumber, NumberOfGuests, BookingTime, Status) VALUES
(1, '2024-01-15', 5, 2, '19:00:00', 'Confirmed'),
(2, '2024-01-15', 3, 4, '20:00:00', 'Confirmed'),
(3, '2024-01-16', 7, 2, '18:30:00', 'Confirmed');

-- Insert Sample Orders
INSERT INTO Orders (CustomerID, BookingID, OrderDate, TotalCost, Status, StaffID) VALUES
(1, 1, '2024-01-15 19:15:00', 45.50, 'Delivered', 3),
(2, 2, '2024-01-15 20:10:00', 78.00, 'Delivered', 4),
(3, 3, '2024-01-16 18:45:00', 52.00, 'Ready', 3);

-- Insert Sample Order Items
INSERT INTO OrderItems (OrderID, MenuItemID, Quantity, UnitPrice, Subtotal) VALUES
(1, 1, 1, 8.50, 8.50),  -- Greek Salad
(1, 3, 1, 18.50, 18.50), -- Grilled Chicken
(1, 5, 1, 7.00, 7.00),   -- Tiramisu
(1, 7, 1, 12.00, 12.00), -- Wine Red
(2, 2, 2, 7.50, 15.00),  -- Bruschetta x2
(2, 4, 2, 16.00, 32.00), -- Pasta Carbonara x2
(2, 6, 2, 6.50, 13.00),  -- Baklava x2
(2, 8, 2, 12.00, 24.00), -- Wine White x2
(3, 1, 1, 8.50, 8.50),   -- Greek Salad
(3, 3, 2, 18.50, 37.00), -- Grilled Chicken x2
(3, 9, 2, 3.50, 7.00);   -- Lemonade x2

-- Insert Sample Delivery Status
INSERT INTO OrderDeliveryStatus (OrderID, DeliveryDate, Status, DeliveryAddress, ActualDeliveryTime) VALUES
(1, '2024-01-15 19:45:00', 'Delivered', '123 Main St, London, SW1A 1AA', '2024-01-15 19:45:00'),
(2, '2024-01-15 20:50:00', 'Delivered', '456 Oak Ave, Manchester, M1 1AB', '2024-01-15 20:50:00'),
(3, NULL, 'Pending', '789 Elm Rd, Birmingham, B1 1CD', NULL);

-- =====================================================
-- End of Schema Implementation
-- =====================================================
