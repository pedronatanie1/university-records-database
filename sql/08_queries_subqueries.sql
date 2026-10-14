USE UniversityRecordsDB;
GO

-- =====================================================
-- 1. STUDENTS ABOVE THE OVERALL AVERAGE
-- =====================================================

-- Find students whose average mark is higher than
-- the overall average mark across all recorded marks.
SELECT
    s.first_name,
    s.last_name
FROM dbo.Student AS s
WHERE s.student_id IN
(
    SELECT e.student_id
    FROM dbo.Enrolment AS e
    WHERE e.mark IS NOT NULL
    GROUP BY e.student_id
    HAVING AVG(e.mark * 1.0) >
    (
        SELECT AVG(mark * 1.0)
        FROM dbo.Enrolment
        WHERE mark IS NOT NULL
    )
);


-- =====================================================
-- 2. STUDENTS WITH MARKS BELOW 60
-- =====================================================

-- Find students with at least one mark below 60, for example to flag
-- students who may need extra support.
-- This threshold differs from the pass mark of 40 used in
-- 07_queries_aggregates.sql.
SELECT
    s.first_name,
    s.last_name
FROM dbo.Student AS s
WHERE EXISTS
(
    SELECT 1
    FROM dbo.Enrolment AS e
    WHERE e.student_id = s.student_id
      AND e.mark < 60
);


-- =====================================================
-- 3. STUDENTS WITHOUT ENROLMENTS
-- =====================================================

-- Find students who have no enrolments.
SELECT
    s.student_id,
    s.first_name,
    s.last_name
FROM dbo.Student AS s
WHERE NOT EXISTS
(
    SELECT 1
    FROM dbo.Enrolment AS e
    WHERE e.student_id = s.student_id
);


-- =====================================================
-- 4. COMMON TABLE EXPRESSION (CTE)
-- =====================================================

-- Calculate each student's average mark using a CTE,
-- then display students from highest average to lowest.
WITH student_avg AS
(
    SELECT
        student_id,
        AVG(mark * 1.0) AS avg_mark
    FROM dbo.Enrolment
    WHERE mark IS NOT NULL
    GROUP BY student_id
)
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    sa.avg_mark
FROM student_avg AS sa
INNER JOIN dbo.Student AS s
    ON s.student_id = sa.student_id
ORDER BY sa.avg_mark DESC;
GO
