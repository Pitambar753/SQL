
-- When to Use COMMIT and ROLLBACK
-- Use COMMIT when all operations in a transaction are successful and we want to save changes permanently.
-- Use ROLLBACK when an error occurs, or the transaction needs to be aborted, ensuring the database remains unaffected by partial or incorrect updates.


# ------------------------ all rows ko import karana hai dekhana hai to (*) MEANS ALL COL
SELECT * FROM campusx.smartphones WHERE 1;  # WHERE 1 -> means you are not applying any conditions in rows 

# ------------------------ FILTER COLU -> MEANS SPECIFIC COLU import table from
SELECT model,price,rating FROM campusx.smartphones;

# ----------------------- alias -> renaming cols
SELECT os AS  'operating system',model,battery_capacity AS 'MAH' FROM campusx.smartphones; 

# ---------------------- create expression using cols
SELECT model,rating/10 FROM campusx.smartphones;

# ---------------------- constants -> type name ka colu is create kela in there colu every row madhe constant value was inserted 'smartphone'  
SELECT model, 'smartphone' AS 'type' FROM campusx.smartphones;

# ---------------------- Distinct (unique) value from a col -> unique value pahayacha asetal tar use the disinct 
SELECT DISTINCT(brand_name) 
AS 'all_brands' FROM campusx.smartphones;  # kontya tya  col chi value unique pahayachi asel tar use DISTINCT(column_name ) kontya col cha name pahayacvh ahe tya col cha name

SELECT DISTINCT(os)  AS 'all_os' FROM campusx.smartphones; # duplicate value delete hotya and only unique value rahatya 

SELECT DISTINCT brand_name,processor_brand  # combination col (unique)  values give you -> combination of unique values 
FROM campusx.smartphones;

# ---------------------- Filter rows where clause
SELECT * FROM campusx.smartphones
WHERE brand_name = 'samsung';             # it will give you only samsung wale rows 

SELECT * FROM campusx.smartphones
WHERE brand_name = 'apple';            # he kay karto purn table madhe searcha karto and apple wale row show karto 
 
 # ---------------------- Filter rows where clause
 SELECT * FROM campusx.smartphones
 WHERE 50000>price;
  SELECT * FROM campusx.smartphones
 WHERE price>10000;
 
 # ---------------------- BETWEEN
 SELECT * FROM campusx.smartphones
 WHERE price>10000 AND price<20000; # in between 10000 to 20000
 
 SELECT * FROM campusx.smartphones
WHERE price BETWEEN 10000 AND 20000;  # using BETWEEN  operator

# --------------------- find phone 
SELECT * FROM campusx.smartphones
WHERE price<25000 AND rating > 80;

SELECT * FROM campusx.smartphones
WHERE price<15000 AND rating > 80 AND processor_brand = 'snapdragon';

SELECT * FROM campusx.smartphones
WHERE brand_name = 'samsung' AND ram_capacity > 8;

SELECT * FROM campusx.smartphones
WHERE brand_name = 'samsung' AND processor_brand = 'snapdragon';


# ----------------- QUEARY execution order 
SELECT DISTINCT (brand_name) FROM campusx.smartphones
WHERE price>50000;

# ----------------- (in) and  (NOT IN)  

SELECT * FROM campusx.smartphones
WHERE processor_brand = 'snapdragoan' OR processor_brand = 'exynos' OR processor_brand = 'bionic'; 
SELECT * FROM campusx.smartphones
WHERE processor_brand IN ('snapdragoan','exynos','bionic');

SELECT * FROM campusx.smartphones
WHERE processor_brand NOT IN ('snapdragoan','exynos','bionic');

# -------------------------------------------- UPDATE QUEARY START 
UPDATE campusx.smartphones
SET processor_brand = 'DIMENSITY'
WHERE processor_brand = 'MEDIATEK';





# ----------------------------------------------- DELETE QUEARY START





# --------------------------- AGGREGATE FUNCTION --------------------
USE hr;
SELECT * FROM employees;

# ---------------------- COUNT FUNCTION START 
SELECT COUNT(*) FROM employees;

USE southwind;
SELECT * FROM orders;
select count(distinct (employee_id)) FROM orders
WHERE customer_id IS NOT NULL;

#----COUNT CUSTOMER NO OF  FROM NEW WORK CITY
SELECT * FROM customers;
SELECT first_name , COUNT(city) FROM customers
WHERE city = 'New York';

# -- ORDERE CITY COUNT CUSTOMER NO OF  FROM NEW WORK CITY
SELECT * FROM orders;
SELECT customer_id, COUNT(DISTINCT customer_id) FROM orders
WHERE ship_city = 'New York'
group by customer_id;


# ----------------------- SUM 

SELECT SUM(shipping_fee) FROM orders;
# ------- 1)FIND THE TOTAL REV GEN BY COMPANY
select sum(quantity*unit_price) from order_details;


# ============================== AVG
select avg(unit_price)  as  avg_unit from order_details;
# find avg order, quantity, 
select * from order_details;
select avg(unit_price)  as  avg_unit, avg(quantity) from order_details;


# ============================= MIN AND MAX
select * from order_details;
select min(unit_price) as minum_unit , max(unit_price) as max_unit from order_details;





# ============================= function of STRING FUNCTION STAR =====================
SELECT * FROM employees;
select upper(FIRST_NAME) from employees;
select lower(FIRST_NAME) from employees;
select FIRST_NAME,length(FIRST_NAME) from employees;
select FIRST_NAME,concat(FIRST_NAME,'-',LAST_NAME) from employees;
select FIRST_NAME,concat_ws('-',FIRST_NAME,LAST_NAME) from employees;
select FIRST_NAME,concat_ws('--',FIRST_NAME,LAST_NAME,SALARY,dep_id,bouns) from employees;
select FIRST_NAME,concat_ws(FIRST_NAME,'--',LAST_NAME,'--',SALARY,'--',dep_id,'--',bouns) as all_name from employees;


# ------- SUBSTRING
select FIRST_NAME,substring(FIRST_NAME,1,3) from employees;
select FIRST_NAME,substring(FIRST_NAME,0,2) from employees; # its not showing anything 
# ------- left
select FIRST_NAME, left(FIRST_NAME,3) from employees;
select FIRST_NAME, left(FIRST_NAME,1) from employees;

# ------right
select FIRST_NAME, right(FIRST_NAME,1) from employees;
select FIRST_NAME, right(FIRST_NAME,3) from employees;  # right give you the -> right side of the 

# --------- replaces
select FIRST_NAME, replace(PHONE_number,'.','-') from employees;  #  in the replaces function -> replace (column_name ,old_value,new_value)

# ----------- instr
select PHONE_number, instr(PHONE_number,'.') from employees;

# ----------- reverse
select FIRST_NAME, reverse(FIRST_NAME)from employees;
select FIRST_NAME, reverse(FIRST_NAME)from employees;

# ------------- repeat 
select * from employees;
select FIRST_NAME, repeat('*',floor(SALARY/5000)) as star from employees
order by star desc;
select FIRST_NAME, floor(SALARY/5000) as star from employees



 
