USE sql_practice

create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values
(1,100,cast('2022-01-01' as date),2000),
(2,200,cast('2022-01-01' as date),2500),
(3,300,cast('2022-01-01' as date),2100),
(4,100,cast('2022-01-02' as date),2000),
(5,400,cast('2022-01-02' as date),2200),
(6,500,cast('2022-01-02' as date),2700),
(7,100,cast('2022-01-03' as date),3000),
(8,400,cast('2022-01-03' as date),1000),
(9,600,cast('2022-01-03' as date),3000);

select * from customer_orders

--Method 1:

WITH first_visit AS (
SELECT customer_id,MIN(order_date) AS First_order_date
FROM customer_orders
GROUP BY customer_id),
Visit_Flag AS
(SELECT co.*,fv.First_order_date,
CASE WHEN co.order_date=fv.First_order_date THEN  1  ELSE 0 END AS New_Customer_Flag,
CASE WHEN co.order_date!=fv.First_order_date THEN  1  ELSE  0 END AS Repeat_customer_Flag
FROM customer_orders co
JOIN first_visit fv
ON co.customer_id=fv.customer_id)
SELECT order_date,SUM(New_Customer_Flag) AS No_of_New_Customers,SUM(Repeat_customer_Flag) AS No_of_Repeat_Customers
FROM Visit_Flag
GROUP BY order_date


--Method:2

WITH first_visit AS (
SELECT customer_id,MIN(order_date) AS First_order_date
FROM customer_orders
GROUP BY customer_id)
SELECT co.order_date,
SUM(CASE WHEN co.order_date=fv.First_order_date THEN  1  ELSE 0 END) AS No_of_New_Customers,
SUM(CASE WHEN co.order_date!=fv.First_order_date THEN  1  ELSE  0 END) AS No_of_Repeat_Customers
FROM customer_orders co
JOIN first_visit fv
ON co.customer_id=fv.customer_id
GROUP BY co.order_date