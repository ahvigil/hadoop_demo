#!/bin/bash
echo javac -cp /usr/lib/hadoop/*:/usr/lib/hadoop/client-0.20/* *.java
read -p "[Enter to run]"
javac -cp /usr/lib/hadoop/*:/usr/lib/hadoop/client-0.20/* *.java
read -p "[Enter to Continue]"

echo
echo jar -cvf hadoop_job.jar *.class
read -p "[Enter to run]"
jar -cvf hadoop_job.jar *.class
read -p "[Enter to Continue]"

echo
echo jar -cvf hadoop_job.jar *.class
read -p "[Enter to run]"
hdfs dfs -rm -f -r /user/cloudera/wordcount/*
read -p "[Enter to Continue]"

echo
echo hdfs dfs -mkdir /user/cloudera/wordcount/input
read -p "[Enter to run]"
hdfs dfs -mkdir /user/cloudera/wordcount/input
read -p "[Enter to Continue]"

echo
echo hdfs dfs -put input/* /user/cloudera/wordcount/input/
read -p "[Enter to run]"
hdfs dfs -put input/* /user/cloudera/wordcount/input/
read -p "[Enter to Continue]"

echo
echo hadoop jar hadoop_job.jar OrderedCount /user/cloudera/wordcount/input /user/cloudera/wordcount/output /user/cloudera/wordcount/output2
read -p "[Enter to run]"
hadoop jar hadoop_job.jar OrderedCount /user/cloudera/wordcount/input /user/cloudera/wordcount/output /user/cloudera/wordcount/output2
read -p "[Enter to Continue]"

echo
rm -f results.txt
echo hadoop fs -get /user/cloudera/wordcount/output2/part-00000 ./results.txt
read -p "[Enter to run]"
hadoop fs -get /user/cloudera/wordcount/output2/part-00000 ./results.txt
read -p "Done! Results file is results.txt"
