--1. Find Employees with Minimum Salary
SELECT *
FROM Employees
WHERE Salary = (SELECT MIN(Salary) FROM Employees);
--2. Find Products Above Average Price
SELECT id,product_name,price
FROM Products
WHERE Price >(SELECT AVG(Price) FROM Products)
--3. Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" department. Tables: employees (columns: id, name, department_id), 
--departments (columns: id, department_name)
SELECT Name
FROM Employees
WHERE department_id =
    (SELECT id
     FROM  departments
   WHERE department_name = 'Sales');
--4. Find Customers with No Orders
SELECT Name
FROM Customers AS C
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders AS O
    WHERE O.Customer_ID = C.Customer_ID
);
--5 Retrieve products with the highest price in each category. Tables: products (columns: id, product_name, price, category_id)
SELECT p.category_id, p.product_name, p.Price AS Highestprice
FROM Products p 
WHERE p.Price =(
    SELECT  MAX(Price) 
    FROM Products 
    WHERE category_id = p.category_id
) ;
--6. Find Employees in Department with Highest Average Salary
SELECT e.id, e.name, e.salary, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE e.department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC);
--7. Find Employees Earning Above Department Average
SELECT * FROM Employees e1
WHERE Salary > (select avg(salary)
from Employees e2
WHERE e2.department_id=e1.department_id)
--8. Find Students with Highest Grade per Course
SELECT 
    g.Course_ID,
    g.Student_ID,
    s.Name,
    g.Grade
FROM Grades g
JOIN Students s ON g.Student_ID = s.Student_ID
WHERE g.Grade = (
    SELECT MAX(g2.Grade)
    FROM Grades g2
    WHERE g2.Course_ID = g.Course_ID
);
--9. Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. Tables: products
--(columns: id, product_name, price, category_id
SELECT id, product_name, price, category_id
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS rnk
    FROM products
) t
WHERE rnk = 3;
--10. Find Employees whose Salary Between Company Average and Department Max Salary
SELECT id, name, salary, department_id
FROM employees e
WHERE salary BETWEEN 
      (SELECT AVG(salary) FROM employees)
  AND (
      SELECT MAX(salary)
      FROM employees
      WHERE department_id = e.department_id
  );
