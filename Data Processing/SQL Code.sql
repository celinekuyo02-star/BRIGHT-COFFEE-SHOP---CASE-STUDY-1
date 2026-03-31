--- checking if the table is corectly loaded and able to see all columns and the first 100 rows 
select * from `workspace`.`default`.`brightcoffeeshopanalyses` limit 100;


--- Viewing distinct store location
SELECT DISTINCT store_location
FROM   `workspace`.`default`.`brightcoffeeshopanalyses`;


--- Which product generates the most revenue
SELECT product_detail,
       SUM(unit_price * transaction_qty) AS Total_Revenue
FROM  `workspace`.`default`.`brightcoffeeshopanalyses`
GROUP BY product_detail
ORDER BY Total_Revenue DESC;


--- What are the busiest hours
SELECT HOUR(transaction_time) AS hour, SUM(unit_price * transaction_qty)AS revenue
FROM  `workspace`.`default`.`brightcoffeeshopanalyses`
GROUP BY hour
ORDER BY revenue;

---How different stores are doing across different product categories 
SELECT store_location, product_category,SUM(unit_price * transaction_qty) AS sales 
FROM  `workspace`.`default`.`brightcoffeeshopanalyses`
GROUP BY store_location,product_category
ORDER BY sales DESC;


--- What are the top products
SELECT product_type,
       SUM(unit_price*transaction_qty) AS revenue
FROM `workspace`.`default`.`brightcoffeeshopanalyses`
GROUP BY product_type
ORDER BY revenue DESC;


--- Start and end dates -start date is 2023-01-01. end date is 2023-06-30
SELECT MIN(transaction_date) AS Min_Date,
       MAX(transaction_date) AS Max_Date
FROM `workspace`.`default`.`brightcoffeeshopanalyses`;

---Which products are sold at the store-9 product categories 
SELECT DISTINCT product_category
FROM `workspace`.`default`.`brightcoffeeshopanalyses`;

 
---Checking for highest and lowest unit price(0.5 and 45)
SELECT MIN(unit_price) AS Lowest_price,
       MAX(unit_price) AS Hishest_price
FROM `workspace`.`default`.`brightcoffeeshopanalyses`;


---Extracting the day and month names
SELECT transaction_date,
       Dayname(transaction_date)AS Day_name,
       Monthname(transaction_date)AS Month_name
FROM `workspace`.`default`.`brightcoffeeshopanalyses`;


---Getting the revenue per product sold
SELECT unit_price,
       transaction_qty,
       unit_price*transaction_qty AS revenue
FROM `workspace`.`default`.`brightcoffeeshopanalyses`;


---COMBINING FUNCTIONS AND ADDING COLUMNS
SELECT transaction_id,
       transaction_date,
       transaction_time,
       transaction_qty,
       store_id,
       store_location,
       product_id,
       unit_price,
       product_category,
       product_type,
       product_detail,
       Dayname(transaction_date)AS Day_name,
       Dayname(transaction_date)AS Month_name,
       Dayofmonth(transaction_date) AS Day_of_month,
CASE
    WHEN Dayname(transaction_date)IN('Sat','Sun') THEN 'Weekend'
    ELSE 'Weekday'
    END AS Day_classifictaion,
CASE
    WHEN date_format(transaction_time,'HH:MM:SS') BETWEEN '05:00:00' AND '08:59:59'THEN 'Morning'
    WHEN date_format(transaction_time,'HH:MM:SS') BETWEEN '09:00:00' AND '11:59:59'THEN 'Mid_morning'
    WHEN date_format(transaction_time,'HH:MM:SS') BETWEEN '12:00:00' AND '16:59:59'THEN 'Afternoon'
    WHEN date_format(transaction_time,'HH:MM:SS') BETWEEN '17:00:00' AND '20:59:59'THEN 'Evening'
    ELSE 'NIGHT'
END AS Time_of_day,
CASE 
    WHEN(transaction_qty*unit_price)<50 THEN 'Low'
    WHEN(transaction_qty*unit_price) BETWEEN 51 AND 200 THEN 'Medium'
    ELSE 'High'
END AS Revenue_classification,
transaction_qty*unit_price AS Revenue
FROM `workspace`.`default`.`brightcoffeeshopanalyses`;




