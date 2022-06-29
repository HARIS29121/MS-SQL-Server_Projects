USE Employees

--If a column on which we are taking rank consists multiple similar records the next ranks will be skipped based on number of multiple records

SELECT emp_id,emp_name,department_id,salary,
RANK() OVER(ORDER BY salary DESC) AS Rnk FROM emp1

--If a column on which we are taking dense rank consists multiple similar records irrespective of multiple records the rank wil be assigned without skipping

SELECT emp_id,emp_name,department_id,salary,
DENSE_RANK() OVER(ORDER BY salary DESC) AS Dense_Rnk FROM emp1

--If a column on which we are taking row number consists multiple similar records irrespective of the values it will assign running number to all the records

SELECT emp_id,emp_name,department_id,salary,
ROW_NUMBER() OVER(ORDER BY salary DESC) AS Rn FROM emp1

-- Partition by will seperate the values based on the department id in the below case

SELECT emp_id,emp_name,department_id,salary,
RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS Rnk, 
DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS Dense_Rnk,
ROW_NUMBER() OVER(PARTITION BY department_id ORDER BY salary DESC) AS Rn
FROM emp1


--Interview Question: Emplyees with highest salary department wise

SElECT * FROM
(SELECT emp_id,emp_name,department_id,salary,
RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS Rnk
FROM emp1) a
WHERE Rnk=1

