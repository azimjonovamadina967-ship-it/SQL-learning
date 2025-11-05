--1--
CREATE TABLE #MonthlySales (
    ProductID INT ,
   TotalQuantity INT,
   TotalRevenue DECIMAL(10,2));
   
INSERT INTO #MonthlySales (ProductID, TotalQuantity, TotalRevenue)
SELECT 
    S.ProductID,
    SUM(S.Quantity) AS TotalQuantity,
    SUM(S.Quantity * P.Price) AS TotalRevenue
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
WHERE 
    YEAR(S.SaleDate) = YEAR(GETDATE())
    AND MONTH(S.SaleDate) = MONTH(GETDATE())
GROUP BY S.ProductID;
select * from #MonthlySales
--2--
CREATE VIEW vw_ProductSalesSummary AS
SELECT s.ProductID, p.ProductName, p.Category, SUM(s.Quantity) AS TotalQuantitySold
FROM Products p
JOIN Sales s on p.ProductID=s.ProductID
group by s.ProductID, p.ProductName, p.Category;
select * from vw_ProductSalesSummary
--3--
CREATE OR ALTER FUNCTION  fn_GetTotalRevenueForProduct(@ProductID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN ( SELECT SUM(s.Quantity * p.Price)
        FROM Sales s
        JOIN Products p ON s.ProductID = p.ProductID
        WHERE s.ProductID = @ProductID);
END;
GO
SELECT dbo.fn_GetTotalRevenueForProduct(1) AS TotalRevenue;
--4--
CREATE OR ALTER FUNCTION  fn_GetSalesByCategory(@Category VARCHAR(50))
RETURNS table
AS
    RETURN ( SELECT p.ProductName,SUM (s.quantity) as TotalQuantity, SUM(s.Quantity * p.Price) AS TotalRevenue
        FROM Sales s
        JOIN Products p ON s.ProductID = p.ProductID
        WHERE p.Category = @Category
		GROUP BY p.ProductName);
GO
SELECT * FROM dbo.fn_GetSalesByCategory('Clothing')
--5--
CREATE FUNCTION dbo.fn_IsPrime (@InputNumber INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @Divider INT = 2;           -- Bo�luvchi sifatida ishlatiladigan son
    DECLARE @IsPrimeNumber BIT = 1;     -- Tub sonmi yoki yo�q (1 = ha, 0 = yo�q)
    DECLARE @Result VARCHAR(3);         -- Natijani qaytarish uchun o�zgaruvchi

    -- 1 dan kichik yoki teng sonlar tub emas
    IF @InputNumber <= 1
        SET @IsPrimeNumber = 0;

    -- 2 dan boshlab bo�luvchilarni tekshirish
    WHILE @Divider <= SQRT(@InputNumber) AND @IsPrimeNumber = 1
    BEGIN
        IF @InputNumber % @Divider = 0
            SET @IsPrimeNumber = 0;
        SET @Divider = @Divider + 1;
    END;

    -- Natijani aniqlash
    IF @IsPrimeNumber = 1
        SET @Result = 'Yes';
    ELSE
        SET @Result = 'No';

    RETURN @Result;   -- RETURN so�nggi satr bo�lishi shart
END;
GO
-- Sinov uchun:
SELECT dbo.fn_IsPrime(2)  AS [2 uchun natija];     -- Yes (tub)
--6--
CREATE FUNCTION dbo.fn_GetNumbersBetween
(
    @Start INT,
    @End INT
)
RETURNS @Numbers TABLE(
  Number INT)
AS
BEGIN
 DECLARE @Current INT = @Start;
WHILE @Current <= @End
 BEGIN
 INSERT INTO @Numbers(Number)
  VALUES (@Current)
SET @Current = @Current + 1;
    END;
    RETURN;END;
GO
