-- Find the change in employees status

USE Employees

create table emp_2020
(
emp_id int,
designation varchar(20)
);

create table emp_2021
(
emp_id int,
designation varchar(20)
)

insert into emp_2020 values (1,'Trainee'), (2,'Developer'),(3,'Senior Developer'),(4,'Manager');
insert into emp_2021 values (1,'Developer'), (2,'Developer'),(3,'Manager'),(5,'Trainee');

SELECT * FROM emp_2020

SELECT * FROM emp_2021

SELECT ISNULL(e20.emp_id,e21.emp_id) AS emp_id,
CASE WHEN e21.designation != e20.designation THEN 'Promoted'
     WHEN e21.designation IS NULL THEN 'Resigned'
	 ELSE 'New'
END AS comment
FROM emp_2020 e20
FULL OUTER JOIN emp_2021 e21 ON e20.emp_id = e21.emp_id
WHERE ISNULl(e20.designation,'aaa') != ISNULL(e21.designation,'bbb')
