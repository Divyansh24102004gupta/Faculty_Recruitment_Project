-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 

-- 1.
DELIMITER //
CREATE TRIGGER IncreaseSalaryTrigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 60000 THEN
        SET NEW.salary = NEW.salary * 1.10;
    END IF;
END;
//
DELIMITER ;


-- 2.
DELIMITER //
CREATE TRIGGER PreventDeleteDepartmentTrigger
BEFORE DELETE ON departments
FOR EACH ROW
BEGIN
    DECLARE employee_count INT;
    SELECT COUNT(*) INTO employee_count
    FROM employees
    WHERE department_id = OLD.department_id;
    IF employee_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete department with assigned employees';
    END IF;
END;
//
DELIMITER ;


-- 3.
DELIMITER //
CREATE TRIGGER SalaryUpdateAuditTrigger
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO salary_audit (emp_id, old_salary, new_salary, employee_name, updated_at)
    VALUES (OLD.emp_id, OLD.salary, NEW.salary, CONCAT(NEW.first_name, ' ', NEW.last_name), NOW());
END;
//
DELIMITER ;


-- 4.
DELIMITER //
CREATE TRIGGER AssignDepartmentTrigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary <= 60000 THEN
        SET NEW.department_id = 3;
    END IF;
END;
//
DELIMITER ;


-- 5.
DELIMITER //
CREATE TRIGGER UpdateManagerSalaryTrigger
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    UPDATE employees
    SET salary = (SELECT MAX(salary) FROM employees WHERE department_id = NEW.department_id)
    WHERE emp_id = (SELECT manager_id FROM departments WHERE department_id = NEW.department_id);
END;
//
DELIMITER ;


-- 6.
DELIMITER //
CREATE TRIGGER PreventUpdateDepartmentTrigger
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    DECLARE project_count INT;
    SELECT COUNT(*) INTO project_count
    FROM works_on
    WHERE emp_id = NEW.emp_id;
    IF project_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot update department for employee with assigned projects';
    END IF;
END;
//
DELIMITER ;


-- 7.
DELIMITER //
CREATE TRIGGER UpdateAverageSalaryTrigger
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    DECLARE avg_salary DECIMAL(10, 2);
    SELECT AVG(salary) INTO avg_salary
    FROM employees
    WHERE department_id = NEW.department_id;
    UPDATE departments
    SET average_salary = avg_salary
    WHERE department_id = NEW.department_id;
END;
//
DELIMITER ;


-- 8.
DELIMITER //
CREATE TRIGGER DeleteWorksOnTrigger
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    DELETE FROM works_on WHERE emp_id = OLD.emp_id;
END;
//
DELIMITER ;


-- 9.
DELIMITER //
CREATE TRIGGER PreventInsertEmployeeTrigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    DECLARE min_salary DECIMAL(10, 2);
    SELECT minimum_salary INTO min_salary
    FROM departments
    WHERE department_id = NEW.department_id;
    IF NEW.salary < min_salary THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee salary cannot be less than department minimum';
    END IF;
END;
//
DELIMITER ;


-- 10.
DELIMITER //
CREATE TRIGGER UpdateTotalBudgetTrigger
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    DECLARE total_salary DECIMAL(10, 2);
    SELECT SUM(salary) INTO total_salary
    FROM employees
    WHERE department_id = NEW.department_id;
    UPDATE departments
    SET total_salary_budget = total_salary
    WHERE department_id = NEW.department_id;
END;
//
DELIMITER ;


-- 11.
-- create table email_queue
CREATE TABLE email_queue (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recipient_email VARCHAR(255) NOT NULL,
    subject VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- trigger
DELIMITER //
CREATE TRIGGER NewEmployeeNotificationTrigger
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    DECLARE recipient_email VARCHAR(255);
    DECLARE subject VARCHAR(255);
    DECLARE message TEXT;

    SET recipient_email = 'hr@example.com'; -- Change this to the HR email address
    SET subject = 'New Employee Hired';
    SET message = CONCAT('A new employee has been hired. Name: ', NEW.first_name, ' ', NEW.last_name, ', ID: ', NEW.emp_id);

    INSERT INTO email_queue (recipient_email, subject, message)
    VALUES (recipient_email, subject, message);
END;
//
DELIMITER ;

-- python code to sent emails (read data from email_queue)
-- import smtplib
-- import mysql.connector
-- from email.message import EmailMessage

-- # Connect to the database
-- db = mysql.connector.connect(
--     host="your_host",
--     user="your_username",
--     password="your_password",
--     database="your_database"
-- )
-- cursor = db.cursor()

-- # Select unsent emails from the email_queue table
-- cursor.execute("SELECT id, recipient_email, subject, message FROM email_queue WHERE sent_at IS NULL")
-- emails = cursor.fetchall()

-- # Send emails
-- for email in emails:
--     msg = EmailMessage()
--     msg.set_content(email[3])
--     msg["Subject"] = email[2]
--     msg["From"] = "your_email@example.com"  # Change this to your email address
--     msg["To"] = email[1]

--     try:
--         # Send the email
--         with smtplib.SMTP("smtp.yourmailserver.com", 587) as smtp:
--             smtp.starttls()
--             smtp.login("your_email@example.com", "your_password")  # Change this to your email and password
--             smtp.send_message(msg)

--         # Mark the email as sent in the database
--         cursor.execute("UPDATE email_queue SET sent_at = CURRENT_TIMESTAMP WHERE id = %s", (email[0],))
--         db.commit()
--     except Exception as e:
--         print(f"Failed to send email: {e}")

-- # Close the database connection
-- cursor.close()
-- db.close()




-- 12.
DELIMITER //
CREATE TRIGGER PreventInsertDepartmentTrigger
BEFORE INSERT ON departments
FOR EACH ROW
BEGIN
    IF NEW.location IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Location must be specified for a new department';
    END IF;
END;
//
DELIMITER ;


-- 13.
DELIMITER //
CREATE TRIGGER UpdateEmployeeDepartmentNameTrigger
AFTER UPDATE ON departments
FOR EACH ROW
BEGIN
    UPDATE employees
    SET department_name = NEW.department_name
    WHERE department_id = NEW.department_id;
END;
//
DELIMITER ;


-- 14.
CREATE TABLE employee_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    operation_type VARCHAR(10) NOT NULL,
    emp_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    salary DECIMAL(10, 2),
    department_id INT,
    operation_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER EmployeeAuditTrigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (operation_type, emp_id, first_name, last_name, salary, department_id)
    VALUES ('INSERT', NEW.emp_id, NEW.first_name, NEW.last_name, NEW.salary, NEW.department_id);
END;
//

CREATE TRIGGER EmployeeAuditTriggerUpdate
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (operation_type, emp_id, first_name, last_name, salary, department_id)
    VALUES ('UPDATE', OLD.emp_id, OLD.first_name, OLD.last_name, OLD.salary, OLD.department_id);
END;
//

CREATE TRIGGER EmployeeAuditTriggerDelete
BEFORE DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (operation_type, emp_id, first_name, last_name, salary, department_id)
    VALUES ('DELETE', OLD.emp_id, OLD.first_name, OLD.last_name, OLD.salary, OLD.department_id);
END;
//

DELIMITER ;


-- 15.
DELIMITER //
CREATE TRIGGER GenerateEmployeeIdTrigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    DECLARE next_id INT;
    SET next_id = (SELECT COALESCE(MAX(emp_id), 0) + 1 FROM employees);
    SET NEW.emp_id = next_id;
END;
//
DELIMITER ;

