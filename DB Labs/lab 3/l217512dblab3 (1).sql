CREATE DATABASE l217512dblab3;

-- 21L-7512 Abdullah Dar DB lab 3 
-------------------------QUESTION NUMBER 1--------------------------------

use l217512dblab3;

create table Student
(
RollNum nvarchar(7),
Name nvarchar(20),
Gender nvarchar(10),
Phone nvarchar(12) 
);

drop table Student;

insert into Student (RollNum,Name,Gender,Phone)
Values
('L164123','Ali Ahmad','Male','0333-3333333' ),
( 'L164124','Rafia Ahmed', 'Female','0333-3456789'),
('L164125','Basit Junaid', 'Male', '0345-3243567');

select * from Student;

create table Attendance
(
RollNum nvarchar(7),
Date nvarchar(10),
Status nvarchar(1),
ClassVenue int
);

insert into Attendance (RollNum,Date,Status,ClassVenue)
Values
('L164123','22-2-2016','P',2 ),
( 'L164124','23-2-2016', 'A',1),
('L164125','4-3-2016', 'P', 2);

select * from Attendance;

drop table Attendance;

create table Class_Venue
(
ID int,
Building nvarchar(20),
RoomNum int,
Teacher nvarchar(20)
);

insert into Class_Venue (ID,Building,RoomNum,Teacher)
Values
(1,'CS',2 ,'sarim Baig'),
( 2,'Civil',7, 'Bismillah Jan');

select * from Class_Venue;

drop table Class_Venue;

create table Teacher
(
Name nvarchar(20),
Designation nvarchar(20),
Department nvarchar(20) 
);

drop table Teacher;

insert into Teacher (Name,Designation,Department)
Values
('Sarim Baig','Assistant Prof.','Computer Science'),
( 'Bismillah Jan','Lecturer', 'Civil Eng.'),
('Kashif zafar','Professor', 'Electrical Eng');

select * from Teacher;


-------------------------QUESTION NUMBER 2--------------------------------


alter table Student alter column RollNum nvarchar(7) NOT NULL;

alter table Student add constraint PrimaryKey Primary key(RollNum);

select * from Student;

alter table Attendance alter column RollNum nvarchar(7) NOT NULL;

alter table Attendance add constraint PrimaryKey2 Primary key(RollNum);

select * from Attendance;

alter table Class_Venue alter column ID int NOT NULL;

alter table Class_Venue add constraint PrimaryKey3 Primary key(ID);

select * from Class_Venue;

alter table Teacher alter column Name nvarchar(20) NOT NULL;

alter table Teacher add constraint PrimaryKey4 Primary key(Name);

select * from Teacher;


-------------------------QUESTION NUMBER 3--------------------------------


alter table Attendance add constraint FK_key_1 foreign key (RollNum) references Student (RollNum) on delete no action on update cascade;

alter table Class_Venue add constraint FK_key_2 foreign key (Teacher) references Teacher (Name)on delete no action on update cascade;

alter table Attendance add constraint FK_key_3 foreign key (ClassVenue) references Class_Venue (ID)on delete no action on update cascade;

-------------------------QUESTION NUMBER 4--------------------------------

alter table Student drop column Phone;

select * from Student;

alter table Student add Warning_Count int;


-------------------------QUESTION NUMBER 5--------------------------------

------------------------------------------------------------------------------

-- 1 is valid query just inserting a value/record

select * from Student;

insert into Student (RollNum,Name,Gender,Warning_Count)
Values
('L162334','Fozan Shahid','Male',3);


--2 Invalid because of foreign key (teacher name) in teacher 
-- Ans: by adding teacher name in teacher table

select * from Class_Venue;

-- Now its correct by running below query

insert into Teacher (Name,Designation,Department)
Values
('Ali','Assistant Prof.','Computer Science');

insert into Class_Venue (ID,Building,RoomNum,Teacher)
Values
( 3,'CS',5, 'Ali');

--3 is Valid Query it has the name present and it has just updated

UPDATE Teacher set Name = 'Dr. Kashif Zafar' where Name = 'kashif zafar';

select * from Teacher;

--4 is Valid Query as it has no dependencies

select * from Student;

delete from Student where RollNum = 'L162334';

--5 is In Valid Query as it has dependency with Attendance 
-- i.e that roll number has an attendance record so it can't be deleted without deleting attendance record
-- on delete no action on update cascade

select * from Student;

delete from Student where RollNum = 'L164123';

--6 it is  a valid query

select * from Attendance;

delete from Attendance where RollNum = 'L164124' and Status = 'A';

------------------------------------------------------------------------------

-------------------------QUESTION NUMBER 6--------------------------------


alter table Teacher add constraint t_unique unique (Name);

alter table Student add constraint s_check check (Gender='Male' or Gender='Female');

alter table Attendance add constraint a_check check (Status='P' or Status='A');


-------------------------------------------------------------------------------------------


