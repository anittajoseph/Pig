--identify users who usr 'reliable ' payment gateways per user (>90%)

userdata =  LOAD '/home/hduser/weblog-' using PigStorage()  as (name:chararray, bank:chararray, logtime:float);

gateway =  LOAD '/home/hduser/gateway-' using PigStorage()  as (bank:chararray, rate:float);

--dump userdata;

--dump gateway;

joined = join userdata by $1, gateway by $0;
--dump joined;

data1 = foreach joined generate $0, $1, $4;
--dump data1;

group1 = group data1 by $0;
--dump group1;
--describe  group1;;
avguser = foreach group1 generate group, AVG(data1.rate);
--dump avguser;

final = filter avguser by $1 > 90.00;
dump final;

--ANS: (john,91.75)

