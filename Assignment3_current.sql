/* 
Q-1. Write an SQL query to print the FIRST_NAME from Worker table after removing 
white spaces from the right side.
*/
use [ORG]
select RTRIM([FIRST_NAME]) from [dbo].[Worker];

/*
Q-2. Write an SQL query that fetches the unique values of DEPARTMENT from Worker
table and prints its length.
*/
select distinct DEPARTMENT, LEN([DEPARTMENT]) from [dbo].[Worker]; 

/*
Q-3. Write an SQL query to fetch nth max salaries from a table.
*/
select * from [dbo].[Worker]
where [SALARY]  = 
(
	select MIN([SALARY]) from [dbo].[Worker]
	where [SALARY] in 
		(select distinct top n [SALARY] from [dbo].[Worker] 
			order by [SALARY] desc)
)
