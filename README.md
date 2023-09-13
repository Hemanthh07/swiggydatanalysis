# swiggydatanalysis

## overview
This SQL project analyzes customer data from an online food delivery app. Using data from the "items" and "orders" tables. The goal is to analyze customer food order habits and restaurant data.

## TABLE OF CONTENT

- [Project Description](#project-description)
- [Data Sources](#data-sources)
- [Project Structure](#project-structure)
- [SQL Queries](#sql-queries)
- [Results](#results)
- [Usage](#usage)


## DATA SOURCES
**Items Table**: Contains information about items ordered and contains columns like id,order_id, name,is_veg
**Orders Table**:Contains information about orders and contains columns like id,order_id,order_total,restaurant_name,order_time,rain_mode,on_time

## PROJECT STRUCTURE
'Swiggy_Analysis.sql':SQL queries for data analysis and calculations
'README.md':Project Description and structure

## SQL QUERIES
The Project includes SQL Queries to calculate Customer Retention, Average order value, YOY Change in revenue,Order Frequency,Customer Retention to a particular restaurant,Ranking restaurants based on Revenue using JOINS, WINDOW Functions such as DENSE_RANK,RANK AND CTE TABLES.

## Results
The Results provide insights for the custome food order behaviour and also on the order data from the food delivery app

## Usage
1. Clone this repository to your local machine.
2. Execute the SQL queries in `SQLQueries.sql` using your preferred database management tool.
3. Analyze the results to gain insights on online food delivery application customer data
