-- All about Aggregations in SQl

USE sql_practice

CREATE TABLE [dbo].[int_orders](
 [order_number] [int] NOT NULL,
 [order_date] [date] NOT NULL,
 [cust_id] [int] NOT NULL,
 [salesperson_id] [int] NOT NULL,
 [amount] [float] NOT NULL
) ON [PRIMARY]
GO
INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (30, CAST(N'1995-07-14' AS Date), 9, 1, 460)
INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (10, CAST(N'1996-08-02' AS Date), 4, 2, 540)
INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (40, CAST(N'1998-01-29' AS Date), 7, 2, 2400)
INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (50, CAST(N'1998-02-03' AS Date), 6, 7, 600)
INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (60, CAST(N'1998-03-02' AS Date), 6, 7, 720)
INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (70, CAST(N'1998-05-06' AS Date), 9, 7, 150)
INSERT [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (20, CAST(N'1999-01-30' AS Date), 4, 8, 1800)

SELECT salesperson_id,order_number,order_date,amount
FROM int_orders

--Simple sum

SELECT SUM(amount) FROM int_orders

SELECT salesperson_id,SUM(amount) FROM int_orders
GROUP BY salesperson_id

SELECT salesperson_id,order_number,order_date,amount,SUM(amount) OVER()
FROM int_orders

SELECT salesperson_id,order_number,order_date,amount,SUM(amount) OVER(PARTITION BY salesperson_id)
FROM int_orders

SELECT salesperson_id,order_number,order_date,amount,SUM(amount) OVER(ORDER BY order_date)
FROM int_orders

SELECT salesperson_id,order_number,order_date,amount,SUM(amount) OVER(PARTITION BY salesperson_id ORDER BY order_date)
FROM int_orders

SELECT salesperson_id,order_number,order_date,amount,
SUM(amount) OVER(ORDER BY order_date ROWS BETWEEN 2 PRECEDING  AND CURRENT ROW)
FROM int_orders

SELECT salesperson_id,order_number,order_date,amount,
SUM(amount) OVER(ORDER BY order_date ROWS BETWEEN 2 PRECEDING  AND 1 FOLLOWING)
FROM int_orders

SELECT salesperson_id,order_number,order_date,amount,
SUM(amount) OVER(ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING  AND CURRENT ROW)
FROM int_orders

SELECT salesperson_id,order_number,order_date,amount,
SUM(amount) OVER(PARTITION BY salesperson_id ORDER BY order_date ROWS BETWEEN 1 PRECEDING  AND CURRENT ROW)
FROM int_orders

SELECT salesperson_id,order_number,order_date,amount,
SUM(amount) OVER(ORDER BY order_date ROWS BETWEEN 1 PRECEDING  AND 1 PRECEDING)
FROM int_orders

SELECT salesperson_id,order_number,order_date,amount,
SUM(amount) OVER(ORDER BY order_date ROWS BETWEEN 1 FOLLOWING  AND 1 FOLLOWING)
FROM int_order
