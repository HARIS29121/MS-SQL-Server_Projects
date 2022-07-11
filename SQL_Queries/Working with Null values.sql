--Working with null values in SQL

USE Employees

SELECT * FROM Orders

--Filtering null values = IS NULL / IS NOT NULL ( equal to symbol will not work while checking for null values)

SELECT * FROM Orders WHERE order_amount IS NULL

SELECT * FROM Orders WHERE order_date IS NOT NULL

--Handling null values.. ISNULL()/COALESCE

SELECT *, ISNULL(order_date,'2008-06-24'),COALESCE(order_date,NULL,'2021-05-08')FROM Orders

--Count(col) function

SELECT COUNT(ISNULL(order_amount,0)) FROM Orders

--Avg() function

SELECT AVG(order_amount) FROM Orders 

SELECT AVG(ISNULL(order_amount,0)) FROM Orders  --Includes rows with null values also for calculating avg