--Rank the duplicates

USE sql_practice

create table list (id varchar(5));
insert into list values ('a');
insert into list values ('a');
insert into list values ('b');
insert into list values ('c');
insert into list values ('c');
insert into list values ('c');
insert into list values ('d');
insert into list values ('d');
insert into list values ('e');

--Rank the duplicate records

SELECT * FROM list

WITH cte_dups AS
(SELECT id FROM list GROUP BY id HAVING  COUNT(1)>1),
rnk AS
(SELECT id, RANK() OVER(ORDER BY id ASC) AS rn FROM cte_dups)
SELECT l.*,'DUP' + CAST (r.rn AS VARCHAR) AS output FROM list l
LEFT JOIN rnk r ON l.id = r.id