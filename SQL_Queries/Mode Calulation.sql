--Mode calculation

USE sql_practice

CREATE TABLE mode (quantity int);

INSERT INTO mode VALUES(1),(2),(2),(3),(3),(3),(3),(4),(5);

SELECT * FROM mode

--Method 1: Using temp table/CTE

WITH T1 AS
(
SELECT quantity, COUNT(quantity) AS frequency FROM mode GROUP BY quantity
)
SELECT quantity AS Mode FROM T1
WHERE frequency = (SELECT MAX(frequency) FROM T1);

--Lets check the dual mode

INSERT INTO mode VALUES (2),(2)

--Same query will work for dual mode also.

WITH T1 AS
(
SELECT quantity, COUNT(quantity) AS frequency FROM mode GROUP BY quantity
)
SELECT quantity AS Mode FROM T1
WHERE frequency = (SELECT MAX(frequency) FROM T1);

--Method 2: Using rank function

WITH T1 AS
(SELECT quantity, COUNT(quantity) AS frequency FROM mode GROUP BY quantity),
T2 AS 
(SELECT *,RANK() OVER(ORDER BY frequency DESC) AS rn FROM T1)
SELECT quantity AS Mode FROM T2 WHERE rn=1