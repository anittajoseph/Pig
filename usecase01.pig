
Retail  = LOAD  '/home/hduser/RetailData'  USING  PigStorage(';')  AS (date, cust_id:int, agegroup, Zipcode, category:int, prod_id:int, qty:int,cost:double, amount:double);

custsale = group Retail by $1; 

totalsale = foreach custsale generate group as cust_id, SUM(Retail.amount) as total;

ordersale = order totalsale by $1 desc;

result = limit ordersale 10;

dump result;

