-- Task1
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE,
    Salary INT
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, HireDate, Salary) VALUES
(1, 'Raj', 'malhotra', 'Sales', '2020-01-15', 50000),
(2, 'Jignesh', 'Johar', 'IT', '2019-03-22', 75000),
(3, 'Rakesh', 'Bhatia', 'Sales', '2021-06-10', 55000),
(4, 'Ruchika', 'Sharma', 'HR', '2020-11-05', 60000),
(5, 'Mahesh', 'Gupta', 'IT', '2018-09-18', 80000),
(6, 'Sakshi', 'Mehta', 'Sales', '2021-02-28', 52000),
(7, 'Ananya', 'Agrawal', 'IT', '2020-05-12', 70000);

SELECT Department, COUNT(*) AS NumEmployees
FROM Employees
GROUP BY Department;

SELECT Department, COUNT(*) AS NumEmployees, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Department
ORDER BY NumEmployees DESC;

-- TASK 2: 

SELECT FirstName, LastName, Department, Salary
FROM Employees
WHERE Department = 'IT' AND Salary > 70000;

SELECT FirstName, LastName, Department, HireDate
FROM Employees
WHERE Department = 'Sales' OR Department = 'HR';

SELECT FirstName, LastName, HireDate, Department
FROM Employees
WHERE HireDate BETWEEN '2019-01-01' AND '2020-12-31';

SELECT FirstName, LastName, Department
FROM Employees
WHERE FirstName LIKE 'J%';

SELECT FirstName, LastName, Department
FROM Employees
WHERE LastName LIKE '%son%';

SELECT FirstName, LastName, Department, Salary, HireDate
FROM Employees
WHERE (Department = 'IT' OR Department = 'Sales')
  AND Salary BETWEEN 50000 AND 75000
  AND HireDate >= '2019-01-01';

-- TASK 3
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    EmployeeID INT,
    StartDate DATE,
    Budget INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Projects (ProjectID, ProjectName, EmployeeID, StartDate, Budget) VALUES
(101, 'Website Redesign', 2, '2022-01-10', 50000),
(102, 'Mobile App', 5, '2022-03-15', 120000),
(103, 'Data Migration', 7, '2022-02-20', 80000),
(104, 'CRM System', 2, '2022-04-05', 95000),
(105, 'Sales Dashboard', 1, '2022-05-12', 30000);

SELECT e.FirstName, e.LastName, e.Department, p.ProjectName, p.Budget
FROM Employees e
INNER JOIN Projects p ON e.EmployeeID = p.EmployeeID;

SELECT TOP 3 e.FirstName, e.LastName, p.ProjectName, p.Budget, p.StartDate
FROM Employees e
INNER JOIN Projects p ON e.EmployeeID = p.EmployeeID
ORDER BY p.Budget DESC;

SELECT TOP 2 e.FirstName, e.LastName, e.Department, p.ProjectName, p.Budget
FROM Employees e
INNER JOIN Projects p ON e.EmployeeID = p.EmployeeID
WHERE e.Department = 'IT'
ORDER BY p.Budget DESC;
