
-------------------------------------------------------------------
-------------------------------------------------------------------
-- ABDULLAH DAR [21-L-7512] [DB LAB 4]
-------------------------------------------------------------------
-------------------------------------------------------------------

---------------------- QUESTION NO 1 ------------------------------
-- Create database, tables and insert values in tables.
-------------------------------------------------------------------
CREATE DATABASE L217512DBLAB4;

use L217512DBLAB4;

create table salesman(id int NOT NULL,salesman varchar(30),city varchar(30),commission float);

insert into salesman VALUES(5001, 'James Hoog','New York', 0.15);
insert into salesman VALUES(5002, 'Nail Knite', 'Paris', 0.13);
insert into salesman VALUES(5005, 'Pit Alex', 'London', 0.11);
insert into salesman VALUES(5006, 'Mc Lyon' ,'Paris', 0.14);
insert into salesman VALUES(5007, 'Paul Adam' ,'San Jose', 0.13);
insert into salesman VALUES(5003, 'Lauson Hen', 'San Jose', 0.12);

create table orders(order_no int NOT NULL,purchamt float ,ord_date date,customer_id int NOT NULL,salesman_id int);

INSERT INTO orders VALUES(70001, 150.5, '2012-10-05', 3005, 5006);
INSERT INTO orders VALUES(70009, 270.65, '2011-09-10', 3001 ,5005);
INSERT INTO orders VALUES(70002, 65.26, '2014-10-05' ,3002 ,5001);
INSERT INTO orders VALUES(70004, 110.5, '2011-08-17' ,3009 ,5003);
INSERT INTO orders VALUES(70007, 948.5, '2012-09-10', 3005 ,5006);
INSERT INTO orders VALUES(70005, 2400.6, '2010-07-27', 3007 ,5001);
INSERT INTO orders VALUES(70008, 5760, '2013-09-10' ,3002 ,5001);
INSERT INTO orders VALUES(70010, 1983.43, '2010-10-10', 3004 ,5005);
INSERT INTO orders VALUES(70003, 2480.4, '2013-10-10', 3009 ,5003);
INSERT INTO orders VALUES(70012, 250.45, '2010-06-27', 3008 ,5002);
INSERT INTO orders VALUES(70011, 75.29, '2014-08-17', 3003 ,NULL);
INSERT INTO orders VALUES(70013, 3045.6, '2010-04-25', 3002 ,NULL);
INSERT INTO orders VALUES(700019, 150.5, '2012-01-05', 3005, 5006);

create table customers(id int NOT NULL,name varchar(30),city varchar(30),grade int,salesman_id int);

INSERT INTO customers VALUES(3002, 'Nick Rimando', 'New York', 100 ,5001);
INSERT INTO customers VALUES(3007, 'John Brad Davis', 'New York', 200, 5001);
INSERT INTO customers VALUES(3005, 'Graham Zusi', 'California' ,200, 5002);
INSERT INTO customers VALUES(3008, 'Julian Green', 'London' ,300 ,5002);
INSERT INTO customers VALUES(3004, 'Fabian Johnson', 'Paris' ,300, 5006);
INSERT INTO customers VALUES(3009, 'Geoff Cameron', 'Berlin' ,100, 5003);
INSERT INTO customers VALUES(3003, 'Jozy Altidor', 'Moscow' ,200, 5007);
INSERT INTO customers VALUES(3001, 'John Brad Guzan', 'London', Null, 5005);

select * from salesman;
select * from orders;
select * from customers;

---------------------- QUESTION NO 2 -----------------------------
-- 2. Identify all primary and foreign keys in the tables and add primary keys and foreign keys using Alter command.

ALTER TABLE salesman add constraint PK1 primary key (id);
ALTER TABLE orders add constraint PK2 primary key (order_no);
ALTER TABLE customers add constraint PK3 primary key (id);

alter table orders add constraint FK_key_1 foreign key (salesman_id) references salesman (id) ;
alter table orders add constraint FK_key_3 foreign key (customer_id) references customers (id);
alter table customers add constraint FK_key_2 foreign key (salesman_id) references salesman (id) ;

---------------------- QUESTION NO 3 -----------------------------
-- Display salesman_id and city only from salesman table.

select id , city from salesman;

---------------------- QUESTION NO 4 -----------------------------
-- List all those customers that live in New York, in ascending order of their name. (Use where clause).

select * from customers where city = 'New York' order by name asc;

---------------------- QUESTION NO 5 -----------------------------
-- Change the column name ‘name’ from salesman table to ‘full_name’.

select salesman as Full_Name from salesman;

---------------------- QUESTION NO 6 -----------------------------
-- List all those customers who have &#39;John&#39; in their name and are either from London, Paris or NewYork. (use ‘like’n and ‘%’ operator)

select * from customers where name like '%John%' AND (city = 'London' OR  city = 'Paris' OR city = 'New York');

---------------------- QUESTION NO 7 -----------------------------
-- Display the name of customer name who have ‘a’ in their name. (use ‘like’ and ‘%’ operator)

select name from customers where name like '%a%';

---------------------- QUESTION NO 8 -----------------------------
-- List all orders in descending order of their order date. (use order by).

select * from orders order by ord_date desc;

---------------------- QUESTION NO 9 -----------------------------
-- List all the orders that were made in January (use built-in function).

select * from orders where Month(ord_date) = 01;

---------------------- QUESTION NO 10 -----------------------------
-- List the year, week, dayofyear, month, day, weekday of all orders in the month of October. (use built in function)

select YEAR(ord_date) as Year, DATEPART (WEEK, ord_date) as WEEK, DATEPART(DAYOFYEAR, ord_date) as D_O_Y, Month(ord_date) as Month, Day(ord_date) as Day, dATEPARt(WEEKDAY, ord_date) as Week_day from orders where Month(ord_date)=10;

---------------------- QUESTION NO 11 -----------------------------
-- List customers who have made order in 2012 as well as 2014.

select * from customers as c inner join orders as o on (o.customer_id=c.id) AND (YEAR(o.ord_date) = 2014 AND YEAR(o.ord_date) = 2012);

---------------------- QUESTION NO 12 -----------------------------
-- Show those customers who have made order in 2012 but not in 2014.

select * from customers as c inner join orders as o on (o.customer_id=c.id) AND (YEAR(o.ord_date) != 2014 AND YEAR(o.ord_date) = 2012);

---------------------- QUESTION NO 13 -----------------------------
-- Triple the purchase amount of all orders in the month of October. (use arithmetic operator).

select order_no, purchamt*3 as purchase ,ord_date,customer_id,salesman_id from orders where Month(ord_date)=10;

---------------------- QUESTION NO 14 -----------------------------
-- Add 0.5 to the commission of all salesmen who belong to San Jose.

select id ,salesman ,city ,commission + 0.5 as commision from salesman where city = 'San Jose';

---------------------- QUESTION NO 15 -----------------------------
-- Find salesman name, orderdate, commission that have places the order.

select salesman,ord_date, commission from salesman inner join orders on salesman.id = orders.salesman_id;

--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------










