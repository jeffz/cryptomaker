/*

The input file is a cliche spy code style puzzle.  Where numbers
might represent the page # of a book, line # and nth word.

The format is as follows:

NumberOfPuzzles
row nthword, row nthword, row, nthword

Your task is to load the puzzle file and decode it using book.txt
as a dictionary.

Example puzzle file:

4
2464 2,2642 9,1722 6,2625 3,1234 3
2244 2,2092 10,2628 2,2469 5,1652 9
1832 0,1584 9,2595 3,1647 12,1712 1
1704 0,292 3,2606 5,1832 0,1365 7,1670 6

*/
String homedir = "data\\";
String bookLines[] = loadStrings(homedir + "book.txt");
String messages[];
int messageIdx = 0;

void keyPressed()
{
  println(messages.length);
  println(messageIdx);
  if(key == 'n' && messageIdx < messages.length-1)
   messageIdx++;
  if(key == 'p' && messageIdx > 0)
   messageIdx--;
}
String decodeword(int linenum, int wordnum)
{
  // read the book into an array of lines
  String words[] = split(bookLines[linenum], " ");
  println("decoded word: " + words[wordnum]);
  return words[wordnum];
}

String[] decodePuzzle(String puzzlefile)
{
  String puzzleLines[] = loadStrings(puzzlefile);
  int numberOfPuzzles = int(puzzleLines[0]);
  String messages[] = new String[numberOfPuzzles];

  for(int puzzleIdx = 1; puzzleIdx <= numberOfPuzzles; puzzleIdx++) // puzzleIdx points to the nth puzzle in the file which is also the line number
  {
    String wordcodesstr[] = split(puzzleLines[puzzleIdx], ",");
    String decoded = "";
    messages[puzzleIdx-1] = "";
    for(int i = 0; i < wordcodesstr.length; i++)
    {
      String[] indicies = split(wordcodesstr[i], " ");
      messages[puzzleIdx-1] = messages[puzzleIdx-1] + decodeword(int(indicies[0]), int(indicies[1])) + " ";
    }
    println("");
  }
  return messages;
}

PFont font = createFont ("Arial", 14);

void draw()
{
 background(255);
 text(messages[messageIdx], width/2, height/2);  
}
void setup()
{
 messages = decodePuzzle(homedir + "generated.txt");
 size(500, 500);
 fill(0);
 textFont(font);
 textAlign(CENTER); 
}

