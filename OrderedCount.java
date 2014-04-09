public class OrderedCount {
  public static void main(String[] args) throws Exception{
    String[] args1 = {args[0], args[1]};
    String[] args2 = {args[1], args[2]};
    WordCount.main(args1);
    CountSort.main(args2);
  }
}
