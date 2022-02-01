/*
1).Explain different types of views. Demonstrate with suitable examples.
There are two types of views in the SQL Server, namely System Defined Views and User Defined Views. 

A) System Defined Views:
The System Defined Views are predefined views that already exist in the SQL Server database, such as 
Tempdb, Master, and temp. Each of the databases has its own properties and functions.
System Defined Views will be automatically attached to all User Defined databases. 
And these provide information about the database, tables, and all the properties of the database and tables.
There are three types of System defined views, Information Schema, Catalog View, and Dynamic Management View.

Information Schema:
There are twenty different schema views in the SQL server. They are used to display the physical information of the 
database, such as tables, constraints, columns, and views. This view starts with INFORMATION_SCHEMA and followed by 
the View Name. INFORMATION_SCHEMA.CHECK_CONSTRAINTS is used to receive information about any constraint available in 
the database.
A constraint is used on a particular column in a table to ensure that certain data rules are followed for the column. 
INFORMATION_SCHEMA.COLUMNS is used to receive information about the table columns such as table name, column name, 
the position of the column, default value, etc. To return the views present in the current database, 
INFORMATION_SCHEMA.VIEWS is used.

Catalog View:
These are used to return information used by the SQL server. Catalog views provide an efficient way to obtain, 
present, and transform custom forms of information. But they do not include any information about backup, replication,
or maintenance plans, etc. These views are used to access metadata of databases, and the names and column names are 
descriptive, helping a user to query what is expected.

Dynamic Management View
These were introduced in the SQL server in 2005. The administer can get information about the server state to 
diagnose problems, monitor the health of the server instance, and tune performance through these views. 
The Server-scoped Dynamic Management View is only stored in the Master database, whereas the Database-scoped 
Dynamic Management View is stored in each database.

B) User Defined Views:
These are the types of views that are defined by the users. There are two types under User Defined views, 
Simple View and Complex View.

Simple Views: Simple views can only contain a single base table. We cannot use group functions like MAX(), COUNT(), etc.
DML operations could be performed through a simple view. INSERT, DELETE and UPDATE are directly possible 
on a simple view.
*/
--example for simple view
use [AdventureWorks2019]
create view vw_Employee
as
select * from [HumanResources].[Employee] where [Gender] = 'M'

/*
complex views: Complex views can be constructed on more than one base table. In particular, complex views can contain: 
join conditions, a group by clause, a order by clause. DML operations could not always be performed through 
a complex view. We cannot apply INSERT, DELETE and UPDATE on complex view directly.
*/
--Example for complex view
use [LandanHotel]
Create view vw_rooms
as
select bedtype, max([Rate]) as max_rate from [HumanResources].[Rooms]
group by [BedType]

/*
2. What is the difference between function and stored procedure? Write syntax for creating functions and 
stored procedures.
Functions: 
A function has a return type and returns a value. You cannot use a function with Data Manipulation queries. 
Only Select queries are allowed in functions. A function does not allow output parameters. You cannot manage
transactions inside a function. You cannot call stored procedures from a function. You can call a function 
using a select statement.
syntax:
create function function_name (@parameter1 datatype, @parameter2 datatype,.....@parameterN datatype)
returns return_datatype
as 
begin
-----function body----
end

stored procedure:
A procedure does not have a return type. But it returns values using the OUT parameters. You can use DML queries 
such as insert, update, select etc… with procedures. A procedure allows both input and output parameters. You can 
manage transactions inside a procedure. You can call a function from a stored procedure. You cannot call a procedure 
using select statements.
syntax:create procedure spname
	   as
	   begin

	   end
*/
/*
3.What is an index in SQL? What are the different types of indexes in SQL? 
An index is a schema object. It is used by the server to speed up the retrieval of rows by using a pointer. 
It can reduce disk I/O(input/output) by using a rapid path access method to locate data quickly. 
An index helps to speed up select queries and where clauses, but it slows down data input, with the update and 
the insert statements. Indexes can be created or dropped with no effect on the data.
Syntax:
 CREATE INDEX index
 ON TABLE column;
where the index is the name given to that index and TABLE is the name of the table on which that index is created 
and column is the name of that column for which it is applied. 

There are two types of Indexes in SQL Server:
1. Clustered Index
2. Non-Clustered Index
Clustered Index:
A clustered index defines the order in which data is physically stored in a table. Table data can be sorted in 
only way, therefore, there can be only one clustered index per table. In SQL Server, the primary key constraint 
automatically creates a clustered index on that particular column.

Non-Clustered Indexes:
A non-clustered index doesn’t sort the physical data inside the table. In fact, a non-clustered index is stored at 
one place and table data is stored in another place. This is similar to a textbook where the book content is located 
in one place and the index is located in another. This allows for more than one non-clustered index per table.
It is important to mention here that inside the table the data will be sorted by a clustered index. However, 
inside the non-clustered index data is stored in the specified order. The index contains column values on which the
index is created and the address of the record that the column value belongs to.

4. Showcase an example of exception handling in SQL stored procedure.
The TRY CATCH construct allows you to gracefully handle exceptions in SQL Server. To use the TRY CATCH construct, 
we should first place a group of Transact-SQL statements that could cause an exception in a BEGIN TRY...END TRY block 
as follows:
BEGIN TRY  
   -- statements that may cause exceptions
END TRY  
Then you use a BEGIN CATCH...END CATCH block immediately after the TRY block:

BEGIN CATCH  
   -- statements that handle exception
END CATCH  

The following illustrates a complete TRY CATCH construct:

BEGIN TRY  
   -- statements that may cause exceptions
END TRY 
BEGIN CATCH  
   -- statements that handle exception
END CATCH 
If the statements between the TRY block complete without an error, the statements between the CATCH block will not 
execute. However, if any statement inside the TRY block causes an exception, the control transfers to the statements 
in the CATCH block.*/
--example of exception handling in SQL stored procedure:
use master
CREATE PROC usp_divide(
    @a decimal,
    @b decimal,
    @c decimal output
) AS
BEGIN
    BEGIN TRY
        SET @c = @a / @b;
    END TRY
    BEGIN CATCH
        SELECT  
            ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;  
    END CATCH
