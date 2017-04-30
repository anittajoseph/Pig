medicaldata = LOAD '/home/hduser/medical-' USING  PigStorage()  as (name:chararray, dept:chararray, claim:float);
--dump medicaldata;
groupbyname= group medicaldata by name;
 -- dump groupbyname;
--describe groupbyname;
 employeeclaim = foreach groupbyname generate group as  emp, SUM(medicaldata.claim) as total, COUNT(medicaldata) as totalcount;

--dump employeeclaim;

avgclaim = foreach employeeclaim generate $0, ROUND_TO(($1/$2),2);
dump avgclaim;
 --Ans:
--(amy,8000.0)
--(joe,9000.0)
--(tim,3666.67)
--(jack,7500.0)
--(daniel,4750.0)

