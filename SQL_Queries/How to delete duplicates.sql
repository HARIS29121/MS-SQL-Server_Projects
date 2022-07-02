--How to delete duplicates from table

USE sql_practice

CREATE TABLE Transactions (Order_id INT , Order_date DATE , Product_Name VARCHAR(13), Order_amount FLOAT, Create_Time DATETIME DEFAULT CURRENT_TIMESTAMP);


INSERT INTO Transactions(Order_id, Order_date , Product_Name, Order_amount) Values (1,'2022-03-03','P1',150)
INSERT INTO Transactions(Order_id, Order_date , Product_Name, Order_amount) Values (1,'2022-03-03','P1',150)
INSERT INTO Transactions(Order_id, Order_date , Product_Name, Order_amount) Values (2,'2022-03-03','P2',200)
INSERT INTO Transactions(Order_id, Order_date , Product_Name, Order_amount) Values (2,'2022-03-03','P2',200)
INSERT INTO Transactions(Order_id, Order_date , Product_Name, Order_amount) Values (2,'2022-03-03','P2',200)
INSERT INTO Transactions(Order_id, Order_date , Product_Name, Order_amount) Values (3,'2022-03-03','P3',300)

SELECT * FROM Transactions

--Step1: Take backup of original table

SELECT * INTO Transactions_Backup FROM Transactions

SELECT * FROM Transactions_Backup

--Step 2: Delete duplicates from original table with a unique time stamp column
--a)Using delete

DELETE t 
FROM Transactions t
INNER JOIN (SELECT Order_id,MIN(Create_Time) AS Create_Time FROM Transactions GROUP BY Order_id HAVING COUNT(1)>1) a
ON a.Order_id=t.Order_id AND a.Create_Time=t.Create_Time

--Deleting all the records from Transactions and inserting all the data again from Transactions_Backup table

DELETE FROM Transactions

INSERT INTO Transactions SELECT * FROM Transactions_Backup

--b) Truncate original table and insert unique records

DELETE FROM Transactions

INSERT INTO Transactions
SELECT Order_id,Order_date,Product_Name,Order_amount,Create_Time FROM
(SELECT *,ROW_NUMBER() OVER(PARTITION BY Order_id ORDER BY Create_Time DESC) AS rn FROM Transactions_Backup) a
WHERE rn=1

SELECT * FROM Transactions

--2nd Step: Delete pure duplicates when there is no time stamp column

DELETE FROM Transactions

INSERT INTO Transactions SELECT * FROM Transactions_Backup

SELECT * FROM Transactions
UPDATE Transactions SET Create_Time=GETDATE()

--While deleting pure duplicates delete command doesnot work here

--Truncate original records and insert unique records by distinct / row_number

DELETE FROM Transactions
UPDATE Transactions_Backup SET Create_Time=GETDATE()

INSERT INTO Transactions
SELECT DISTINCT * FROM Transactions_Backup

SELECT * FROM Transactions