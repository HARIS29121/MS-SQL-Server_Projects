--Creating backup for Orders table

SELECT  * INTO Orders_Backup FROM Orders

--Deleting all the records from Order

DELETE  FROM  Orders

--Inserting values into Orders table without duplicates (Created rank in the Orders_backup table and fetch the results from that table where rank=1 and inserted into Orders)

INSERT INTO Orders
SELECT [Row ID],[Order ID],[Order Date],[Ship Date],[Ship Mode],[Customer ID],[Customer Name],[Segment],[Country/Region],
[City],[State],[Postal Code],[Region],[Product ID],[Category],[Sub-Category],[Product Name],[Sales],[Quantity],[Discount],[Profit]
FROM
(SELECT * , ROW_NUMBER() OVER(PARTITION BY [Order ID] ORDER BY [Order Date]) AS Rnk
FROM Orders_backup) t
WHERE Rnk=1


--Creating backup for Returns table

SELECT * INTO Returns_Backup FROM Returns

--Deleting all records from Returns table

DELETE FROM Returns

--Inserting values into Returns table without duplicates (Created rank in the Returns_backup table and fetch the results from that table where rank=1 and inserted into Returns)

INSERT INTO Returns
SELECT Returned, [Order ID] FROM
(SELECT *,ROW_NUMBER() OVER(PARTITION BY [Order ID] ORDER BY [Order ID]) AS Rnk
FROM Returns_Backup) t
WHERE Rnk=1

--Total Orders: 5009  Total Returns: (296 + 1)   Not Returned: 4713

SELECT * FROM Orders

SELECT * FROM Returns

--Inner Join: Fetches the records which are common in joining tables

--Total revenue loss by returns

SELECT COUNT(r.Returned) AS Total_Orders_Returned, SUM(o.Sales) AS Total_Revenue_Loss_On_Returns
FROM Orders o
INNER JOIN Returns r ON o.[Order ID] = r.[Order ID]

--Total revenue loss on returns by State wise

SELECT o.State,COUNT(r.Returned) AS Total_Orders_Returned, SUM(o.Sales) AS Total_Revenue_Loss_On_Returns
FROM Orders o
INNER JOIN Returns r ON o.[Order ID] = r.[Order ID]
GROUP BY State

--Total revenue loss on returns by City wise

SELECT o.City,COUNT(r.Returned) AS Total_Orders_Returned, SUM(o.Sales) AS Total_Revenue_Loss_On_Returns
FROM Orders o
INNER JOIN Returns r ON o.[Order ID] = r.[Order ID]
GROUP BY City
ORDER BY Total_Orders_Returned DESC  --LosAngeles has the highest orders returned


--Left Join: Fetches all the records from the first table irrespective of whether they are available in other table or not.

SELECT o.[Order ID],r.[Order ID],Sales
FROM Orders o
LEFT JOIN Returns r ON o.[Order ID] = r.[Order ID]

--Sales of all orders which are not returned

SELECT o.[Order ID],r.[Order ID],Sales
FROM Orders o
LEFT JOIN Returns r ON o.[Order ID] = r.[Order ID]
WHERE r.[Order ID] IS NULL                              (--It will returns 4713 records)     

--Right Join: It will fetches all the records from right table and matches with left table. Whatever records only available in right table and not available in left table those records will shown as null

--Creating dummy record in returns table

INSERT INTO dbo.Returns VALUES('Yes','Dummy')


SELECT o.[Order ID],r.[Order ID],Sales
FROM Orders o
RIGHT JOIN Returns r ON o.[Order ID] = r.[Order ID] 


--Full Outer Join: Everything will come from both left & right tables

SELECT o.[Order ID],r.[Order ID],Sales
FROM Orders o
FULL OUTER JOIN Returns r ON o.[Order ID] = r.[Order ID] 

