-- 1. Retrieve the total number of orders placed.
USE pizzahut;
SELECT COUNT(order_id) AS "Total_order_count" 
FROM orders;

-- Calculate the total revenue generated from pizza sales.
SELECT 
ROUND(SUM(quantity * price), 2) AS 'revenue_each'
FROM pizzas t1
JOIN order_details t2 
ON t1.pizza_id = t2.pizza_id;
    
-- Identify the highest-priced pizza.
SELECT name, price
FROM
pizzas t1
JOIN
pizza_types t2 
ON t1.pizza_type_id = t2.pizza_type_id
ORDER BY price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT size, COUNT(order_details_id)
FROM pizzas t1
JOIN
order_details t2 ON t1.pizza_id = t2.pizza_id
GROUP BY size
ORDER BY COUNT(order_details_id) DESC;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT name,SUM(quantity) 
FROM pizza_types p1
JOIN pizzas p2
ON p1.pizza_type_id=p2.pizza_type_id
JOIN order_details p3
ON p2.pizza_id=p3.pizza_id
GROUP BY name
ORDER BY SUM(quantity) DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT category,SUM(quantity) AS "no.pizzas" FROM pizza_types t1
JOIN pizzas t2
ON t1.pizza_type_id=t2.pizza_type_id
JOIN order_details t3
ON t2.pizza_id=t3.pizza_id
GROUP BY category;

-- Determine the distribution of orders by hour of the day.
SELECT HOUR(time), COUNT(order_id)
FROM
    orders
GROUP BY HOUR(time)
ORDER BY HOUR(time);

-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT category , COUNT(name) FROM pizza_types
GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT DATE(date) AS "Day",SUM(quantity) AS "total_orders",ROUND(AVG(SUM(quantity)) OVER (),2) AS "Avg_order_per_day" FROM orders t1
JOIN order_details t2
ON t1.order_id=t2.order_id
GROUP BY DATE(date);

-- Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    name, SUM(quantity * price)
FROM
    pizzas t1
        JOIN
    pizza_types t2 ON t1.pizza_type_id = t2.pizza_type_id
        JOIN
    order_details t3 ON t1.pizza_id = t3.pizza_id
GROUP BY name
ORDER BY SUM(quantity * price) DESC
LIMIT 3;

