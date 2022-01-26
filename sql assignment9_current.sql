--Q-17. Write an SQL query to show the top n (say 10) records of a table.
use [AdventureWorks2019]
select top 10 [UnitPrice]
from [Sales].[SalesOrderDetail]

--Q-18. Write an SQL query to determine the nth (say n=5) highest salary from a table.
use [ORG]
select * from [dbo].[Worker] 
where [SALARY] = (select min(salary) from [dbo].[Worker] where [SALARY] in 
(select distinct top 5 [SALARY] from [dbo].[Worker]
order by [SALARY] desc)
)