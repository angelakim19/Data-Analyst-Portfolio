-- Using the pizza_sales database
USE pizza_sales;

-- 1. Total number of unique orders
-- The total number of unique orders is 21350
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;


-- 2. Total number of pizzas sold
-- The total number of pizza that was wold is 49574
SELECT SUM(quantity) AS total_pizzas_sold
FROM pizza_sales;


-- 3. Total revenue generated from all sales
-- The total revenue generated from all sales is 817860.05
SELECT ROUND(SUM(total_price),2) AS total_revenue
FROM pizza_sales;


-- 4. Top 5 best-selling pizzas by quantity
-- The top 5 best selling pizza are:
-- i. The Classic Deluxe Pizza - 2453
-- ii. The Barbecue Chicken Pizza - 2432
-- iii. The Hawaiian Pizza - 2422
-- iv. The Pepperoni Pizza - 2418
-- v. The Thai Chicken Pizza - 2371
SELECT pizza_name, SUM(quantity) AS total_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_sold DESC
LIMIT 5;


-- 5. Revenue breakdown  by pizza size
-- L	375318.7
-- M	249382.25
-- S	178076.5
-- XL	14076
-- XXL	1006.6
SELECT pizza_size, ROUND(SUM(total_price), 2) AS revenue
FROM pizza_sales
GROUP BY pizza_size
ORDER BY revenue DESC;

-- 6. Pizzas Sold by Category
-- Classic	14888
-- Supreme	11987
-- Veggie	11649
-- Chicken	11050
SELECT pizza_category, SUM(quantity) AS total_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_sold DESC;


-- 7. Average Order Value (AOV): average amount spent per order
-- 38.31
SELECT ROUND(AVG(total_price), 2) AS avg_order_value
FROM (
  SELECT order_id, SUM(total_price) AS total_price
  FROM pizza_sales
  GROUP BY order_id
) AS order_totals;


-- 8. Monthly sales trend (quantity sold and revenue by month)
-- pizza sold: 49574
-- revenue: 817860.05
SELECT 
  DATE_FORMAT(order_date, '%Y-%m') AS month,
  SUM(quantity) AS pizzas_sold,
  ROUND(SUM(total_price), 2) AS revenue
FROM pizza_sales
GROUP BY month
ORDER BY month;


-- 9. Busiest hour of the day by total number of orders
SELECT 
  HOUR(order_time) AS hour,
  COUNT(*) AS total_orders
FROM pizza_sales
GROUP BY hour
ORDER BY total_orders DESC;
