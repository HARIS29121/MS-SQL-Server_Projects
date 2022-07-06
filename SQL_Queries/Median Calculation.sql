--Median Calculation

--Method1: Median using row number

USE Employees

--Odd number of records

WITH T1 AS (
SELECT *,ROW_NUMBER() OVER(ORDER BY emp_age DESC) AS rn_desc,
ROW_NUMBER() OVER(ORDER BY emp_age ASC) AS rn_asc FROM Emp)
SELECT emp_age AS [Median Age] FROM T1 WHERE rn_desc=rn_asc

--Even number of records

WITH T1 AS (
SELECT *,ROW_NUMBER() OVER(ORDER BY salary DESC) AS rn_desc,
ROW_NUMBER() OVER(ORDER BY salary ASC) AS rn_asc FROM emp1)
SELECT AVG(salary) AS [Median salary] FROM T1 WHERE abs(rn_desc - rn_asc)<=1


--Method2: Median using percentile cont

SELECT DISTINCT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY emp_age) OVER() AS Median FROM emp

SELECT DISTINCT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary) OVER() AS Median FROM emp1




