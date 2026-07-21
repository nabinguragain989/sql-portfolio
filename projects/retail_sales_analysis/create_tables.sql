/*
===============================================================================
Retail Sales Analysis
Create Database Tables
Author: Nabin Guragain
Database: PostgreSQL
===============================================================================

Description

This script creates all database tables required for the Retail Sales Analysis
project.

Database Design

raw_sales      (Staging Table)
customers
products
locations
orders
order_items

===============================================================================
*/

-- ============================================================================
-- Remove Existing Tables
-- ============================================================================

DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS locations CASCADE;
DROP TABLE IF EXISTS raw_sales CASCADE;

-- ============================================================================
-- RAW STAGING TABLE
-- ============================================================================

CREATE TABLE raw_sales (

    row_id              INTEGER,

    order_id            VARCHAR(30),

    order_date          DATE,

    ship_date           DATE,

    ship_mode           VARCHAR(50),

    customer_id         VARCHAR(30),

    customer_name       VARCHAR(150),

    segment             VARCHAR(50),

    country             VARCHAR(100),

    city                VARCHAR(100),

    state               VARCHAR(100),

    postal_code         VARCHAR(20),

    region              VARCHAR(50),

    product_id          VARCHAR(30),

    category            VARCHAR(50),

    sub_category        VARCHAR(100),

    product_name        TEXT,

    sales               NUMERIC(12,2),

    quantity            INTEGER,

    discount            NUMERIC(5,2),

    profit              NUMERIC(12,2)

);

-- ============================================================================
-- CUSTOMERS
-- ============================================================================

CREATE TABLE customers (

    customer_id         VARCHAR(30) PRIMARY KEY,

    customer_name       VARCHAR(150) NOT NULL,

    segment             VARCHAR(50) NOT NULL,

    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

-- ============================================================================
-- PRODUCTS
-- ============================================================================

CREATE TABLE products (

    product_id          VARCHAR(30) PRIMARY KEY,

    product_name        TEXT NOT NULL,

    category            VARCHAR(50) NOT NULL,

    sub_category        VARCHAR(100) NOT NULL,

    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

-- ============================================================================
-- LOCATIONS
-- ============================================================================

CREATE TABLE locations (

    location_id         SERIAL PRIMARY KEY,

    country             VARCHAR(100),

    state               VARCHAR(100),

    city                VARCHAR(100),

    postal_code         VARCHAR(20),

    region              VARCHAR(50),

    UNIQUE (

        country,

        state,

        city,

        postal_code

    )

);

-- ============================================================================
-- ORDERS
-- ============================================================================

CREATE TABLE orders (

    order_id            VARCHAR(30) PRIMARY KEY,

    order_date          DATE NOT NULL,

    ship_date           DATE,

    ship_mode           VARCHAR(50),

    customer_id         VARCHAR(30),

    location_id         INTEGER,

    FOREIGN KEY (customer_id)

        REFERENCES customers(customer_id)

        ON UPDATE CASCADE

        ON DELETE RESTRICT,

    FOREIGN KEY (location_id)

        REFERENCES locations(location_id)

        ON UPDATE CASCADE

        ON DELETE RESTRICT

);

-- ============================================================================
-- ORDER ITEMS
-- ============================================================================

CREATE TABLE order_items (

    row_id              INTEGER PRIMARY KEY,

    order_id            VARCHAR(30),

    product_id          VARCHAR(30),

    sales               NUMERIC(12,2) NOT NULL,

    quantity            INTEGER NOT NULL,

    discount            NUMERIC(5,2),

    profit              NUMERIC(12,2),

    FOREIGN KEY (order_id)

        REFERENCES orders(order_id)

        ON UPDATE CASCADE

        ON DELETE CASCADE,

    FOREIGN KEY (product_id)

        REFERENCES products(product_id)

        ON UPDATE CASCADE

        ON DELETE RESTRICT

);

-- ============================================================================
-- CREATE INDEXES
-- ============================================================================

CREATE INDEX idx_customer_id
ON orders(customer_id);

CREATE INDEX idx_location_id
ON orders(location_id);

CREATE INDEX idx_order_date
ON orders(order_date);

CREATE INDEX idx_product_category
ON products(category);

CREATE INDEX idx_product_subcategory
ON products(sub_category);

CREATE INDEX idx_region
ON locations(region);

CREATE INDEX idx_state
ON locations(state);

CREATE INDEX idx_city
ON locations(city);

CREATE INDEX idx_sales
ON order_items(sales);

CREATE INDEX idx_profit
ON order_items(profit);

CREATE INDEX idx_discount
ON order_items(discount);

-- ============================================================================
-- VERIFY TABLE CREATION
-- ============================================================================

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

-- ============================================================================
-- END OF SCRIPT
-- ============================================================================
