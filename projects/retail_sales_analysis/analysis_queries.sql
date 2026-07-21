/*
===============================================================================
Retail Sales Analysis
SQL Analysis Queries

Author: Nabin Guragain

Dataset:
Global Superstore Sales Dataset

Description:
This script answers key business questions using SQL.

===============================================================================
*/

-- ============================================================================
-- SECTION 1
-- DATA EXPLORATION
-- ============================================================================

-- 1. View the first 10 records

SELECT *
FROM raw_sales
LIMIT 10;

------------------------------------------------------------

-- 2. Count total records

SELECT COUNT(*) AS total_records
FROM raw_sales;

------------------------------------------------------------

-- 3. Find date range

SELECT
MIN(order_date) AS first_order,
MAX(order_date) AS last_order
FROM raw_sales;

------------------------------------------------------------

-- 4. Count unique customers

SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM raw_sales;

------------------------------------------------------------

-- 5. Count unique products

SELECT COUNT(DISTINCT product_id) AS total_products
FROM raw_sales;

------------------------------------------------------------

-- ============================================================================
-- SECTION 2
-- SALES KPIs
-- ============================================================================

-- 6. Total Sales

SELECT
ROUND(SUM(sales),2) AS total_sales
FROM order_items;

------------------------------------------------------------

-- 7. Total Profit

SELECT
ROUND(SUM(profit),2) AS total_profit
FROM order_items;

------------------------------------------------------------

-- 8. Average Order Value

SELECT
ROUND(AVG(sales),2) AS average_order_value
FROM order_items;

------------------------------------------------------------

-- 9. Total Quantity Sold

SELECT
SUM(quantity) AS total_quantity
FROM order_items;

------------------------------------------------------------

-- 10. Average Profit Per Order

SELECT
ROUND(AVG(profit),2)
AS average_profit
FROM order_items;

------------------------------------------------------------

-- ============================================================================
-- SECTION 3
-- CUSTOMER ANALYSIS
-- ============================================================================

-- 11. Top 10 Customers by Revenue

SELECT

c.customer_name,

ROUND(SUM(oi.sales),2) AS revenue

FROM customers c

JOIN orders o

ON c.customer_id = o.customer_id

JOIN order_items oi

ON o.order_id = oi.order_id

GROUP BY c.customer_name

ORDER BY revenue DESC

LIMIT 10;

------------------------------------------------------------

-- 12. Customer Segment Performance

SELECT

c.segment,

ROUND(SUM(oi.sales),2) AS sales,

ROUND(SUM(oi.profit),2) AS profit

FROM customers c

JOIN orders o

ON c.customer_id = o.customer_id

JOIN order_items oi

ON o.order_id = oi.order_id

GROUP BY c.segment

ORDER BY sales DESC;

------------------------------------------------------------

-- 13. Customers with Highest Number of Orders

SELECT

c.customer_name,

COUNT(DISTINCT o.order_id) AS total_orders

FROM customers c

JOIN orders o

ON c.customer_id = o.customer_id

GROUP BY c.customer_name

ORDER BY total_orders DESC

LIMIT 10;

------------------------------------------------------------

-- 14. Customers Generating Losses

SELECT

c.customer_name,

ROUND(SUM(oi.profit),2) AS profit

FROM customers c

JOIN orders o

ON c.customer_id = o.customer_id

JOIN order_items oi

ON o.order_id = oi.order_id

GROUP BY c.customer_name

HAVING SUM(oi.profit) < 0

ORDER BY profit;

------------------------------------------------------------

-- 15. Average Revenue per Customer

SELECT

ROUND(

SUM(sales) /

COUNT(DISTINCT customer_id)

,2)

AS average_customer_revenue

FROM raw_sales;

------------------------------------------------------------
