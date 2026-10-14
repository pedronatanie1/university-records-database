USE UniversityRecordsDB;
GO

-- =====================================================
-- 1. STUDENT ACADEMIC PERFORMANCE VIEW
-- =====================================================

-- Summarise each student's recorded academic performance.
CREATE OR ALTER VIEW dbo.v_student_performance
AS
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    AVG(e.mark * 1.0) AS average_mark,
    MAX(e.mark) AS highest_mark,
    MIN(e.mark) AS lowest_mark
FROM dbo.Student AS s
INNER JOIN dbo.Enrolment AS e
    ON e.student_id = s.student_id
WHERE e.mark IS NOT NULL
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name;
GO

-- Find students with an average mark of at least 70.
SELECT
    student_id,
    first_name,
    last_name,
    average_mark,
    highest_mark,
    lowest_mark
FROM dbo.v_student_performance
WHERE average_mark >= 70
ORDER BY average_mark DESC;
GO


-- =====================================================
-- 2. STUDENT MODULE RESULTS VIEW
-- =====================================================

-- Show recorded module results alongside student and module names.
CREATE OR ALTER VIEW dbo.v_student_results
AS
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    m.module_id,
    m.module_name,
    e.mark
FROM dbo.Enrolment AS e
INNER JOIN dbo.Student AS s
    ON s.student_id = e.student_id
INNER JOIN dbo.Module AS m
    ON m.module_id = e.module_id;
GO

-- Display all module results.
SELECT
    student_id,
    first_name,
    last_name,
    module_id,
    module_name,
    mark
FROM dbo.v_student_results
ORDER BY
    last_name,
    first_name,
    module_name;
GO
