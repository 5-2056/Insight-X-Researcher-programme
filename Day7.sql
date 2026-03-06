
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT EmployeeID, FirstName, LastName, Department, Salary
FROM Employees
WHERE Salary > 70000;

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

CREATE NONCLUSTERED INDEX IX_Employees_Salary
ON Employees (Salary)
INCLUDE (EmployeeID, FirstName, LastName, Department);

SET STATISTICS IO ON;
SET STATISTICS TIME ON;

PRINT '=== AFTER INDEX: Index Seek ==='
SELECT EmployeeID, FirstName, LastName, Department, Salary
FROM Employees
WHERE Salary > 70000;

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

-- TASK 2

SELECT StudentID, FirstName, LastName, CGPA, Branch
FROM Students
WHERE CGPA > 8.0
ORDER BY CGPA DESC;

CREATE NONCLUSTERED INDEX IX_Students_CGPA
ON Students (CGPA)
INCLUDE (StudentID, FirstName, LastName, Branch);

SELECT StudentID, FirstName, LastName, CGPA, Branch
FROM Students
WHERE CGPA > 8.0
ORDER BY CGPA DESC;


-- TASK 3
/*

Clustered Index (e.g., StudentID):
┌─────────────────────────────┐
│    Clustered Index Tree      │
├─────────────────────────────┤
│ Leaf Level = DATA            │
│                             │
│ StudentID | FirstName | ... │  ← Actual data rows
│   2401    | Ajay      | ... │     sorted by StudentID
│   2402    | Riya      | ... │
│   2404    | Shiva     | ... │
│   2405    | Vibhanshu | ... │
└─────────────────────────────┘

Non-Clustered Index (e.g., CGPA):
┌──────────────────────────────┐
│  Non-Clustered Index Tree    │
├──────────────────────────────┤
│ Leaf Level = INDEX KEYS      │
│                              │
│ CGPA  | StudentID (pointer)  │
│ 7.20  | → 2404               │  ← Points to actual data
│ 7.75  | → 2401               │     (via Clustered Index key)
│ 8.60  | → 2403               │
│ 8.85  | → 2405               │
│ 8.90  | → 2402               │
└──────────────────────────────┘
*/

SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME IN ('Employees', 'Students')
ORDER BY TABLE_NAME, CONSTRAINT_TYPE;

SELECT 
    name AS IndexName,
    type_desc AS IndexType,
    is_unique AS IsUnique,
    is_primary_key AS IsPrimaryKey,
    OBJECT_NAME(object_id) AS TableName
FROM sys.indexes
WHERE OBJECT_NAME(object_id) IN ('Employees', 'Students')
    AND name IS NOT NULL
ORDER BY TableName, type_desc DESC;

CREATE NONCLUSTERED INDEX IX_Employees_Department
ON Employees (Department)
INCLUDE (EmployeeID, FirstName, LastName, Salary);

CREATE NONCLUSTERED INDEX IX_Employees_HireDate
ON Employees (HireDate)
INCLUDE (EmployeeID, FirstName, LastName, Department);

SELECT TOP 5 * FROM Employees
WHERE EmployeeID = 3;
SELECT FirstName, LastName, Salary FROM Employees
WHERE Salary BETWEEN 60000 AND 80000;

SELECT FirstName, LastName, Department FROM Employees
WHERE Department = 'IT'
ORDER BY FirstName;

SELECT StudentID, FirstName, CGPA FROM Students
WHERE CGPA > 8.5;

SELECT 
    name AS IndexName,
    type_desc AS IndexType,
    OBJECT_NAME(object_id) AS TableName
FROM sys.indexes
WHERE (OBJECT_NAME(object_id) IN ('Employees', 'Students'))
    AND (name LIKE 'IX_%' OR name LIKE 'CIX_%')
ORDER BY TableName, name;

