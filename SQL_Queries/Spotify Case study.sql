--Spotify Case study

USE sql_practice
CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);
delete from activity;
insert into activity values 
(1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');

--the activity table shows the app-installed and app purchase activities for spotify app along with country details.
SELECT * FROM activity

--Q1) Find total active users each day

SELECT event_date,COUNT(DISTINCT(user_id)) AS No_of_Active_Users 
FROM activity GROUP BY event_date

--Q2) Find total active users each week

SELECT *,DATEPART(WEEK,event_date) FROM activity

SELECT DATEPART(WEEK,event_date) AS Week,COUNT(DISTINCT(user_id)) AS No_of_Active_Users 
FROM activity GROUP BY DATEPART(WEEK,event_date)

--Q3) Date wise total number of users who made the purchase same day they installed the app

SELECT * FROM activity

SELECT event_date,COUNT(new_user) AS no_of_users FROM 
(SELECT USER_ID,event_date,CASE WHEN COUNT(DISTINCT event_name)=2 THEN user_id ELSE NULl END AS new_user  FROM activity
GROUP BY user_id,event_date --HAVING COUNT(DISTINCT event_name)=2
) t
GROUP BY event_date

--Q4) Percentae of paid users in India,USA and any other country shoud be tagged as others country percentage_users

WITH T1 AS (
SELECT CASE WHEN country IN ('USA','India') THEN country ELSE 'Others' END AS new_country,COUNT(user_id)  AS user_count 
FROM activity 
WHERE event_name = 'app-purchase'
GROUP BY CASE WHEN country IN ('USA','India') THEN country ELSE 'Others' END
), TOTAL AS (SELECT SUM(user_count) AS total_users FROM T1)

SELECT new_country,((user_count * 1.0 )/total_users)*100
FROM T1,total
