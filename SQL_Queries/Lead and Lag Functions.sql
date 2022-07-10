USE Superstores

SELECT * FROM Orders_Backup

DELETE  FROM Orders

INSERT INTO  Orders SELECT * FROM Orders_Backup

SELECT * FROM Orders

--Finding Year on year sales and also comparing previous year sales

WITH Year_Sales AS 
(SELECT DATEPART(YEAR,[Order Date]) AS Order_Year, SUM(Sales) AS Sales
FROM Orders 
GROUP BY DATEPART(YEAR,[Order Date]))
SELECT *,
LAG(Sales,1,0) OVER(ORDER BY Order_Year) AS Prev_Sales,
Sales-LAG(Sales,1,0) OVER(ORDER BY Order_Year) AS Diff
FROM Year_Sales
ORDER BY Order_Year


--Finding Year on year sales and also comparing next year sales

WITH Year_Sales AS 
(SELECT DATEPART(YEAR,[Order Date]) AS Order_Year, SUM(Sales) AS Sales
FROM Orders 
GROUP BY DATEPART(YEAR,[Order Date]))
SELECT *,
LEAD(Sales,1,0) OVER(ORDER BY Order_Year) AS Next_Year_Sales,
Sales-LEAD(Sales,1,0) OVER(ORDER BY Order_Year) AS Diff
FROM Year_Sales
ORDER BY Order_Year

--Finding Year on year sales and also comparing previous year sales based on Regions

WITH Year_Sales AS 
(SELECT Region,DATEPART(YEAR,[Order Date]) AS Order_Year, SUM(Sales) AS Sales
FROM Orders 
GROUP BY Region,DATEPART(YEAR,[Order Date]))
SELECT *,
LAG(Sales,1,0) OVER(PARTITION BY Region ORDER BY Order_Year) AS Prev_Sales
--Sales-LAG(Sales,1,0) OVER(ORDER BY Order_Year) AS Diff
FROM Year_Sales
ORDER BY Region,Order_Year

--Finding Year on year sales and also comparing next year sales based on Regions

SELECT * FROM Orders
WITH Year_Sales AS (
SELECT Region,DATEPART(YEAR,[Order Date]) AS Order_Year, SUM(Sales) AS Total_Sales
FROM Orders
GROUP BY Region,DATEPART(YEAR,[Order Date]))
SELECT *,
LEAD(Total_Sales,1,0) OVER (PARTITION BY Region ORDER BY Order_Year)
FROM Year_Sales
ORDER BY Region,Order_Year