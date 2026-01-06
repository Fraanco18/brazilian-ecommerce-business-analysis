# Processed Dataset — master_sales_clean

The `master_sales_clean` dataset represents the final business-ready table generated for this project.

## Description

This dataset consolidates multiple raw e-commerce tables into a single analytical view, combining:
- Orders
- Customers
- Payments
- Products
- Logistics and delivery information
- Product category names translation

It serves as the foundation for all business questions and visual insights presented in this repository.

## Generation Logic

The dataset is generated using SQL by:
1. Filtering delivered orders only
2. Aggregating payment values to compute real revenue per order
3. Aggregating order items to calculate product value, freight cost, and item quantity
4. Translating product categories to English
5. Enriching orders with temporal features (purchase month and hour)

All transformation logic is fully documented in the SQL scripts located in the `sql/` directory.

## Schema Overview

Key fields include:
- `order_id`
- `customer_id`
- `customer_state`
- `order_status`
- `purchase_date`
- `delivery_date`
- `purchase_month`
- `purchase_hour`
- `total_revenue`
- `product_value`
- `freight_value`
- `items_qty`
- `category`

## Reusability

This dataset can be reused for further analysis, including:
- Advanced customer segmentation
- Time-series analysis
- Predictive modeling
- Additional business intelligence dashboards


This dataset is designed to serve as a reusable analytical layer for exploratory and business-oriented analysis.
