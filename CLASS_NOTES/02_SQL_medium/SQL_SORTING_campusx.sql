
SELECT * FROM campusx.smartphones;
# ======================================================= ORDER BY ========================================
# ORDER BY  USE --> IT IS USE FOR THE SORTING 
# LIMIT (NO)  -> IS USE FOR TOP NO ROW SHOW  (NO MANY ROWS YOU WANT THAT WHY USE THIS LIMIT NO)-> HOW MANY TOP ROW YOU WANT
SELECT model,screen_size FROM campusx.smartphones WHERE brand_name = 'samsung'
ORDER BY screen_size DESC  LIMIT 5;  #ORDER BY screen_size  --> BY DEFAULT ASSENDING ORDER AHE

#---------- SORT ALL THE PHONE IN DESCENDING  ORDER OF NO OF TOTAL CAMERA
SELECT num_rear_cameras+num_front_cameras AS 'TOTAL_CAMERA' , model  FROM campusx.smartphones
ORDER BY TOTAL_CAMERA DESC;

# ------------- SORT DATA ON THE BASIC OF PPI IN DECREASING ORDER 
SELECT model , ROUND(SQRT(resolution_width*resolution_width+resolution_height*resolution_height)/screen_size) AS 'PPI' FROM campusx.smartphones
 ORDER BY PPI ASC;
 
 # ----------------- FIND THE PHONE WITH 2ND LARGEST BATTERY 
--  SELECT model,battery_capacity FROM campusx.smartphones
--  ORDER BY battery_capacity DESC LIMIT 2;
 SELECT model,battery_capacity FROM campusx.smartphones
 ORDER BY battery_capacity DESC LIMIT 1,1;
 
 #  ------------ find the name & rating of the worst rateed apple phone
 SELECT  brand_name,model,rating FROM campusx.smartphones
 WHERE brand_name= 'apple'
 ORDER BY rating  ASC LIMIT 1;
 
 # ---------------- SORT PHONES ALPHABETICALLY AND THEN ON THE BASIC OF RATING IN DESC ORDER
 ### -------------- sort  don column la sort kel ahe 
 SELECT  brand_name,model,rating FROM campusx.smartphones
 ORDER BY brand_name ASC ,rating ASC ;
 
  SELECT  brand_name,model,rating FROM campusx.smartphones
 ORDER BY brand_name ASC ,rating DESC;
  # ---------------- SORT PHONES ALPHABETICALLY AND THEN ON THE BASIC OF PRICE IN DESC ORDER
  SELECT * FROM campusx.smartphones;
SELECT  brand_name,model,price FROM campusx.smartphones
ORDER BY brand_name ASC,price  ASC ;
 
SELECT  brand_name,model,price FROM campusx.smartphones
ORDER BY brand_name ASC,price  DESC ;
 
 
 
 
 
 
 
 
 

 #================================================== GROUP BY =======================================
 SELECT * FROM campusx.smartphones;
 #----------- 1) GROUP SMARTPHONE BY BRAND AND GET THE COUNT , AVERAGE PRICE , MAX RARING , AVG SCREEN SIZE , AVG BATTERY CAPACITY
 SELECT brand_name,COUNT(brand_name) AS no_phone,
  AVG(price) AS AVG_PRICE,
  MAX(rating) AS MAX_RARING,
  AVG(screen_size) AS AVG_SCREEN_SIZE,
  AVG (battery_capacity) AS AVG_BATTERY_CAPACITY
 FROM campusx.smartphones
 GROUP BY brand_name
 ORDER BY  no_phone DESC;
 
 # --------- 2) GROUP SMARTPHONE BY WHERE THEY HAVE AN NFC AND GET THE AVG PRICE AND RATING
 SELECT * FROM campusx.smartphones; 
 SELECT * FROM campusx.smartphones
 GROUP BY has_nfc; 
 #Error Code: 1055. 
 # Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 
 # 'campusx.smartphones.brand_name' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
