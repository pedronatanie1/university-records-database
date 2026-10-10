USE UniversityRecordsDB;
GO


-- Find students whose average mark is higher than
-- the overall average mark across all recorded marks.
SELECT
    s.first_name,
    s.last_name
FROM Student AS s
WHERE s.student_id IN
(
    SELECT e.student_id
    FROM Enrolment AS e
    WHERE e.mark IS NOT NULL
    GROUP BY e.student_id
    HAVING AVG(e.mark * 1.0) >
    (
        SELECT AVG(mark * 1.0)
        FROM Enrolment
        WHERE mark IS NOT NULL
    )
);


-- Find students who have failed at least one module.
-- A mark below 60 is treated as a failure.
SELECT
    s.first_name,
    s.last_name
FROM Student AS s
WHERE EXISTS
(
    SELECT 1
    FROM Enrolment AS e
    WHERE e.student_id = s.student_id
      AND e.mark < 60
);


-- Find students who have no enrolments.
SELECT
    s.student_id,
    s.first_name,
    s.last_name
FROM Student AS s
WHERE NOT EXISTS
(
    SELECT 1
    FROM Enrolment AS e
    WHERE e.student_id = s.student_id
);


-- Calculate each student's average mark using a CTE,
-- then display students from highest average to lowest.
WITH student_avg AS
(
    SELECT
        student_id,
        AVG(mark * 1.0) AS avg_mark
    FROM Enrolment
    WHERE mark IS NOT NULL
    GROUP BY student_id
)
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    sa.avg_mark
FROM student_avg AS sa
INNER JOIN Student AS s
    ON s.student_id = sa.student_id
ORDER BY sa.avg_mark DESC;
