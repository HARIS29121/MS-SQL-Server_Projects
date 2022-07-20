-- Meeshow hackerrank online sq test
-- list how many products falls under customer budget along with list of products
-- Incase of clash choose the less costly product

USE sql_practice

create table products1
(
product_id varchar(20) ,
cost int
);
insert into products1 values ('P1',200),('P2',300),('P3',500),('P4',800);

create table customer_budget
(
customer_id int,
budget int
);

insert into customer_budget values (100,400),(200,800),(300,1500);

WITH running_cost AS (
SELECT *, SUM(cost) OVER(ORDER BY cost ASC) AS r_cost
FROM products1
)
SELECT customer_id,budget,COUNT(1) AS Number_of_Products,STRING_AGG(product_id,',') AS products
FROM customer_budget cb
LEFT JOIN running_cost rc
ON rc.r_cost < cb.budget
GROUP BY customer_id,budget

