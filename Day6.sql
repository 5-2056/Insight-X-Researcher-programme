
WITH SalesByEmployee AS (
    SELECT
        e.EmployeeID,
        e.EmployeeName,
        e.DepartmentID,
        SUM(s.SaleAmount) AS TotalSales
    FROM Sales s
    JOIN Employees e ON s.EmployeeID = e.EmployeeID
    GROUP BY e.EmployeeID, e.EmployeeName, e.DepartmentID
),
RankedEmployees AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY TotalSales DESC) AS DeptRank
    FROM SalesByEmployee
)

SELECT
    DepartmentID,
    EmployeeID,
    EmployeeName,
    TotalSales
FROM RankedEmployees
WHERE DeptRank = 1;
