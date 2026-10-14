USE UniversityRecordsDB;
GO

-- =====================================================
-- 1. SEARCH STUDENTS BY NAME OR EMAIL
-- =====================================================

-- Search for students whose first name, last name, or email
-- contains 'morgan', ignoring case.
SELECT
    student_id,
    first_name,
    last_name,
    email
FROM dbo.Student
WHERE LOWER(first_name) LIKE '%morgan%'
   OR LOWER(last_name) LIKE '%morgan%'
   OR LOWER(email) LIKE '%morgan%';


-- =====================================================
-- 2. FILTER AND SORT STUDENTS BY COURSE AND STATUS
-- =====================================================

-- Find active second-year students on the BSc Computer Science course,
-- sorted alphabetically by last name, then first name.
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name,
    s.year_of_study,
    s.status
FROM dbo.Student AS s
INNER JOIN dbo.Course AS c
    ON c.course_id = s.course_id
WHERE c.course_name = 'BSc Computer Science'
  AND s.year_of_study = 2
  AND s.status = 'Active'
ORDER BY
    s.last_name ASC,
    s.first_name ASC;


-- =====================================================
-- 3. SORT STUDENTS BY DATE OF BIRTH
-- =====================================================

-- List all students, ordered by date of birth from newest to oldest.
-- This places the youngest students first.
SELECT
    student_id,
    first_name,
    last_name,
    date_of_birth
FROM dbo.Student
ORDER BY date_of_birth DESC;


-- =====================================================
-- 4. SORT STUDENTS BY YEAR OF STUDY
-- =====================================================

-- List all students, ordered by year of study from lowest to highest.
SELECT
    student_id,
    first_name,
    last_name,
    year_of_study
FROM dbo.Student
ORDER BY year_of_study ASC;
GO
