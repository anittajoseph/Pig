volumedata = LOAD '/home/hduser/NYSE.csv' using PigStorage(',') as (excahngename:chararray, stocksymbol:chararray, stockdate:float, stockpriceopen:double, stockpricehigh:double, stockpricelow:double, stockpriceclose:double,stockvolume:long, stockpriceadjclose:double);

--dump variencedata;
describe volumedata;

volume = foreach volumedata generate stocksymbol, stockvolume as maxvolume;

--dump volume;

a = group volume by $0;
--dump a;

b = foreach a generate group, SUM(volume.maxvolume);
--dump b;
 

c = order b by $1 desc;
 d = limit c 5;
dump d;

-- ANS: (AMD,47252808500)
--(AA,42061448400)
--(AXP,40263020300)
--(AMR,22505621700)
--(AVP,20750196700)