# ---------- ANS 
SELECT  has_nfc,
AVG(price) AS 'avg_price',
AVG(rating) AS 'avg_rating'
FROM campusx.smartphones
WHERE 1
GROUP BY has_nfc; 


#--------------- 3)1  has_5g AASANAR PHONE CHA AVG AND NAASANAR PHONE CHA AVG
SELECT * FROM campusx.smartphones;
SELECT  has_5g,
AVG(price) AS 'avg_price',
AVG(rating) AS 'avg_rating'
FROM campusx.smartphones
WHERE 1
GROUP BY has_5g; 

# ------------------ 3)  GROUP SMARTPHONE BY EXTENED MEMORY AVALAIBLE AND GET THE AVG PRICE AND RATING
SELECT extended_memory_available, 
AVG(price) AS avg_price,
AVG(rating) AS avg_rating
FROM campusx.smartphones
GROUP BY extended_memory_available;


# ---------- GROUP SMARTPHONE BY THE BRAND AND PROCESSOR BRAND AND GET THE COUNT OF THE MODELS AND THE AVG PRIMARY CAMERA RESOLUTION (REAR)alter

SELECT * FROM campusx.smartphones;
SELECT brand_name, processor_brand , 
COUNT(*) AS 'NO_PHONE',
ROUND(AVG(primary_camera_rear)) AS 'AVG_CAMERA_RESOLUTION'
FROM campusx.smartphones
-- WHERE brand_name = 'samsung' AND processor_brand = 'snapdragon'
GROUP BY processor_brand,brand_name
ORDER BY NO_PHONE DESC ;




# ---------------- in the group by use the 2 col use the and there combination also showing 
SELECT * FROM campusx.smartphones; 
# --------------  COMBINATION OF THE TWO GORUPS 
SELECT has_5g,has_nfc FROM campusx.smartphones
GROUP BY has_5g,has_nfc;
# ---------------   COMBINATION OF THE TWO GORUPS ,AVG
SELECT has_5g,has_nfc , COUNT(*) AS 'NO_PHONES', AVG(price) AS 'AVG_PRICE' FROM campusx.smartphones
GROUP BY has_5g,has_nfc
ORDER BY NO_PHONES ASC;


# - === METHOD 2
-- SELECT brand_name, processor_brand , COUNT(*) FROM campusx.smartphones
-- WHERE 
-- CASE 
-- WHEN brand_name = 'samsung' AND processor_brand = 'snapdragon'
-- WHEN brand_name = 'xiaomi' AND processor_brand = 'dimensity'
-- GROUP BY processor_brand,brand_name;

#-====----- 5) FIND TOP 5 MOST COSTLY PHONE BRANDS
SELECT * FROM campusx.smartphones;
SELECT brand_name , COUNT(*) AS 'NO_PHONES', ROUND(AVG(price)) AS 'AVG_PRICE'
FROM campusx.smartphones
GROUP BY brand_name
ORDER BY AVG_PRICE DESC LIMIT 5;

#=----------=------ WHICH BRAND MAKES THE SMALLEST SCREESN SMARPHONES
SELECT * FROM campusx.smartphones;
SELECT brand_name , COUNT(*) AS 'NO_PHONES', MAX(price) AS 'AVG_PRICE', AVG(screen_size) AS 'AVG_SIZE'
FROM campusx.smartphones
GROUP BY brand_name
ORDER BY AVG_PRICE ASC LIMIT 1;

# =------------------ grop smartphones by the brand , and find the brand with the hightest no of models that have both nfc and ir blaster 
SELECT * FROM campusx.smartphones; 
SELECT brand_name,COUNT(*) AS 'COUNT_PH' FROM campusx.smartphones
WHERE has_nfc = 'True' AND has_ir_blaster = 'True' # ==> (has_nfc = True) YOU CAN NOT  GIVE THIS ONLY USE THE ('') THIS (has_nfc = 'True')
GROUP BY brand_name
ORDER BY COUNT_PH;
 
 
 # ---------------- FIND ALL SAMAUNG 5G phones enabled smarphone and find out the avg price for nfc and nonnfc
