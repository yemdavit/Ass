use university;

-- Create the Students Table
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);


-- Create the Departments Table
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);


-- Create the Faculty Table
CREATE TABLE faculty (
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Create the Courses Table
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(10) NOT NULL,
    title VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    faculty_id INT,
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) 
        REFERENCES students(student_id)
        ON DELETE CASCADE,
    FOREIGN KEY (course_id) 
        REFERENCES courses(course_id)
        ON DELETE RESTRICT,
    CHECK (grade IN ('A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'D', 'F', NULL))
) ENGINE=InnoDB;

CREATE INDEX idx_student_id ON enrollments(student_id);
CREATE INDEX idx_course_id ON enrollments(course_id);

-- Insert 6 students
INSERT INTO students (first_name, last_name, date_of_birth, email)
VALUES
('John', 'Doe', '2000-01-01', 'john.doe@example.com'),
('Jane', 'Smith', '1999-05-15', 'jane.smith@example.com'),
('Alice', 'Johnson', '2001-07-10', 'alice.johnson@example.com'),
('Bob', 'Brown', '1998-11-20', 'bob.brown@example.com'),
('Charlie', 'Davis', '2000-03-30', 'charlie.davis@example.com'),
('David', 'Martinez', '2002-09-05', 'david.martinez@example.com');


-- Insert 6 departments
INSERT INTO departments (name)
VALUES
('Computer Science'),
('Electrical Engineering'),
('Mechanical Engineering'),
('Mathematics'),
('Physics'),
('Chemistry');


-- Insert 6 faculty members
INSERT INTO faculty (first_name, last_name, department_id, email)
VALUES
('Dr. Sarah', 'Williams', 1, 'sarah.williams@university.edu'),
('Dr. Michael', 'Taylor', 1, 'michael.taylor@university.edu'),
('Dr. Emily', 'Clark', 2, 'emily.clark@university.edu'),
('Dr. David', 'Martinez', 3, 'david.martinez@university.edu'),
('Dr. Laura', 'Harris', 2, 'laura.harris@university.edu'),
('Dr. James', 'Lewis', 4, 'james.lewis@university.edu');

select * from faculty;

-- Insert 6 courses
INSERT INTO courses (code, title, credits, faculty_id)
VALUES
('CS101', 'Introduction to Programming', 4, 1),
('CS102', 'Data Structures and Algorithms', 3, 1),
('CS103', 'Database Systems', 3, 3),
('CS104', 'Operating Systems', 4, 2),
('CS105', 'Computer Networks', 2, 5),
('CS106', 'Artificial Intelligence', 3, 6);


INSERT INTO enrollments (student_id, course_id, enrollment_date, grade)
VALUES
    (1, 1, '2023-09-01', 'B+'),
    (1, 2, '2023-09-02', NULL),
    (2, 5, '2023-09-02', 'A-'),
     (5, 1, '2023-09-01', 'C'),
    (4, 3, '2023-09-02', NULL),
    (2, 5, '2023-09-02', 'A-'),
     (3, 3, '2023-09-01', 'B'),
    (5, 5, '2023-09-02', NULL),
    (2, 2, '2023-09-02', 'A-');
    
    
    
-- Query 1: Retrieve all students who enrolled in a specific course (e.g., Course ID = 1)
SELECT s.student_id, s.first_name, s.last_name, e.enrollment_date, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
WHERE e.course_id = 1;


-- Query 2: Find all faculty members in a particular department (Assuming faculty table exists)
SELECT f.faculty_id, f.first_name, f.last_name, f.email
FROM faculty f
WHERE f.department_id = 1;

-- Query 3: List all courses a particular student is enrolled in (e.g., Student ID = 1)
SELECT c.course_id, c.code, c.title, e.enrollment_date, e.grade
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
WHERE e.student_id = 1;

-- Query 4: Retrieve students who have not enrolled in any course
SELECT s.student_id, s.first_name, s.last_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

-- Query 5: Find the average grade of students in a specific course (e.g., Course ID = 1)
SELECT c.course_id, c.code, c.title, 
       AVG(CASE 
           WHEN e.grade = 'A' THEN 4.0
           WHEN e.grade = 'B' THEN 3.0
           WHEN e.grade = 'C' THEN 2.0
           WHEN e.grade = 'D' THEN 1.0
           ELSE 0.0
       END) AS average_grade_points
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
WHERE c.course_id = 1
GROUP BY c.course_id;


select * from courses;

select *from enrollments; 






