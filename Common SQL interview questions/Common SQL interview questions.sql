CREATE database Employee

CREATE table emp
( emp_id int, emp_name varchar(50), department_id int, salary int, manager_id int)

CREATE table emp1
( emp_id int, emp_name varchar(50), department_id int, salary int, manager_id int)

CREATE table dept
(dep_id int, dep_name varchar(50))

CREATE table Orders
(customer_name varchar(50), order_date date , order_amount int, customer_gender varchar(50))

INSERT INTO emp VALUES 
(1,'Ankit',100,10000,4),
(2,'Mohit',100,15000,5),
(3,'Vikas',100,10000,4),
(4,'Rohit',100,5000,2),
(5,'Mudit',200,12000,6),
(6,'Agam',200,12000,2),
(7,'Sanjay',200,9000,2),
(8,'Ashish',200,5000,2),
(1,'Saurabh',900,12000,2)

INSERT INTO emp1 VALUES
(1,'Ankit',100,10000,4),
(2,'Mohit',100,15000,5),
(3,'Vikas',100,10000,4),
(4,'Rohit',100,5000,2),
(5,'Mudit',200,12000,6),
(6,'Agam',200,12000,2),
(7,'Sanjay',200,9000,2),
(8,'Ashish',200,5000,2),
(1,'Saurabh',900,12000,2)

INSERT INTO dept VALUES
(100, 'Analytics'),
(300,'IT')

INSERT INTO Orders VALUES
('Shilpa', '2020-01-01' , 10000, 'Male'),
('Rahul', '2020-01-02', 12000, 'Female'),
('SHILPA', '2020-01-02', 12000, 'Male'),
('Rohit', '2020-01-03', 15000, 'Female'),
('shilpa', '2020-01-03', 14000, 'Male')

-- Q1. How to find duplicated in a given table.

SELECT emp_id,COUNT(1) FROM emp GROUP BY emp_id HAVING COUNT(1)>1

-- Q2. How to delete duplicates.

WITH T1 AS 
(SELECT *,ROW_NUMBER() OVER (PARTITION BY emp_id ORDER BY emp_id) AS running_number FROM emp1)
DELETE FROM T1 WHERE running_number>1


-- Q3. Difference between Union and Union all.

SELECT manager_id FROM emp 
UNION -- It removes duplicate rows in the result set.
SELECT manager_id FROM emp1

SELECT * FROM emp 
UNION ALL -- It includes all the rows in the result set
SELECT * FROM emp1

-- Q4. Difference between rank, row number and dense rank.

-- IF entries with same rank next rank number will be exclude in RANK function.

SELECT emp_id,emp_name,department_id,salary,
RANK() OVER(ORDER BY salary DESC) AS rnk FROM emp1

-- DENSE_RANK assign rank in order without excluding even if we have multiple records with same rank

SELECT emp_id,emp_name,department_id,salary,
DENSE_RANK() OVER(ORDER BY salary DESC) AS dense_rnk FROM emp1

-- ROW_NUMBER, irrespective of similar numbers it will assign rolling number to entries

SELECT emp_id,emp_name,department_id,salary,
ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_number FROM emp1

-- Q5. Employees who are not present in department table

--Solution 1

SELECT * FROM emp WHERE department_id NOT IN (SELECT dep_id FROM dept)

--Solution 2

SELECT * FROM emp
LEFT JOIN dept
ON emp.department_id = dept.dep_id
WHERE dept.dep_id IS NULL

-- Q6. Second highest salary in each department

WITH T1 as (SELECT * , DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS rank FROM emp)
SELECT * FROM T1 WHERE rank=2

-- Q7. Find all transactions done by Shilpa

SELECT * FROM Orders WHERE UPPER(customer_name) = 'SHILPA'

-- Q8. Self join manager salary > employee salary

SELECT e.emp_id, e.emp_name, e.salary AS emp_salary, m.emp_name AS manager_name, m.salary AS manager_Salary FROM emp1 e
INNER JOIN emp1 m
ON  e.manager_id = m.emp_id 
WHERE e.salary > m.salary


-- Q9. Joins Left Join / Inner Join

-- Left join shows all the entries in the first table
SELECT * FROM emp
LEFT JOIN dept ON
emp.department_id = dept.dep_id

-- Inner join shows all the common records 

SELECT * FROM emp
INNER JOIN dept ON
emp.department_id = dept.dep_id


-- Q10. Update query to swap gender

UPDATE Orders SET customer_gender = CASE WHEN customer_gender = 'Male' THEN 'Female'
                                         WHEN customer_gender = 'Female' THEN 'Male' END
SELECT * FROM Orders
