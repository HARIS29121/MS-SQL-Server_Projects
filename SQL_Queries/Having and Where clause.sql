USE Employees

SELECT * FROM emp1

-- When we want to check row level records we use where clause

SELECT * FROM emp1
WHERE salary > 10000

-- When we use agregations we need to use having clause for filtering

SELECT department_id, AVG(salary) AS Avg_salary
FROM emp1
GROUP BY department_id
HAVING AVG(salary) > 9500

-- Using both where clause and having clause
--Where filter should be applied first and then having filter

SELECT department_id, AVG(salary) AS Avg_salary
FROM emp1
WHERE salary>10000
GROUP BY department_id
HAVING AVG(salary) > 12000
