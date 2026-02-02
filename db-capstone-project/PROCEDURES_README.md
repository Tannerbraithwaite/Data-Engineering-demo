# Little Lemon Database - Stored Procedures and Prepared Statements

This document describes the stored procedures and prepared statements created for Little Lemon's database optimization tasks.

## Overview

Stored procedures and prepared statements help optimize database queries by:
- **Reducing parsing time** - Queries are pre-compiled
- **Improving security** - Protection against SQL injection attacks
- **Code reusability** - Logic can be reused without retyping
- **Better performance** - Optimized execution plans

## Tasks Completed

### Task 1: GetMaxQuantity Stored Procedure ✅
**File:** `task1_getmaxquantity.sql`

Creates a stored procedure that displays the maximum ordered quantity in the Orders table.

**Usage:**
```sql
CALL GetMaxQuantity();
```

**Output:**
```
Max Quantity in Order
---------------------
        8
```

**Features:**
- Finds maximum quantity across all order items
- Can be called repeatedly without retyping code
- Includes alternative versions for different schema structures

### Task 2: GetOrderDetail Prepared Statement ✅
**File:** `task2_getorderdetail.sql`

Creates a prepared statement that accepts CustomerID and returns order details.

**Usage:**
```sql
SET @id = 1;
EXECUTE GetOrderDetail USING @id;
```

**Output:**
```
OrderID | Quantity | Cost
--------|----------|------
   1    |    4     | 45.50
```

**Features:**
- Accepts CustomerID as parameter
- Returns OrderID, Quantity, and Cost
- Reduces parsing time
- Protects against SQL injection
- Can be executed multiple times with different IDs

**Security Benefits:**
- Parameterized queries prevent SQL injection
- Input values are properly escaped
- Type checking ensures data integrity

### Task 3: CancelOrder Stored Procedure ✅
**File:** `task3_cancelorder.sql`

Creates a stored procedure to delete an order record based on order ID input.

**Usage:**
```sql
CALL CancelOrder(1);
```

**Output:**
```
Confirmation
------------------
Order 1 is cancelled
```

**Features:**
- Accepts OrderID as parameter
- Deletes order and related records (OrderItems, OrderDeliveryStatus)
- Uses transactions for data integrity
- Provides confirmation message
- Includes alternative soft-delete version (recommended for production)

**Important Notes:**
- This procedure performs a HARD DELETE (permanently removes data)
- For production, consider using the soft-delete alternative that updates status to 'Cancelled'
- Always backup data before testing delete operations

## Schema Adaptations

The queries are adapted to work with the current normalized schema:
- **Quantity** is stored in `OrderItems` table (not directly in `Orders`)
- Queries aggregate quantities when needed
- Alternative versions provided for different schema structures

## Installation

### Prerequisites
- MySQL Server with LittleLemonDB database
- Appropriate user privileges (CREATE PROCEDURE, EXECUTE)

### Steps

1. **Connect to MySQL Workbench**
   ```sql
   USE LittleLemonDB;
   ```

2. **Run Task 1 Script**
   ```sql
   source task1_getmaxquantity.sql;
   ```

3. **Run Task 2 Script**
   ```sql
   source task2_getorderdetail.sql;
   ```

4. **Run Task 3 Script**
   ```sql
   source task3_cancelorder.sql;
   ```

## Usage Examples

### Example 1: Get Maximum Quantity
```sql
-- Call the procedure
CALL GetMaxQuantity();
```

### Example 2: Get Order Details for Customer
```sql
-- Set customer ID
SET @id = 1;

-- Execute prepared statement
EXECUTE GetOrderDetail USING @id;

-- Try with different customer
SET @id = 2;
EXECUTE GetOrderDetail USING @id;
```

### Example 3: Cancel an Order
```sql
-- Cancel order with ID 1
CALL CancelOrder(1);

-- Verify order is deleted
SELECT * FROM Orders WHERE OrderID = 1;
```

## Best Practices

### Stored Procedures
1. **Use descriptive names** - Clear, meaningful procedure names
2. **Include error handling** - Use TRY-CATCH or error handlers
3. **Document parameters** - Add comments explaining inputs/outputs
4. **Use transactions** - For operations affecting multiple tables
5. **Validate inputs** - Check parameters before processing

### Prepared Statements
1. **Always use parameters** - Never concatenate user input into SQL
2. **Deallocate when done** - Free resources after use
3. **Reuse statements** - Execute multiple times with different values
4. **Type safety** - Ensure parameter types match expected values

### Security Considerations
1. **SQL Injection Prevention** - Always use parameterized queries
2. **Input Validation** - Validate all user inputs
3. **Principle of Least Privilege** - Grant minimum necessary permissions
4. **Audit Logging** - Log important operations (deletes, updates)
5. **Soft Deletes** - Consider updating status instead of hard deletes

## Troubleshooting

### Issue: "Procedure already exists"
**Solution:**
```sql
DROP PROCEDURE IF EXISTS GetMaxQuantity;
-- Then recreate it
```

### Issue: "Prepared statement not found"
**Solution:**
- Ensure you've prepared the statement before executing
- Check for typos in statement name
- Re-prepare the statement if needed

### Issue: "Foreign key constraint fails" (CancelOrder)
**Solution:**
- Ensure related records are deleted first (OrderItems, OrderDeliveryStatus)
- Or use the soft-delete alternative that updates status instead

### Issue: "Access denied"
**Solution:**
- Verify user has CREATE PROCEDURE privilege
- Grant necessary permissions:
  ```sql
  GRANT CREATE ROUTINE ON LittleLemonDB.* TO 'user'@'localhost';
  ```

## Performance Benefits

### Stored Procedures
- **Pre-compiled** - Execution plan cached
- **Reduced network traffic** - Single call vs multiple queries
- **Consistency** - Same logic executed every time

### Prepared Statements
- **Parsing optimization** - Query parsed once, executed many times
- **Security** - Parameter binding prevents injection
- **Efficiency** - Better for repeated queries with different values

## Additional Resources

- MySQL Stored Procedures: https://dev.mysql.com/doc/refman/8.0/en/stored-programs.html
- Prepared Statements: https://dev.mysql.com/doc/refman/8.0/en/sql-prepared-statements.html
- SQL Injection Prevention: https://owasp.org/www-community/attacks/SQL_Injection

## Conclusion

These stored procedures and prepared statements provide:
- ✅ Optimized query execution
- ✅ Code reusability
- ✅ Enhanced security
- ✅ Better maintainability
- ✅ Improved performance

Little Lemon can now efficiently query and manage their database with these optimized solutions.
