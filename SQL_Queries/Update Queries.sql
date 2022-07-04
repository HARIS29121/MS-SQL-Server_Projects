---UPDATE statements

USE Employees

SELECT * FROM emp
SELECT * FROM dept


--Update syntax for single value update

UPDATE emp SET salary = 15000  -- updates all the salary values as 15000 executing row by row

--Update with where clause

UPDATE emp SET salary = 15000 WHERE emp_id = 1

-- Update multiple values

UPDATE emp SET salary=12000,emp_age=30 WHERE emp_id = 2

--Update col with constant values and derivations (col calculations / case when )

UPDATE emp SET salary=salary+1000

UPDATE emp SET salary=salary*1.1 WHERE emp_id=3  -- 10% increment

UPDATE emp SET salary= CASE WHEN department_id=100 THEN salary*1.1 
                            WHEN department_id=200 THEN salary*1.2
							ELSE salary END
SELECT * FROM emp

--Update using Join

UPDATE emp
SET dep_name = d.dep_name
FROM emp e
INNER JOIN dept d ON e.department_id = d.dep_id

SELECT * FROM emp

-- Caution before running update

SELECT *, CASE WHEN dep_name = 'Analytics' THEN 'IT' 
               WHEN dep_name = 'IT' THEN 'Analytics' 
			   ELSE dep_name END FROM emp  --Check with select statement before updating

