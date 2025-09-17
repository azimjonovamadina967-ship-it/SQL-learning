CREATE TABLE Employees (
EmpID INT PRIMARY KEY,
NAME VARCHAR (50),
Salary DECIMAL(10,2))
INSERT INTO Employees VALUES (1, 'Alice', 5000.00);
INSERT INTO Employees VALUES (2, 'John', 10000.00),
(3,'Farruh', 6000.00);
INSERT INTO Employees (EmpID, Name, Salary)
VALUES 
(4, 'Charos', 5500.00),
(5, 'Demon', 6500.00),
(6, 'Elena', 7000.00);
UPDATE Employees
SET Salary=7000
WHERE EmpID =1
SELECT * FROM Employees;
DELETE FROM Employees
WHERE EmpID=2;

 --DELETE, DROP and TRUNCATE deleteS the data in the SQL database but they serve different purposes.
 --The DELETE command offers fine-grained control over data removal with the ability to roll back changes, while DROP permanently removes tables or databases.
 --TRUNCATE provides a fast way to remove all data from a table without affecting its schema. Understanding these differences and knowing when to use
 --each command can significantly enhance our database management skills and optimize performance in various scenarios.

 ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100); 

ALTER TABLE Employees
ADD Department VARCHAR(50);

ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

TRUNCATE TABLE Employees;
SELECT * FROM Employees;

INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'HR'
UNION ALL
SELECT 2, 'Finance'
UNION ALL
SELECT 3, 'IT'
UNION ALL
SELECT 4, 'Marketing'
UNION ALL
SELECT 5, 'Operations';

UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;

TRUNCATE TABLE Employees;
ALTER TABLE Employees
DROP COLUMN Department;
EXEC sp_rename 'Employees', 'StaffMembers';
DROP TABLE Departments;

CREATE TABLE Products (
ProductID INT Primary Key,
ProductName VARCHAR (100) NOT NULL,
Category VARCHAR (50),
Price DECIMAL(10,2),
Quantity INT 
);
SELECT * FROM Products
ALTER TABLE Products
ADD CONSTRAINT chk_price_positive CHECK (Price > 0);
ALTER TABLE Products
ADD StockQuantity INT CONSTRAINT df_stock_default DEFAULT 50;
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

INSERT INTO Products VALUES (1, 'Laptop', 'Electronics', 1200.00, 10, 50);
INSERT INTO Products VALUES (2, 'Fridge', 'Home Electronics', 1000.00, 15,50);
INSERT INTO Products VALUES (3, 'Chair', 'Furniture', 8000.00, 30,50);
INSERT INTO Products VALUES (4, 'Dress', 'Clothes',  75.00,20, 50);
INSERT INTO Products VALUES (5,'Cupboard', 'Furniture', 1000.00, 25,50);
SELECT *
INTO Products_Backup
FROM Products;
EXEC sp_rename 'Products', 'Inventory' ;
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;
SELECT name, type_desc
FROM sys.check_constraints
WHERE parent_object_id = OBJECT_ID('Inventory');
ALTER TABLE Inventory
DROP CONSTRAINT chk_price_positive; 

ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000,5);
SELECT * FROM Inventory