END;
GO

--call the usp_divide stored procedure to divide 10 by 2:
DECLARE @r decimal;
EXEC usp_divide 10, 2, @r output;
PRINT @r;

--Because no exception occurred in the TRY block, the stored procedure completed at the TRY block.

--attempt to divide 20 by zero by calling the usp_divide stored procedure:
DECLARE @r2 decimal;
EXEC usp_divide 10, 0, @r2 output;
PRINT @r2;

/*
Because of division by zero error which was caused by the formula, the control was passed to the statement 
inside the CATCH block which returned the error’s detailed information
*/
/*
5.Create a SQL function to split strings into rows on a given character? 
Input String: Stephen;peter;berry;Olivier;caroline;
*/
use [AdventureWorks2019]
select value from string_split('Stephen;peter;berry;Olivier;caroline;', ';')


/*
6.What is a temporary and a variable table? Write suitable syntax to create temporary tables and variable tables.

Temporary Tables are most likely as Permanent Tables. Temporary Tables are Created in TempDB and are automatically 
deleted as soon as the last connection is terminated. Temporary Tables helps us to store and process intermediate 
results. Temporary tables are very useful when we need to store temporary data. The Syntax to create a Temporary 
Table is given below:
To Create Temporary Table:
CREATE TABLE #EmpDetails (id INT, name VARCHAR(25))  
To Insert Values Into Temporary Table:
INSERT INTO #EmpDetails VALUES (01, 'Lalit'), (02, 'Atharva') 
To Select Values from Temporary Table:
SELECT * FROM #EmpDetails 
Result:
id	name
1	Lalit
2	Atharva
There are 2 types of Temporary Tables: Local Temporary Table, and Global Temporary Table. These are explained as 
following below.

Local Temporary Table:
A Local Temp Table is available only for the session that has created it. It is automatically dropped (deleted) 
when the connection that has created it, is closed. To create Local Temporary Table Single “#” is used as the 
prefix of a table name.
Also, the user can drop this temporary table by using the “DROP TABLE #EmpDetails” query. There will be Random 
Numbers are appended to the Name of Table Name. If the Temporary Table is created inside the stored procedure, 
it get dropped automatically upon the completion of stored procedure execution.

Example:

CREATE PROCEDURE ProcTemp 
AS
BEGIN
CREATE TABLE #EmpDetails
INSERT INTO #EmpDetails VALUES ( 01, 'Lalit'), ( 02, 'Atharva')
SELECT * FROM #EmpDetails
END
EXECUTE ProcTemp 

Global Temporary Table:
To create a Global Temporary Table, add the “##” symbol before the table name.
Example:

CREATE TABLE ##EmpDetails (id INT, name VARCHAR(25)) 
Global Temporary Tables are visible to all connections and Dropped when the last connection referencing the table is 
closed. Global Table Name must have an Unique Table Name. There will be no random Numbers suffixed at the end of the 
Table Name.



*/