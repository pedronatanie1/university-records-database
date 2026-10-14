USE UniversityRecordsDB;
GO

-- =====================================================
-- 1. STUDENTS AND THEIR MODULE RESULTS
-- =====================================================

-- List students alongside the modules they are enrolled in
-- and their marks, sorted by student surname and module name.
SELECT
    s.first_name,
    s.last_name,
    m.module_name,
    e.mark
FROM dbo.Student AS s
INNER JOIN dbo.Enrolment AS e
    ON e.student_id = s.student_id
INNER JOIN dbo.Module AS m
    ON m.module_id = e.module_id
ORDER BY
    s.last_name ASC,
    m.module_name ASC;


-- =====================================================
-- 2. STUDENTS WITHOUT ENROLMENTS
-- =====================================================

-- Find students who are not enrolled in any modules.
SELECT
    s.student_id,
    s.first_name,
    s.last_name
FROM dbo.Student AS s
LEFT JOIN dbo.Enrolment AS e
    ON e.student_id = s.student_id
WHERE e.student_id IS NULL;
GO
