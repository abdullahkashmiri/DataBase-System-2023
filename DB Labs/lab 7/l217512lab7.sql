-- L21-7512 Abdullah Dar BSCS 4G DB LAB 7 


use master
go
drop  database ATM
go 
Create database ATM
go 
use ATM
go
create Table UserType(
userTypeID int primary key,
[name] varchar(20) not null
)
go
create table [User](
[userId] int primary key,
[name] varchar(20) not null,
[userType] int foreign key references UserType(UserTypeID),
[phoneNum] varchar(15) not null,
[city] varchar(20) not null
)
go

create table CardType(
[cardTypeID] int primary key,
[name] varchar(15),
[description] varchar(40) null
)
go
create Table [Card](
cardNum Varchar(20) primary key,
cardTypeID int foreign key references  CardType([cardTypeID]),
PIN varchar(4) not null,
[expireDate] date not null,
balance float not null
)
go


Create table UserCard(
userID int foreign key references [User]([userId]),
cardNum varchar(20) foreign key references [Card](cardNum),
primary key(cardNum)
)
go
create table TransactionType(
transTypeID int primary key,
typeName varchar(20) not null,
[description] varchar (40) null
)
go
create table [Transaction](
transId int primary key,
transDate date not null,
cardNum varchar(20) foreign key references [Card](cardNum),
amount int not null,
transType int foreign key references TransactionType(transTypeID)
)




GO
INSERT [dbo].[UserType] ([userTypeID], [name]) VALUES (1, N'Silver')
GO
INSERT [dbo].[UserType] ([userTypeID], [name]) VALUES (2, N'Gold')
GO
INSERT [dbo].[UserType] ([userTypeID], [name]) VALUES (3, N'Bronze')
GO
INSERT [dbo].[UserType] ([userTypeID], [name]) VALUES (4, N'Common')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (1, N'Ali', 2, N'03036067000', N'Narowal')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (2, N'Ahmed', 1, N'03036047000', N'Lahore')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (3, N'Aqeel', 3, N'03036063000', N'Karachi')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (4, N'Usman', 4, N'03036062000', N'Sialkot')
GO
INSERT [dbo].[User] ([userId], [name], [userType], [phoneNum], [city]) VALUES (5, N'Hafeez', 2, N'03036061000', N'Lahore')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (1, N'Debit', N'Spend Now, Pay Now')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (2, N'Credit', N'Spend Now, Pay later')
GO
INSERT [dbo].[CardType] ([cardTypeID], [name], [description]) VALUES (3, N'Gift', N'Enjoy')
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'1324327436569', 3, N'1770', CAST(N'2022-07-01' AS Date), 43025.31)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'2324325423336', 3, N'0234', CAST(N'2020-03-02' AS Date), 14425.62)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'2324325436566', 1, N'1234', CAST(N'2019-02-06' AS Date), 34325.52)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'2324325666456', 2, N'1200', CAST(N'2021-02-05' AS Date), 24325.3)
GO
INSERT [dbo].[Card] ([cardNum], [cardTypeID], [PIN], [expireDate], [balance]) VALUES (N'2343243253436', 2, N'0034', CAST(N'2020-09-02' AS Date), 34025.12)
GO

INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'1324327436569')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (1, N'2343243253436')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (2, N'2324325423336')
GO
INSERT [dbo].[UserCard] ([userID], [cardNum]) VALUES (3, N'2324325436566')
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName], [description]) VALUES (1, N'Withdraw', NULL)
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName], [description]) VALUES (2, N'Deposit', NULL)
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName], [description]) VALUES (3, N'ScheduledDeposit', NULL)
GO
INSERT [dbo].[TransactionType] ([transTypeID], [typeName], [description]) VALUES (4, N'Failed', NULL)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (1, CAST(N'2017-02-02' AS Date), N'1324327436569', 500, 1)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (2, CAST(N'2018-02-03' AS Date), N'2343243253436', 3000, 3)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (3, CAST(N'2017-05-06' AS Date), N'2324325436566', 2500, 2)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (4, CAST(N'2016-09-09' AS Date), N'2324325436566', 2000, 1)
GO
INSERT [dbo].[Transaction] ([transId], [transDate], [cardNum], [amount], [transType]) VALUES (5, CAST(N'2015-02-10' AS Date), N'2324325423336', 6000, 4)
GO


Select * from UserType
Select * from [User]
Select * from UserCard
Select * from [Card]
Select * from CardType
Select * from [Transaction]
Select * from TransactionType


-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------

-- Question no 1
-- Create a procedure to display all the user’s details.

