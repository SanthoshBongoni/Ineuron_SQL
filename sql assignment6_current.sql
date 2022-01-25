/*
Q-1. Write an SQL query to print details of the Workers who have joined in Feb’2014.
*/
select * from [dbo].[Worker] where (MONTH([JOINING_DATE])=2 and YEAR([JOINING_DATE])=2014)


/*
Q-2. Write an SQL query to fetch duplicate records having matching data in some fields of
a table.
*/
use [PragimTech]
select [Name], [Gender], [salary], COUNT(*) as cnt from [dbo].[tblemployee]
group by [Name], [Gender], [salary]
having COUNT(*)>1

/*
Q-3. How to remove duplicate rows from Employees table.
*/
use ORG

CREATE TABLE DETAILS
( SN INT IDENTITY(1,1),
 EMPNAME VARCHAR(25),
 DEPT VARCHAR(20),
 CONTACTNO BIGINT NOT NULL,
 CITY VARCHAR(15)
 );

 INSERT INTO DETAILS
 VALUES ('VISHAL','SALES',9193458625,'GAZIABAD'),
 ('VIPIN','MANAGER',7352158944,'BARIELLY'),
 ('ROHIT','IT',7830246946,'KANPUR'),
('RAHUL','MARKETING',9635688441,'MEERUT'),
('SANJAY','SALES',9149335694,'MORADABAD'),
('VIPIN','MANAGER',7352158944,'BARIELLY'),
('VISHAL','SALES',9193458625,'GAZIABAD'),
('AMAN','IT',78359941265,'RAMPUR');

SELECT EMPNAME,DEPT,CONTACTNO,CITY, COUNT(*) FROM DETAILS
GROUP BY EMPNAME,DEPT,CONTACTNO,CITY
HAVING COUNT(*)>1

DELETE FROM DETAILS WHERE SN NOT IN (
SELECT MAX(SN) FROM DETAILS GROUP BY EMPNAME,DEPT,CONTACTNO,CITY)


