-- ABDULLAH DAR 21L-7512 LAB 6 BSCS 4G

create database l217512lab6;
use  l217512lab6;

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Items](
	[ItemNo] [int] NOT NULL,
	[Name] [varchar](10) NULL,
	[Price] [int] NULL,
	[Quantity in Store] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (100, N'A', 1000, 100)
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (200, N'B', 2000, 50)
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (300, N'C', 3000, 60)
INSERT [dbo].[Items] ([ItemNo], [Name], [Price], [Quantity in Store]) VALUES (400, N'D', 6000, 400)
/****** Object:  Table [dbo].[Courses]    Script Date: 02/17/2017 13:04:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerNo] [varchar](2) NOT NULL,
	[Name] [varchar](30) NULL,
	[City] [varchar](3) NULL,
	[Phone] [varchar](11) NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C1', N'AHMED ALI', N'LHR', N'111111')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C2', N'ALI', N'LHR', N'222222')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C3', N'AYESHA', N'LHR', N'333333')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C4', N'BILAL', N'KHI', N'444444')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C5', N'SADAF', N'KHI', N'555555')
INSERT [dbo].[Customers] ([CustomerNo], [Name], [City], [Phone]) VALUES (N'C6', N'FARAH', N'ISL', NULL)
/****** Object:  Table [dbo].[Order]    Script Date: 02/17/2017 13:04:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Order](
	[OrderNo] [int] NOT NULL,
	[CustomerNo] [varchar](2) NULL,
	[Date] [date] NULL,
	[Total_Items_Ordered] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date], [Total_Items_Ordered]) VALUES (1, N'C1', CAST(0x7F360B00 AS Date), 30)
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date], [Total_Items_Ordered]) VALUES (2, N'C3', CAST(0x2A3C0B00 AS Date), 5)
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date], [Total_Items_Ordered]) VALUES (3, N'C3', CAST(0x493C0B00 AS Date), 20)
INSERT [dbo].[Order] ([OrderNo], [CustomerNo], [Date], [Total_Items_Ordered]) VALUES (4, N'C4', CAST(0x4A3C0B00 AS Date), 15)
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 02/17/2017 13:04:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderNo] [int] NOT NULL,
	[ItemNo] [int] NOT NULL,
	[Quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderNo] ASC,
	[ItemNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (1, 200, 20)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (1, 400, 10)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (2, 200, 5)
INSERT [dbo].[OrderDetails] ([OrderNo], [ItemNo], [Quantity]) VALUES (3, 200, 60)

GO
/****** Object:  ForeignKey [FK__OrderDeta__ItemN__4316F928]    Script Date: 02/03/2017 13:55:38 ******/
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([ItemNo])
REFERENCES [dbo].[Items] ([ItemNo])
GO
/****** Object:  ForeignKey [FK__OrderDeta__Order__4222D4EF]    Script Date: 02/03/2017 13:55:38 ******/
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([OrderNo])
REFERENCES [dbo].[Order] ([OrderNo])
GO

------------------------
select * from Customers;
select * from Items;
select * from [Order];
select * from OrderDetails;
------------------------

-------------------------------------------------------------------------------------------------------------------
------------------------------------------- LAB 6 SOULTION --------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------

-- 1. Create a View that gives order number and total price of that order (price= item price * item Quantity )

create view [orderprice] as (select o.OrderNo , SUM(i.Price*o.[Quantity]) as Total_Price
from OrderDetails as o inner join Items as i on (o.ItemNo = i.ItemNo) group by o.OrderNo );

select * from orderprice;

-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------

-- 2. Create a View that gives all the items that are doing well in sales. The criteria to judge
-- which item is doing good sale is that the item is has sold more than 20 pieces.

create view [bestitems] as (select i.ItemNo, i.Name ,o.Quantity 
from OrderDetails as o inner join Items as i on (o.ItemNo = i.ItemNo) where o.Quantity >  20 );

select * from bestitems;
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------

--3. Create a view that return StarCustomers. StarCustomers are the customers who have
-- made a purchase of more than 2000.

create view [starcustomers] as(
select  cs.CustomerNo, cs.Name, cs.City, cs.Phone ,b.OrderNo, b.Total_Price from Customers as cs join (
select c.CustomerNo, c.OrderNo, a.Total_Price from [Order] as c inner join (select o.OrderNo ,
SUM(i.Price*o.[Quantity]) as Total_Price from OrderDetails as o inner join Items as i on 
(o.ItemNo = i.ItemNo) group by o.OrderNo)as a ON (a.OrderNo = c.OrderNo)) as b ON 
(cs.CustomerNo = b.CustomerNo) where b.Total_Price>2000);

select * from starcustomers;

-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------

-- 4. Create a view that returns all the customers that have phone number not null.
-- Create it without with check option.
-- Create the same view with WITH CHECK option.
-- a. Now try to insert, delete and update though the view, and observe the results.

-- WITHOUT CHECK VIEW

create view [withoutcheck] as(select * from Customers where Phone is not null);
-- display
select * from withoutcheck;
-- insert
go
INSERT into withoutcheck VALUES (N'C7', N'FARAH', N'ISL', NULL);
go
-- delete
go
delete from withoutcheck where CustomerNo = 'C7'
go
-- update
go
update withoutcheck set city = 'GRW' where city = 'ISL';
go

-------------------------------------------------------------------------------------------------------------------
-- WITH CHECK VIEW

create view [withcheck] as(select * from Customers where Phone is not null) with check option;
-- display
select * from withcheck;
-- insert
go
INSERT into withcheck VALUES (N'C8', N'FARAH', N'ISL', NULL);
go
-- delete
go
delete from withcheck where CustomerNo = 'C7'
go
-- update
go
update withcheck set city = 'GRW' where city = 'ISL';
go

-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------

-- Extra Querires used for checking Q no  4 
go
INSERT into Customers VALUES (N'C6', N'FARAH', N'ISL', NULL);
go

delete from Customers where CustomerNo = 'C7'

select * from Customers;
-------------------------------------------------------------------------------------------------------------------
----------------------------------------------------- END ---------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------