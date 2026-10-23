use campusx;

#====================================== WINDOWS FUNCTION ====================
-- SQL window functions allow performing calculations across a set of rows that are related to the current row, without collapsing the result into a single value. 
-- They are commonly used for tasks like aggregates, rankings and running totals.
-- The OVER clause defines the “window” of rows for the calculation. It can:

# ---------------- PARTITION BY: It divides the data into groups using PARTITION BY.
# ----------------- ORDER BY: It specifies the order of rows within each group using ORDER BY


# ====================================== PARTITION BY Clause ====================
-- The PARTITION BY clause in MySQL divides the result set into smaller groups so calculations can be performed independently within each group. 
-- It is mainly used with window functions to analyze related rows without affecting the entire dataset.

-- Used with window functions like RANK(), DENSE_RANK(), LEAD(), and LAG()
-- Creates partitions (also called windows) within the result set.
-- Each partition is processed separately for calculations.
-- If omitted, the whole table is treated as a single partition.
########### SYNTAX------
/* window_function(expression)
OVER (
    PARTITION BY column_name
    [ORDER BY column_name]
    [frame_clause]
)*/
-- window_function(expression): Defines the window function and the column or value it operates on.
-- OVER(): Specifies how the function should be applied across rows.
-- PARTITION BY column_name: Divides rows into groups where calculations run separately.
-- ORDER BY / frame_clause: Controls row order and the subset of rows used within each partition (Optional



###################################=========Window Functions in SQL==========##########################################
/*SELECT column_name1, 
       window_function(column_name2) 
       OVER ([PARTITION BY column_name3] [ORDER BY column_name4]) AS new_column
FROM table_name;*/

-- window_function: Aggregate or ranking function (SUM(), AVG(), ROW_NUMBER(), etc.)
-- column_name1: Column(s) to display
-- column_name2: Column used by the window function
-- column_name3: Column for grouping (PARTITION BY)
-- column_name4: Column for ordering (ORDER BY)
-- new_column: Alias for the window function result
-- table_name: Table to select data from



########### WHERE YOU need to find newly or latest joined employee 
select * from hr.employees;


#####################===== remove employee+deparment  -- duplicate  () read
with emp as(
select EMPLOYEE_ID,FIRST_NAME,dep_id,
ROW_NUMBER() OVER ( PARTITION BY FIRST_NAME,dep_id ) AS AS_REM FROM hr.employees)
SELECT *  FROM emp
WHERE AS_REM;















##################################============= CLASS OF CAMPUSX ==============######################
SELECT AVG(SALARY)   FROM hr.employees; # WHEN ONLY USE AGGREATE FUN THE ONLY ONE ANS IS GIVE 
SELECT EMPLOYEE_ID , avg(SALARY)  OVER () FROM hr.employees; # WHEN USE  (OVER ()) CALUSE -->> THEN GIVE EVERY ROW KO AVG VALUE SAME DETA HAI  ===>> THEY ACT LIKE WINDOWS FUNCTION
--SELECT *   OVER () FROM hr.employees; # ==>> Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'OVER () FROM hr.employees' at line 1

###########===== PARTITION BY ========##########
DESC employees;
SELECT * FROM hr.employees;
SELECT FIRST_NAME,dep_id,JOB_ID, AVG(SALARY) OVER(partition by JOB_ID )  as salary FROM hr.employees; # JOB ID VISE AVG SALARY DILE AHE 


############### QUE.1======>>>> FIND -> USA EMP KO JISAKI SALARY  AVG SALARY SE JADA USA EMP KO  
SELECT * FROM (SELECT FIRST_NAME, dep_id, SALARY, JOB_ID,
 AVG(SALARY) 
 OVER(partition by JOB_ID ) AS 'AVG_SALARY' 
 FROM hr.employees
)   AS E1
WHERE E1.SALARY>E1.AVG_SALARY;

#################################===== RANK() Function =======################################
SELECT * FROM campusx.markS;
SELECT *,
RANK() OVER(partition by branch order BY marks DESC) FROM campusx.marks; ### OVERALL TABALE  VAR RANK LAVAL AHE 

#====== ======= BRANCH VISE RANK SHOW KARANAR AHE ATA  VAR RANK LAVAL AHE
 SELECT *,
RANK() OVER(partition by branch ORDER BY marks DESC) FROM marks;    ## Skips rank after tie
### -- 9	Vinay	ECE	95	RANK(1)   THIS IS RANK FUNCTION 
### -- 12	Rohit	ECE	95	RANK(1)    THIS IS RANK FUNCTION  THEY BOTH 
###  --10	Ankit	ECE	88	RANK(3)     which may skip rank numbers when there are ties --> IT'S CALLED RANK FUNCTION  

#################################===== DENSE_RANK Function =======################################

 SELECT *,
DENSE_RANK() OVER(partition by branch ORDER BY marks DESC) FROM marks;   ## No skipping
## -- 9	   Vinay	ECE	95	1   THIS IS RANK FUNCTION IS THE 
## -- 12	Rohit	ECE	95	1   THIS IS RANK FUNCTION 
## -- 10	Ankit	ECE	88	2    always returns consecutive rank values --> IT'S CALLED  DENSE RANK FUNCTION


#################################===== ROW_NUMBER() =======################################
SELECT *,
ROW_NUMBER() OVER() FROM marks;
#====== ======= BRANCH VISE RANK SHOW KARANAR AHE ATA  VAR RANK LAVAL AHE
SELECT *,
ROW_NUMBER() OVER(partition by branch) FROM marks;

## ==== CONCAT FUNCTION USING INSIDE THIS 
SELECT *,
CONCAT(branch,'-',ROW_NUMBER() OVER(partition by branch))  # ENGINE SORTING KART AHE NAHI TAR HOT NAHI 
 FROM marks;
 
 
 ### ----------------FIND TOP 2 MOST movie  OF EACH MONTH 
 desc movie_db.tmdb_movies;
 select * from movie_db.tmdb_movies;
 select year(release_date) from movie_db.tmdb_movies;
 SELECT original_title, month(release_date),vote_count,
 dense_rank() over(partition by month(release_date) order by vote_count desc) as rank_no FROM movie_db.tmdb_movies
 where month(release_date) = 5
 order by  month(release_date)limit 2;
 
 
 
 
 
 
 
 
 
