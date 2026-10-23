use hr;


#######################============-- Stored Functions (MySQL) – Quick Revision Guide====================####################
## --> A stored function is a reusable database object that:
-- Accepts input parameters
-- Performs operations
-- Returns exactly ONE value
#################-- Key Characteristics
-- ✔ Returns single scalar value
-- ✔ Can be used in SELECT, WHERE, ORDER BY
-- ✔ Stored in DB and reused
-- ✔ Mostly uses IN parameters only

########### SYNTAX
/*DELIMITER $$
CREATE FUNCTION function_name(param1 datatype, param2 datatype)
RETURNS return_datatype
[DETERMINISTIC | NOT DETERMINISTIC]
[READS SQL DATA | MODIFIES SQL DATA | NO SQL]
BEGIN
    DECLARE variable_name datatype;

    -- logic

    RETURN value;
END$$

DELIMITER ;*/

#################======================= Step-by-Step Working ======================########################
--           [1] --> CREATE FUNCTION get_full_name(emp_id INT);
--         You are creating a function named get_full_name
--         It takes one input parameter:
--         👉 emp_id (employee ID)
--          [2]--> RETURNS VARCHAR(100)
--          Function will return a string
--           Max length = 100 characters
--           [3]DETERMINISTIC
--           Same emp_id → always same result
--           get_full_name(101) → "John Smith" (always same)
--            4. Declare Variable
--            DECLARE name VARCHAR(100);
-- 				A local variable name is created
-- 			It will store the full name
--            5. Fetch Data from Table
-- 		SELECT CONCAT(first_name,' ',last_name)
-- 		INTO name
-- 		FROM employees
-- 		WHERE employee_id = emp_id;
--           
-- 				A local variable name is created
-- 			It will store the full name










DELIMITER $$
CREATE FUNCTION get_full_name(emp_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE name VARCHAR(100);

    SELECT CONCAT(first_name,' ',last_name)
    INTO name
    FROM employees
    WHERE employee_id = emp_id;

    RETURN name;
END;;
$$
DELIMITER ;
SELECT  get_full_name(100);
SELECT * FROM employees;



### GET DEPT CURRRENT BUGET \
SELECT * FROM hr.employees;
SELECT * FROM hr.departments;
DELIMITER $$
CREATE FUNCTION get_full(dep_id1 INT)
RETURNS INT
DETERMINISTIC 
BEGIN 
	DECLARE total_salary INT  ;
    SELECT SUM(SALARY) INTO total_salary
    FROM employees
    WHERE dep_id = dep_id1;
    RETURN total_salary;
END;;
$$
DELIMITER ;
SELECT get_full(90);
SELECT get_full (60);
select get_full(dep_id) from employees;


########## simple -->get dept and empl_name\
DROP FUNCTION get_name_emp;
select * from employees;
delimiter $$
CREATE FUNCTION get_name_empl(emp_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC 
BEGIN 
	DECLARE def_NAME VARCHAR(100);
	select CONCAT(e.FIRST_NAME ,' - ',d.DEPARTMENT_NAME)  INTO  def_NAME
    from employees e
	join departments d
	on e.dep_id = d.DEPARTMENT_ID
    WHERE EMPLOYEE_ID = emp_id;
    RETURN def_NAME;
END;;
$$ 
DELIMITER ;

SELECT get_name_empl(101);
show function status;
drop function get_full_name;

##############################=====================Stored Procedure==================###############################
-- It may or may NOT return a value
-- It can return multiple outputs
-- It is executed using CALL
############-- Basic Syntax
/*DELIMITER $$

CREATE PROCEDURE procedure_name(IN param1 datatype)
BEGIN
    -- SQL statements
END$$

DELIMITER ;*/
DELIMITER $$
CREATE PROCEDURE get_salary_proc(IN emp_id INT)
BEGIN
    SELECT salary
    FROM employees
    WHERE employee_id = emp_id;
END$$

DELIMITER ;
CALL get_salary_proc(102);


	
    
#####################=============== SQL =============############################
SELECT * FROM employees;
CREATE VIEW emp_name_dept  AS SELECT distinct department_id, employee_id ,
CONCAT (first_name ,' ',last_name ) AS full_name 








