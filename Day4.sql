
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Branch VARCHAR(50),
    CGPA DECIMAL(3,2)
);

INSERT INTO Students (StudentID, FirstName, LastName, Branch, CGPA) VALUES
(2401, 'Ajay', 'Kumar', 'Computer Science', 7.75),
(2402, 'Riya', 'Singh', 'Electrical', 8.90),
(2403, 'Krishna', 'Dubey', 'Mathematics', 8.60),
(2404, 'Shiva', 'Shankar', 'Metallurgy', 7.20),
(2405, 'Vibhanshu', 'Choukse', 'Computer Science', 8.85);

SELECT * FROM Students;

SELECT FirstName, LastName, CGPA
FROM Students
WHERE Branch = 'Computer Science';

SELECT Branch, COUNT(*) AS NumStudents, AVG(CGPA) AS AvgCGPA
FROM Students
GROUP BY Branch
HAVING AVG(CGPA) >= 7.5;

SELECT StudentID, FirstName, LastName, CGPA
FROM Students
ORDER BY CGPA DESC;

UPDATE Students
SET CGPA = CGPA + 0.10
WHERE StudentID = 2404;

DELETE FROM Students
WHERE StudentID = 2403;
