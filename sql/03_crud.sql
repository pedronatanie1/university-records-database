USE UniversityRecordsDB;
GO

-- ==========================================
-- 1. CREATE (INSERT)
-- ==========================================

-- Insert a new course
INSERT INTO dbo.Course
    (course_id, course_name, department, duration_years)
VALUES
    (5, 'BSc Artificial Intelligence', 'Computing', 3);


-- Insert a new module
INSERT INTO dbo.Module
    (module_id, module_name, credits)
VALUES
    ('CS105', 'Software Engineering Principles', 20);


-- Insert a new student
-- Status defaults to 'Active'
INSERT INTO dbo.Student
    (student_id, first_name, last_name, email,
     date_of_birth, course_id, year_of_study)
VALUES
    (10060, 'Robin', 'Ellis', 'robin.ellis@example.com',
     '2005-06-12', 5, 1);


-- Enrol the student in a module
INSERT INTO dbo.Enrolment
    (student_id, module_id, mark)
VALUES
    (10060, 'CS105', NULL);


-- ==========================================
-- 2. READ (SELECT)
-- ==========================================

-- Read all courses
SELECT *
FROM dbo.Course;


-- Read students on a particular course
SELECT
    student_id,
    first_name,
    last_name,
    email,
    year_of_study,
    status
FROM dbo.Student
WHERE course_id = 1;


-- Read modules worth at least 20 credits
SELECT
    module_id,
    module_name,
    credits
FROM dbo.Module
WHERE credits >= 20;


-- Read enrolments for a particular student
SELECT
    student_id,
    module_id,
    mark
FROM dbo.Enrolment
WHERE student_id = 10042;


-- ==========================================
-- 3. UPDATE
-- ==========================================

-- Preview the student before updating
SELECT *
FROM dbo.Student
WHERE student_id = 10043;

-- Change the student's year of study
UPDATE dbo.Student
SET year_of_study = 2
WHERE student_id = 10043;


-- Preview the course before updating
SELECT *
FROM dbo.Course
WHERE course_id = 2;

-- Update the department name
UPDATE dbo.Course
SET department = 'Cyber Security'
WHERE course_id = 2;


-- Preview the module before updating
SELECT *
FROM dbo.Module
WHERE module_id = 'CS103';

-- Change the module's credit value
UPDATE dbo.Module
SET credits = 30
WHERE module_id = 'CS103';


-- Preview the enrolment before updating
SELECT *
FROM dbo.Enrolment
WHERE student_id = 10042
  AND module_id = 'CS101';

-- Change the student's mark
UPDATE dbo.Enrolment
SET mark = 85
WHERE student_id = 10042
  AND module_id = 'CS101';


-- ==========================================
-- 4. DELETE
-- ==========================================

-- Preview the enrolment before deleting
SELECT *
FROM dbo.Enrolment
WHERE student_id = 10060
  AND module_id = 'CS105';

-- Delete the enrolment first because it references
-- the student and module through foreign keys
DELETE FROM dbo.Enrolment
WHERE student_id = 10060
  AND module_id = 'CS105';


-- Preview the student before deleting
SELECT *
FROM dbo.Student
WHERE student_id = 10060;

-- The student can now be deleted because their
-- enrolment has been removed
DELETE FROM dbo.Student
WHERE student_id = 10060;


-- Preview the module before deleting
SELECT *
FROM dbo.Module
WHERE module_id = 'CS105';

-- Delete the module after removing its enrolments
DELETE FROM dbo.Module
WHERE module_id = 'CS105';


-- Preview the course before deleting
SELECT *
FROM dbo.Course
WHERE course_id = 5;

-- Delete the course after removing its students
DELETE FROM dbo.Course
WHERE course_id = 5;
