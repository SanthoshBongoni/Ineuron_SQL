--Q-19. Write an SQL query to determine the 5th highest salary without using TOP or limit method.
use [ORG]
select * from 
(select *, DENSE_RANK() 
over (order by salary desc) as t from [dbo].[Worker]) 
where t=5;


--Q-20. Write an SQL query to fetch the list of employees with the same salary.
select [FIRST_NAME] from [dbo].[Worker]
where [SALARY] in 
( select SALARY from [dbo].[Worker] group by SALARY having count(*) > 1)
