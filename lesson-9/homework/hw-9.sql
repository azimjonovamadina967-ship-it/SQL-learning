
--🟢 Easy-Level Tasks (10)
SELECT Products.ProductName,
Suppliers.SupplierName 
FROM Products CROSS JOIN Suppliers;

SELECT d.DepartmentID, e.Name,
d.DepartmentName
FROM Departments d
INNER JOIN Employees e
   ON d.DepartmentID = e.DepartmentID;

  SELECT s.SupplierName, p.ProductName
FROM Products p
INNER JOIN Suppliers s
    ON p.SupplierID = s.SupplierID;

	SELECT c.FirstName, o.OrderID
	FROM Orders o
	INNER JOIN Customers c 
	ON c.CustomerID=o.OrderID;

	SELECT s.Name, c.CourseName
FROM Students s
CROSS JOIN Courses c;

SELECT  o.OrderID,p.ProductName
FROM Products p
INNER JOIN Orders o
ON p.ProductID= o.ProductID;

SELECT e.Name, d.DepartmentName
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID

SELECT s.Name, e.CourseID
FROM Students s
INNER JOIN Enrollments e
ON s.StudentID= e.StudentID;


SELECT o.OrderID, p.PaymentID, p.Amount
FROM Orders o
INNER JOIN Payments p
    ON o.OrderID = p.OrderID;

	SELECT o.OrderID, p. ProductName,p.Price
	FROM Products p
	INNER JOIN Orders o
	ON p.ProductID=O.ProductID
	WHERE p.Price > 100;

	--Medium (10 puzzles)
	SELECT e.Name, d.DepartmentName
	FROM Employees e
	CROSS JOIN Departments d 
WHERE e.DepartmentID <> d.DepartmentID; 

SELECT o.OrderID, p.ProductName, o.Quantity, p.StockQuantity
FROM Orders o
INNER JOIN Products p
ON o.ProductID= p.ProductID
WHERE o.Quantity >p.StockQuantity;

SELECT c.FirstName, s.ProductID, s.SaleAmount
FROM Customers c
INNER JOIN Sales s 
ON c.CustomerID= s.CustomerID
WHERE s.SaleAmount >=500

SELECT s.Name, c.CourseName
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID;

SELECT p.ProductName, s.SupplierName
FROM Products p
INNER JOIN Suppliers s
ON p.ProductID =s.SupplierID
WHERE s.SupplierName LIKE '%Tech%'

SELECT o.OrderID, o.TotalAmount, p.Amount
FROM Orders o
INNER JOIN Payments p 
ON o.OrderID = p.OrderID
WHERE p.Amount > o.TotalAmount;

SELECT e.Name, d.DepartmentName
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;

	SELECT p.ProductName, c.CategoryName
FROM Products p
INNER JOIN Categories c
    ON p.ProductID = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');

SELECT s.SaleID, s.SaleDate, s.SaleAmount, c.FirstName, c.Country
FROM Sales s
INNER JOIN Customers c
    ON s.CustomerID = c.CustomerID
WHERE c.Country = 'USA';

SELECT o.OrderID, o.TotalAmount, c.FirstName, c.Country
FROM Orders o
INNER JOIN Customers c
    ON o.CustomerID = c.CustomerID
WHERE c.Country = 'Germany'
  AND o.TotalAmount > 100;

  --Hard (5 puzzles)(Do some research for the tasks below)

  SELECT e1.Name AS Employee1,
       e2.Name AS Employee2,
       e1.DepartmentID AS Dept1,
       e2.DepartmentID AS Dept2
FROM Employees e1
INNER JOIN Employees e2
    ON e1.EmployeeID < e2.EmployeeID   -- bir xil juftlikni ikki marta chiqarmaslik uchun
   AND e1.DepartmentID <> e2.DepartmentID; -- bo‘limlari har xil bo‘lsin

SELECT 
    p.PaymentID,
    p.Amount AS PaidAmount,
    o.OrderID,
    o.Quantity,
    pr.ProductName,
    pr.Price,
    (o.Quantity * pr.Price) AS ExpectedAmount
FROM Payments p
INNER JOIN Orders o 
    ON p.OrderID = o.OrderID
INNER JOIN Products pr 
    ON o.ProductID = pr.ProductID
WHERE p.Amount <> (o.Quantity * pr.Price);

SELECT s.StudentID, s.Name
FROM Students s
LEFT JOIN Enrollments e 
    ON s.StudentID = e.StudentID
WHERE e.CourseID IS NULL;

SELECT 
    m.EmployeeID AS ManagerID,
    m.Name AS ManagerName,
    m.Salary AS ManagerSalary,
    e.EmployeeID AS EmployeeID,
    e.Name AS EmployeeName,
    e.Salary AS EmployeeSalary
FROM Employees e
INNER JOIN Employees m 
    ON e.ManagerID = m.EmployeeID
WHERE m.Salary <= e.Salary;

SELECT DISTINCT c.CustomerID, c.FirstName
FROM Customers c
INNER JOIN Orders o 
    ON c.CustomerID = o.CustomerID
LEFT JOIN Payments p 
    ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;


