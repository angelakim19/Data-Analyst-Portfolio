SELECT *
FROM orders;
-- 1. What is the total revenue (sales)?
SELECT ROUND(SUM(sales),2) AS total_revenue
FROM orders;


-- 2. What is the total profit?
SELECT ROUND(SUM(profit),2) AS total_profit
FROM orders;


-- 3. What is the total number of orders?
SELECT COUNT(DISTINCT order_id) AS total_orders 
FROM orders;


-- 4. Average Order values
SELECT ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS avg_order_values 
FROM orders;


-- 5. What are the top 5 most profitable products?
SELECT `Product Name`,
	   ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY `Product Name`
ORDER BY total_profit DESC
LIMIT 5;


-- 6. Which sub-categories bring the most sales?
SELECT `Sub-Category`, 
		ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY `Sub-Category`
ORDER BY total_sales DESC;


-- 7. Sales trend over time (monthly/yearly)?
SELECT 
  DATE_FORMAT(order_date, '%Y-%m') AS month,
  ROUND(SUM(sales), 2) AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY month
ORDER BY month;


-- 8. Sales by region and segment
SELECT region, segment,
       ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY region, segment
ORDER BY region, total_sales DESC;


-- 9. Products with the highest discounts
SELECT `Product Name`,
       ROUND(AVG(discount), 2) AS avg_discount,
       COUNT(*) AS total_orders
FROM orders
GROUP BY `Product Name`
HAVING COUNT(*) >= 10
ORDER BY avg_discount DESC
LIMIT 10;


-- 10. Which ship mode has the most orders?
SELECT `Ship Mode`, 
       COUNT(*) AS order_count
FROM orders
GROUP BY `Ship Mode`
ORDER BY order_count DESC;