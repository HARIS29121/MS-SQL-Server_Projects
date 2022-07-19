--Rolling calculations SUM, AVG, MIN, MAX

USE Superstores

SELECT * FROM Orders

-- Finding rolling sum of sales for last 2 months and the current month

WITH T1 AS (
SELECT DATEPART(YEAR,[Order Date]) AS Order_Year,DATEPART(MONTH,[Order Date]) AS Order_Month, ROUND(SUM(Sales),0) AS Sales
FROM Orders
GROUP BY DATEPART(YEAR,[Order Date]),DATEPART(MONTH,[Order Date])
)
SELECT *,SUM(Sales) OVER(ORDER BY Order_Year,Order_Month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS RUNNING_3_Sales
FROM T1

-- Same process is applicable for all the aggregations

WITH T1 AS (
SELECT DATEPART(YEAR,[Order Date]) AS Order_Year,DATEPART(MONTH,[Order Date]) AS Order_Month, ROUND(SUM(Sales),0) AS Sales
FROM Orders
GROUP BY DATEPART(YEAR,[Order Date]),DATEPART(MONTH,[Order Date])
)
SELECT *,
SUM(Sales) OVER(ORDER BY Order_Year,Order_Month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS RUNNING_3months_Sales,
AVG(Sales) OVER(ORDER BY Order_Year,Order_Month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS AVG_RUNNING_3months_Sales,
MIN(Sales) OVER(ORDER BY Order_Year,Order_Month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MIN_of_3months_Sales,
MAX(Sales) OVER(ORDER BY Order_Year,Order_Month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MAX_of_3months_Sales
FROM T1

