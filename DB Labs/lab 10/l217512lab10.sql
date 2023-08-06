-- L217512 DB LAB 10 ABDULLAH DAR

CREATE DATABASE l217512lab10db;

USE l217512lab10db;

CREATE TABLE Student (
  roll_no INT PRIMARY KEY,
  name VARCHAR(50),
  dept_id INT,
  batch VARCHAR(10)
);

CREATE TABLE Course (
  course_id INT PRIMARY KEY,
  name VARCHAR(50),
  credit_hrs INT,
  dept_id INT
);

CREATE TABLE Section (
  section_id INT PRIMARY KEY,
  course_id INT,
  capacity INT,
  FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Enrolled (
  student_roll_no INT,
  section_id INT,
  PRIMARY KEY (student_roll_no, section_id),
  FOREIGN KEY (student_roll_no) REFERENCES Student(roll_no),
  FOREIGN KEY (section_id) REFERENCES Section(section_id)
);

CREATE TABLE Faculty (
  faculty_id INT PRIMARY KEY,
  name VARCHAR(50),
  dept_id INT
);

CREATE TABLE Department (
  dept_id INT PRIMARY KEY,
  name VARCHAR(50)
);

INSERT INTO Student (roll_no, name, dept_id, batch) 
VALUES (1, 'John Doe', 1, '2022'),
       (2, 'Jane Smith', 2, '2021'),
       (3, 'Bob Johnson', 1, '2023');

INSERT INTO Course (course_id, name, credit_hrs, dept_id) 
VALUES (1, 'Introduction to Computer Science', 3, 1),
       (2, 'Data Structures and Algorithms', 4, 1),
       (3, 'Linear Algebra', 3, 2);

INSERT INTO Section (section_id, course_id, capacity)
VALUES (1, 1, 30),
       (2, 2, 25),
       (3, 3, 20);

INSERT INTO Enrolled (student_roll_no, section_id)
VALUES (1, 1),
       (2, 1),
       (2, 2),
       (3, 2);

INSERT INTO Faculty (faculty_id, name, dept_id)
VALUES (1, 'Dr. John Smith', 1),
       (2, 'Prof. Jane Johnson', 2);

INSERT INTO Department (dept_id, name)
VALUES (1, 'Computer Science'),
       (2, 'Mathematics');

SELECT * FROM Student;
SELECT * FROM Course;
SELECT * FROM Section;
SELECT * FROM Enrolled;
SELECT * FROM Faculty;
SELECT * FROM Department;

-- ------------------------------------------------------------------------------------------------------
-- ---------------------------------------  S O L U T I O N  --------------------------------------------
-- ------------------------------------------------------------------------------------------------------

-- Question no 1
-- The academic officer is concerned with database auditing so he decides to maintain a record
-- of changes made to database. Create a table Auditing in database with a column audit_id
-- and Last_change_on. Create triggers on student, department and faculty tables so that
-- whenever any change is made on these tables the dates of change get stored in the Auditing
-- table.

-- create the Auditing table

CREATE TABLE Auditing (
  audit_id INT PRIMARY KEY IDENTITY(1,1),
  last_change_on DATETIME DEFAULT GETDATE()
);

-- create trigger on Student table

CREATE TRIGGER [student_trigger]
ON Student
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  INSERT INTO Auditing (last_change_on)
  VALUES (GETDATE());
END;

-- create trigger on Department table

CREATE TRIGGER [department_trigger]
ON Department
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  INSERT INTO Auditing (last_change_on)
  VALUES (GETDATE());
END;

-- create trigger on Faculty table

CREATE TRIGGER [faculty_trigger]
ON Faculty
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  INSERT INTO Auditing (last_change_on)
  VALUES (GETDATE());
END;

---------------------------
-- checking these triggers
---------------------------

-- insertion 
INSERT INTO Student (roll_no, name, dept_id, batch) VALUES (10, 'John Doe', 1, '2022');
SELECT * FROM Auditing;

-- deletion 
DELETE FROM Faculty WHERE faculty_id = 1;
SELECT * FROM Auditing;

-- updation 

UPDATE Department SET name = 'New Department Name' WHERE dept_id = 1;
SELECT * FROM Auditing;

-- ------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------
-- Question no 2
-- Though academic officer was pretty much satisfied with your last change but after few
-- months it feels something is missing in auditing table so you are asked to change the
-- structure of the audit table. So now you also have to store the description of changes
-- i.e. which table from the above-mentioned tables was changed. So, make appropriate change in
-- triggers to perform the operation.

-- altering Auditing Table
ALTER TABLE Auditing
ADD table_name VARCHAR(50);

-- changing triggers
-- student trigger

DROP TRIGGER IF EXISTS student_trigger;
GO
CREATE TRIGGER [student_trigger]
ON Student
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @action CHAR(6);
    IF EXISTS(SELECT * FROM inserted)
    BEGIN
        IF EXISTS(SELECT * FROM deleted)
        BEGIN
            SET @action = 'UPDATE';
        END
        ELSE
        BEGIN
            SET @action = 'INSERT';
        END
    END
    ELSE
    BEGIN
        SET @action = 'DELETE';
    END

    INSERT INTO Auditing (last_change_on, table_name)
    VALUES (GETDATE(), 'Student ' + @action);
END
GO

-- department tigger

DROP TRIGGER IF EXISTS department_trigger;
GO
CREATE TRIGGER [department_trigger]
ON Department
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @action CHAR(6);
    IF EXISTS(SELECT * FROM inserted)
    BEGIN
        IF EXISTS(SELECT * FROM deleted)
        BEGIN
            SET @action = 'UPDATE';
        END
        ELSE
        BEGIN
            SET @action = 'INSERT';
        END
    END
    ELSE
    BEGIN
        SET @action = 'DELETE';
    END

    INSERT INTO Auditing (last_change_on, table_name)
    VALUES (GETDATE(), 'Department ' + @action);
END
GO

-- faculty trigger

DROP TRIGGER IF EXISTS faculty_trigger;
GO
CREATE TRIGGER [faculty_trigger]
ON Faculty
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @action CHAR(6);
    IF EXISTS(SELECT * FROM inserted)
    BEGIN
        IF EXISTS(SELECT * FROM deleted)
        BEGIN
            SET @action = 'UPDATE';
        END
        ELSE
        BEGIN
            SET @action = 'INSERT';
        END
    END
    ELSE
    BEGIN
        SET @action = 'DELETE';
    END

    INSERT INTO Auditing (last_change_on, table_name)
    VALUES (GETDATE(), 'Faculty ' + @action);
END
GO

-- checking for updations made

select * from Auditing;

-- insertion 
INSERT INTO Student (roll_no, name, dept_id, batch) VALUES (11, 'John Doe', 1, '2022');
SELECT * FROM Auditing;

-- deletion 
DELETE FROM Faculty WHERE faculty_id = 2;
SELECT * FROM Auditing;

-- updation 

UPDATE Department SET name = 'New Department Name' WHERE dept_id = 5;
SELECT * FROM Auditing;


-- ------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------
-- Question no 3
-- Now focusing more on the registration system, we firstly need to have some sort of security. 
-- So, in order to have some level of abstraction in our course and section tables we need to
-- design a view, so that when students query for enrollment i.e. applying for the registration
-- of a particular section you should be displaying data from that view rather applying queries
-- on multiple tables (course and section).

-- creating view

CREATE VIEW EnrollmentView AS
SELECT s.roll_no, s.name AS student_name, c.course_id, c.name AS course_name, sec.section_id, sec.capacity, COUNT(e.student_roll_no) AS enrolled_students
FROM Student s
INNER JOIN Enrolled e ON s.roll_no = e.student_roll_no
INNER JOIN Section sec ON e.section_id = sec.section_id
INNER JOIN Course c ON sec.course_id = c.course_id
GROUP BY s.roll_no, s.name, c.course_id, c.name, sec.section_id, sec.capacity;

-- checking 

SELECT * FROM EnrollmentView WHERE student_name = 'John Doe';


-- ------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------
-- Question no 4
-- Moreover, we need to have a store procedure of the above functionality in order to reduce
-- the network traffic and faster execution.

-- stored procedure

CREATE PROCEDURE GetEnrollmentData 
    @roll_no INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM EnrollmentView WHERE roll_no = @roll_no;
END

-- checking

EXEC GetEnrollmentData @roll_no = 1;


-- ------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------
-- Question no 5
-- The academic officer also wants to make sure no one insert, update or deletes department
-- information from the database. As university has only 3 departments CS, EE and MG and
-- that are already present in database. So, create a trigger that will not let anyone to change
-- the department table.

-- roll back trigger 
CREATE TRIGGER PreventDepartmentChanges
ON Department
INSTEAD OF INSERT, UPDATE, DELETE
AS
BEGIN
    PRINT 'Changes to the Department table are not allowed.' 
    ROLLBACK TRANSACTION
END

-- checking

UPDATE Department SET name = 'Computer Science' WHERE dept_id = 1;


-- ------------------------------------------------------------------------------------------------------
-- -------------------------------------------- E N D ---------------------------------------------------
-- ------------------------------------------------------------------------------------------------------
-- l217512 abdullah dar db lab 10