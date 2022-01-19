-- 6. Create a table with a primary key, a column default value, and a column unique constraint in SQL.

use ineuron_assignment

create table persons (
ID int primary key identity(1,1),
[first name] varchar(50) not null,
[last name] varchar(50) unique,
age int,
city varchar(50) default 'NewYork'
);

insert into persons ([first name],[last name],[age],[city]) values ('Santhosh','Bongoni',29,'hyderabad');
insert into persons ([first name],[last name],[age]) values ('sunil','Dodla','27');
insert into persons ([first name],[last name],[age]) values ('shivakumar','shetty','28');

select * from persons