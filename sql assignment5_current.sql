/*
Q-1. Write an SQL query to print details of workers excluding first names, “Vipul” and
“Satish” from Worker table.
*/
use ORG
delete [dbo].[Worker] where [FIRST_NAME] in ('vipul', 'satish')
select * from [dbo].[Worker] 

/*
Q-2. Write an SQL query to print details of the Workers whose FIRST_NAME ends with
‘h’ and contains six alphabets.
*/
use [ORG]
select * from [dbo].[Worker] where [FIRST_NAME] like '%h' and LEN([FIRST_NAME]) = 6

/*
Q-3. Write a query to validate Email of Employee.
*/
use [PragimTech]
select * from [dbo].[tblemployee]
where email like '%@gmail.com'
