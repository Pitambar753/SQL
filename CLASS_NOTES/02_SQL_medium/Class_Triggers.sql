create database triggers_data;
use triggers_data;



###############=====================[What is a Trigger================###################

####-- A trigger is a special type of stored program in a database that automatically runs when a specific event happens on a table or view.
####-- 👉 You don’t call a trigger manually — it runs automatically when something happens like:
###-- INSERT (adding data)
###-- UPDATE (modifying data)
###-- DELETE (removing data)

########## SYNTAX+++++++==
/*CREATE TRIGGER trigger_name
BEFORE/AFTER INSERT/UPDATE/DELETE
ON table_name
FOR EACH ROW
BEGIN
   -- trigger logic
END;*/

CREATE TABLE salary_history (
    emp_id INT,
    first_name VARCHAR(50),
    old_salary DECIMAL(10, 2),
    new_salary DECIMAL(10, 2),
    department_id INT
);


CREATE TABLE employee (
  employee_id INT,
  name VARCHAR(50),
  salary FLOAT,
  department_id INT
);


INSERT INTO employee (employee_id, name, salary, department_id)
VALUES
  (1, 'John Smith', 50000.0, 101),
  (2, 'Jane Doe', 60000.0, 102),
  (3, 'Bob Johnson', 55000.0, 101),
  (4, 'Mary Brown', 65000.0, 103),
  (5, 'Tom Davis', 70000.0, 102);
  
  
  Before Insert:
delimiter $$
create trigger before_insert_into_employee
before insert on employee
for each row
begin
	-- new === this take new value 
    -- old == this take old vvalues in the table
    if new.salary is null then
		set new.salary=15000.0;
	end if;
    
end;;
$$
delimiter ;
select * from triggers_data.employee;
insert into employee(employee_id,name,department_id)
values(6,'karaan',101)  # madhe apan employee salary dile nahi mag te value nulll zali -->> apopa tya vlue madhe 15000 geli yala 


###############NEW EXAPLE
DELIMITER $$
CREATE TRIGGER before_insert_into_employee_eg2
before insert on employee
for each row 
begin 
	if new.department_id is null then 
		set new.department_id = 100;
	end if;
end;;
$$
delimiter ;
select * from employee;
insert into employee (employee_id,name)
value(7,'xyz1')



########## example 3
delimiter $$
create trigger before_insert_into_employee_eg3
before insert on employee
for each row
begin
	
    if new.email not like '%@%' then
		signal SQLSTATE '45000'
			set message_text="Invalid email type";
        
	end if;
    
end;;
$$
delimiter ;
INSERT INTO employee (employee_id, name)
VALUES(7, ' Will Smith');
select * from employee;



#################example 4) AFTER TRIGGER (Explained + Execution)
select * from employee;
CREATE TABLE employee_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255),
    log_timetamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER after_insert_employee
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
    INSERT INTO employee_log(message)
    VALUES (CONCAT('a employee has been inserted with  employee ID: ', NEW.employee_id));
END$$

DELIMITER ;

INSERT INTO employee VALUES (10, 'John Doe', 50000, 101);
INSERT INTO employee(employee_id,name,salary) 
values(1230,'jhon doe',50000.00);
select * from employee_log;
select * from employee;


############## employee table employee_email data to data insert zal aka nahi check karto

CREATE TABLE employee_emails (
    emp_id INT,
    email VARCHAR(100),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Trigger to auto-generate email when employee is inserted
DELIMITER $$
CREATE TRIGGER trg_generate_email
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
    -- Generate email: firstname.employeeid@company.com
    INSERT INTO employee_emails (emp_id, email)
    VALUES (
        NEW.employee_id,
        CONCAT(LOWER(REPLACE(NEW.name, ' ', '.')), 
               '@company.com')
    );
END$$
DELIMITER ;


INSERT INTO employee (employee_id, name, salary, department_id)
VALUES (78, 'Yogesh', 80000.0, 101);
INSERT INTO employee (employee_id, name, salary, department_id)
VALUES (75, 'pitambar salagre ', 5000, 102);
selecT * from employee;
select * from employee_emails;


############## 5 delete in table before insert delete 
create table deleted_emp(
emp_id int,
name varchar(50),
salary int ,
depament_id int,
deleted_by varchar(155)
);
select * from deleted_emp;

DELIMITER $$
CREATE TRIGGER trg_generate_email1
before delete  ON employee
FOR EACH ROW
BEGIN
    -- Generate email: firstname.employeeid@company.com
    INSERT INTO deleted_emp (
    emp_id ,
	name ,
	salary ,
	depament_id ,
	deleted_by )
    VALUES (
        old.employee_id,
        old.name,
        old.salary,
        old.department_id,
        user()     -- current mysql use
    );
END$$
DELIMITER ;

select * from employee;
select * from triggers_data.deleted_emp;


############# exampl6

DELIMITER $$
CREATE TRIGGER before_employee_delete
before  delete ON employee
FOR EACH ROW
BEGIN
    if datediff(now(),old.hire_date)>3650 then 
		signal sqlstate '45000' set message_text  = 'cannot delete employee - haas been with ';
        end if ;
END$$
DELIMITER ;


############ example 6
CREATE TABLE admin_notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255),
    notification_type VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DELIMITER $$

CREATE TRIGGER trg_notify_after_delete
AFTER DELETE ON employee
FOR EACH ROW
BEGIN
    INSERT INTO admin_notifications (message, notification_type)
    VALUES (
        CONCAT('Employee ', OLD.name, ' (ID: ', OLD.employee_id, 
               ') has been removed from the system'),
        'EMPLOYEE_DELETED'
    );
END$$
DELIMITER ;

DELETE FROM employee WHERE employee_id = 4;

-- Check notifications
SELECT * FROM admin_notifications;

##################### ================== before Update ================ ##############
DELIMITER $$

CREATE TRIGGER trg_before_salary_update
BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
    -- Prevent salary decrease
    IF NEW.salary < OLD.salary THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Salary cannot be decreased!';
    END IF;
    
    -- Prevent salary increase more than 20%
    IF NEW.salary > (OLD.salary * 1.20) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Salary increase cannot exceed 20%!';
    END IF;
END$$

DELIMITER ;

-- This will FAIL (salary decrease)
select * from employee;
UPDATE employee 
SET salary = 50000 
WHERE employee_id = 1;
-- Error: Salary cannot be decreased!

-- This will FAIL (increase > 20%)
UPDATE employee 
SET salary = 70000 
WHERE employee_id = 1;  -- Current: 50000
-- Error: Salary increase cannot exceed 20%!

-- This will SUCCEED (10% increase)
UPDATE employee 
SET salary = 500
WHERE employee_id = 900;
-- Success



###################--------AFTER UPDATE
DELIMITER $$

CREATE TRIGGER after_salary_update
AFTER UPDATE ON employee
FOR EACH ROW
BEGIN
    IF OLD.SALARY <> NEW.SALARY THEN
        INSERT INTO salary_history (emp_id, first_name, old_salary, new_salary, department_id)
        VALUES (OLD.employee_id, OLD.NAME, OLD.SALARY, NEW.SALARY, OLD.DEPARTMENT_ID);
    END IF
END $$

DELIMITER 


select * from triggers_data.salary_history; 

show triggers;



