-- Question 1

CREATE DATABASE Q1;
USE Q1;
CREATE TABLE Manufactures (
  ManufactureID INT PRIMARY KEY
 ,ManufactureAddress NVARCHAR(100)
 ,ManufactureFax VARCHAR(20)
 ,ManufacturePhone VARCHAR(20)
);
CREATE TABLE Laptops (
  LaptopSKU VARCHAR(100) PRIMARY KEY
 ,LaptopName NVARCHAR(50)
 ,Price DECIMAL(8, 2)
 ,Description NVARCHAR(200)
 ,ManufactureID INT
 ,FOREIGN KEY (ManufactureID) REFERENCES Manufactures (ManufactureID)
);
CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY
 ,CustomerAddress NVARCHAR(100)
 ,CustomerPhone VARCHAR(20)
);
CREATE TABLE Purchase (
  LaptopSKU VARCHAR(100)
 ,CustomerID INT
 ,Date DATETIME
 ,Quantity INT
 ,FOREIGN KEY (LaptopSKU) REFERENCES Laptops (LaptopSKU)
 ,FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID)
);

-- Question 2

SELECT
  e.employee_id
 ,e.first_name
 ,e.last_name
FROM employees e
WHERE e.employee_id < 105;

-- Question 3

SELECT
  l.location_id
 ,l.street_address
 ,d.department_name
 ,l.city
FROM locations l
JOIN departments d
  ON l.location_id = d.location_id
WHERE d.department_name = 'IT'
OR d.department_name = 'Marketing';

-- Question 4
SELECT
  CONCAT(e.first_name, ', ', e.last_name)
 ,j.job_title
 ,d1.department_name
 ,e.salary
FROM employees e
JOIN departments d1
  ON e.department_id = d1.department_id
JOIN jobs j
  ON e.job_id = j.job_id
WHERE e.salary > 7000
AND e.job_id = 16
ORDER BY e.salary;

-- Question 5
SELECT
  d.department_id
 ,d.department_name
 ,MAX(e.salary) AS 'MAX(salary)'
FROM departments d
JOIN employees e
  ON d.department_id = e.department_id
GROUP BY d.department_id
        ,d.department_name
ORDER BY 'MAX(salary)' DESC;

-- Question 6
SELECT
TOP (5)
  e1.first_name
 ,e1.last_name
FROM employees e
JOIN employees e1
  ON e.manager_id = e1.employee_id
GROUP BY e1.first_name
        ,e1.last_name
ORDER BY e1.first_name;

--Question 7
SELECT
  c.country_id
 ,c.country_name
 ,COUNT(e.employee_id) AS 'number of employees'
FROM locations l
JOIN countries c
  ON l.country_id = c.country_id
LEFT JOIN departments d
  ON l.location_id = d.location_id
LEFT JOIN employees e
  ON d.department_id = e.department_id
GROUP BY c.country_id
        ,c.country_name
HAVING COUNT(e.employee_id) > 2
ORDER BY 'number of employees' DESC;

-- Question 8
DROP TRIGGER IF EXISTS Salary_Not_Decrease;
CREATE TRIGGER Salary_Not_Decrease
ON employees
AFTER UPDATE
AS
BEGIN
  UPDATE employees
  SET salary = d.salary
  FROM DELETED d
  WHERE employees.employee_id = d.employee_id
  AND d.salary > employees.salary
END;

  UPDATE employees
  SET salary = 17000
  WHERE employee_id = 101;
  SELECT
    e.salary
  FROM employees e
  WHERE e.employee_id = 101;

-- Question 9
CREATE PROCEDURE Get_ManagerID @id INT, @idManager INT OUTPUT
AS
SELECT
  @idManager = e.manager_id
FROM employees e
WHERE e.employee_id = @id;

DECLARE @X INT;
DECLARE @in INT = 101;
EXECUTE Get_ManagerID @in
                     ,@X OUTPUT;
SELECT
  @X AS ManagerID;

-- Question 10;
DELETE FROM dependents
WHERE employee_id IN (SELECT
      e.employee_id
    FROM employees e
    WHERE e.first_name = 'Karen');