create view [userdetail] as (select u.userId,u.name, u.userType, u.city, u.phoneNum, ucc.balance,ucc.cardNum, ucc.expireDate,ucc.PIN from [User] as u left join
(select uc.cardNum, uc.userID, c.balance,c.cardTypeID, c.expireDate,c.PIN from Usercard as uc right join [Card] as c on (uc.cardNum=c.cardNum)) as ucc on (u.userId=ucc.userID));

select * from userdetail;

create Procedure allUserDetails
As

Begin
select  * from userdetail;
End

exec allUserDetails

-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------

-- Question no 2
-- Create a procedure that takes user name and display his details.


create Procedure UserDetail_name
(@name varchar(20) = 'Usman')
As

Begin
select  * from userdetail where name = @name;
End

exec UserDetail_name 'Ahmed'

-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------

-- Question no 3
-- Create a procedure that takes card number and display owner’s name, phone number and city.

create Procedure Userdetail_card 

@cardnm varchar(20) = '1324327436569'
as
Begin
select name, city, phoneNum from userdetail where cardNum = @cardnm;
End 

exec Userdetail_card '2343243253436'

-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------

-- Question no 4
-- Create a procedure that returns minimum balance in an output parameter.


create Procedure MinBalance
@min float = 0.00 output
as
Begin
select @min = Min(balance) from userdetail;
End 

declare @min_balance float
exec MinBalance  @min_balance output
select @min_balance as min_balance


-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------

-- Question no 5
-- Create a procedure that takes user name, id and returns no. of cards of that user in an output parameter.


create Procedure CardOwner
@name varchar(20), @id int, @card  int = 0 output
as
Begin
select @card = Count(cardNum) from userdetail group by name, userId having name = @name and userid = @id
End 

declare @result int
exec CardOwner'Ahmed', 2, @result  output
select @result as Num_of_Cards


-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------

-- Question no 6
-- Create a procedure Login that takes card number, PIN and returns the status in an output
-- parameter. @status =1 if card number and PIN is valid and @status=0 otherwise.

create Procedure [Login]
@cardnum varchar(20), @pin varchar(20), @status int output
as
Begin
if exists (select cardNum from [Card] where cardNum = @cardnum and @pin = PIN)
	Begin 
		set @status = 1
	End 
else 
	Begin 
		set @status = 0
	End
End


declare @st int
exec [login] '232432542336', '0234', @st output

select @st as IsValid
 
 -- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------

-- Question no 7
--Create a procedure to update the PIN. The procedure takes Card Number, old PIN and new Valid
-- PIN (Length 4) and print ‘Updated PIN’ if PIN gets updated or ‘Error’ otherwise.
 
 
Create Procedure Updatepin 
@cardnum Varchar(20), @pin varchar(4), @n_pin varchar(4)
As
Begin
	If LEN(@n_pin) = 4
	Begin
		If exists (Select cardNum From [Card] Where cardNum = @cardnum AND PIN = @pin)
			Begin
				Update [Card] set Pin = @n_pin
				Where cardNum = @cardnum AND PIN = @pin
				Print 'PIN Updated Successfully'
			End
		Else
			Begin
				Print 'ERROR: No Record Found For Card num : '+ @cardnum + ' with pin : ' + @pin;
			End
	End

	Else
		Begin
			print 'ERROR: Invlid New Pin!!'
		End
End

Exec Updatepin '2324325423336', '0234', '0231'


-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------


-- Question no 8
-- Create a procedure WithDraw using Login Procedure (Question#6), the procedure will take
-- CardNumber, PIN, amount for transaction. Now insert detail of the transaction in Transaction
-- Tableif the transaction is successful with TransType =1(successful Transaction) and next transID
-- (calculate the max transID and increment transID, then insert in table). If the transaction fails
-- insert TransType=4 (Failed Transaction). Update the balance against the card number accordingly.
 

Create Procedure With_Draw 
@cardnum Varchar(20), @pin varchar(4), @amount int
As
Begin
	Declare @valid int
	Exec [Login] @cardnum, @pin, @valid output
	If @valid = 1
	Begin
		Declare @acc_amo int, @id int, @type int
		Select @acc_amo = balance From [Card] 
		Where cardNum = @cardnum AND PIN = @pin
		Select @id = max(transId) From [Transaction] 
		Set @id = @id + 1;
		if @acc_amo >= @amount AND @amount > 9  
		Begin
			set @type = 1;
		End
		Else
		Begin
			set @type = 4;
		End
		Insert into [Transaction] 
		Values (@id, GETDATE(), @cardnum, @amount, @type);
	End

	Else
	Begin
		Print 'ERROR: No Record Found For Card num : '+ @cardnum + ' with pin: ' + @pin;
	End
End

Exec With_Draw '1324327436569', '1770', 8934
Select * From [Transaction]

-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------
-- ----------------------------------------------- END ----------------------------------------------------
-- --------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------