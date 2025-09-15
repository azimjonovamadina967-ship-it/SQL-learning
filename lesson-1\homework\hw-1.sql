1) Define the following terms: data, database, relational database, table
Data is raw facts and figures that can be processed.
Database is an organized collection of related data.
Relational database – a type of database that organizes data into tables which can be linked—or related—based on data common to each.
Table is a database object that stores data in rows and columns.
2) List five key features of SQL Server.
High performance and scalability.
Security features (authentication, encryption, authorization).
Data integrity and reliability.
Advanced querying with T-SQL.
Support for stored procedures, triggers, and functions.
3) What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
Windows Authentication Mode (uses Windows user accounts).
SQL Server Authentication Mode (uses SQL Server logins and passwords).
Medium
4). Create a new database in SSMS named SchoolDB.
CREATE DATABASE SchoolDB;
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);

6)Describe the differences between SQL Server, SSMS, and SQL 
 SQL (Structured Query Language)
What it is: A programming/query language used to interact with databases.
Purpose: Allows you to create tables, insert data, update records, and run queries
SQL Server (Microsoft SQL Server)
What it is: A Database Management System (DBMS) created by Microsoft.
Purpose: Stores, organizes, and manages data.
Role: It’s SSMS (SQL Server Management Studio)
. SSMS (SQL Server Management Studio)
What it is: A tool (GUI application) used to connect to SQL Server.
Purpose: Provides a friendly interface to write SQL queries, manage databases, and view results.
Role: Helps developers and DBAs manage SQL Server easily without typing everything in the command line.the “engine” that processes SQL commands and handles your data.
7)1. DQL (Data Query Language)
 Used to query (retrieve) data from the database.
Main command: SELECT
Example;
SELECT Name, Age fROM Students WHERE Age > 20;
This retrieves student names and ages where the age is greater than 20.
DML (Data Manipulation Language)
👉 Used to manipulate (insert, update, delete) data inside tables.
Commands:
INSERT → add new records
UPDATE → modify existing records
DELETE → remove records
Examples
INSERT INTO Students (StudentID, Name, Age)
VALUES (4, 'David Lee', 21);
UPDATE Students
SET Age = 23
WHERE StudentID = 2;
DELETE FROM Students
WHERE StudentID = 3;
3. DDL (Data Definition Language)
👉 Used to define or change the structure of the database objects (tables, schemas, etc.).
Commands:
CREATE → create objects
ALTER → modify structure
DROP → delete objects
TRUNCATE → delete all records quickly
Examples:
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50)
);
ALTER TABLE Students ADD Email VARCHAR(100);
DROP TABLE Courses;
4. DCL (Data Control Language)
👉 Used to control permissions and access rights in the database.
Commands:
GRANT → give access
REVOKE → remove access
Examples:
GRANT SELECT, INSERT ON Students TO User1;
REVOKE INSERT ON Students FROM User1;
🔹 5. TCL (Transaction Control Language)
Used to manage transactions (a group of SQL operations treated as one unit).
Commands:
COMMIT → save changes permanently
ROLLBACK → undo changes
SAVEPOINT → set a checkpoint to roll back to
7)



















