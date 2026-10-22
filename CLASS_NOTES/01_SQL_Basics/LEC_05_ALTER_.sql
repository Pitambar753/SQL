
# ---------------------------- UPDATE --------
select * from employees;
UPDATE employees SET email= 'KING@GMAIL.COM'   # 
WHERE EMPLOYEE_ID = 100;

UPDATE employees SET email= 'NEENA@GMAIL.COM', hire_date=curdate()   # 
WHERE EMPLOYEE_ID = 101;

UPDATE employees SET SALARY= SALARY_   # 
WHERE EMPLOYEE_ID = 100;

UPDATE employees SET SALARY  = SALARY + 2500;

SELECT  * FROM employees WHERE TIMESTAMPDIFF(YEAR ,CURDATE(),hire_date)<=20 ;
# Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ')' at line 1
set sql_safe_updates=0;

UPDATE employees 
SET avl = 'NONACTIVE'
WHERE (COMMISSION_PCT = 0.0 AND avl = 'ACTIVE');

# ----------------------- table
CREATE TABLE emp_update SELECT * FROM employees;
TRUNCATE emp_update;
DESC emp_update;

ALTER TABLE emp_update MODIFY email VARCHAR(50) NULL, MODIFY PHONE_NUMBER INT NULL ;
ALTER TABLE emp_update ADD PRIMARY KEY (employee_id);


# -----------------------------DIFF ->ALTER AND UPDATE ------------------
#------------- ALTER -> ALTER MADE changes IN THE columns or by columns like add, drop , constrantint
# ------------ update -> update work on the row wise data delete or add the values 


CREATE TABLE cust(
  cust_id INT AUTO_INCREMENT PRIMARY KEY,
  cust_name VARCHAR(200) NOT NULL,
  address VARCHAR(200)  
);

CREATE TABLE order1(
	order_id INT PRIMARY KEY,
    cus_id INT,
    order_name VARCHAR(255),
    CONSTRAINT order1_fk FOREIGN KEY(cus_id) 
    references cust(cust_id)
);
ALTER TABLE order1 reneame


 