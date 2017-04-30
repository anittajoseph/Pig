-- find the product list, qty, profitability and margin percentage;

Retail  = LOAD  '/home/hduser/RetailData'  using PigStorage(';') as (date, cust_id:int, agegroup, Zipcode: double, category:int, prod_id:int, qty:int, cost:double, amount:double);

custsale = group Retail by $5; 

--describe custsale;

totalsale = foreach custsale generate group as prod_id, SUM(Retail.qty) as totalqty, SUM(Retail.cost) as totalcost, SUM(Retail.amount) as totalsales;

--dump totalsale;

--describe totalsale

margin_data = foreach totalsale generate $0,$1,ROUND_TO(($3-$2),2),ROUND_TO((($3-$2)*100/$2),2) as margin;

--dump margin_data;

order_margin = order margin_data by $3 desc;

--dump order_margin;

new_margin= limit order_margin 5;

dump new_margin;

-- Ans:
-- (20562687,9,336.0,3733.33)
--(20454388,20,171.0,142.5)
--(20454395,5,42.0,140.0)
--(20569150,2,104.0,136.84)
--(20564520,1,250.0,125.0)



 








