
use hr;
# ---- 1) write queary to display  country_id and number of emp_working in each country that has more than  5 emp


-- emp1 -- DEP_ID  -- deparatment table  -- location_id
# --- location -- has country id  and name 

select * from employees;
select * from departments;
select count(* ) from employees e
inner join departments d 
on e.dep_id = d.DEPARTMENT_ID
inner join locations l
on d.location_id = l.location_id
group by l.country_id
having no_of;


# write query to find depr where more than 5 emp avg salary >5000
select * from departments;

#-==== give me the count emo[ snd the s where de0-0ehabd six

#------- 5) find all the non executive mang who lead of 3 or more emp earning above 4,000 
-- where the avg  salary exceed 5000 
select * from hr.countries;





# has hr city level break dowmn job role acroos americaat you need see each city ameraca shoud have distin job rolem you have to find total no city is having more than to emp and avg salary 5000 +
#  -- need exculded emp salary 
select * from hr.locations;
select * from hr.countries 
inner join region  r
 where r.register_name  and e.SALARY ;
group by having  no)i