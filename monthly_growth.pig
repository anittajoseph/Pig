--loading the data

sales2000 = LOAD  '/home/hduser/2000.txt'  USING  PigStorage(',')  AS (prod_id:long, product:chararray, jan:double, feb:double, march:double, april:double, may:double, june:double, july:double, aug:double, sept:double, oct:double, nov:double, dec:double );

sales2001 = LOAD  '/home/hduser/2001.txt'  USING  PigStorage(',')  AS (prod_id:long, product:chararray, jan:double, feb:double, march:double, april:double, may:double, june:double, july:double, aug:double, sept:double, oct:double, nov:double, dec:double );

sales2002 = LOAD  '/home/hduser/2002.txt'  USING  PigStorage(',')  AS (prod_id:long, product:chararray, jan:double, feb:double, march:double, april:double, may:double, june:double, july:double, aug:double, sept:double, oct:double, nov:double, dec:double );

-- groupin the data 

group2000 = group sales2000 all;

--describe group2000;
 
group2001 = group sales2001 all;

--describe group2001;

group2002 = group sales2002 all;

--describe group2002;

-- filtering the data

monthly_sales0 = foreach group2000 generate SUM(sales2000.jan) as jantotal, SUM(sales2000.feb) as febtotal, SUM(sales2000.march) as marchtotal, SUM(sales2000.april) as apriltotal, SUM(sales2000.may) as maytotal, SUM(sales2000.june) as junetotal, SUM(sales2000.july) as julytotal, SUM(sales2000.aug) as augtotal, SUM(sales2000.sept) as septtotal, SUM(sales2000.oct) as octtotal, SUM(sales2000.nov) as novtotal, SUM(sales2000.dec) as dectotal;

--dump monthly_sales0;

monthly_sales1 = foreach group2001 generate SUM(sales2001.jan) as jantotal, SUM(sales2001.feb) as febtotal, SUM(sales2001.march) as marchtotal, SUM(sales2001.april) as apriltotal, SUM(sales2001.may) as maytotal, SUM(sales2001.june) as junetotal, SUM(sales2001.july) as julytotal, SUM(sales2001.aug) as augtotal, SUM(sales2001.sept) as septtotal, SUM(sales2001.oct) as octtotal, SUM(sales2001.nov) as novtotal, SUM(sales2001.dec) as dectotal;

--dump monthly_sales1;

monthly_sales2 = foreach group2002 generate SUM(sales2002.jan) as jantotal, SUM(sales2002.feb) as febtotal, SUM(sales2002.march) as marchtotal, SUM(sales2002.april) as apriltotal, SUM(sales2002.may) as maytotal, SUM(sales2002.june) as junetotal, SUM(sales2002.july) as julytotal, SUM(sales2002.aug) as augtotal, SUM(sales2002.sept) as septtotal, SUM(sales2002.oct) as octtotal, SUM(sales2002.nov) as novtotal, SUM(sales2002.dec) as dectotal;

--dump monthly_sales2;

-- storing the data into temp files

--store monthly_sales into '/home/hduser/temp01' using USING  PigStorage(',');

--bag1 =  LOAD '/home/hduser/temp01' using USING  PigStorage(',')  as (lines:chararray);

--bag2 = foreach bag1 generate FLATTEN(TOKENIZE(lines));

--bag3 = rank bag2;

--dump bag3;

ranked2000 = rank (foreach monthly_sales0 generate FLATTEN(TOBAG(*)));
ranked2001 = rank (foreach monthly_sales1 generate FLATTEN(TOBAG(*)));
ranked2002 = rank (foreach monthly_sales2 generate FLATTEN(TOBAG(*)));

joined_bag = join ranked2000 by $0, ranked2001 by $0, ranked2002 by $0;

monthly_compare = foreach joined_bag generate $0, $1, $3, $5, ROUND_TO((($3-$1)/$1*100),2), ROUND_TO((($5-$3)/$3*100),2);

avg_growth = foreach monthly_compare generate $0, $1, $2, $3, $4, $5, ROUND_TO((($4+$5)/2),2);
 
dump avg_growth;

-- ans: (8,267091.0,275690.0,286023.0,3.22,3.75,3.49)





