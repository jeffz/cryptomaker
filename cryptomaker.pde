/*

Task:

Given an input file books.txt and an input phrase typed in by the
user, construct an output puzzle file containing an encrypted message.

*/
String homedir = "data\\";
String bookLines[] = loadStrings(homedir + "book.txt");
HashMap wordpairs = new HashMap();

void fillHashMap()
{
 for(int lineNum = 0; lineNum < bookLines.length; lineNum++)
 {
   String words[] = split(bookLines[lineNum], " ");
   for(int wordNumOnLine = 0; wordNumOnLine < words.length; wordNumOnLine++)
   {
     wordpairs.put(words[wordNumOnLine], str(lineNum) + " " + str(wordNumOnLine));
   }
 } 
}
String encodeString(String plaintext)
{
  String inputwords[] = split(plaintext, " ");
  String output = "";
  for(int i = 0; i < inputwords.length; i++)
  { 
    output = output + (String)wordpairs.get(inputwords[i]);
    if(i != inputwords.length-1)
    {
      output = output + ",";
    }
  }
  return output;
}
void setup()
{
 size(500,500);
 fill(0);
 textAlign(CENTER);
 fillHashMap();
}

PFont font = createFont ("Arial", 14);

void draw()
{
  background(255);
  text(kpBuf, width/2, height/2);  
  text(encBuf, width/2, height/3);
}

String kpBuf = "";
String encBuf = "";
void keyPressed()
{
  if(key == BACKSPACE)
  {
    if(kpBuf.length() > 0)
    {
      println(kpBuf);
      kpBuf = kpBuf.substring(0, kpBuf.length()-1);
    }
  }
  if(key == ENTER)
  {
    String output[] = new String[2];
    println("kpBuf:" + kpBuf + "|");
    encBuf = encodeString(kpBuf.toLowerCase());

    output[0] = "1";
    output[1] = encBuf;
    saveStrings(homedir + "generated.txt", output);    
    
    kpBuf = "";
  }
}
void keyTyped()
{
  if(key != BACKSPACE && key != ENTER)
  {
    kpBuf = kpBuf + key;
  }
}
