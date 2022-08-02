--Write a query to determine phone numbers that satisfy below conditions
--1. The number should have both incoming and outgoing calls
--2. The sum of duration of outgoing calls should be greater that sum of duration of incoming calls


USE sql_practice

create table call_details  (
call_type varchar(10),
call_number varchar(12),
call_duration int
);

insert into call_details
values ('OUT','181868',13),('OUT','2159010',8)
,('OUT','2159010',178),('SMS','4153810',1),('OUT','2159010',152),('OUT','9140152',18),('SMS','4162672',1)
,('SMS','9168204',1),('OUT','9168204',576),('INC','2159010',5),('INC','2159010',4),('SMS','2159010',1)
,('SMS','4535614',1),('OUT','181868',20),('INC','181868',54),('INC','218748',20),('INC','2159010',9)
,('INC','197432',66),('SMS','2159010',1),('SMS','4535614',1);

SELECT * FROM call_details

--CTE and Filter clause

WITH CTE as (
SELECT call_number,
SUM(CASE WHEN call_type = 'OUT' THEN call_duration ELSE NULL END) AS Out_going_duration,
SUM(CASE WHEN call_type = 'INC' THEN call_duration ELSE NULL END) AS Incoming_duration
FROM call_details
GROUP BY call_number)
SELECT call_number FROM CTE
WHERE Out_going_duration > Incoming_duration

--Using Having clause

SELECT call_number
FROM call_details
GROUP BY call_number
HAVING SUM(CASE WHEN call_type = 'OUT' THEN call_duration ELSE NULL END) > SUM(CASE WHEN call_type = 'INC' THEN call_duration ELSE NULL END)

--USING CTE and Join

WITH CTE_out as (
SELECT call_number,
SUM(call_duration) AS Out_going_duration
FROM call_details
WHERE call_type = 'OUT'
GROUP BY call_number),
CTE_inc as (
SELECT call_number,
SUM(call_duration) AS Incoming_duration
FROM call_details
WHERE call_type = 'INC'
GROUP BY call_number)
SELECT CTE_out.call_number
FROM CTE_out
INNER JOIN CTE_inc
ON CTE_out.call_number = CTE_inc.call_number
WHERE CTE_out.Out_going_duration>CTE_inc.Incoming_duration
