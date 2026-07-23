/*
===============================================================================
Retail Sales Analysis
SQL Analysis Queries

Author: Nabin Guragain

Dataset:
Global Superstore Sales Dataset

Description:
This script answers key business questions using SQL.


SECTION 1 - SALES PERFORMANCE
Business Questions 1 - 6
===============================================================================
*/

-- 1. What is the total revenue?

SELECT
    ROUND(SUM(sales), 2) AS total_revenue
FROM order_items;


-- 2. What is the total profit?

SELECT
    ROUND(SUM(profit), 2) AS total_profit
FROM order_items;


-- 3. What is the average order value?

SELECT
    ROUND(AVG(order_total), 2) AS average_order_value
FROM (
    SELECT
        order_id,
        SUM(sales) AS order_total
    FROM order_items
    GROUP BY order_id
) AS order_summary;


-- 4. Which year generated the highest revenue?

SELECT
    EXTRACT(YEAR FROM o.order_date) AS year,
    ROUND(SUM(oi.sales), 2) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY year
ORDER BY total_revenue DESC;


-- 5. Which month has the highest sales?

SELECT
    TO_CHAR(o.order_date, 'Month') AS month,
    ROUND(SUM(oi.sales), 2) AS total_sales
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    EXTRACT(MONTH FROM o.order_date),
    TO_CHAR(o.order_date, 'Month')
ORDER BY total_sales DESC;


-- 6. Which quarter performs best?

SELECT
    EXTRACT(QUARTER FROM o.order_date) AS quarter,
    ROUND(SUM(oi.sales), 2) AS total_sales
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY quarter
ORDER BY total_sales DESC;

/*
===============================================================================
SECTION 2 - CUSTOMER ANALYSIS
Business Questions 7 - 10
===============================================================================
*/

-- 7. Who are the Top 10 Customers by Revenue?

SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(oi.sales), 2) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_revenue DESC
LIMIT 10;


-- 8. Which customer segment contributes the highest revenue?

SELECT
    c.segment,
    ROUND(SUM(oi.sales), 2) AS total_revenue,
    ROUND(SUM(oi.profit), 2) AS total_profit,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.segment
ORDER BY total_revenue DESC;


-- 9. Which customers place the most orders?

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_orders DESC
LIMIT 10;


-- 10. Which customers are least active?

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_orders ASC
LIMIT 10;


/*
===============================================================================
SECTION 3 - PRODUCT ANALYSIS
Business Questions 11 - 15
===============================================================================
*/

-- 11. Which products generate the highest revenue?

SELECT
    p.product_id,
    p.product_name,
    ROUND(SUM(oi.sales), 2) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_revenue DESC
LIMIT 10;


-- 12. Which products generate the highest profit?

SELECT
    p.product_id,
    p.product_name,
    ROUND(SUM(oi.profit), 2) AS total_profit
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_profit DESC
LIMIT 10;


-- 13. Which products generate losses?

SELECT
    p.product_id,
    p.product_name,
    ROUND(SUM(oi.profit), 2) AS total_profit
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
HAVING SUM(oi.profit) < 0
ORDER BY total_profit ASC;


-- 14. Which categories perform best?

SELECT
    p.category,
    ROUND(SUM(oi.sales), 2) AS total_sales,
    ROUND(SUM(oi.profit), 2) AS total_profit
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY total_sales DESC;


-- 15. Which sub-categories need improvement?

SELECT
    p.sub_category,
    ROUND(SUM(oi.sales), 2) AS total_sales,
    ROUND(SUM(oi.profit), 2) AS total_profit
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.sub_category
ORDER BY total_profit ASC;


/*
===============================================================================
SECTION 4 - REGIONAL ANALYSIS
Business Questions 16 - 18
===============================================================================
*/

-- 16. Which region performs best?

SELECT
    l.region,
    ROUND(SUM(oi.sales), 2) AS total_sales,
    ROUND(SUM(oi.profit), 2) AS total_profit
FROM locations l
JOIN orders o
    ON l.location_id = o.location_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY l.region
ORDER BY total_sales DESC;


-- 17. Which state generates the highest revenue?

SELECT
    l.state,
    ROUND(SUM(oi.sales), 2) AS total_revenue
FROM locations l
JOIN orders o
    ON l.location_id = o.location_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY l.state
ORDER BY total_revenue DESC;


-- 18. Which city generates the highest profit?

SELECT
    l.city,
    ROUND(SUM(oi.profit), 2) AS total_profit
FROM locations l
JOIN orders o
    ON l.location_id = o.location_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY l.city
ORDER BY total_profit DESC;


/*
===============================================================================
SECTION 5 - SHIPPING ANALYSIS
Business Questions 19 - 20
===============================================================================
*/

-- 19. Which shipping mode is most popular?

SELECT
    ship_mode,
    COUNT(*) AS total_orders
FROM orders
GROUP BY ship_mode
ORDER BY total_orders DESC;


-- 20. Does faster shipping increase profitability?

SELECT
    o.ship_mode,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.sales), 2) AS total_sales,
    ROUND(SUM(oi.profit), 2) AS total_profit,
    ROUND(AVG(oi.profit), 2) AS average_profit
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.ship_mode
ORDER BY average_profit DESC;


/*
===============================================================================
SECTION 6 - DISCOUNT ANALYSIS
Business Questions 21 - 22
===============================================================================
*/

-- 21. Which discounts reduce profitability?

SELECT
    discount,
    ROUND(AVG(profit), 2) AS average_profit,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(*) AS total_transactions
FROM order_items
GROUP BY discount
ORDER BY discount;


-- 22. Which categories are most affected by discounts?

SELECT
    p.category,
    ROUND(AVG(oi.discount), 2) AS average_discount,
    ROUND(SUM(oi.sales), 2) AS total_sales,
    ROUND(SUM(oi.profit), 2) AS total_profit
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY average_discount DESC;
