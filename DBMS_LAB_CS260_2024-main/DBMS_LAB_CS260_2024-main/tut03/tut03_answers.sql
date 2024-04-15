-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 

-- Assignments starts
-- 1. Write a query to display the first name and last name of all students.
SELECT first_name,last_name FROM students;
-- 2. List all course names along with their credit hours.
SELECT course_name,credit_hours FROM courses; 
-- 3. Display the first name, last name, and email of all instructors.
SELECT first_name,last_name,email FROM instructors;
-- 4. Show the course names and grades of all students.
SELECT courses.course_name, enrollments.grade 
FROM enrollments 
JOIN courses ON enrollments.course_id = courses.course_id;
-- 5. List the first name, last name, and city of all students.
select first_name,last_name,city from students;
-- 6. Display the course names and instructor names for all courses.
SELECT courses.course_name, CONCAT(instructors.first_name, ' ', instructors.last_name) AS instructor_name 
FROM courses 
JOIN instructors ON courses.instructor_id = instructors.instructor_id;
-- 7. Show the first name, last name, and age of all students.
select first_name,last_name,age from students;
-- 8. List the course names and enrollment dates of all students.
SELECT courses.course_name, enrollments.enrollment_date 
FROM enrollments 
JOIN courses ON enrollments.course_id = courses.course_id;
-- 9. Display the instructor names and email addresses for all instructors.
SELECT CONCAT(instructors.first_name, ' ', instructors.last_name) AS instructor_name,email
FROM instructors; 
-- 10. Show the course names and credit hours for all courses.
SELECT course_name,credit_hours FROM courses;
-- 11. List the first name, last name, and email of the instructor for 'Mathematics' course.
SELECT i.first_name,i.last_name,i.email 
FROM instructors i
JOIN courses c ON c.instructor_id = i.instructor_id
WHERE c.course_name = 'Mathematics';
-- 12. Display the course names and grades for all students with a grade of 'A'.
SELECT c.course_name, e.grade 
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
WHERE e.grade = 'A';
-- 13. Show the first name, last name, and state of students enrolled in 'Computer Science' course.
SELECT s.first_name, s.last_name, s.state 
FROM students s
JOIN enrollments e ON s.student_id = e.student_id 
JOIN courses c ON e.course_id = c.course_id 
WHERE c.course_name = 'Computer Science';
-- 14. List the course names and enrollment dates for all students with a grade of 'B+'.
SELECT c.course_name,e.enrollment_date
FROM enrollments e
JOIN courses c ON c.course_id = e.course_id
WHERE e.grade = 'B+';
-- 15. Display the instructor names and email addresses for instructors teaching courses with more than 3 credit hours.
SELECT CONCAT(i.first_name, ' ', i.last_name) AS instructor_name,i.email
FROM instructors i
JOIN courses c ON c.instructor_id = i.instructor_id
WHERE c.credit_hours > 3; 
