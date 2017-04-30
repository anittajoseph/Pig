Retail  = LOAD  '/home/hduser/RetailData'  USING  PigStorage(';')  AS (date, cust_id:int, agegroup, Zipcode, category:int, prod_id:int, qty:int,cost:double, amount:double);

--custwisesale = foreach Retail generate $1, $8;

custsale = group Retail by $1; 

ordersale = foreach custsale generate group as cust_id,COUNT(Retail) as orders,SUM(Retail.amount) as total;

dump ordersale;

