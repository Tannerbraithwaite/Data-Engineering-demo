# Little Lemon Database - ER Diagram Design

## Task 1: Normalized ER Diagram Design

This document describes the Entity-Relationship (ER) diagram for Little Lemon's database system, designed to adhere to 1NF, 2NF, and 3NF normalization rules.

## Database Name
**LittleLemonDB**

## Normalization Overview

### First Normal Form (1NF)
- Each table contains atomic values (no multi-valued attributes)
- No repeating groups
- Each row is unique

### Second Normal Form (2NF)
- All tables are in 1NF
- All non-key attributes are fully functionally dependent on the primary key
- No partial dependencies

### Third Normal Form (3NF)
- All tables are in 2NF
- No transitive dependencies (non-key attributes don't depend on other non-key attributes)

## Entity Identification

### 1. Customers Table
**Purpose:** Store customer information and contact details

**Attributes:**
- `CustomerID` (INT, PRIMARY KEY, AUTO_INCREMENT)
- `FirstName` (VARCHAR(100), NOT NULL)
- `LastName` (VARCHAR(100), NOT NULL)
- `Email` (VARCHAR(255), UNIQUE, NOT NULL)
- `Phone` (VARCHAR(20), NOT NULL)
- `Address` (VARCHAR(255))
- `City` (VARCHAR(100))
- `PostalCode` (VARCHAR(20))
- `Country` (VARCHAR(100))

**Constraints:**
- Email must be unique
- Phone is required

### 2. Staff Table
**Purpose:** Store staff information including roles and salaries

**Attributes:**
- `StaffID` (INT, PRIMARY KEY, AUTO_INCREMENT)
- `FirstName` (VARCHAR(100), NOT NULL)
- `LastName` (VARCHAR(100), NOT NULL)
- `Role` (VARCHAR(50), NOT NULL)
- `Salary` (DECIMAL(10,2), NOT NULL)
- `Email` (VARCHAR(255), UNIQUE, NOT NULL)
- `Phone` (VARCHAR(20))
- `HireDate` (DATE)
- `Department` (VARCHAR(50))

**Constraints:**
- Email must be unique
- Role and Salary are required
- Salary must be positive

### 3. Bookings Table
**Purpose:** Store information about booked tables in the restaurant

**Attributes:**
- `BookingID` (INT, PRIMARY KEY, AUTO_INCREMENT)
- `CustomerID` (INT, FOREIGN KEY → Customers.CustomerID, NOT NULL)
- `BookingDate` (DATE, NOT NULL)
- `TableNumber` (INT, NOT NULL)
- `NumberOfGuests` (INT, NOT NULL)
- `BookingTime` (TIME)
- `Status` (ENUM('Confirmed', 'Cancelled', 'Completed'), DEFAULT 'Confirmed')
- `Notes` (TEXT)

**Constraints:**
- CustomerID references Customers table
- TableNumber must be positive
- NumberOfGuests must be positive
- BookingDate cannot be in the past (business rule)

### 4. MenuItems Table
**Purpose:** Store information about menu items (cuisines, starters, courses, drinks, desserts)

**Attributes:**
- `MenuItemID` (INT, PRIMARY KEY, AUTO_INCREMENT)
- `ItemName` (VARCHAR(255), NOT NULL)
- `ItemType` (ENUM('Starter', 'Main Course', 'Dessert', 'Drink'), NOT NULL)
- `Cuisine` (VARCHAR(100), NOT NULL)
- `Price` (DECIMAL(10,2), NOT NULL)
- `Description` (TEXT)
- `IsAvailable` (BOOLEAN, DEFAULT TRUE)
- `PreparationTime` (INT) -- in minutes

**Constraints:**
- Price must be positive
- ItemType must be one of the specified values
- ItemName must be unique

### 5. Orders Table
**Purpose:** Store information about each order

**Attributes:**
- `OrderID` (INT, PRIMARY KEY, AUTO_INCREMENT)
- `CustomerID` (INT, FOREIGN KEY → Customers.CustomerID, NOT NULL)
- `BookingID` (INT, FOREIGN KEY → Bookings.BookingID, NULL)
- `OrderDate` (DATETIME, NOT NULL, DEFAULT CURRENT_TIMESTAMP)
- `TotalCost` (DECIMAL(10,2), NOT NULL)
- `Status` (ENUM('Pending', 'Preparing', 'Ready', 'Delivered', 'Cancelled'), DEFAULT 'Pending')
- `StaffID` (INT, FOREIGN KEY → Staff.StaffID) -- Staff member who took the order

**Constraints:**
- CustomerID references Customers table
- BookingID references Bookings table (nullable for walk-in orders)
- TotalCost must be positive
- OrderDate defaults to current timestamp

### 6. OrderItems Table
**Purpose:** Store individual items within each order (resolves many-to-many relationship)

**Attributes:**
- `OrderItemID` (INT, PRIMARY KEY, AUTO_INCREMENT)
- `OrderID` (INT, FOREIGN KEY → Orders.OrderID, NOT NULL)
- `MenuItemID` (INT, FOREIGN KEY → MenuItems.MenuItemID, NOT NULL)
- `Quantity` (INT, NOT NULL)
- `UnitPrice` (DECIMAL(10,2), NOT NULL) -- Price at time of order
- `Subtotal` (DECIMAL(10,2), NOT NULL) -- Quantity * UnitPrice

**Constraints:**
- OrderID references Orders table
- MenuItemID references MenuItems table
- Quantity must be positive
- UnitPrice must be positive
- Subtotal = Quantity * UnitPrice (calculated)

### 7. OrderDeliveryStatus Table
**Purpose:** Store information about the delivery status of each order

**Attributes:**
- `DeliveryID` (INT, PRIMARY KEY, AUTO_INCREMENT)
- `OrderID` (INT, FOREIGN KEY → Orders.OrderID, NOT NULL, UNIQUE)
- `DeliveryDate` (DATETIME)
- `Status` (ENUM('Pending', 'In Transit', 'Delivered', 'Failed', 'Cancelled'), NOT NULL, DEFAULT 'Pending')
- `DeliveryAddress` (VARCHAR(255))
- `DeliveryNotes` (TEXT)
- `EstimatedDeliveryTime` (DATETIME)
- `ActualDeliveryTime` (DATETIME)

**Constraints:**
- OrderID references Orders table
- One delivery record per order (UNIQUE constraint)
- DeliveryDate cannot be before OrderDate (business rule)

## Relationships

### One-to-Many Relationships:
1. **Customers → Bookings**: One customer can have many bookings
2. **Customers → Orders**: One customer can place many orders
3. **Bookings → Orders**: One booking can have one order (or none for walk-ins)
4. **Orders → OrderItems**: One order can have many order items
5. **Orders → OrderDeliveryStatus**: One order has one delivery status
6. **MenuItems → OrderItems**: One menu item can appear in many order items
7. **Staff → Orders**: One staff member can take many orders

### Relationship Cardinality:
- Customers (1) → (M) Bookings
- Customers (1) → (M) Orders
- Bookings (1) → (0..1) Orders
- Orders (1) → (M) OrderItems
- Orders (1) → (1) OrderDeliveryStatus
- MenuItems (1) → (M) OrderItems
- Staff (1) → (M) Orders

## Normalization Justification

### 1NF Compliance:
- All attributes contain atomic values
- No repeating groups (OrderItems table handles multiple items per order)
- Each row is uniquely identified by primary key

### 2NF Compliance:
- All tables have single-column primary keys
- All non-key attributes fully depend on the primary key
- OrderItems table separates order details from item details

### 3NF Compliance:
- No transitive dependencies
- Staff salary depends only on StaffID, not on other attributes
- Menu item price depends only on MenuItemID, not on cuisine or type

## Data Types Summary

- **INT**: For IDs and numeric counts
- **VARCHAR**: For variable-length text (names, addresses, etc.)
- **DECIMAL(10,2)**: For monetary values (prices, salaries, costs)
- **DATE**: For dates without time
- **DATETIME**: For dates with time
- **TIME**: For time values
- **ENUM**: For fixed set of values (status fields)
- **BOOLEAN**: For true/false values
- **TEXT**: For longer text descriptions

## Indexes (Recommended)

- Primary keys (automatic indexes)
- Foreign keys (for join performance)
- Email fields (for unique lookups)
- BookingDate, OrderDate (for date range queries)
- Status fields (for filtering)

## Export Information

**Model Name:** LittleLemonDM  
**Export Format:** PNG (for visual representation)  
**Database Name:** LittleLemonDB
