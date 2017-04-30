medicaldata = LOAD '/home/hduser/medical-' USING  PigStorage()  as (name:chararray, dept:chararray, claim:float);
--dump medicaldata;
groupbydept= group medicaldata by dept;
 -- dump groupbydept;
avgclaim = foreach groupbydept generate group, ROUND_TO(AVG(medicaldata.claim),2);
dump avgclaim;
--ans:
--(TS,3666.67)
--(hr,7750.0)
--(admin,4750.0)
--(finance,9000.0)
