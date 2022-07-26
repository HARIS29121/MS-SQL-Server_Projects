--Recommendation system problem

USE sql_practice

create table orders_c
(
order_id int,
customer_id int,
product_id int,
);

insert into orders_c VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

create table product (
id int,
name varchar(10)
);
insert into product VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');

SELECT * FROM orders_c

SELECT * FROM product

SELECT CONCAT(pr1.name,' ', pr2.name) products_pair , SUM(1) AS purchase_frequency FROM orders_c o1
INNER JOIN orders_c o2 ON o1.order_id = o2.order_id
INNER JOIN product pr1 ON pr1.id=o1.product_id
INNER JOIN product pr2 ON pr2.id=o2.product_id
WHERE o1.product_id <  o2.product_id
GROUP BY pr1.name, pr2.name