# Little Lemon Database Queries - Task Solutions

This folder contains SQL queries for three tasks related to creating reports on orders placed at Little Lemon restaurant.

## Tasks Overview

### Task 1: Create Virtual Table (VIEW)
Create a virtual table called `OrdersView` that focuses on OrderID, Quantity, and Cost columns for all orders with quantity greater than 2.

**File:** `task1_orders_view.sql`

### Task 2: JOIN Query
Extract information from four tables (Customers, Orders, Menus, MenuItems) for all customers with orders costing more than $150, sorted by lowest cost.

**File:** `task2_join_query.sql`

### Task 3: Subquery with ANY Operator
Find all menu items for which more than 2 orders have been placed using a subquery with the ANY operator.

**File:** `task3_subquery.sql`

## Schema Notes

The current database schema uses a normalized structure:
- **Orders** table contains `TotalCost` (not `Quantity` directly)
- **OrderItems** table contains `Quantity` per item
- **MenuItems** table exists (no separate **Menus** table in base schema)

The queries are adapted to work with this schema. If your schema differs (e.g., has a `Menus` table or `Quantity` directly in `Orders`), see the alternative queries provided in each file.

## Usage

### Prerequisites
1. Ensure the `LittleLemonDB` database is created and populated
2. Connect to MySQL server using MySQL Workbench
3. Select the `LittleLemonDB` database

### Running the Queries

1. **Task 1 - Create View:**
   ```sql
   -- Open and execute task1_orders_view.sql
   -- Then query the view:
   SELECT * FROM OrdersView;
   ```

2. **Task 2 - JOIN Query:**
   ```sql
   -- Open and execute task2_join_query.sql
   -- The query will return customers with orders > $150
   ```

3. **Task 3 - Subquery:**
   ```sql
   -- Open and execute task3_subquery.sql
   -- The query will return menu items with orders > 2
   ```

## Schema Adjustment (Optional)

If you need to match the exact schema described in the task requirements (with a `Menus` table and `Quantity` in `Orders`), run:

```sql
-- Execute schema_adjustment.sql
source schema_adjustment.sql;
```

This will:
- Create a `Menus` table linking to `MenuItems`
- Add a `Quantity` column to the `Orders` table
- Populate the new tables with data

## Expected Outputs

### Task 1 Output
```
OrderID | Quantity | Cost
--------|----------|------
   2    |    8     | 78.00
   3    |    3     | 52.00
```

### Task 2 Output
```
CustomerID | FullName      | OrderID | Cost  | MenuName        | ItemName        | Category
-----------|---------------|---------|-------|-----------------|-----------------|----------
    2      | Emma Johnson  |    2    | 78.00 | Bruschetta      | Bruschetta      | Starter
    2      | Emma Johnson  |    2    | 78.00 | Pasta Carbonara | Pasta Carbonara | Main Course
```

### Task 3 Output
```
MenuName
----------
Bruschetta
Grilled Chicken
Pasta Carbonara
Wine White
```

## Query Explanations

### Task 1: Virtual Table (VIEW)
- Creates a view that aggregates quantities from `OrderItems` per order
- Filters orders where total quantity > 2
- Provides a simplified interface to query order data

### Task 2: JOIN Query
- Uses INNER JOIN to combine data from 4 tables
- Filters orders with `TotalCost > 150`
- Sorts results by cost (ascending)
- Shows customer details, order info, and menu item details

### Task 3: Subquery with ANY
- Outer query selects menu item names
- Inner query (subquery) finds menu items with quantity > 2 in any order
- Uses ANY operator to match menu items from the subquery result

## Troubleshooting

### Issue: "Table doesn't exist"
- Ensure you've run the `LittleLemonDB.sql` script to create all tables
- Verify you're using the correct database: `USE LittleLemonDB;`

### Issue: "No rows returned"
- Check if sample data was inserted correctly
- Verify order costs and quantities match filter criteria
- Run sample data queries to verify data exists

### Issue: "View already exists"
- Drop the view first: `DROP VIEW IF EXISTS OrdersView;`
- Then recreate it

## Additional Queries

Each task file includes:
- Main query matching task requirements
- Alternative queries for different schema structures
- Enhanced queries with additional information
- Comments explaining the logic

## Next Steps

After running these queries, you can:
1. Modify the queries to match your specific reporting needs
2. Create additional views for common queries
3. Add indexes to improve query performance
4. Create stored procedures for complex reporting
