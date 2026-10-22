# ------------------ NULL-------






# -- even employee_id -- number
SELECT employee_id,first_name,salary, 
	case when employee_id%2 = 0 then 'even EMP ID'
    else 'odd EMP ID'
    END AS eve_emp_id
    from hr.employees;

#- ------  
SELECT employee_id,first_name,salary, 
	case when employee_id%2 = 0 then 'even EMP ID'
    else 'odd EMP ID'
    END AS eve_emp_id
    from hr.employees;

use hr;
SELECT employee_id,first_name,salary,hire_date from employees where hire_date ='1987-06-17';

select * from employees;
SELECT employee_id,first_name,salary,hire_date from employees where first_name between 'A' and 'F' order by first_name;
SELECT employee_id,first_name,salary,hire_date,deparment_id,deparment_id from employees where deparment_id <>90;


# find the emp who not 
SELECT employee_id,first_name,salary,hire_date from employees where employee_id between 100 and 105 order by employee_id;
SELECT employee_id,first_name,salary FROM employees where salary<2100 or salary>2500;

# ---------------------------------- NORTHWIND START -----------------
USE northwind;
SELECT * FROM products;
use southwind;
SELECT * FROM products;
SELECT minimum_reorder_quantity FROM products 
WHERE minimum_reorder_quantity BETWEEN 5 AND 30;

SELECT * FROM products 
WHERE minimum_reorder_quantity BETWEEN 5 AND 30;


# FIND THE EMP WHO HAVE HIRE TEM 1987-07-01 AND 1987-08-01
USE hr;
SELECT * FROM employees;
SELECT HIRE_DATE FROM employees
WHERE HIRE_DATE BETWEEN '1987-07-01' AND '1987-08-01';

#  ----------- EXAMPLE 1
SELECT serial_num, EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, dep_id, bouns, avl
FROM employees 
WHERE SALARY>10000
	ADD DEPARMENT_ID  IN  (80,90,100)
    ORDER BY SALARY DESC;



