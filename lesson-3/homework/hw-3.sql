---Easy-Level Tasks (100)
 ----BULK INSERT in SQL Server is a Transact-SQL (T-SQL) command used to efficiently import large amounts of data from an external file
----(such as a CSV, text file, or other supported formats) into a SQL Server database table. It is particularly useful for scenarios where high-speed data 
----loading is required, such as migrating data, populating staging tables, or processing large datasets.
----Purpose of BULK INSERT
----High-Speed Data Import: It allows for rapid insertion of large datasets into a table, bypassing row-by-row insertion methods.
----Simplified Data Loading: It provides a straightforward way to load data directly from files without requiring complex ETL (Extract, Transform, Load) tools.
----Flexibility: It supports various file formats and allows customization of delimiters, row terminators, and other file properties.
----Cost-Effective: Reduces the overhead of manual data entry or slower data import methods.

--there are four Four file formats that can be imported into SQL Server:
--CSV – Comma-Separated Values
--TXT – Text files with delimiters
--DAT – Data files (custom-delimited)
--XML – Extensible Markup Language

CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR (50),
Price DECIMAL (10,2)
);
INSERT INTO Products (ProductID, ProductName,Price)
VALUES (1,'Laptop',1200.50);
INSERT INTO Products (ProductID, ProductName,Price)
SELECT 2,'Mouse', 25.75;
INSERT INTO Products (ProductID, ProductName,Price) 
SELECT 3,'Keyboard',45.00;

----NULL is nothing derived from any information already existing at this moment in time: absolute nothingness.
----It is important however that care be taken when dealing with NULLs because even though they might seem convenient so far so good, without 
----some extra effort they cause more problems than may seem at first sight. On the contrary, when specified as NOT NULL, it ensures data completeness. 
----This way, it checks that every record
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);
SELECT * FROM Products
----A comment in SQL is a piece of text written inside a query to explain its purpose.
----The SQL engine ignores comments (they are not executed).
----They are only for humans — to make the code easier to read and understand
--Two types of comments in SQL Server
--1) Single-line comment (--)
--the -- symbol tells SQL Server to ignore everything after it on that line.
--2) Multi-line comment (/* ... */)
--the /* ... */ syntax is used when you want to write a longer explanation across multiple lines-Easy-Level Tasks (100)
 
----A comment in SQL is a piece of text written inside a query to explain its purpose.
----The SQL engine ignores comments (they are not executed).
----They are only for humans — to make the code easier to read and understand
--Two types of comments in SQL Server
--1) Single-line comment (--)
--the -- symbol tells SQL Server to ignore everything after it on that line.
--2) Multi-line comment (/* ... */)
--the /* ... */ syntax is used when you want to write a longer explanation across multiple lines
ALTER TABLE Products
ADD CategoryID VARCHAR (100);

CREATE TABLE Categories (
CategoryID INT PRIMARY KEY,
CategoryName VARCHAR (100) UNIQUE
);
SELECT * FROM Categories

----The Identity in SQL Server is a property that can be applied to a column of a table whose value is automatically created by the server. 
----So, whenever you marked a column as identity, then that column will be filled in an auto-increment way by SQL Server. That means as a user we cannot 
----insert a value manually into an identity column.



truncate table Products

BULK INSERT Products
FROM 'C:\Users\User\Downloads\Telegram Desktop\Products.txt'
WITH (
    FIELDTERMINATOR = ',',   
    ROWTERMINATOR = '\n',    
    FIRSTROW = 2         
	);

 
select * FROM Products

ALTER TABLE Products
ADD CategoryID INT;

ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

--The primary and unique keys are quite similar. Both prevent duplicates and ensure the uniqueness of values, and both can be used as foreign keys.
--A primary key does not allow null values, making it perfect for record identification, as it ensures that each record has a unique and non-null 
--identifier. Hence, there can be only one primary key defined in a table to avoid having more than one identifier per record.
--In contrast, a unique key allows null values and only ensures the uniqueness of the non-null values. You can define a unique key on a column
--that requires its values to be unique but not necessarily non-null. You can define multiple unique keys in one table, as there may be multiple 
--columns that store only unique values.
--A primary key and a unique key can both be present in a table ; however, it makes no sense to define both a uniquekey and a primary key on the same 
--column(s). In cases like this, you should stick with the primary key – not only does it ensure uniqueness just like the unique key, but it also ensures
--null values are stored. 

ALTER TABLE Products
ADD CONSTRAINT CK_Products_Price
CHECK (Price > 0);

ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;


SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;

--A FOREIGN KEY is a column or set of columns in one table that references the primary key columns of another table. This creates a relationship
--between the two tables, ensuring that the child table (which contains the foreign key) can only have values that exist in the parent table's 
--primary key column(s).
--The table containing the foreign key is called the foreign table (or child table), and the table that the foreign key references is called the primary 
--table (or parent table).
--The primary purpose of a foreign key is to maintain referential integrity, ensuring that the relationship between tables is consistent and that
--invalid data does not enter the system.
--A foreign key can be created during table creation using CREATE TABLE statement or it can be added to a table later using ALTER TABLE statement

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Age INT NOT NULL,
    CONSTRAINT CK_Customers_Age CHECK (Age >= 18)
);

CREATE TABLE Orders (
    OrderID INT IDENTITY(100, 10) PRIMARY KEY,
    CustomerName VARCHAR(50),
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT,
    Price DECIMAL(10, 2),
    PRIMARY KEY (OrderID, ProductID)
);

--COALESCE and ISNULL are both functions in SQL Server used to handle NULL values, but they have some differences. ISNULL replaces NULL 
--with a specified replacement value. Syntax: ISNULL(expression, replacement_value). Example: SELECT ISNULL(Price, 0) AS NewPrice FROM Products;.
--If Price is NULL, it will be replaced with 0. Limitation: ISNULL only accepts two arguments. COALESCE returns the first non-NULL value from a list 
--of expressions. Syntax: COALESCE(expr1, expr2, ..., exprN). Example: SELECT COALESCE(Price, DiscountPrice, 0) AS FinalPrice FROM Products;. If Price is NULL, 
--SQL Server checks DiscountPrice. If that is also NULL, it returns 0. Advantage: COALESCE can handle multiple arguments and follows SQL standard.
--Key Differences: ISNULL is SQL Server specific, COALESCE is standard SQL. ISNULL accepts only two arguments, while COALESCE can handle multiple.
--Data type handling is different: ISNULL returns the type of the first argument, while COALESCE returns the type of the highest precedence argument. 
--Conclusion: Use ISNULL for simple replacement of NULL values. Use COALESCE for checking multiple values and returning the first non-NULL one


CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Salary DECIMAL(10,2)
);

ALTER TABLE Products
DROP CONSTRAINT FK_Products_Categories;

ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID)
ON DELETE CASCADE
ON UPDATE CASCADE;






