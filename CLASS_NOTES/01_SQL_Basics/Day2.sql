show databases;
use feb26;
show tables;

# ---------					# new table 

create table employee_num(
	emp_id int,
    emp_name varchar(20),
    salary float,
    bouns decimal
);
insert into employee_num value(1,'seema',2300,2000.0);
select * from employee_num;
select length(salary), length(bouns) from employee_num; 


#---------------------------------new table float and decimal data type
 create table employee_num1(
	emp_id int,
    emp_name varchar(20),
    salary float(5,2),
    bouns decimal(4,1)
);
insert into employee_num1 value(-10,'check neg',-230,2000.0); # Error Code: 1264. Out of range value for column 'bouns' at row 1
insert into employee_num1 value(-10,'check neg',-230,200.0); # error code 
select * from employee_num1;
select salary, salary/0 from employee_num1;


 # ---------------------- data type -> date , datetime, timestamp, timestamp --------------
 create table emp_date(
 emp_id int,
 emp_name varchar(30),
 dod date,
 doj datetime,
 login_time timestamp,
 exp_year year
 );
 
 insert into emp_date(emp_id, emp_name, dod ,doj , login_time , exp_year) value(12,'abc','2000-09-25','2026-02-25 08:02:00',now(),2026);
 select * from  emp_date;
 
 select now();
 select curdate();
 select curtime();
 select utc_timestamp();
 
 select year(dod), month(dod), date(dod), dayname(dod) from emp_date; 
 # Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '(dob) from emp_date' at line 1
select hour(doj),minute(doj),second(doj) from emp_date;

-- diff
select datediff(curdate(),dod) as age from emp_date; # curdate - dod -> date differnces
select timestampdiff(day,dod,now()) from emp_date;
select timestampdiff(year,dod,now()) from emp_date;
select timestampdiff(week,dod,now()) from emp_date;



#----------------------- data type -> virtual 
drop table to_check_virtual;
 create table to_check_virtual
 (
 f_name varchar(30),
 l_name varchar(30),
	full_name varchar(100) generated always as 
    (concat(f_name,' ',l_name))  virtual
 );
--  select * from to_check_virtual;
 insert into to_check_virtual(f_name,l_name) value('pitu','salgare');
 
 select * from to_check_virtual;
  
# ---------------- virtual 
-- Avoid data duplication   --> example ->Instead of storing total = price × quantity, you just calculate it when needed.
-- Save storage space       --> example -> Since the value is not stored, it doesn’t use extra disk space
-- Automatic updates          --> example -> Whenever base data changes, the virtual column updates automatically.

CREATE TABLE sales (
    price DECIMAL(10,2),
    quantity INT,
    total DECIMAL(10,2) AS (price * quantity) VIRTUAL
);

INSERT INTO sales (price, quantity)
VALUES (100, 2);
#             -- total is calculated on the fly
#             -- ✔ It is not stored in the table
SELECT price, quantity, total FROM sales;

# --------------------------- new tabele 1
create table to_check_virtual2(
f_name varchar(30),
l_name varchar(30),
dob date,
doj date,
full_name varchar(100) generated always as 
(concat(f_name ,' ',l_name)) virtual,
age int generated always as(datediff(doj,dob)/365) virtual,
salary int ,
bonus int ,
increment decimal (4,2),
new_salary int generated always as (salary+((salary+bonus)*increment)) virtual
);
select * from to_check_virtual2; 

insert into to_check_virtual2(f_name ,l_name ,dob,doj,salary,bonus,increment) 
values ('shubham','joshi','2002-09-26','2026-09-26',25000,2000,.15);



# ------------------------- new table data type is json format
create table to_use_json(
f_name varchar(30),
l_name varchar(30),
dob date,
doj date,
full_name varchar(100) generated always as 
(concat(f_name ,' ',l_name)) virtual,
age int generated always as(datediff(doj,dob)/365) virtual,
salary int ,
bonus int ,
increment decimal (4,2),
new_salary int generated always as (salary+((salary+bonus)*increment)) virtual,
skill_set json
);
select * from to_use_json; 
insert into to_use_json(f_name,l_name,skill_set)
values ('pitu','salgare',
'{"skill":["python","java"], "certificate":["aws cloud","pyhton hackerank"],"edu":"cdac"}');

select full_name,
	skill_set ->> '$.skill[0]' as skills,    # aliasa
    skill_set ->> '$.edu' as education from to_use_json;
    
-- select full_name,
-- 	skill_set ->> '$.skill[0]' skill,
--     skill_set ->> '$.edu' as education from to_use_json;

select full_name,
skill_set ->> '$.skill' as skill,
skill_set ->> '$.certificate[1]' as j1 from to_use_json;



# -------------------------- New table 5
create table to_use_json(
f_name varchar(30),
l_name varchar(30),
dob date,
doj date,
full_name varchar(100) generated always as 
(concat(f_name ,' ',l_name)) virtual,
age int generated always as(datediff(doj,dob)/365) virtual,
salary int ,
bonus int ,
increment decimal (4,2),
new_salary int generated always as (salary+((salary+bonus)*increment)) virtual,
skill_set json
);





