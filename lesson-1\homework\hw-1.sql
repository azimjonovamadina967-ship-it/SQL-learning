--1) Define the following terms: data, database, relational database, table
--Data is a collection of information gathered by observations,measurements or analysis.
--Database is an organized collection of structured information, typically stored electronically for easy access.
--Relational database – is a collection of info that orginizes data in predefined relationships where data is stored in one or more tables of columns and rows.
--Table is a set of facts or figures systemically,displayed, especially in columns.
--2) List five key features of SQL Server.
--High availability and disaster recovery.
--Relational Database Management System.
--Advanced security features.
--Intelligent Database Capabilities.
--Integration and analytics Capabilities.
--3) What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
--Windows Authentication Mode.
--SQL Server Authentication Mode.
--Mixed Authentication
--Medium
--4). Create a new database in SSMS named SchoolDB.
CREATE DATABASE SCHOOLDB;
5) USE SCHOOLDB;
    CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);

--6)Describe the differences between SQL Server, SSMS, and SQL 
-- SQL (Structured Query Language) is the language you use to communicate with database
--SQL Server is the database management system that stores and manages your data
--SSMS is the tool (a GUI) that helps you manage and interact with SQL Server,including writing and executing SQL queries.
--7)Research and explain the different SQL commands: DQL, DML, DDL, DCL,TCL with examples
--DQL- Data Query language which asks questions to get data. The central DQL command is SELECT.
--EXAMPLE: SELECT* FROM Customers;- Get all the data from the customers table
--DML- Data Manipulation Language - adds changes and deletes data. 
--Example:INSERT INTO Students(StudentID,FullName,Age) VALUES (1, 'Abror Akmalov',20)
--DELETE FROM Students
--WHERE StudentID=1
--DDL-Data Definition language.These commands are used to build and manage the structure of the database They set up where your data will be stored.
--EXAMPLE:ALTER TABLE table_name ADD column_name datatype; -modifies an existing database object.
--DROP TABLE table_name;-deletes an existing table, vies or other database object
--DCL-Data Control Language. These commands are used to maanage access and permissions in a database.They control who can see, modify,or manage the data.
--EXAMPLE:GRANT permission ON object TO user; -gives specific privileges to users; REVOKE permission ON object FROM user;-removes specific privileges from users
--TCL-Transaction Control Language - helps to manage transactions and ensures if something goes wrong during a set of changes, the database can go back to how it was before.
--EXAMPLE:COMMIT- saves all transactions to the database
--8) Insert three records into the Students tablE
INSERT INTO Students VALUES
    (1, 'Dilnoza Rahmonova', 20),
    (2, 'Javohir Abdullayev', 22),
    (3, 'Yasmina Akromova', 19);
select * from Students
--9)1. Downloaded the `.bak` file from GitHub:  
--   https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak
--2. Opened **SQL Server Management Studio (SSMS)**.
--3. Right-clicked **Databases** → chose **Restore Database...**.
--4. In **Source**, selected **Device** and added the `.bak` file.
--5. Set the destination database name as `AdventureWorksDW2022`.
--6. In **Options**, checked **Overwrite the existing database (WITH REPLACE)** (because it was already installed).
--7. Clicked **OK** → database was successfully restored.
--8. Now `AdventureWorksDW2022` is visible under Databases in SSMS.
