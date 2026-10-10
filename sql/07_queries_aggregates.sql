USE UniversityRecordsDB;
GO


-- Count how many students belong to each status,
-- ordered from the most common status to the least common.
SELECT
    status,
    COUNT(*) AS total
FROM Student
GROUP BY status
ORDER BY total DESC;


-- Count the students on each course and return only
-- courses with at least three students.
SELECT
    c.course_name,
    COUNT(*) AS students
FROM Student AS s
INNER JOIN Course AS c
    ON c.course_id = s.course_id
GROUP BY c.course_name
HAVING COUNT(*) >= 3
ORDER BY students DESC;


-- Calculate each student's average, highest and lowest mark,
-- and number of passes and failures for graded modules.
-- A mark of 40 or above is treated as a pass.
-- Enrolments without a mark are excluded.
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    AVG(e.mark * 1.0) AS average_mark,
    MAX(e.mark) AS highest_mark,
    MIN(e.mark) AS lowest_mark,
    SUM(CASE WHEN e.mark >= 40 THEN 1 ELSE 0 END) AS passed,
    SUM(CASE WHEN e.mark < 40 THEN 1 ELSE 0 END) AS failed
FROM Student AS s
INNER JOIN Enrolment AS e
    ON e.student_id = s.student_id
WHERE e.mark IS NOT NULL
GROUP BY
    s.student_id,
    s.first_name,
    s.last_name
ORDER BY average_mark DESC;
