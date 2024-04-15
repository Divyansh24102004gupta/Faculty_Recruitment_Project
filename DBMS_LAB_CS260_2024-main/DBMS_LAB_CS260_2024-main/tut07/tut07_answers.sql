-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 

-- 1. Create a procedure to calculate the average salary of employees in a given department.
DELIMITER //

CREATE PROCEDURE CalculateAverageSalary(IN department_name VARCHAR(255), OUT avg_salary DECIMAL(10,2))
BEGIN
    SELECT AVG(salary) INTO avg_salary
    FROM employees e
    INNER JOIN departments d ON e.department_id = d.department_id
    WHERE d.department_name = department_name;
END //

DELIMITER ;

-- Example usage: CALL CalculateAverageSalary('Engineering', @avg_salary);
-- SELECT @avg_salary;

-- 2. Write a procedure to update the salary of an employee by a specified percentage.
DELIMITER //

CREATE PROCEDURE UpdateEmployeeSalary(IN emp_id INT, IN percentage DECIMAL(5,2))
BEGIN
    UPDATE employees
    SET salary = salary * (1 + percentage / 100)
    WHERE emp_id = emp_id;
END //

DELIMITER ;

-- Example usage: CALL UpdateEmployeeSalary(1001, 10); -- Increase salary of employee with emp_id 1001 by 10%

-- 3. Create a procedure to list all employees in a given department.
DELIMITER //

CREATE PROCEDURE ListEmployeesInDepartment(IN department_name VARCHAR(255))
BEGIN
    SELECT *
    FROM employees e
    INNER JOIN departments d ON e.department_id = d.department_id
    WHERE d.department_name = department_name;
END //

DELIMITER ;

-- Example usage: CALL ListEmployeesInDepartment('Engineering');

-- 4. Write a procedure to calculate the total budget allocated to a specific project.
DELIMITER //

CREATE PROCEDURE CalculateProjectBudget(IN project_name VARCHAR(255), OUT total_budget DECIMAL(10,2))
BEGIN
    SELECT budget INTO total_budget
    FROM projects
    WHERE project_name = project_name;
END //

DELIMITER ;

-- Example usage: CALL CalculateProjectBudget('Project A', @total_budget);
-- SELECT @total_budget;

-- 5. Create a procedure to find the employee with the highest salary in a given department.
DELIMITER //

CREATE PROCEDURE FindEmployeeWithHighestSalary(IN department_name VARCHAR(255), OUT highest_salary DECIMAL(10,2))
BEGIN
    SELECT MAX(salary) INTO highest_salary
    FROM employees e
    INNER JOIN departments d ON e.department_id = d.department_id
    WHERE d.department_name = department_name;
END //

DELIMITER ;

-- Example usage: CALL FindEmployeeWithHighestSalary('Engineering', @highest_salary);
-- SELECT @highest_salary;

-- 6. Write a procedure to list all projects that are due to end within a specified number of days.
DELIMITER //

CREATE PROCEDURE ListProjectsDueWithinDays(IN num_days INT)
BEGIN
    SELECT *
    FROM projects
    WHERE DATEDIFF(end_date, CURDATE()) <= num_days;
END //

DELIMITER ;

-- Example usage: CALL ListProjectsDueWithinDays(30);

-- 7. Create a procedure to calculate the total salary expenditure for a given department.
DELIMITER //

CREATE PROCEDURE CalculateDepartmentSalaryExpenditure(IN department_name VARCHAR(255), OUT total_salary DECIMAL(10,2))
BEGIN
    SELECT SUM(salary) INTO total_salary
    FROM employees e
    INNER JOIN departments d ON e.department_id = d.department_id
    WHERE d.department_name = department_name;
END //

DELIMITER ;

-- Example usage: CALL CalculateDepartmentSalaryExpenditure('Finance', @total_salary);
-- SELECT @total_salary;

-- 8. Write a procedure to generate a report listing all employees along with their department and salary details.
DELIMITER //

CREATE PROCEDURE GenerateEmployeeReport()
BEGIN
    SELECT e.first_name, e.last_name, d.department_name, e.salary
    FROM employees e
    INNER JOIN departments d ON e.department_id = d.department_id;
END //

DELIMITER ;

-- Example usage: CALL GenerateEmployeeReport();

-- 9. Create a procedure to find the project with the highest budget.
DELIMITER //

CREATE PROCEDURE FindProjectWithHighestBudget(OUT project_name VARCHAR(255), OUT max_budget DECIMAL(10,2))
BEGIN
    SELECT project_name, MAX(budget) INTO project_name, max_budget
    FROM projects;
END //

DELIMITER ;

-- Example usage: CALL FindProjectWithHighestBudget(@project_name, @max_budget);
-- SELECT @project_name, @max_budget;

-- 10. Write a procedure to calculate the average salary of employees across all departments.
DELIMITER //

CREATE PROCEDURE CalculateOverallAverageSalary(OUT avg_salary DECIMAL(10,2))
BEGIN
    SELECT AVG(salary) INTO avg_salary
    FROM employees;
END //

DELIMITER ;

-- Example usage: CALL CalculateOverallAverageSalary(@avg_salary);
-- SELECT @avg_salary;

-- 11. Create a procedure to assign a new manager to a department and update the manager_id in the departments table.
DELIMITER //

CREATE PROCEDURE AssignNewManager(IN department_name VARCHAR(255), IN new_manager_id INT)
BEGIN
    UPDATE departments
    SET manager_id = new_manager_id
    WHERE department_name = department_name;
END //

DELIMITER ;

-- Example usage: CALL AssignNewManager('Engineering', 1004); -- Assign employee with emp_id 1004 as manager of Engineering department

-- 12. Write a procedure to calculate the remaining budget for a specific project.
DELIMITER //

CREATE PROCEDURE CalculateRemainingProjectBudget(IN project_name VARCHAR(255), OUT remaining_budget DECIMAL(10,2))
BEGIN
    SELECT budget - SUM(salary) INTO remaining_budget
    FROM projects p
    INNER JOIN employees e ON p.project_id = e.project_id
    WHERE p.project_name = project_name;
END //

DELIMITER ;

-- Example usage: CALL CalculateRemainingProjectBudget('Project A', @remaining_budget);
-- SELECT @remaining_budget;

-- 13. Create a procedure to generate a report of employees who joined the company in a specific year.
DELIMITER //

CREATE PROCEDURE GenerateEmployeeJoinReport(IN join_year INT)
BEGIN
    SELECT *
    FROM employees
    WHERE YEAR(join_date) = join_year;
END //

DELIMITER ;

-- Example usage: CALL GenerateEmployeeJoinReport(2023);

-- 14. Write a procedure to update the end date of a project based on its start date and duration.
DELIMITER //

CREATE PROCEDURE UpdateProjectEndDate(IN project_name VARCHAR(255), IN duration_days INT)
BEGIN
    UPDATE projects
    SET end_date = DATE_ADD(start_date, INTERVAL duration_days DAY)
    WHERE project_name = project_name;
END //

DELIMITER ;

-- Example usage: CALL UpdateProjectEndDate('Project A', 30); -- Update the end date of Project A to be 30 days after its start date

-- 15. Create a procedure to calculate the total number of employees in each department.
DELIMITER //

CREATE PROCEDURE CalculateEmployeesPerDepartment()
BEGIN
    SELECT d.department_name, COUNT(e.emp_id) AS num_employees
    FROM departments d
    LEFT JOIN employees e ON d.department_id = e.department_id
    GROUP BY d.department_name;
END //

DELIMITER ;

-- Example usage: CALL CalculateEmployeesPerDepartment();