SELECT brand_name,has_5g, COUNT(*) FROM campusx.smartphones
# WHERE brand_name = samsung;   # : 1054. Unknown column 'samsung' in 'where clause' -> 'SAMSUNG ' -> 'MADHE TAKA'
WHERE brand_name = 'samsung'  AND has_5g = 'True'; # # AAP KO COL MAI JARKAR SERACH KARANA HAI TO USE (' ')
 
 
 # ---------- 
 SELECT * FROM campusx.smartphones;
 SELECT brand_name,has_5g, COUNT(*),has_nfc FROM campusx.smartphones
WHERE brand_name = 'samsung'  
GROUP BY has_nfc; # Error Code: 1055. 
# Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 
# 'campusx.smartphones.has_5g' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

# -------- COREECT ANS 
SELECT brand_name, COUNT(*),has_nfc, AVG(price) FROM campusx.smartphones
WHERE brand_name = 'samsung'  
GROUP BY has_nfc;

# -------- ==== ------ FIND THE PHONE NAME , PRICE OF THE COSTLIEST PHONE 
SELECT * FROM campusx.smartphones;
#------------ METHOD 1
SELECT brand_name , MAX(price)  AS 'COSTLIEST_PHONE' FROM campusx.smartphones
GROUP BY brand_name
ORDER BY COSTLIEST_PHONE DESC LIMIT 1;

# ----------- METHOD 2 THIS BRAND ASC ORDER 
SELECT brand_name , price FROM campusx.smartphones
ORDER BY  brand_name DESC LIMIT 1;
# ---------- METHOD 2 
SELECT brand_name , price FROM campusx.smartphones
ORDER BY  price DESC LIMIT 1;


# ################################################################### HAVING CLAUSE===========================






 
 
 #=================================== IN CLASS NOTES
 use southwind;
 use hr;
select * from employees;
 select count(dep_id) as no_of_emp
 from employees
 group by dep_id;
   #---------------1
 select * from employees;
 select count(dep_id) as no_of_emp , dep_id
 from employees
 group by dep_id;
 
 #--------------------- 
 select * from employees;
 select count(dep_id) as no_of_emp , dep_id      # Error Code: 1140. In aggregated query without GROUP BY, expression #2 of SELECT list contains nonaggregated column 'hr.employees.dep_id'; this is incompatible with sql_mode=only_full_group_by 
 from employees;
 
 # -----------
 select * from employees;
 select count(dep_id) as no_of_emp , first_name 
 from employees
 group by first_name ;
 
 # ---------- 
select * from employees;
 select count(dep_id) as no_of_emp , first_name 
 from employees
 group by dep_id ;
 
 
 # ------ examp1
 select * from employees ;
 select salary , count(*) from employees
 group by salary;
 
 
 # example 2
  select * from employees ;
 select salary , count(*) from employees
 where salary  = 19500.00
 group by salary;
 
 # ---------------- use southwind 
 use southwind;
 select * from products;
 select category , count(*) as no_of_product_cat from products
 where category = 'Beverages'
 group by category
 order by no_of_product_cat desc;
 
 
 # find the total no of order each cust
 select * from orders;
 select customer_id,count(id ) from orders 
 group by customer_id;
 
 
 # find they  total renv for each product 
 select * from  order_details;
 select sum(quantity*unit_price) as gross
 from order_details 
 group by  product_id 
 order by gross desc;
 
 
 # ------------ example 
 #  -- year - 1988
 # -- group - dept_id
 # -- count - > 
 
 
# -------- no of  find the min and max salary for each job_id where dep_id is 80
use hr;
select * from employees;
select dep_id,min(salary) as min_salary , max(salary) as max_salary
from employees 
group by dep_id
order by min_salary , max_salary ;

#####========= pro)10
select * from 

