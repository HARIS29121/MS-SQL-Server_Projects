--Problem with runing sum


USE sql_practice

create table products
(
product_id varchar(20) ,
cost int
);
insert into products values ('P1',200),('P2',300),('P3',300),('P4',500),('P5',800);

SELECT * FROM products

SELECT *, SUM(cost) OVER(ORDER BY cost asc) 
FROM products

SELECT *, SUM(cost) OVER(ORDER BY cost asc,product_id) --introduce unique coumn in order by
FROM products

SELECT *, SUM(cost) OVER(ORDER BY cost ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
FROM products