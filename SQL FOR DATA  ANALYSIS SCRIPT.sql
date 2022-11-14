# ACTIVATING THE DATABASE
USE online_retail;

# RETRIEVE ALL DATA FROM TABLE 1
SELECT * 
FROM online_retail.`online sales tale 1`;

# RETRIEVE ALL DATA FROM TABLE 2
SELECT * 
FROM online_retail.`online sales table 2`;

## LET US NOW PERFORM SOME TASKS TO EXPLORE THE ABOVE DATASETS BEFORE CLEANING THEM
# FROM TABLE 1;
# RETRIEVE ONLY CITY AND PAYMENT METHOD FROM TABLE 1
SELECT 
	City,
	Payment
FROM online_retail.`online sales tale 1`;

# LIST ALL THE UNIQUE CITIES FROM TABLE 1
SELECT DISTINCT
	City
FROM online_retail.`online sales tale 1`;

# RETRIEVE ALL THE CITIES WITH 'Ewallet' AS THE PAYMENT METHOD FROM TABLE 2
SELECT DISTINCT
	City,
    Payment
FROM online_retail.`online sales tale 1`
WHERE Payment LIKE 'Ewallet';

# RETRIEVE ALL MALE CUSTOMERS IN 'Yangon city' FROM TABLE 2
SELECT 
	City,
	Gender
FROM online_retail.`online sales tale 1`
WHERE City = 'Yangon' AND Gender = 'Male';

# FROM TABLE 2
# RETRIEVE ALL INVOICE IDs, SORTING THE RESULTS BY DATE AND HIGHEST GROSS INCOME FIRST
SELECT 
	`Invoice ID`,
	Date,
	`gross income`
FROM online_retail.`online sales table 2`
ORDER BY Date ASC, `gross income` DESC;

## WE NOW COMBINE TWO TABLES USING ALIASES AND JOINS

# LIST INVOICE ID, CITY NAME, PRODUCT LINE, UNIT PRICE, DATE AND QUANTITY OF GOODS ORDERD
          # WE EXECUTE ONLY CUSTOMERS WITH MATCHING IDs FRPOM BOTH TABLES ON c AND o COLUMNS
SELECT 
	c.`Invoice ID`,
	c.City,
    c.`Product line`,
    o.`Unit price`,
    o.Quantity,
    o.Date
FROM online_retail.`online sales tale 1` AS c
INNER JOIN online_retail.`online sales table 2` AS o
ON c.`Invoice ID` = o.`Invoice ID`;

# LIST INVOICE ID, CITY NAME, PRODUCT LINE, UNIT PRICE, DATE AND QUANTITY OF GOODS ORDERD
          # WE EXECUTE ALL ROWS FROM TABLE 1 WITH ALIACE 'c' BUT ONLY CUSTOMERS WITH MATCHING INVOICE IDs IN TABLE TWO WITH ALIACE 'o'
SELECT 
	c.`Invoice ID`,
	c.City,
    c.`Product line`,
    o.`Unit price`,
    o.Quantity,
    o.Date
FROM online_retail.`online sales tale 1` AS c
LEFT JOIN online_retail.`online sales table 2` AS o
ON c.`Invoice ID` = o.`Invoice ID`;

# LIST INVOICE ID, CITY NAME, PRODUCT LINE, UNIT PRICE, DATE AND QUANTITY OF GOODS ORDERD
          # WE EXECUTE ALL ROWS FROM TABLE 2 WITH ALIACE 'o' BUT ONLY CUSTOMERS WITH MATCHING INVOICE IDs IN TABLE 1 WITH ALIACE 'c'
SELECT 
	c.`Invoice ID`,
	c.City,
    c.`Product line`,
    o.`Unit price`,
    o.Quantity,
    o.Date
FROM online_retail.`online sales tale 1` AS c
RIGHT JOIN online_retail.`online sales table 2` AS o
ON c.`Invoice ID` = o.`Invoice ID`;

## AGGREGATE FUNCTIONS

# FIND THE NUMBER OF CUSTOMERS IN TABLE 2
SELECT COUNT(*) AS TOTAL_CUSTOMERS # NOTE THAT COUNT DOES NOT INCLUDE NULL ENTRIES FROM THE TABLE ROWS
FROM online_retail.`online sales table 2`;

# FIND THE TOTAL QUATITY OF ORDERS
SELECT SUM(Quantity) AS TOTAL_QUANTITY # SUM ONLY WORKS WITH NUMERICAL COLUMNS
FROM online_retail.`online sales table 2`;

