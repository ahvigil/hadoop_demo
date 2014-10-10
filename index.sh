#!/bin/bash
javac -cp /usr/lib/hadoop/*:/usr/lib/hadoop/client-0.20/* Indexer.java
jar -cvf index.jar Indexer*.class

hdfs dfs -rm -f -r /user/cloudera/index

hdfs dfs -mkdir /user/cloudera/index/documents

let docid=0
for f in 12th_night/*
do
	echo "$docid $f"
	let docid+=1
	
	$(hdfs dfs -put $f /user/cloudera/index/documents/$docid)
done

hadoop jar index.jar Indexer

hdfs dfs -cat /user/cloudera/index/output/part-00000