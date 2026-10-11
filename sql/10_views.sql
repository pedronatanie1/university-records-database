USE UniversityRecordsDB;
GO

-- View 1: Summarise each student's recorded academic performance.
CREATE OR ALTER VIEW v_student_performance
AS
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    AVG(e.mark * 1.0) AS average_mark,
    MAX(e.mark) AS highest_mark,
    MIN(e.mark) AS lowest_mark
FROM Student AS s
INNER JOIN Enrolment AS e
    ON e.student_id = s.student_id
WHERE e.mark IS NOT NULL
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name;
GO

-- Query the view: find students with an average mark of at least 70.
SELECT
    student_id,
    first_name,
    last_name,
    average_mark,
    highest_mark,
    lowest_mark
FROM v_student_performance
WHERE average_mark >= 70
ORDER BY average_mark DESC;
GO

-- View 2: Show recorded module results alongside student and module names.
CREATE OR ALTER VIEW v_student_performance
AS
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    m.module_id,
    m.module_name,
    e.mark
FROM Enrolment AS e
INNER JOIN Student AS s
    ON s.student_id = e.student_id
INNER JOIN Module AS m
    ON m.module_id = e.module_id;
GO

-- Query the view: display all module results.
SELECT
    student_id,
    first_name,
    last_name,
    module_id,
    module_name,
    mark
FROM v_module_results
ORDER BY last_name, first_name, module_name;
GO
