USE sql_practice

CREATE TABLE bms (seat_no int ,is_empty varchar(10));
INSERT INTO bms VALUES
(1,'N')
,(2,'Y')
,(3,'N')
,(4,'Y')
,(5,'Y')
,(6,'Y')
,(7,'N')
,(8,'Y')
,(9,'Y')
,(10,'Y')
,(11,'Y')
,(12,'N')
,(13,'Y')
,(14,'Y');

-- 3 or more consecutive seats are empty

--Method: 1

WITH t1 AS(
SELECT *
,LAG(is_empty,1) OVER(ORDER BY seat_no) as prev1
,LAG(is_empty,2) OVER(ORDER BY seat_no) as prev2
,LEAD(is_empty,1) OVER(ORDER BY seat_no) as next1
,LEAD(is_empty,2) OVER(ORDER BY seat_no) as next2
FROM bms)
SELECT * FROM t1
WHERE (is_empty='Y' AND prev1='Y' AND prev2='Y')
OR (is_empty='Y' AND prev1='Y' AND next1='Y')
OR (is_empty='Y' AND next1='Y' AND next2='Y')


--Method: 2

SELECT * FROM
(SELECT *
,SUM(CASE WHEN is_empty = 'Y' THEN 1 ELSE 0 END) OVER(ORDER BY seat_no rows between 2 PRECEDING AND CURRENT ROW) as prev2
,SUM(CASE WHEN is_empty = 'Y' THEN 1 ELSE 0 END) OVER(ORDER BY seat_no rows between 1 PRECEDING AND 1 FOLLOWING) as prev_next
,SUM(CASE WHEN is_empty = 'Y' THEN 1 ELSE 0 END) OVER(ORDER BY seat_no rows between CURRENT ROW AND 2 FOLLOWING ) as next2
FROM bms)a
WHERE (prev2=3 OR prev_next=3 OR next2=3)


--Method: 3
WITH diff_num AS
(SELECT *
,ROW_NUMBER() OVER(ORDER BY seat_no) AS rn
,seat_no-ROW_NUMBER() OVER(ORDER BY seat_no) AS diff
FROM bms
WHERE is_empty='Y'),
cnt AS
(SELECT diff,COUNT(1) AS c FROM diff_num
GROUP BY diff HAVING COUNT(1) >=3)
SELECT * FROM diff_num WHERE diff IN (SELECT diff FROM cnt)