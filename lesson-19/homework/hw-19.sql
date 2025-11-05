--1--
CREATE PROCEDURE dbo.usp_GetEmployeeBonus
AS
BEGIN
    CREATE TABLE #EmployeeBonus
    (
        EmployeeID INT,
        FullName NVARCHAR(200),
        Department NVARCHAR(100),
        Salary DECIMAL(10, 2),
        BonusPercentage DECIMAL(5,2),
        BonusAmount DECIMAL(10, 2)
    );
    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusPercentage, BonusAmount)
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        e.Salary,
        10.00 AS BonusPercentage,                     
        e.Salary * 10.00 / 100 AS BonusAmount         
    FROM Employees e;
    SELECT * FROM #EmployeeBonus;
END;
go
EXEC dbo.usp_GetEmployeeBonus;
--2--
go
CREATE PROCEDURE Emp_Detail
@departmentname NVARCHAR(50),
 @IncreasePercentage DECIMAL(5,2)
AS
BEGIN
 SET NOCOUNT ON;
   UPDATE Employees
    SET Salary = Salary + (Salary * @IncreasePercentage / 100)
    WHERE Department = @DepartmentName;
	  SELECT 
        EmployeeID,
        FirstName + ' ' + LastName AS FullName,
        Department,
        Salary
    FROM Employees
    WHERE Department = @DepartmentName;
END;
GO
EXEC Emp_Detail
 @DepartmentName = 'Sales', 
     @IncreasePercentage = 10;
	 --3--
MERGE Products_Current AS T
USING Products_New AS S
ON T.ProductID = S.ProductID
WHEN MATCHED THEN
UPDATE SET T.ProductName=S.ProductName,
T.Price = S.Price
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (S.ProductID, S.ProductName, S.Price)
WHEN NOT MATCHED BY SOURCE THEN DELETE ;
SELECT * FROM Products_Current;

