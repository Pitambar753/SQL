use northwind;
use southwind;


select * from southwind.customers;
select * from southwind.employee_privileges;
select * from southwind.employees;
select * from southwind.inventory_transaction_types;
select * from southwind.inventory_transactions;
select * from southwind.order_details;
select * from southwind.orders;
select * from southwind.products;
select * from southwind.shippers;
select * from southwind.suppliers;

#### ========= QU->1) find all products where unite price < recorded level show product name , stock , how many units short they have
-- select * from southwind.products;
-- select * from southwind.order_details;
-- with exam1 as(
-- select * from 
-- )



### ---- que->2) compute total revenu per month 
drop database northwind;



#### ---- QUE-3)
WITH RECURSIVE rec AS (
    -- Start date (min date from orders)
    SELECT MIN(DATE(order_date)) AS dt
    FROM orders

    UNION ALL

    -- Generate next dates
    SELECT dt + INTERVAL 1 DAY
    FROM rec
    WHERE dt < (SELECT MAX(DATE(order_date)) FROM orders)
),

order_day AS (
    SELECT DATE(o.order_date) AS od_da, COUNT(*) AS no_od_od
    FROM order_details od
    join orders o
    on o.id=od.id
    WHERE YEAR(order_date) = 2006
    GROUP BY DATE(order_date)
)

SELECT 
    r.dt,
    DAYNAME(r.dt) AS day_name,
    COALESCE(od.no_od_od, 0) AS total_orders
FROM rec r
LEFT JOIN order_day od 
    ON r.dt = od.od_da
ORDER BY total_orders desc;

