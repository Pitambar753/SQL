create database join_example;
select * from join_example.category;
select * from join_example.class;
select * from join_example.groups;
select * from join_example.membership;
select * from join_example.order_details;
select * from join_example.orders;
select * from join_example.users;
select * from join_example.users1;


################====================== CROSS JOIN ======================#####################
select  * from join_example.users1;   # in this table 6 rows 
select * from join_example.groups;   # in this table 4 rows
select count(*) from join_example.users1 t1
cross join join_example.groups t2;   # mul both the table row then come to new table rows ---> this called cross join  



##############======================= INNER JOIN ======================########################
SELECT * FROM join_example.users1;     ## extra use_id no ->> 8,11
select * from join_example.membership;     ### extra use_id no ->> 5,6
select count(*) from join_example.users1 t1           # table total row 9 ahe 
inner join join_example.membership t2
on   t1.user_id = t2.user_id;                                    ### (on) called  --->> on ko join ki  condition bolate hai 







##############======================= LEFT JOIN ======================########################
select * from join_example.users1 t1            #### LEFT TABLE -->> join_example.users1 t1 (FIX AHE) 
join join_example.membership t2         #### RIGHT TABLE -->> join_example.membership t2  (FIX AHE )
on   t1.user_id = t2.user_id ; 

 ### FROM ==> CHAYA NATAR CHA LEFT TABLE && JOIN ==>> CHAYA NATAR CHA RIGHT TABLE AHE 

SELECT * FROM join_example.users1;     ## extra use_id no ->> 8,11
select * from join_example.membership;     ### extra use_id no ->> 5,6
select * from join_example.users1 t1 LEFT join           # ==>> FROM ==>> CHYA NATAR CHA TABLE JO AHE TO LEFT AHE  && JOIN ==>> CHAYA NATAR CHA TABLE JO AHE RIGHT TABLE AHE 
join_example.membership t2          ### LEFT TABLE NAME IS ==>> USER1 AND ### RIGHT TABLE IS ==>> MEMBERSHIP 
on   t1.user_id = t2.user_id ;                             ### USER1==>> table madhil row 8 and 11 ahet tya mule left table ahe and chayanch value null dakhavt ahe menas membership table madhe 8,11 nahi 
## 



##############======================= RIGHT JOIN  ======================########################
SELECT * FROM join_example.users1;     ## extra use_id no ->> 8,11
select * from join_example.membership;     ### extra use_id no ->> 5,6
select * from join_example.users1 t1 RIGHT join           # table total row 9 ahe 
join_example.membership t2          ### LEFT TABLE NAME IS ==>> USER1 AND ### RIGHT TABLE IS ==>> MEMBERSHIP 
on   t1.user_id = t2.user_id ;                             ### USER1==>> table madhil row 8 and 11 ahet tya mule left table ahe and chayanch value null dakhavt ahe menas membership table madhe 8,11 nahi 
## left join ===> use karyacha asel tar jaya table var left join lavayacha he te table aadhi liha ==> LIKE ==>> TABLE_1 LEFT JOIN ==>> TABLE_1 HA ATA LEFT TABLE AHE  
##  TYA natar cha table ahe to right join table ahe 


##############======================= FULL OUTER  JOIN  ======================########################
######### ERROR YET AHE ==> DEFAUT FULL OUTER JOIN NOT PERFORM IN MYSQL 
-- select * from join_example.users1 t1            # table total row 9 ahe 
-- FULL OUTER join_example.membership t2          ### LEFT TABLE NAME IS ==>> USER1 AND ### RIGHT TABLE IS ==>> MEMBERSHIP 
-- on   t1.user_id = t2.user_id ; 

select * from join_example.users1 t1            #### LEFT TABLE -->> join_example.users1 t1 (FIX AHE) 
LEFT join join_example.membership t2         #### RIGHT TABLE -->> join_example.membership t2  (FIX AHE )
on   t1.user_id = t2.user_id 
UNION
select * from join_example.users1 t1            #### LEFT TABLE -->> join_example.users1 t1 (FIX AHE) 
RIGHT JOIN join_example.membership t2         #### RIGHT TABLE -->> join_example.membership t2  (FIX AHE )
on   t1.user_id = t2.user_id ;                ### THIS IS FULL OUTER JOIN AHE airport


##############======================= SQL SET OPERATION   ======================########################
##############-- UNION     ==>> 1.===>>Combines results from two queries &&& 2.==>>Removes duplicate rows  
##############-- UNION ALL ==>> 1.===>>Combines results from two queries &&& 2.==>>Keeps duplicates &&& 3.===>> Returns all cities including duplicates
###############-- INTERSECT  ==>> 1.===>>Returns only common rows from both queries &&& 2.==>>Returns cities that exist in both tables 
################# -- EXCEPT  ==>> 1.===>>Returns rows from first query that are NOT in second query &&& 2.==>>Returns cities in customers but not in suppliers 

##############------------------------ UNION-------------##########################
select * from join_example.person1;
select * from join_example.person2;
select * from join_example.person1
UNION 
select * from join_example.person2;
 
 ##############------------------------ UNION ALL-------------##########################
 select * from join_example.person1;
select * from join_example.person2;
select * from join_example.person1
UNION ALL
select * from join_example.person2;

#############------------------------ INTERSECT-------------##########################
 select * from join_example.person1;
select * from join_example.person2;
select * from join_example.person1
INTERSECT
select * from join_example.person2;

#############------------------------ EXCEPT -------------##########################
select * from join_example.person1;
select * from join_example.person2;
select * from join_example.person1  ##### PERSON1-PERSON2 ====>> JO FIRST TABLE USEKA HI AHAYAE GA  
EXCEPT
select * from join_example.person2;