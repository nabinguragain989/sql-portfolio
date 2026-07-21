/*
===============================================================================
Retail Sales Analysis
Database Schema Documentation
===============================================================================

Project:
Retail Sales Analysis using SQL

Dataset:
Global Superstore Sales Dataset
https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting

Author:
Nabin Guragain

Description:
This document describes the relational database schema used for this project.
The original dataset was provided as a single CSV file and has been normalized
into multiple relational tables following Third Normal Form (3NF).

===============================================================================
DATABASE OVERVIEW
===============================================================================

                     +----------------+
                     |   CUSTOMERS    |
                     +----------------+
                     | customer_id PK |
                     | customer_name  |
                     | segment        |
                     +-------+--------+
                             |
                             |
                             |
                     +-------v--------+
                     |     ORDERS     |
                     +----------------+
                     | order_id PK    |
                     | order_date     |
                     | ship_date      |
                     | ship_mode      |
                     | customer_id FK |
                     | location_id FK |
                     +-------+--------+
                             |
                             |
                             |
             +---------------+----------------+
             |                                |
             |                                |
     +-------v--------+              +--------v--------+
     | ORDER_ITEMS    |              |   LOCATIONS     |
     +----------------+              +-----------------+
     | row_id PK      |              | location_id PK  |
     | order_id FK    |              | country         |
     | product_id FK  |              | state           |
     | sales          |              | city            |
     | quantity       |              | postal_code     |
     | discount       |              | region          |
     | profit         |              +-----------------+
     +-------+--------+
             |
             |
             |
     +-------v--------+
     |    PRODUCTS    |
     +----------------+
     | product_id PK  |
     | product_name   |
     | category       |
     | sub_category   |
     +----------------+

===============================================================================
TABLE DESCRIPTIONS
===============================================================================

1. CUSTOMERS
------------

Purpose:
Stores unique customer information.

Primary Key:
    customer_id

Columns

customer_id
Unique customer identifier.

customer_name
Customer full name.

segment
Business segment
(Consumer, Corporate, Home Office)

-------------------------------------------------------------------------------

2. PRODUCTS
-----------

Purpose

Stores product catalogue information.

Primary Key

product_id

Columns

product_id

product_name

category

sub_category

-------------------------------------------------------------------------------

3. LOCATIONS
------------

Purpose

Stores geographical information.

Primary Key

location_id

Columns

location_id

country

state

city

postal_code

region

-------------------------------------------------------------------------------

4. ORDERS
---------

Purpose

Stores each sales order.

Primary Key

order_id

Foreign Keys

customer_id

location_id

Columns

order_id

order_date

ship_date

ship_mode

customer_id

location_id

-------------------------------------------------------------------------------

5. ORDER_ITEMS
--------------

Purpose

Stores individual products within each order.

Primary Key

row_id

Foreign Keys

order_id

product_id

Columns

row_id

order_id

product_id

sales

quantity

discount

profit

===============================================================================
RELATIONSHIPS
===============================================================================

CUSTOMERS

1 Customer

↓

Many Orders

-------------------------------------------------------------------------------

LOCATIONS

1 Location

↓

Many Orders

-------------------------------------------------------------------------------

ORDERS

1 Order

↓

Many Order Items

-------------------------------------------------------------------------------

PRODUCTS

1 Product

↓

Many Order Items

===============================================================================
DATABASE NORMALIZATION
===============================================================================

Normalization Level

Third Normal Form (3NF)

Reasons

• Removes duplicate customer information

• Removes duplicate product information

• Removes duplicate location information

• Prevents update anomalies

• Improves scalability

• Reduces storage redundancy

===============================================================================
ENTITY RELATIONSHIPS
===============================================================================

Customers
    │
    │
    ├──────────────┐
    │              │
    ▼              │
 Orders            │
    │              │
    │              │
    ▼              ▼
Order Items     Locations
    │
    │
    ▼
Products

===============================================================================
EXPECTED ROW COUNTS
===============================================================================

Customers
≈ Unique Customer IDs

Products
≈ Unique Product IDs

Locations
≈ Unique Cities / States

Orders
≈ Unique Order IDs

Order_Items
≈ Total rows in original dataset

===============================================================================
END OF SCHEMA
===============================================================================
