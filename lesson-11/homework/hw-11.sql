SELECT o.OrderID, c.FirstName AS CustomerName, o.OrderDate
FROM Orders o
INNER JOIN Customers c ON o.CustomerID =c.CustomerID
WHERE OrderDate > '2022-12-31';
--------2--------
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees E
INNER JOIN Departments d ON e.DepartmentID =d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing');
-------3--------
SELECT  d.DepartmentName,
  MAX(e.Salary) AS MaxSalary
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;
------4--------
SELECT c.FirstName AS CustomerName, o.OrderID, o.OrderDate
FROM Customers c
INNER JOIN Orders o ON c.CustomerID=o.CustomerID
WHERE c.Country = 'USA'
AND YEAR (o.OrderDate) = 2023;
------5--------
SELECT  c.FirstName AS  CustomerName, COUNT (o.OrderID) AS TotalOrders
FROM Customers c 
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName;
-------6------
SELECT p.ProductName, s.SupplierName
FROM Products p
INNER JOIN Suppliers s on p.SupplierID=s.SupplierID
WHERE 
  s.SupplierName = 'Gadget Supplies' 
  OR s.SupplierName = 'Clothing Mart';
  -----7------
 SELECT c.FirstName AS CustomerName, o.MostRecentOrderDate
 FROM Customers c
 OUTER APPLY (
 SELECT TOP 1 OrderDate AS MostRecentOrderDate
 FROM Orders o
 WHERE c.CustomerID=o.CustomerID
 ORDER BY OrderDate DESC
 ) AS o;
 -----8------
 SELECT c.FirstName AS CustomerName, o.TotalAmount AS OrderTotal
 FROM Customers c
 INNER JOIN Orders o ON c.CustomerID = o.CustomerID 
 WHERE TotalAmount > 500;
 ----9-----
 SELECT p.ProductName, s.SaleDate, s.SaleAmount
 FROM Products p
 INNER JOIN Sales s ON p.ProductID=s.SaleID
 WHERE YEAR (s.SaleDate) = 2022
 OR s.SaleAmount >400; 
 ----10----
 SELECT p.ProductName, SUM (s.SaleAmount) AS TotalSaleAmount
 FROM Products p
 INNER JOIN Sales s ON  p.ProductID = s.ProductID 
 GROUP BY p.ProductName ;
 ----11---
 SELECT e.Name AS EmployeeName, d.DepartmentName, e.Salary
 FROM Employees e
 INNER JOIN Departments d  ON e.DepartmentID = d.DepartmentID
 WHERE d.DepartmentName ='HR'
 AND e.Salary > 60000;
 ----12----
 SELECT  p.ProductName, s.SaleDate, p.StockQuantity
 FROM Products p
 INNER JOIN Sales s ON p.ProductID = s.ProductID
 WHERE YEAR ( s.SaleDate) =2023
 AND  p.StockQuantity =100;
 ---13----
 SELECT e.Name AS EmployeeName, d.DepartmentName, e.HireDate
 FROM Employees e
 INNER JOIN Departments d ON e.DepartmentID=d.DepartmentID
 WHERE d.DepartmentName='Sales'
 OR YEAR (e.HireDate) > 2020;
 -----14---
 SELECT c.FirstName AS CustomerName, o.OrderID, c.Address, o.OrderDate
 FROM Customers c
 INNER JOIN Orders o ON  c.CustomerID=o.CustomerID
 WHERE c.Country IN ('USA')
 AND c.Address LIKE '[0-9][0-9][0-9][0-9]%';
 ----15-----
 SELECT p.ProductName, p.Category, s.SaleAmount
FROM Products p
INNER JOIN Sales s ON p.ProductID = s.ProductID
WHERE p.Category = 'Electronics'
  OR s.SaleAmount > 350;
----16-----
SELECT 
    c.CategoryName,
    COUNT(p.ProductID) AS ProductCount
FROM Categories c
LEFT JOIN Products p
    ON c.CategoryID = p.Category
GROUP BY c.CategoryName;
----17---
SELECT c.FirstName As CustomerName, c.City, o.OrderID, o.TotalAmount AS Amount
FROM Customers c 
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City ='Los Angeles'
AND o.TotalAmount > 300;
----18----
SELECT e.Name AS EmployeeName, d.DepartmentName
FROM Employees e 
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('HR','Finance')
   OR e.Name LIKE '%a%a%a%a%' 
   OR e.Name LIKE '%e%e%e%e%' 
   OR e.Name LIKE '%i%i%i%i%' 
   OR e.Name LIKE '%o%o%o%o%' 
   OR e.Name LIKE '%u%u%u%u%';
   -------19----------
   SELECT e.Name  as EmployeeName, d.DepartmentName, e.Salary
FROM Employees e
INNER JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales','Marketing')
  AND e.Salary > 60000;
