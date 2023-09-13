USE swiggy;
/*DISTINCT ORDERS*/
SELECT COUNT(DISTINCT name) as orders
FROM items;

/*DISTINCT ORDERS BY CUSTOMER*/
SELECT COUNT(DISTINCT order_id) 
FROM orders;

/*ITEMS CONTAINING CHICKEN IN THE NAME*/
SELECT COUNT(name) AS Chickenitems 
FROM items
WHERE name LIKE '%CHICKEN%';

/*AVERAGE ITEMS PER ORDER*/
SELECT COUNT(name)/COUNT(distinct order_id) AS averageitemsperorder
FROM items;

/*ITEM ORDERED THE MOST NUMBER OF TIMES*/
SELECT name,COUNT(*) numberoftimesordered FROM items
GROUP BY name
ORDER BY COUNT(*) DESC
LIMIT 1;

/*RESTRAUNTS WITH MOST ORDERS*/
SELECT restaurant_name,COUNT(order_id) FROM ORDERS
GROUP BY restaurant_name
ORDER BY COUNT(order_id) DESC;

/*ORDERS PLACED PER MONTH AND YEAR*/
SELECT DATE_FORMAT(order_time,"%Y-%M") MONTH_YEAR ,COUNT(order_id) NO_OF_ORDERS
FROM orders
GROUP BY DATE_FORMAT(order_time,"%Y-%M")
ORDER BY COUNT(order_id) DESC;

/*AVERAGE ORDER VALUE*/
SELECT ROUND(SUM(order_total)/COUNT(DISTINCT ORDER_ID),2) AS AVERAGE_ORDER_VALUE
FROM ORDERS;

/*YOY CHANGE IN REVENUE*/
use swiggy;
WITH CTE2 AS (
SELECT DATE_FORMAT(order_time,"%Y") as ORDER_YEAR,
SUM(ORDER_TOTAL) as TOTAL_REVENUE
FROM ORDERS
GROUP BY DATE_FORMAT(order_time,"%Y"))

SELECT ORDER_YEAR , 
TOTAL_REVENUE,
LAG(TOTAL_REVENUE,1,0) OVER (ORDER BY ORDER_YEAR) as PREVIOUS_REVENUE, 
(TOTAL_REVENUE-LAG(TOTAL_REVENUE,1,0) OVER (ORDER BY ORDER_YEAR)) AS YOY_CHANGE_IN_REVENUE
FROM CTE2 ;

/*RANKING RESTAURANTS WITH HIGHEST REVENUE*/
WITH CTE3 AS(
SELECT restaurant_name,
SUM(ORDER_TOTAL) as TOTAL_REVENUE
FROM ORDERS
GROUP BY restaurant_name)
SELECT restaurant_name,TOTAL_REVENUE,
RANK()OVER (ORDER BY TOTAL_REVENUE DESC) AS RANKING 
FROM CTE3;

/*NUMBER OF ON TIME ORDERS DURING DIFFERENT RAIN MODES*/
SELECT rain_mode,
SUM( CASE WHEN on_time=1 THEN 1 
    ELSE 0 
    END) AS NO_OF_ONTIME_ORDERS,
SUM( CASE WHEN on_time=1 THEN 0 
    ELSE 1
    END) AS NO_OF_DELAYED_ORDERS
FROM orders
GROUP BY rain_mode;

/*CUSTOMER PREFERENCES*/
SELECT name,is_veg
FROM items;

/*ORDER FREQUENCY*/
WITH CTE4 AS(
SELECT COUNT(order_id) order_count,
LOWER(DATE_FORMAT(order_time,"%h:%i %p")) order_hour,
DAYNAME(order_time) order_week
FROM orders
GROUP BY order_week,order_hour)

SELECT 
order_week,order_hour,order_count,
dense_rank()OVER(PARTITION BY order_week ORDER BY order_count DESC) peak_time_rank
FROM CTE4;

/*CUSTOMER RETENTION*/
WITH Customer_retention as(SELECT restaurant_name,
MIN(order_time) First_Order_Date,
MAX(order_time) Last_Order_Date
FROM orders
GROUP BY restaurant_name)

SELECT restaurant_name,
CASE WHEN DATEDIFF(Last_Order_Date,First_Order_Date)=0 THEN '1st time'
ELSE 'Returning'
END AS 'Retention_Status'
FROM Customer_retention;

/*TIME BASED TRENDS OVER THE YEAR */
SELECT 
 DISTINCT DATE_FORMAT(o.order_time,'%m') Month,
 SUM(
 CASE WHEN i.is_veg=1 THEN 1
 ELSE 0 
 END) AS veg_itemsordered,
 SUM(
 CASE WHEN i.is_veg=0 THEN 1
 ELSE 1 
 END) AS nonveg_itemsordered
FROM Orders o JOIN items i ON o.order_id=i.order_id
GROUP BY Month
ORDER BY Month



