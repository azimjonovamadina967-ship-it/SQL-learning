--Easy-Level Tasks (10)
SELECT MIN (Price) AS MinPrice
FROM Products;

SELECT MAX (Salary) AS MaxSalary
FROM Employees;

SELECT COUNT (*) AS TotalCustomers
FROM Customers;

SELECT COUNT(DISTINCT Category) AS UniqueCategories 
FROM Products;

SELECT SUM(SaleAmount) AS TotalSales
FROM Sales
WHERE ProductID = 7;

SELECT AVG (Age) AS AvgAge
FROM Employees;

SELECT DepartmentName, 
 COUNT(*) AS NumberOfEmployees
FROM Employees
GROUP BY DepartmentName;

SELECT MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice 
FROM Products
GROUP BY Category;

SELECT CustomerID, SUM (SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID;

SELECT DepartmentName, COUNT (*) AS EmpCount
FROM Employees
GROUP BY DepartmentName
HAVING Count (*)>5;

--Medium-Level Tasks (9)
SELECT ProductID,
SUM (SaleAmount) AS TotalSales,
AVG (SaleAmount) AS AvgSales
FROM Sales
GROUP BY ProductID;

SELECT COUNT (DepartmentName) HRCount
FROM Employees
WHERE DepartmentName= 'HR';

SELECT DepartmentName,
MIN (Salary) AS MinSalary, MAX (Salary) AS MaxSalary
FROM Employees
GROUP BY DepartmentName;

SELECT DepartmentName,
AVG (Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName;

SELECT DepartmentName,
 COUNT(*) AS Employee_count,
 AVG(salary) AS Average_salary
FROM Employees
GROUP BY DepartmentName;

SELECT Category,
       AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG (Price) >400;

SELECT YEAR (SaleDate) AS SaleYear,
SUM (SaleAmount) AS TotalAmount
FROM Sales
GROUP BY SaleDate
ORDER BY SaleYear;

SELECT CustomerID,  COUNT(*) AS TotalORD
FROM Orders
GROUP BY CustomerID
HAVING COUNT (*) >=3;

SELECT DepartmentName,
AVG (Salary) AS AverageSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG (Salary) >60000;

--Hard-Level Tasks (6)
SELECT Category,
AVG (Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG (Price) >150;

SELECT CustomerID,
SUM (SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM (SaleAmount) >1500;

SELECT DepartmentName,
SUM (Salary) AS TotalSalary,
AVG (Salary) AS AVGSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG (Salary) >65000;

SELECT o.custid,
       SUM(CASE WHEN o.freight > 50 THEN ot.OrderTotal ELSE 0 END) AS TotalAmount_FreightOver50,
       MIN(ot.OrderTotal) AS LeastPurchase
FROM Sales.Orders AS o
JOIN (
     SELECT od.orderid,
            SUM(od.unitprice * od.qty * (1 - od.discount)) AS OrderTotal
     FROM Sales.OrderDetails AS od
     GROUP BY od.orderid
) AS ot
   ON o.orderid = ot.orderid
GROUP BY o.custid;

SELECT 
    YEAR(o.orderdate)  AS SaleYear,
    MONTH(o.orderdate) AS SaleMonth,
    SUM(od.unitprice * od.qty * (1 - od.discount)) AS TotalSales,
    COUNT(DISTINCT od.productid) AS UniqueProductsSold
FROM Sales.Orders o
JOIN Sales.OrderDetails od
    ON o.orderid = od.orderid
GROUP BY YEAR(o.orderdate), MONTH(o.orderdate)
HAVING COUNT(DISTINCT od.productid) >= 2
ORDER BY SaleYear, SaleMonth;

SELECT
YEAR(o.orderdate) AS OrderYear, MIN(od.qty) AS MinQty, MAX(od.qty) AS MaxQty FROM Sales.Orders o
JOIN Sales.OrderDetails od ON o.orderid = od.orderid 
GROUP BY YEAR(o.orderdate)
ORDER BY OrderYear;

