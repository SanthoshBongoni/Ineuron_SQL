--Q-15. Write an SQL query to fetch intersecting records of two tables.
use [H+Active] 
select [FirstName], [City] from [dbo].[Customers]
intersect
select [Firstname], [city] from [dbo].[customerscontacts]

--Q-16. Write an SQL query to show records from one table that another table does not have.

use [PragimTech]
select [Name], [email] from [dbo].[tblemployeebackup]
except
select [name], [email] from [dbo].[tblperson]