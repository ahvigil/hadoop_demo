#!/bin/bash
echo javac -cp /usr/lib/hadoop/*:/usr/lib/hadoop/client-0.20/* *.java
read -p "[Enter]"
javac -cp /usr/lib/hadoop/*:/usr/lib/hadoop/client-0.20/* *.java

echo jar -cvf hadoop_job.jar *.class
read -p "[Enter]"
jar -cvf hadoop_job.jar *.class

echo jar -cvf hadoop_job.jar *.class
read -p "[Enter]"
hdfs dfs -rm -f -r /user/cloudera/wordcount/*

echo hdfs dfs -mkdir /user/cloudera/wordcount/input
read -p "[Enter]"
hdfs dfs -mkdir /user/cloudera/wordcount/input

echo hdfs dfs -put input/* /user/cloudera/wordcount/input/
read -p "[Enter]"
hdfs dfs -put input/* /user/cloudera/wordcount/input/

echo hadoop jar hadoop_job.jar OrderedCount /user/cloudera/wordcount/input /user/cloudera/wordcount/output /user/cloudera/wordcount/output2
read -p "[Enter]"
hadoop jar hadoop_job.jar OrderedCount /user/cloudera/wordcount/input /user/cloudera/wordcount/output /user/cloudera/wordcount/output2

rm -f results.txt
echo hadoop fs -get /user/cloudera/wordcount/output2/part-00000 ./results.txt
read -p "[Enter]"
hadoop fs -get /user/cloudera/wordcount/output2/part-00000 ./results.txt
