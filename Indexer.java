import java.io.IOException;
import java.util.*;

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.conf.*;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapred.*;
import org.apache.hadoop.util.*;

public class Indexer {

  public static class Map extends MapReduceBase implements Mapper<LongWritable, Text, Text, Text> {
    private Text word = new Text();
	private Text docid = new Text();

	@Override
    public void map(LongWritable key, Text value, OutputCollector<Text, Text> output, Reporter reporter) throws IOException {
	  FileSplit fileSplit = (FileSplit)reporter.getInputSplit();
      String fileName = fileSplit.getPath().getName();
		
      String line = value.toString();
      line = line.toLowerCase();
      line = line.replaceAll("[^A-Za-z0-9 '-]", "");
      line = line.replaceAll("-"," ");
      StringTokenizer tokenizer = new StringTokenizer(line);
	  docid.set(fileName);
      while (tokenizer.hasMoreTokens()) {
        word.set(tokenizer.nextToken());
        output.collect(word, docid);
      }
    }
  }

  public static class Reduce extends MapReduceBase implements Reducer<Text, Text, Text, Text> {
	  @Override
    public void reduce(Text key, Iterator<Text> values, OutputCollector<Text, Text> output, Reporter reporter) throws IOException {
	  StringBuilder postingList = new StringBuilder();
	  postingList.append("(");
      while (values.hasNext()) {
        postingList.append(values.next().toString() + " ");
      }
	  postingList.append(")");
      output.collect(key, new Text(postingList.toString()));
    }
  }

  public static void main(String[] args) throws Exception {
    JobConf conf = new JobConf(Indexer.class);
    conf.setJobName("indexer");

    conf.setOutputKeyClass(Text.class);
    conf.setOutputValueClass(Text.class);
	conf.setMapOutputValueClass(Text.class);

    conf.setMapperClass(Map.class);
    conf.setCombinerClass(Reduce.class);
    conf.setReducerClass(Reduce.class);

    conf.setInputFormat(TextInputFormat.class);
    conf.setOutputFormat(TextOutputFormat.class);

    FileInputFormat.setInputPaths(conf, new Path("/user/cloudera/index/documents"));
    FileOutputFormat.setOutputPath(conf, new Path("/user/cloudera/index/output"));

    JobClient.runJob(conf);
  }
}
