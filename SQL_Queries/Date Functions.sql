--Datepart, Dateadd, Datediff

--Datepart

SELECT DATEPART(DAY,'2025-01-08')

SELECT DATEPART(MONTH,'2025-01-08')

SELECT DATEPART(YEAR,'2025-01-08')

SELECT DATEPART(WEEK,'2025-01-08')

SELECT DATEPART(WEEKDAY,'2025-01-08')

--Dateadd

SELECT DATEADD(DAY,2,'2025-01-08')

SELECT DATEADD(MONTH,2,'2025-01-08')

SELECT DATEADD(YEAR,2,'2025-01-08')

--Datediff

SELECT DATEDIFF(DAY,'2025-01-01','2025-01-08')

SELECT DATEDIFF(WEEK,'2025-01-01','2025-05-08')

 -- Finding no.of days to ship

SELECT [Order ID], [Order Date], [Ship Date],[Ship Mode], DATEDIFF(DAY,[Order Date],[Ship Date]) AS 'Days_to_ship'
FROM Orders

--Finding no.of business days to ship

SELECT [Order ID], [Order Date], [Ship Date],[Ship Mode], DATEDIFF(DAY,[Order Date],[Ship Date]) AS 'Days_to_ship',
DATEDIFF(WEEK,[Order Date],[Ship Date]) AS 'Weeks_between_Days',
DATEDIFF(DAY,[Order Date],[Ship Date])-2*DATEDIFF(WEEK,[Order Date],[Ship Date]) as Business_days_to_ship
FROM Orders

-- to get current date

SELECT GETDATE()



