/* There is a phone log table that has information about callers call history
Write a query to findout callers whose first and last call are to the same person on a given day 


USE sql_practice

create table phonelog(
    Callerid int, 
    Recipientid int,
    Datecalled datetime
);

insert into phonelog(Callerid, Recipientid, Datecalled)
values(1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000'); */


SELECT * FROM phonelog

WITH calls AS (
SELECT Callerid, CAST(Datecalled as date) AS calleddate, MIN(Datecalled) AS firstcall,MAX(Datecalled) AS lastcall
FROM phonelog
GROUP BY Callerid, CAST(Datecalled as date)
)
SELECT c.*,p1.Recipientid FROM calls c
INNER JOIN phonelog p1 ON c.Callerid = p1.Callerid AND c.firstcall=p1.Datecalled
INNER JOIN phonelog p2 ON c.Callerid = p1.Callerid AND c.lastcall=p2.Datecalled
WHERE p1.Recipientid = p2.Recipientid