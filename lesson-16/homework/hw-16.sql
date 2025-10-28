--Easy Tasks
--1 Create a numbers table using a recursive query from 1 to 1000.
;WITH cte_numbers AS (
SELECT 1 AS n
UNION ALL
SELECT n+1
FROM cte_numbers
WHERE n < 1000)
SELECT n FROM cte_numbers
OPTION (MAXRECURSION 1000);
--2 Write a query to find the total sales per employee using a derived table.(Sales, Employees)
SELECT e.FirstName, s.TotalAmount
FROM employees e
join(
SELECT EmployeeID, SUM (SalesAmount) AS TotalAmount
FROM Sales s
GROUP BY EmployeeID)  AS s
 ON  e.EmployeeID = s.EmployeeID;
 --3Create a CTE to find the average salary of employees.(Employees)
;WITH cte_avg AS (
select FirstName, AVG(Salary) AS avgSalary
FROM employees
GROUP BY FirstName)
SELECT FirstName,avgSalary FROM cte_avg;
--4Write a query using a derived table to find the highest sales for each product.(Sales, products)
SELECT p.ProductName,s.highestsales
FROM products p
join(
SELECT productID,MAX (SalesAmount) AS highestsales
FROM Sales s
GROUP BY productID) AS s
ON p.productID = s.productID;
--5Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.
;WITH cte_numbers AS (
SELECT 1 as n
UNION ALL
SELECT n*2
FROM cte_numbers
WHERE n * 2  < 1000000)
SELECT n FROM cte_numbers
OPTION (MAXRECURSION 0);
--6Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
WITH cte_sales AS (
SELECT EmployeeID, COUNT(ProductID) AS Number
FROM Sales s
GROUP BY EmployeeID ) 
SELECT e.FirstName, s.Number
FROM Employees e 
JOIN cte_sales s ON s.employeeID=e.employeeID
WHERE s.Number > 5;
--7Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
WITH cte_sales AS (
SELECT ProductID, sum (SalesAmount) AS Totalsum
FROM Sales s
GROUP BY ProductID  ) 
SELECT p.ProductID, s.Totalsum
FROM  Products p
JOIN cte_sales s ON s.ProductID=p.ProductID
WHERE s.Totalsum > 500;
--8Create a CTE to find employees with salaries above the average salary.(Employees)
WITH cte_avg AS (
select DepartmentID, AVG(Salary) AS avgSalary
FROM employees
GROUP BY DepartmentID)
SELECT e.FirstName, e.Salary, e.DepartmentID
FROM employees e
JOIN cte_avg c on e.DepartmentID =  c.DepartmentID
WHERE e.salary >c.avgSalary ;
--9Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
SELECT e.FirstName,s.numberoforder
FROM Employees e
join(
SELECT TOP 5 employeeID, COUNT (ProductID) AS numberoforder
FROM Sales s
GROUP BY employeeID
ORDER BY COUNT(ProductID) DESC
) AS s
ON e.employeeID = s.employeeID; 
select * from Sales
select * from Products
--10Write a query using a derived table to find the sales per product category.(Sales, Products)
SELECT s.TotallAmount, p.CategoryID
FROM Products p
join(
SELECT ProductID,SUM (SalesAmount) AS TotallAmount
FROM Sales s
GROUP BY ProductID) AS s
ON p.ProductID = s.ProductID
GROUP BY s.TotallAmount,p.CategoryID ;
--11Write a script to return the factorial of each value next to it.(Numbers1)
WITH cte AS (
    SELECT Number, Number AS Factorial
    FROM Numbers1
    WHERE Number = (SELECT MIN(Number) FROM Numbers1)
    UNION ALL
    SELECT n.Number, n.Number * f.Factorial
    FROM Numbers1 n
    JOIN cte f ON n.Number = f.Number + 1)
SELECT * FROM cte;
--12This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
WITH SplitCTE AS (
    SELECT
        Id,
        1 AS Pos,
        SUBSTRING(String, 1, 1) AS CharPart,
        String AS FullString
    FROM Example
    UNION ALL
    SELECT
        Id,
        Pos + 1,
        SUBSTRING(FullString, Pos + 1, 1),
        FullString
    FROM SplitCTE
    WHERE Pos + 1 <= LEN(FullString)
)
SELECT
    Id,
    Pos AS RowNumber,
    CharPart AS Character
FROM SplitCTE
ORDER BY Id, Pos;
--13Use a CTE tSaleso calculate the sales difference between the current month and the previous month.(Sales)
WITH CTE AS (
SELECT     
FORMAT(SaleDate, 'MMMM') AS M,
SUM(SalesAmount) AS TotalSales
 FROM Sales
 GROUP BY FORMAT(SaleDate, 'MMMM')
),ddcte as (
SELECT 
 M AS MonthName, 
 TotalSales,
  LAG(TotalSales) OVER (ORDER BY M) AS differenc FROM CTE)
 select monthname,
totalsales,
differenc,
totalsales-differenc as resalt from ddcte
--14Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)
SELECT 
e.EmployeeID,
e.FirstName,
s.Quarter,
s.TotalSales
FROM Employees e
JOIN (
 SELECT EmployeeID,
 DATEPART(QUARTER, SaleDate) AS Quarter,
 SUM(SalesAmount) AS TotalSales
 FROM Sales
 GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
) AS s  
ON e.EmployeeID = s.EmployeeID
WHERE s.TotalSales > 45000;
--15This script uses recursion to calculate Fibonacci numbers
WITH RECURSIVE fibonacci (n, fib1, fib2) AS (
SELECT 1, 0, 1
UNION ALL
SELECT n + 1, fib2, fib1 + fib2
FROM fibonacci
WHERE n < 10)
--16Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
SELECT *
FROM FindSameCharacters
WHERE LEN(Vals) > 1
  AND LEN(REPLACE(Vals, LEFT(Vals, 1), '')) = 0;
  --17Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.
  --(Example:n=5 | 1, 12, 123, 1234, 12345)
CREATE TABLE NumbersTable (
    num INT,
    Siquence VARCHAR(100));
	DECLARE @n INT = 5;
WITH Numbers AS (
SELECT 1 AS num
UNION ALL
SELECT num + 1
FROM Numbers
WHERE num < @n)
INSERT INTO NumbersTable (num, Siquence)
SELECT num,
LEFT('123456789', num) AS Siquence
FROM Numbers
OPTION (MAXRECURSION 0);
SELECT * FROM NumbersTable