# RETRIEVE MINIMUM AND MAXIMUM SALES
SELECT 
	MIN(Total) AS `MINIMUM GROSS`,
    MAX(Total) AS `MAXIMUM GROSS`
FROM online_retail.`online sales table 2`;

# FINND THE AVERAGE SALES 
SELECT
	avg(Total) AS MEAN
FROM online_retail.`online sales table 2`;

# RETRIEVE THE QUANTITIES WHOSE TOTAL SALES ARE BELOW THE MEAN
SELECT 
	Quantity,
	Total
FROM online_retail.`online sales table 2`
WHERE Total < '323.15581959798993';

# FIND THE TOTAL QUANTITIES WHOSE TOTAL SALES ARE BELOW THE MEAN
SELECT 
	SUM(Quantity) AS TOTAL_QUANTITIES
FROM online_retail.`online sales table 2`
WHERE Total < '323.15581959798993';

# FIND THE FIRST INVOICE ID FROM THE FIRST DATE OF SALES
SELECT 
		`Invoice ID`,
        MIN(time) AS FIRST_TIME,
		MIN(Date) AS FIRST_DAY,
        MAX(time) AS LAST_TIME,
		MAX(Date) AS LAST_DAY
FROM online_retail.`online sales table 2`;

# FIND THE TOTAL NUMBER OF CUSTOMERS FROM EACH CITY
SELECT
	COUNT(*) AS TOTAL_CUSTOMERS,
    City
    FROM online_retail.`online sales tale 1`
    GROUP BY City;
    
# FIND THE TOTAL NUMBER OF CUSTOMERS FROM EACH CITY SORT FROM HIGHEST TO LOWEST
SELECT
	COUNT(*) AS TOTAL_CUSTOMERS,
    City
    FROM online_retail.`online sales tale 1`
    GROUP BY City
    ORDER BY COUNT(*) DESC;


## FOR THE FOLLOWING TASKS, THE SUPERMARKET TABLE WILL BE USED 

SELECT *
FROM online_retail.`supermarket_sales _data`;

# FIND THE HIGHEST SALES FOR EACH CITY (FROM LOWEST TO HIGEST)
SELECT MAX(Total) AS MAX_SALES,
	City  
FROM online_retail.`supermarket_sales _data`
GROUP BY City
ORDER BY MAX(Total) ASC;

# FIND THE CITY WITH HIGHEST SALES
SELECT MAX(Total) AS MAX_SALES,
City  
FROM online_retail.`supermarket_sales _data`;

# FIND THE TOTAL NUMBER OF CUSTOMERS FOR EACH CITY AND ONLY INCLUDE CITIES WITH LESS THAN 50 CUSTOMER
      # NOTE: WHERE IS USED TO FITER THE DEFINED COLUMNNS IN THE DATABASE WHILE, HAVING CLAUSE IS USED FILTER ON THE AGGREGATED FUNCTION
SELECT COUNT(City) AS TOTAL_CUSTOMERS,
	City  
FROM online_retail.`supermarket_sales _data`
GROUP BY City
HAVING COUNT(*) < 50;

# FIND THE TOTAL NUMBER OF CUSTOMERS LESS THAN 50 FOR EACH CITY, EXCLUDING Yangon
SELECT COUNT(City) AS TOTAL_CUSTOMERS,
	City  
FROM online_retail.`supermarket_sales _data`
WHERE City != 'Yangon'
GROUP BY City
HAVING COUNT(*) < 50;


## THE FOLLOWING TASKS CAN BE PEFORMED IN ORDER TO TRANSFORM THE DATA TABLE

# COMBINE CITY AND CUSTOMER TYPE COLUMNS
SELECT
	CONCAT(City,',',`Customer type`) AS CUSTOMER_CATEGORY
FROM online_retail.`supermarket_sales _data`;

# CHANGE THE COLUMN CITY TO UPPER CASE
SELECT
	CONCAT(UPPER(City),',',`Customer type`) AS CUSTOMER_CATEGORY
FROM online_retail.`supermarket_sales _data`;

SELECT *
FROM online_retail.`supermarket_sales _data`;

# REMOVE WHITE SPACES IN THE CITY COLUMN (STRING)
SELECT
	TRIM(City) AS CUSTOMER_CATEGORY
FROM online_retail.`supermarket_sales _data`;

# DESCRIBING EACH COLUMN IN THE TABLE (CHECK FOR DATA TYPES AND IF NULLS ARE ALLOWED FOR EACH COLUMN)
DESCRIBE online_retail.`supermarket_sales _data`