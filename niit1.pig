--count the freequent of each word in a text file.

--A = LOAD 'data' USING TextLoader();

book = LOAD '/home/hduser/file1.txt' USING  PigStorage()  as (lines:chararray);

--book = LOAD '/home/hduser/file1.txt' USING  TextLoader()  as (lines:chararray);

--dump book;

transform =  foreach book generate FLATTEN(TOKENIZE(lines)) as word;

--transform= foreach book generate FLATTEN(TOKENIZE(LOWER(word,',',''))) as word;

transform= foreach transform generate TRIM(LOWER( REPLACE(word, '[\\p{Punct}, \\p{Cntrl}]', ''))) as word;

--transform= foreach book generate FLATTEN(TOKENIZE(LOWER(lines))) as word;

--dump transform;
groupbyword = group transform by word;

--dump groupbyword;
--describe groupbyword;

countofeachword = foreach groupbyword generate group, COUNT(transform);
dump countofeachword;

--store countofeachword into 'niit/pig_wordcount' using PigStorage();


--output
--(a,1)
--(hi,1)
--(is,1)
--(we,5)
--(are,5)
--(now,1)
--(pig,3)
--(data,4)
--(hive,1)
--(this,1)
--(class,1)
--(hadoop,1)
--(having,1)
--(session,1)
--(learning,4)
--(mapreduce,1)

