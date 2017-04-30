 --find the maxvarience(NYSE data) for each stock.

variencedata = LOAD '/home/hduser/NYSE.csv' using PigStorage(',') as (excahngename:chararray, stocksymbol:chararray, stockdate:float, stockpriceopen:double, stockpricehigh:double, stockpricelow:double, stockpriceclose:double,stockvolume:long, stockpriceadjclose:double);

--dump variencedata;
describe variencedata;

--data = foreach variencedata generate $1, $4, $5;
--dump data;
--describe data;

 --final = foreach variencedata generate $0 as excahngename, ROUND_TO((((variencedata.stockpricehigh-variencedata.stockpricelow)/variencedata.stockpricelow)*100),2) as maxvarience;

--varience = foreach data generate $0 as stocksymbol, ROUND_TO(((($1-$2)/$2)*100), 2) as maxvarience;

varience = foreach variencedata generate $1 as stocksymbol, ((($4-$5)*100)/$5) as maxvarience;

dump varience;

describe varience;

--max = foreach varience generate $0 as stocksymbol, MAX(varience.maxvarience);
--dump max;

final =limit varience 10;
dump final;
describe final;

--a= foreach varience generate group, MAX(varience.maxvarience)
 --dump a;


--ANS: (AEA,4.988123515439429)
--(AEA,7.5829383886256)
--(AEA,6.833712984054686)
--(AEA,4.222222222222231)
--(AEA,8.225108225108222)
--(AEA,5.128205128205133)
--(AEA,6.092436974789917)
--(AEA,8.523908523908528)
--(AEA,7.724425887265139)
--(AEA,7.692307692307696)



