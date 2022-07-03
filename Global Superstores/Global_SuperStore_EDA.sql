CREATE DATABASE Global_SuperStore

USE Global_SuperStore

SELECT * FROM Orders
SELECT * FROM People
SELECT * FROM Returns

--Total records in the dataset

SELECT COUNT(*) AS 'No.of.Records' FROM Global_SuperStore..Orders

--Ordering the data based on row id in ascending order

SELECT * FROM Global_SuperStore..Orders
ORDER BY [Row ID]

--Checking whether order id is primary key or not.

SELECT [Order ID],COUNT(*) as No_of_items
FROM Orders
GROUP BY [Order ID]
HAVING COUNT(*)>1

SELECT * FROM Orders
WHERE [Order ID] = 'AE-2011-9160' --In same order customers ordered different products. So, it cannot ba a primary key

--Always ship date sholuld be posterior to order date Lets'check that.

SELECT * FROM Orders
WHERE [Order Date]>[Ship Date] --we found no records so, there were no anamolies in these columns

--Checking the distinct ship modes

SELECT DISTINCT [Ship Mode]
FROM Orders

--Checking the distinct Segments

SELECT DISTINCT Segment
FROM Orders

--Checking the distinct Countries

SELECT DISTINCT Country
FROM Orders

--Finding the number days to ship the products for different ship modes

WITH T1 AS
(SELECT DATEDIFF(DAY, [Order Date],[Ship Date]) AS NoOfDays,*
FROM Orders
WHERE [Ship Mode]='First Class')
SELECT MIN(NoOfDays) AS Min_Days,MAX(NoOfDays) AS Max_Days FROM T1 -- First class 1 to 3 days

WITH T1 AS
(SELECT DATEDIFF(DAY, [Order Date],[Ship Date]) AS NoOfDays,*
FROM Orders
WHERE [Ship Mode]='Standard Class')
SELECT MIN(NoOfDays) AS Min_Days,MAX(NoOfDays) AS Max_Days FROM T1  -- Standard class 4 to 7 days

WITH T1 AS
(SELECT DATEDIFF(DAY, [Order Date],[Ship Date]) AS NoOfDays,*
FROM Orders
WHERE [Ship Mode]='Second Class')
SELECT MIN(NoOfDays) AS Min_Days,MAX(NoOfDays) AS Max_Days FROM T1   -- Second class 2 to 5 days

--Checking the no.of items ordered by the customer in single order

SELECT [Customer ID],[Order ID],COUNT(DISTINCT [Product ID]) AS No_of_Products_Ordered_per_order
FROM Orders
GROUP BY [Customer ID],[Order ID]
ORDER BY [Customer ID]


-- Checking no of orders placed by customers

SELECT [Customer ID],COUNT([Order ID]) AS No_Of_Orders
FROM Orders
GROUP BY [Customer ID]
ORDER BY [Customer ID]

--Checking total sales and total profit country wise

SELECT Country, SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit
FROM Orders
GROUP BY Country
ORDER BY Total_Sales DESC


