-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 
-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 

-- 1. Write a SQL query to display the first name and last name of all employees.
SELECT first_name, last_name FROM employees;

-- 2. List all departments along with their locations.
SELECT department_name, location FROM departments;

-- 3. Display the project names along with their budgets.
SELECT project_name, budget FROM projects;

-- 4. Show the first name, last name, and salary of all employees in the 'Engineering' department.
SELECT e.first_name, e.last_name, e.salary
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Engineering';

-- 5. List the project names and their corresponding start dates.
SELECT project_name, start_date FROM projects;

-- 6. Display the first name, last name, and department name of all employees.
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- 7. Show the project names with budgets greater than ?90000.
SELECT project_name
FROM projects
WHERE budget > 90000;

-- 8. Write a SQL query to calculate the total budget allocated to projects.
SELECT SUM(budget) AS total_budget
FROM projects;

-- 9. Display the first name, last name, and salary of employees earning more than ?60000.
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 60000;

-- 10. List the project names and their corresponding end dates.
SELECT project_name, end_date FROM projects;

-- 11. Show the department names with locations in 'North India' (Delhi or nearby regions).
SELECT department_name, location
FROM departments
WHERE location LIKE 'North India%';

-- 12. Write a SQL query to calculate the average salary of all employees.
SELECT AVG(salary) AS average_salary
FROM employees;

-- 13. Display the first name, last name, and department name of employees in the 'Finance' department.
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';

-- 14. List the project names with budgets between ?70000 and ?100000.
SELECT project_name
FROM projects
WHERE budget BETWEEN 70000 AND 100000;

-- 15. Show the department names along with the count of employees in each department.
SELECT d.department_name, COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;
