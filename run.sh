#!/bin/bash
javac -cp /usr/lib/hadoop/*:/usr/lib/hadoop/client-0.20/* *.java
jar -cvf hadoop_job.jar *.class

hdfs dfs -rm -f -r /user/cloudera/wordcount/input /user/cloudera/wordcount/output /user/cloudera/wordcount/output2
hdfs dfs -mkdir /user/cloudera/wordcount/input
hdfs dfs -put input/* /user/cloudera/wordcount/input/

hadoop jar hadoop_job.jar OrderedCount /user/cloudera/wordcount/input /user/cloudera/wordcount/output /user/cloudera/wordcount/output2

rm results.txt
hadoop fs -get /user/cloudera/wordcount/output2/part-00000 ./results.txt
