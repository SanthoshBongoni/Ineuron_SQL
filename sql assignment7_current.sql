--Q-13. Write an SQL query to show only odd rows from a table.

use [PragimTech]
select * from
(
select *, ROW_NUMBER() over (order by city) as rownumber from [dbo].[tblperson]
)t
where t.rownumber % 2 = 1;

--Q-14. Write an SQL query to clone a new table from another table.

select * into [new_tblperson] from [dbo].[tblperson];  --example-1

select  ----example-2
[Name], 
Age, 
Email 
into newtblperson2 
from tblperson 
where city in ('Hyd', 'chennai')


