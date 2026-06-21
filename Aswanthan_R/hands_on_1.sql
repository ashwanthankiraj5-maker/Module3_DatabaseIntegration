-- Task 1 : CREATE DATABASE AND TABLES

CREATE DATABASE college_db;

USE college_db;

-- Departments Table

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    hod_name VARCHAR(100),
    budget DECIMAL(12,2)
);

-- Students Table

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    date_of_birth DATE,
    department_id INT,
    enrollment_year INT,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

-- Courses Table

CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(150) NOT NULL,
    course_code VARCHAR(20) UNIQUE,
    credits INT,
    department_id INT,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

-- Enrollments Table

CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade CHAR(2),
    FOREIGN KEY (student_id)
        REFERENCES students(student_id),
    FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
);

-- Professors Table

CREATE TABLE professors (
    professor_id INT AUTO_INCREMENT PRIMARY KEY,
    prof_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);


-- Task 2 : VERIFY NORMALISATION


-- 1NF (First Normal Form)
-- All columns contain atomic (single) values.
-- There are no repeating groups or multi-valued attributes.
-- Example violation: storing multiple phone numbers
-- in one column like '9876543210,9123456789'.

-- 2NF (Second Normal Form)
-- All non-key attributes are fully dependent on the primary key.
-- In the enrollments table, grade and enrollment_date
-- depend on the student-course enrollment record.
-- There is no partial dependency.

-- 3NF (Third Normal Form)
-- There are no transitive dependencies.
-- Department details are stored only in the departments table.
-- Storing dept_name directly in students would create redundancy       Z
-- and violate 3NF because dept_name depends on department_id.

-- Enrollments Table 3NF Analysis
-- enrollment_id uniquely identifies each enrollment record.
-- student_id and course_id are foreign keys only.
-- grade and enrollment_date depend directly on the enrollment.
-- No non-key attribute depends on another non-key attribute.
-- Therefore the enrollments table satisfies 3NF.

-- TASK 3  : ALTER AND EXTEND THE SCHEMA
 ALTER TABLE students ADD phone_number VARCHAR(15)
 DESCRIBE students

 ALTER TABLE courses ADD max_seats INT DEFAULT 60;
 DESCRIBE courses;

ALTER TABLE enrollments
ADD CONSTRAINT chk_grade
CHECK (
grade IN ('A','B','C','D','F')
OR grade IS NULL
);
ALTER TABLE departments
RENAME  COLUMN hod_name TO head_of_dept;

ALTER TABLE students
DROP COLUMN phone_number;