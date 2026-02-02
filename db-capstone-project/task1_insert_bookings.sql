-- =====================================================
-- Task 1: Populate Bookings Table with Records
-- =====================================================
-- Little Lemon wants to populate the Bookings table with records.
-- Use simple INSERT statements to add the booking records.

USE LittleLemonDB;

-- Check if bookings already exist and clear them if needed (optional)
-- Uncomment the following line if you want to start fresh:
-- DELETE FROM Bookings WHERE BookingID IN (1, 2, 3, 4);

-- Insert booking records
-- Note: Adjust CustomerID values if your Customers table has different IDs
-- First, verify customer IDs exist
SELECT CustomerID FROM Customers LIMIT 5;

-- Insert the booking records
-- Note: NumberOfGuests is required, using default value of 2 for all bookings
INSERT INTO Bookings (BookingID, BookingDate, TableNumber, CustomerID, NumberOfGuests) VALUES
(1, '2022-10-10', 5, 1, 2),
(2, '2022-11-12', 3, 3, 2),
(3, '2022-10-11', 2, 2, 2),
(4, '2022-10-13', 2, 1, 2);

-- If BookingID is AUTO_INCREMENT, use this version instead:
-- INSERT INTO Bookings (BookingDate, TableNumber, CustomerID, NumberOfGuests) VALUES
-- ('2022-10-10', 5, 1, 2),
-- ('2022-11-12', 3, 3, 2),
-- ('2022-10-11', 2, 2, 2),
-- ('2022-10-13', 2, 1, 2);

-- Verify the bookings were inserted
SELECT 
    BookingID,
    BookingDate,
    TableNumber,
    CustomerID
FROM Bookings
ORDER BY BookingID;

-- Display bookings with customer names
SELECT 
    b.BookingID,
    b.BookingDate,
    b.TableNumber,
    b.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName
FROM Bookings b
INNER JOIN Customers c ON b.CustomerID = c.CustomerID
ORDER BY b.BookingID;
