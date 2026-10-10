USE UniversityRecordsDB;
GO

-- Search for students whose first name, last name, or email
-- contains 'pedro', ignoring case.
SELECT
    student_id,
    first_name,
    last_name,
    email
FROM Student
WHERE LOWER(first_name) LIKE '%morgan%'
   OR LOWER(last_name) LIKE '%morgan%'
   OR LOWER(email) LIKE '%morgan%';


-- Find active second-year students on the BSc Computer Science course,
-- sorted alphabetically by last name, then first name.
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name,
    s.year_of_study,
    s.status
FROM Student AS s
JOIN Course AS c
    ON c.course_id = s.course_id
WHERE c.course_name = 'BSc Computer Science'
  AND s.year_of_study = 2
  AND s.status = 'Active'
ORDER BY
    s.last_name ASC,
    s.first_name ASC;


-- List all students, ordered by date of birth from newest to oldest.
-- This places the youngest students first.
SELECT
    student_id,
    first_name,
    last_name,
    date_of_birth
FROM Student
ORDER BY date_of_birth DESC;


-- List all students, ordered by year of study from lowest to highest.
SELECT
    student_id,
    first_name,
    last_name,
    year_of_study
FROM Student
ORDER BY year_of_study ASC;
