USE UniversityRecordsDB;
GO

INSERT INTO Course (course_id, course_name, department, duration_years)
VALUES
    (1, 'BSc Computer Science', 'Computing', 3),
    (2, 'BSc Cyber Security', 'Computing', 3),
    (3, 'BEng Software Engineering', 'Engineering', 4),
    (4, 'BSc Data Science', 'Mathematics', 5);

INSERT INTO Module (module_id, module_name, credits)
VALUES
    ('CS101', 'Programming Fundamentals', 30),
    ('CS102', 'Database Systems', 30),
    ('CS103', 'Web Development', 30),
    ('CS104', 'Data Structures and Algorithms', 30);

-- Insert students using the default status of 'Active'
INSERT INTO dbo.Student (student_id, first_name, last_name,
    email, date_of_birth, course_id, year_of_study)
VALUES
    (10042, 'Alex', 'Morgan', 'alex.morgan@example.com', '2005-03-14', 1, 2),
    (10043, 'Jamie', 'Taylor', 'jamie.taylor@example.com', '2004-07-22', 2, 3),
    (10044, 'Riley', 'Carter', 'riley.carter@example.com', '2006-01-09', 3, 1),
    (10045, 'Jordan', 'Brooks', 'jordan.brooks@example.com', '2005-11-30', 4, 2),
    (10046, 'Casey', 'Reed', 'casey.reed@example.com', '2004-04-18', 1, 3),
    (10047, 'Taylor', 'Hayes', 'taylor.hayes@example.com', '2006-08-05', 2, 1),
    (10048, 'Avery', 'Bennett', 'avery.bennett@example.com', '2005-02-27', 3, 2),
    (10049, 'Morgan', 'Foster', 'morgan.foster@example.com', '2004-09-12', 4, 3),
    (10050, 'Cameron', 'Price', 'cameron.price@example.com', '2006-05-21', 1, 1),
    (10051, 'Drew', 'Murphy', 'drew.murphy@example.com', '2005-12-03', 2, 2);

-- Insert students with explicitly specified statuses
INSERT INTO Student (student_id, first_name, last_name,
    email, date_of_birth, course_id, year_of_study, status)
VALUES
    (10052, 'Quinn', 'Parker', 'quinn.parker@example.com', '2004-06-16', 3, 3, 'Graduated'),
    (10053, 'Skyler', 'Ward', 'skyler.ward@example.com', '2005-10-08', 4, 2, 'Suspended'),
    (10054, 'Rowan', 'Kelly', 'rowan.kelly@example.com', '2006-03-25', 1, 1, 'Active'),
    (10055, 'Emerson', 'Cooper', 'emerson.cooper@example.com', '2005-07-19', 2, 2, 'Withdrawn'),
    (10056, 'Finley', 'Bailey', 'finley.bailey@example.com', '2004-12-11', 3, 3, 'Active'),
    (10057, 'Harper', 'Richardson', 'harper.richardson@example.com', '2006-09-02', 4, 1, 'Suspended'),
    (10058, 'Reese', 'Collins', 'reese.collins@example.com', '2005-04-07', 1, 2, 'Active'),
    (10059, 'Peyton', 'Stewart', 'peyton.stewart@example.com', '2004-02-14', 2, 3, 'Graduated');

-- Insert enrolments
INSERT INTO Enrolment (student_id, module_id, mark)
VALUES
    -- Student 10042
    (10042, 'CS101', 82),
    (10042, 'CS102', 76),
    (10042, 'CS103', 91),
    (10042, 'CS104', 68),

    -- Student 10043
    (10043, 'CS101', 74),
    (10043, 'CS102', 88),
    (10043, 'CS104', 79),

    -- Student 10044
    (10044, 'CS101', 65),
    (10044, 'CS103', 72),
    (10044, 'CS104', 81),

    -- Student 10045
    (10045, 'CS102', 59),
    (10045, 'CS103', 67),
    (10045, 'CS104', 73),

    -- Student 10046
    (10046, 'CS101', 93),
    (10046, 'CS102', 85),
    (10046, 'CS103', 89),
    (10046, 'CS104', 95),

    -- Student 10047
    (10047, 'CS101', 58),
    (10047, 'CS102', 64),
    (10047, 'CS103', 71),

    -- Student 10048
    (10048, 'CS101', 77),
    (10048, 'CS103', 83),
    (10048, 'CS104', 86),

    -- Student 10049
    (10049, 'CS102', 91),
    (10049, 'CS103', 78),
    (10049, 'CS104', 84),

    -- Student 10050
    (10050, 'CS101', 69),
    (10050, 'CS102', 73),

    -- Student 10051
    (10051, 'CS101', 80),
    (10051, 'CS102', 87),
    (10051, 'CS104', 75),

    -- Student 10052
    (10052, 'CS101', 62),
    (10052, 'CS103', 70),

    -- Student 10053
    (10053, 'CS102', 55),
    (10053, 'CS104', 61),

    -- Student 10054
    (10054, 'CS101', 90),
    (10054, 'CS103',  NULL),

    -- Student 10055
    (10055, 'CS102', 48),
    (10055, 'CS103', 57),

    -- Student 10056
    (10056, 'CS101', 86),
    (10056, 'CS102', 92),
    (10056, 'CS104', 88),

    -- Student 10058
    (10058, 'CS101', 71),
    (10058, 'CS103', 79),
    (10058, 'CS104', 82);
