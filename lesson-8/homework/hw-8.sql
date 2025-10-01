--Easy-Level Tasks 1
SELECT Category,  Count(ProductName) AS TotalNumber
FROM Products
GROUP BY Category;

SELECT Category, AVG(Price) AS AvgPrice
FROM Products
WHERE Category = 'Electronics'
GROUP BY Category;

SELECT *
FROM Customers
WHERE City LIKE 'L%';

SELECT ProductName
FROM Products
WHERE ProductName LIKE '%er';

SELECT CustomerID, Email,Country
FROM Customers
WHERE Country LIKE '%a';

SELECT MAX(Price) AS HighestPrice
FROM Products;

SELECT ProductName, StockQuantity,
 CASE 
 WHEN StockQuantity < 30 THEN 'Low Stock'
 ELSE 'Sufficient'
 END AS StockStatus
FROM Products;

SELECT Country, COUNT(CustomerID) AS TotalCustomers
FROM Customers
GROUP BY Country;

SELECT MIN(Quantity) AS MinQuantity,
       MAX(Quantity) AS MaxQuantity
FROM Orders;

--Medium-Level Tasks 10-18

SELECT DISTINCT o.CustomerID
FROM Orders o
WHERE YEAR(o.OrderDate) = 2023
  AND MONTH(o.OrderDate) = 1
  AND o.CustomerID NOT IN (
        SELECT i.CustomerID
        FROM Invoices i
        WHERE YEAR(i.InvoiceDate) = 2023
          AND MONTH(i.InvoiceDate) = 1
     );

 SELECT ProductName FROM Products
UNION ALL
SELECT ProductName FROM Products_Discounted;

SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

SELECT YEAR(OrderDate) AS OrderYear,
 AVG(TotalAmount) AS AvgOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;

SELECT ProductName,
 CASE
 WHEN Price < 100 THEN 'Low'
 WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
 ELSE 'High'
 END AS PriceGroup
FROM Products;

SELECT district_name, [2012], [2013]
INTO Population_Each_Year
FROM 
(
    SELECT district_name, Year, Population
    FROM City_Population
) AS SourceTable
PIVOT
(
    SUM(Population) 
    FOR Year IN ([2012], [2013])
) AS PivotTable;
Population_Each_Year

SELECT ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID;

SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';

SELECT Year, [Bektemir], [Chilonzor], [Yakkasaroy]
INTO Population_Each_City
FROM 
(
    SELECT Year, district_name, Population
    FROM City_Population
) AS SourceTable
PIVOT
(
    SUM(Population)
    FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS PivotTable;

SELECT * FROM Population_Each_City

--Hard-Level Tasks 19-22

SELECT TOP 3  CustomerID, 
       SUM(TotalAmount) AS TotalSpent
FROM Invoices
GROUP BY CustomerID
ORDER BY TotalSpent DESC;

SELECT district_name, Year, Population
FROM Population_Each_Year
UNPIVOT
(
    Population FOR Year IN ([2012], [2013])
) AS UnpivotTable;

SELECT p.ProductName, 
       COUNT(s.SaleID) AS TimesSold
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName
ORDER BY TimesSold DESC;

SELECT Year, City, Population
FROM Population_Each_City
UNPIVOT
(
    Population FOR City IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS UnpivotTable;



