CREATE DATABASE IF NOT EXISTS school_grading_system;
USE school_grading_system;

-- Students table
CREATE TABLE IF NOT EXISTS Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    grade_level INT,
    contact_info VARCHAR(100)
);

-- Courses table
CREATE TABLE IF NOT EXISTS Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20),
    title VARCHAR(100),
    description TEXT,
    teacher_id INT
);

-- Teachers table
CREATE TABLE IF NOT EXISTS Teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    contact_info VARCHAR(100)
);

-- Grades table
CREATE TABLE IF NOT EXISTS Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade FLOAT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Users table
CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(100),
    role ENUM('admin', 'teacher', 'student')
);
-- Add sample data to Students table
INSERT INTO Students (name, grade_level, contact_info) 
VALUES 
('Ravi',11, 'ravi@xyz.com'),
('Bob', 10, 'bob@example.com'),
('Chadra',9,'chanra@xyz.com'),
('Rizwan',15,'rizwan@xyz.com'),
('puneet',20,'puneet@xyz.com'),
('Rajeev',25,'rajeev@xyz.com');
-- Add sample data to Teachers table
INSERT INTO Teachers (name, contact_info) 
VALUES 
('Ms. Davis', 'davis@example.com'),
('Mr. Johnson', 'johnson@example.com');
-- Add sample data to Courses table
INSERT INTO Courses (course_code, title, description, teacher_id) 
VALUES 
('MATH101', 'Mathematics', 'Introductory mathematics course', 1),
('ENG101', 'English', 'Introductory English course', 2),
('SCI101', 'Science', 'Introductory Science course', 1);
-- Add sample data to Grades table
INSERT INTO Grades (student_id, course_id, grade) 
VALUES 
(1, 1, 90),
(1, 2, 85),
(2, 1, 88),
(2, 3, 92),
(3, 2, 75),
(3, 3, 80);
-- Add sample data to Users table
INSERT INTO Users (username, password, role) 
VALUES 
('admin_user', 'admin_password', 'admin'),
('teacher_user', 'teacher_password', 'teacher'),
('student_user', 'student_password', 'student');
DELIMITER //
-- Procedure to add a student
CREATE PROCEDURE AddStudent(
    IN student_name VARCHAR(100),
    IN student_grade_level INT,
    IN student_contact_info VARCHAR(100)
)
BEGIN
    INSERT INTO Students (name, grade_level, contact_info)
    VALUES (student_name, student_grade_level, student_contact_info);
END //
-- Procedure to add a course
CREATE PROCEDURE AddCourse(
    IN course_code VARCHAR(20),
    IN course_title VARCHAR(100),
    IN course_description TEXT,
    IN course_teacher_id INT
)
BEGIN
    INSERT INTO Courses (course_code, title, description, teacher_id)
    VALUES (course_code, course_title, course_description, course_teacher_id);
END //
-- Procedure to add a teacher
CREATE PROCEDURE AddTeacher(
    IN teacher_name VARCHAR(100),
    IN teacher_contact_info VARCHAR(100)
)
BEGIN
    INSERT INTO Teachers (name, contact_info)
    VALUES (teacher_name, teacher_contact_info);
END //
-- Procedure to add a grade
CREATE PROCEDURE AddGrade(
    IN student_id INT,
    IN course_id INT,
    IN student_grade FLOAT
)
BEGIN
    INSERT INTO Grades (student_id, course_id, grade)
    VALUES (student_id, course_id, student_grade);
END //
DELIMITER ;
-- Drop the trigger if it already exists
DROP TRIGGER IF EXISTS DeleteGradesOnCourseDelete;
-- Recreate the trigger
DELIMITER $$
CREATE TRIGGER DeleteGradesOnCourseDelete
BEFORE DELETE ON Courses
FOR EACH ROW
BEGIN
    DELETE FROM Grades WHERE course_id = OLD.course_id;
END$$
DELIMITER ;
-- Add sample data to Students table
INSERT INTO Students (name, grade_level, contact_info) 
VALUES 
('Alice Johnson', 11, 'alice@example.com'),
('Bob Smith', 10, 'bob@example.com'),
('Charlie Brown', 9, 'charlie@example.com');
-- Add sample data to Teachers table
INSERT INTO Teachers (name, contact_info) 
VALUES 
('Ms. Davis', 'davis@example.com'),
('Mr. Johnson', 'johnson@example.com');
-- Add sample data to Courses table
INSERT INTO Courses (course_code, title, description, teacher_id) 
VALUES 
('MATH101', 'Mathematics', 'Introductory mathematics course', 1),
('ENG101', 'English', 'Introductory English course', 2),
('SCI101', 'Science', 'Introductory Science course', 1);
-- Add sample data to Grades table
INSERT INTO Grades (student_id, course_id, grade) 
VALUES 
(1, 1, 90),
(1, 2, 85),
(2, 1, 88),
(2, 3, 92),
(3, 2, 75),
(3, 3, 80);
-- Add sample data to Users table
INSERT INTO Users (username, password, role) 
VALUES 
('admin_user', 'admin_password', 'admin'),
('teacher_user', 'teacher_password', 'teacher'),
('student_user', 'student_password', 'student');
-- Add data to Students table
INSERT INTO Students (name, grade_level, contact_info) VALUES ('Alice Johnson', 11, 'alice@example.com');
-- Add data to Teachers table
INSERT INTO Teachers (name, contact_info) VALUES ('Ms. Davis', 'davis@example.com');
-- Add data to Courses table
INSERT INTO Courses (course_code, title, description, teacher_id) VALUES ('MATH101', 'Mathematics', 'Introductory mathematics course', 1);
-- Add data to Grades table
INSERT INTO Grades (student_id, course_id, grade) VALUES (1, 1, 90);
SHOW TABLES;
DESCRIBE Students;
DESCRIBE Teachers;
DESCRIBE Courses;
DESCRIBE Grades;
DESCRIBE Users;
-- Add sample data to Assignments table
INSERT INTO Assignments (course_id, student_id, grade)
VALUES 
(1, 1, 85),
(1, 2, 90),
(1, 3, 75);
-- Add sample data to Exams table
INSERT INTO Exams (course_id, student_id, grade)
VALUES 
(1, 1, 90),
(1, 2, 85),
(1, 3, 80);
-- View data in Students table
SELECT * FROM Students;
-- View data in Teachers table
SELECT * FROM Teachers;
-- View data in Courses table
SELECT * FROM Courses;
-- View data in Grades table
SELECT * FROM Grades;
-- View data in Users table
SELECT * FROM Users;
SHOW TABLES;
SELECT * FROM Students;
SELECT * FROM Teachers;
SELECT * FROM Courses;
SELECT * FROM Grades;
SELECT * FROM Users;
SELECT * FROM Assignments;
SELECT * FROM Exams;
SELECT 
    s.*,
    t.name AS teacher_name,
    c.course_code,
    c.title AS course_title,
    g.grade,
    u.username,
    u.role
FROM 
    Grades g
JOIN 
    Students s ON g.student_id = s.student_id
JOIN 
    Courses c ON g.course_id = c.course_id
JOIN 
    Teachers t ON c.teacher_id = t.teacher_id
JOIN 
    Users u ON s.student_id = u.user_id;
---------END-------------

