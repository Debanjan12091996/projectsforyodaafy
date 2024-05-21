USE pizza;
SELECT * FROM pizza_sales;
SELECT SUM(total_price)AS Total_Revenue from pizza_sales ;
SELECT SUM(total_price)/ COUNT(DISTINCT order_id)AS Avg_ord_value from pizza_sales;
SELECT SUM(quantity)AS Total_pizzas_sold FROM pizza_sales;
SELECT COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales;
SELECT SUM(quantity)/ COUNT(DISTINCT order_id) AS Avg_Pizzas_per_ord FROM pizza_sales;
SELECT DAYNAME(order_date) AS order_day, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY order_day;
/*----TOTAL ORDERS IN A WEEK-----------*/
SELECT 
    DATE_FORMAT(order_date, '%x-%v') AS week,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    pizza_sales
GROUP BY 
    DATE_FORMAT(order_date, '%x-%v')
ORDER BY 
    MIN(order_date);
   /*-----------------------------HOURLY TREND---------------------------------------------------------*/
SELECT HOUR(order_time) AS order_hours, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);
/*----------------TOTAL MONTHLY ORDER--------------*/
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    pizza_sales
GROUP BY 
    DATE_FORMAT(order_date, '%Y-%m')
ORDER BY 
    MIN(order_date);
/*----------TOTAL SALES IN PIZZA QUALITY------------*/
 SELECT 
    pizza_category, sum(total_price) as total_sales,
    SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS Total_sales
FROM 
    pizza_sales
GROUP BY 
    pizza_category;
/*-----PERCENTAGE OF SALES BY PIZZA SIZE----------*/
SELECT 
    pizza_size, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_sales,
    CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM 
    pizza_sales
GROUP BY 
    pizza_size
ORDER BY 
    PCT DESC;
/*----------------TOTAL PIZZAS SOLD IN PIZZA CATEGORY----------------------*/
SELECT pizza_category ,SUM(quantity) AS Total_pizzas_sold
from pizza_sales
GROUP BY pizza_category;
/* TOP 5 BEST SELLER BY TOTAL PIZZA SOLD*/
SELECT 
    pizza_name_id,
    SUM(quantity) AS Total_pizza_sold
FROM 
    pizza_sales
GROUP BY 
    pizza_name_id
ORDER BY 
    SUM(quantity) DESC
LIMIT 5;
/* Bottom 5 vworst selling Pizzas by Total Pizza sold */
SELECT 
    pizza_name_id,
    SUM(quantity) AS Total_pizza_sold
FROM 
    pizza_sales
GROUP BY 
    pizza_name_id
ORDER BY 
    SUM(quantity) ASC
LIMIT 5;



    















