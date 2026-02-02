-- =====================================================
-- Task 3: Show All Databases in MySQL Server
-- =====================================================
-- This SQL code shows all databases in the MySQL server
-- and verifies that LittleLemonDB is included in the list

-- Show all databases
SHOW DATABASES;

-- Alternative: Query the information_schema to get database list
SELECT SCHEMA_NAME AS 'Database Name'
FROM information_schema.SCHEMATA
ORDER BY SCHEMA_NAME;

-- Verify LittleLemonDB exists
SELECT 
    CASE 
        WHEN COUNT(*) > 0 THEN 'LittleLemonDB database exists'
        ELSE 'LittleLemonDB database does not exist'
    END AS 'Database Status'
FROM information_schema.SCHEMATA
WHERE SCHEMA_NAME = 'LittleLemonDB';

-- Show detailed information about LittleLemonDB if it exists
SELECT 
    SCHEMA_NAME AS 'Database Name',
    DEFAULT_CHARACTER_SET_NAME AS 'Character Set',
    DEFAULT_COLLATION_NAME AS 'Collation'
FROM information_schema.SCHEMATA
WHERE SCHEMA_NAME = 'LittleLemonDB';
