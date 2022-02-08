/*
(1)Q. Explain how SQL Query keyword statements are executed in order.
Each query begins with finding the data that we need in a database, and then filtering that data down into something 
that can be processed and understood as quickly as possible. Because each part of the query is executed sequentially, 
it's important to understand the order of execution so that you know what results are accessible where.
Query order of execution
1. FROM and JOINs
The FROM clause, and subsequent JOINs are first executed to determine the total working set of data that is being
queried. This includes subqueries in this clause, and can cause temporary tables to be created under the hood 
containing all the columns and rows of the tables being joined.

2. WHERE
Once we have the total working set of data, the first-pass WHERE constraints are applied to the individual rows, and 
rows that do not satisfy the constraint are discarded. Each of the constraints can only access columns directly from 
the tables requested in the FROM clause. Aliases in the SELECT part of the query are not accessible in most databases 
since they may include expressions dependent on parts of the query that have not yet executed.

3. GROUP BY
The remaining rows after the WHERE constraints are applied are then grouped based on common values in the column 
specified in the GROUP BY clause. As a result of the grouping, there will only be as many rows as there are unique 
values in that column. Implicitly, this means that you should only need to use this when you have aggregate functions 
in your query.

4. HAVING
If the query has a GROUP BY clause, then the constraints in the HAVING clause are then applied to the grouped rows, 
discard the grouped rows that don't satisfy the constraint. Like the WHERE clause, aliases are also not accessible 
from this step in most databases.

5. SELECT
Any expressions in the SELECT part of the query are finally computed.

6. DISTINCT
Of the remaining rows, rows with duplicate values in the column marked as DISTINCT will be discarded.

7. ORDER BY
If an order is specified by the ORDER BY clause, the rows are then sorted by the specified data in either ascending or 
descending order. Since all the expressions in the SELECT part of the query have been computed, you can reference 
aliases in this clause.

8. LIMIT / OFFSET
Finally, the rows that fall outside the range specified by the LIMIT and OFFSET are discarded, leaving the final set 
of rows to be returned from the query.

========================================================================================================================

(2)Q. Explain the advantages of stored procedures and their syntax in relation to recompiling stored procedures.
Advantages :
The main advantages of stored procedure are given below:
1. Better Performance:
The procedure calls are quick and efficient as stored procedures are compiled once and stored in executable form.
Hence the response is quick. The executable code is automatically cached, hence lowers the memory requirements.
2. Higher Productivity:
Since the same piece of code is used again and again so, it results in higher productivity.
3. Ease of Use:
To create a stored procedure, one can use any Java Integrated Development Environment (IDE). Then, they can be 
deployed on any tier of network architecture.
4. Scalability:
Stored procedures increase scalability by isolating application processing on the server.
5. Maintainability:
Maintaining a procedure on a server is much easier then maintaining copies on various client machines, this is 
because scripts are in one location.

To recompile a stored procedure you do not have to recreate the stored procedure. Here are two easy methods:

Method 1: WITH RECOMPILE
You can recompile your stored procedure while you execute it. Here is the script.

1
EXEC StoredProcedureName @parameters WITH RECOMPILE
This method will recompile the stored procedure as soon as the stored procedure executes it.

Method 2: sp_recompile for Recompile Stored Procedures
Here is a neat trick where you can make your stored procedure for recompilation but not actually execute it. 
Here is the script.

1
EXEC sp_recompile 'StoredProcedureName'
This method will recompile the stored procedure in the first run of the stored procedure. Essentially this method 
removes the cache from the procedure cache.

So now you know different methods to recompile stored procedures. One method can be used when you execute the stored 
procedure and another method that can be used to make stored procedure is ready for recompilation and recompiles 
during its first run.

=======================================================================================================================
(3)Q:- Give an example of the derived table.

A derived table is a table expression that appears in the FROM clause of a query. You can apply derived tables when 
the use of column aliases is not possible because another clause is processed by the SQL translator before the 
alias name is known.

 Example:-

USE sample;
SELECT enter_month
FROM (SELECT MONTH(enter_date) as enter_month FROM works_on) AS m
GROUP BY enter_month

========================================================================================================================
(4)Q:- What is the database's trigger? Explain the different forms of triggers that can be found in the database.

Ans:- In SQL Server, triggers are database objects, actually, a special kind of stored procedure, which “reacts” to 
certain actions we make in the database. The main idea behind triggers is that they always perform an action in case 
some event happens. 

Types of SQL Triggers:-

In SQL Server, we have 3 groups of triggers:

DML (data manipulation language) triggers – We’ve already mentioned them, and they react to DML commands. 
These are – INSERT, UPDATE, and DELETE
DDL (data definition language) triggers – As expected, triggers of this type shall react to DDL commands 
like – CREATE, ALTER, and DROP
Logon triggers – The name says it all. This type reacts to LOGON events
 
 and again each trigger is classified into '2' types.
 1. AFTER or For trigger.
 2. INSTEAD of trigger.

=====================================================================================================================
(5). What are the benefits and drawbacks of triggers?

Pros and Cons of SQL Server Triggers:

The fact is that thinking of triggers as stored procedures hides a set of benefits and drawbacks. Triggers 
provide us with the ability to do things that we are unable to do with stored procedures by themselves.

Pros of SQL Server Triggers
1. Triggers are easy to code. The fact that they are coded like stored procedures which makes getting started with 
triggers easy.
2. Triggers allow you to create basic auditing. By using the deleted table inside a trigger you can build a decent audit 
solution that inserts the contents of the deleted table data into an audit table which holds the data that is either 
being removed by a DELETE statement or being changed by an UPDATE statement.
3. You can call stored procedures and functions from inside a trigger.
4. Triggers are useful when you need to validate inserted or updated data in batches instead of row by row. 
Think about it, in a trigger's code you have the inserted and deleted tables that hold a copy of the data that 
potentially will be stored in the table (the inserted table); and the data that will be removed from the table 
(the deleted table).
5.You can use triggers to implement referential integrity across databases. Unfortunately SQL Server doesn't allow the 
creation of constraints between objects on different databases, but by using triggers you can simulate the behavior of 
constraints. I recently wrote a tip about this matter which you can read here SQL Server Referential Integrity Across
Databases Using Triggers.
6. Triggers are useful if you need to be sure that certain events always happen when data is inserted, updated or 
deleted. This is the case when you have to deal with complex default values of columns, or modify the data of other 
tables.
7. You can use external code as a trigger by using CLR triggers. This type of trigger specifies the method of an 
assembly written in .NET to bind with the trigger.
8. Triggers can be nested to up to 32 levels. A trigger is considered to be nested when it performs an action that fires 
another trigger.
9. Triggers allow recursion. Triggers are recursive when a trigger on a table performs an action on the base table that 
causes another instance of the trigger to fire. This is useful when you have to solve a self-referencing relation 
(i.e. a constraint to itself).

Cons on SQL Server Triggers:

1. When you use BULK INSERT to insert data into a table, triggers are not fired unless you include the FIRE_TRIGGERS
option in your bulk insert statement. This is very important to keep in mind, because if you have triggers on a table 
as part of the business logic, and you make a bulk insert without including the FIRE_TRIGGERS option you will lose 
data consistency.
2. Triggers are difficult to locate unless you have proper documentation because they are invisible to the client. 
For instance, sometimes you execute a DML statement without errors or warnings, say an insert, and you don't see it 
reflected in the table's data. In such case you have to check the table for triggers that may be disallowing you to
run the insert you wanted.
3. Triggers add overhead to DML statements. Every time you run a DML statement that has a trigger associated to it, you
are actually executing the DML statement and the trigger; but by definition the DML statement won't end until the 
trigger execution completes. This can create a disaster in production.
4. The problem of using triggers for audit purposes is that when triggers are enabled, they execute always regardless of 
the circumstances that caused the trigger to fire. For example, if you only need to audit the data inserted by a 
specific stored procedure and you use a trigger, you may have to delete the rows of the audit table that were created 
when someone changed data using an ad-hoc query or add more logic into the trigger's code which of course impacts 
performance. In such case you may have to use the OUTPUT clause.
5. If there are many nested triggers it could get very hard to debug and troubleshoot, which consumes development time 
and resources.
6. Recursive triggers are even harder to debug than nested triggers.
7. If you use triggers to enforce referential integrity you have to be aware that triggers can be disabled by users that 
have the ALTER permission on the table or view on which the trigger was created. To avoid this, you may have to review
user permissions. 
8. For CLR triggers to work you have to enable the "clr enabled" server option using the sp_configure system stored 
procedure. Enabling CLR code to run in the database instance has a potential security threat because a malicious user 
can add CLR assemblies to a database and then take control of the server. To avoid this, you have to strengthen 
security and try to avoid using unsafe assemblies.

=======================================================================================================================

(6). Create a stored procedure to call other stored procedures.
*/
use [H+Active]

create procedure Sp_insert  
(  
@ID int,  
@TempName varchar(max) 
)
as 
begin  
Declare @SampleTable Table(id int, Name varchar(max))  
Insert into @SampleTable(id,Name)values(@ID,@TempName)  
select*from @SampleTable  
end

create procedure Sp_Call
(
@SID int,
@Name varchar(max)
)
as
begin
exec Sp_insert @ID=@SID,@TempName=@Name
end

exec Sp_Call 1,'santhu'
