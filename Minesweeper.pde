import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 25;
public int count = 0;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];  // first call to new
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new MSButton(r, c); // second call to new
    }
  }



  setMines();
}
public void setMines()
{
  int NUM_BOMBS = 30;
  while (mines.size() < NUM_BOMBS ) {
    int r = (int)(Math.random() * NUM_ROWS);
    int c = (int)(Math.random() * NUM_COLS);
    if (!mines.contains(buttons[r][c])) {
      mines.add(buttons[r][c]);
    }
  }
}

public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon() {
/* for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      MSButton button = buttons[r][c];
 if (mines.contains(button) && button.clicked) {
                displayLosingMessage();
                return false;
  
      }
    }
  }*/
  if(count == mines.size()){
   return true; 
  }
return false;
}
  //displayWinningMessage();
  //return true;
  


   //displayLosingMessage();
  // return true;
 
public void displayLosingMessage() {
  //System.out.println("Sorry, you lost the game. Better luck next time!");
  
  buttons[10][5].setLabel( "Y");
  buttons[10][6].setLabel( "O");
  buttons[10][7].setLabel( "U");
  buttons[10][8].setLabel( " ");
  buttons[10][9].setLabel( "L");
  buttons[10][10].setLabel( "O");
  buttons[10][11].setLabel( "S");
  buttons[10][12].setLabel( "T");
 
}

public void displayWinningMessage() {
//  System.out.println("Congratulations! You won the game!");
  
    buttons[10][5].setLabel( "Y");
  buttons[10][6].setLabel( "O");
  buttons[10][7].setLabel( "U");
  buttons[10][8].setLabel( " ");
  buttons[10][9].setLabel( "W");
  buttons[10][10].setLabel( "I");
  buttons[10][11].setLabel( "N");

}

public boolean isValid(int r, int c)
{
  if ( r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS) {
    return true;
  } else {
    return false;
  }
}
public int countMines(int row, int col)
{
  int numMines = 0;
  for (int i = row - 1; i <= row +1; i++) {
    for (int j = col - 1; j <= col + 1; j++) {
      if (i == row && j == col) {
        continue;
      }
      if (i >= 0 && i < buttons.length && j >= 0 && j < buttons[i].length && mines.contains(buttons[i][j])) {
        numMines++;
      }
    }
  }
  return numMines;
}
public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col;
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed ()
  {
    clicked = true;
    if (mouseButton == RIGHT) {
      if (flagged == false) {
        flagged = true;
        count++;
      } else if (flagged == true) {
        flagged = false;
        clicked = false;
        count--;
      }
    } else if (mines.contains(this) && flagged == false) {
      displayLosingMessage();
    } else if (countMines(myRow, myCol) > 0) { 
      setLabel(countMines(myRow, myCol));
    } else 

    if (countMines(myRow, myCol) == 0) {
      if (isValid(myRow, myCol-1) && !buttons[myRow][myCol-1].clicked) {
        buttons[myRow][myCol-1].mousePressed();
      } 
      if (isValid(myRow-1, myCol-1) && !buttons[myRow-1][myCol-1].clicked) {
        buttons[myRow-1][myCol-1].mousePressed();
      }  
      if (isValid(myRow-1, myCol) && !buttons[myRow-1][myCol].clicked) {
        buttons[myRow-1][myCol].mousePressed();
      }
      if (isValid(myRow-1, myCol+1) && !buttons[myRow-1][myCol+1].clicked) {
        buttons[myRow-1][myCol+1].mousePressed();
      }
      if (isValid(myRow, myCol+1) && !buttons[myRow][myCol+1].clicked) {
        buttons[myRow][myCol+1].mousePressed();
      }
      if (isValid(myRow+1, myCol+1) && !buttons[myRow+1][myCol+1].clicked) {
        buttons[myRow+1][myCol+1].mousePressed();
      }
      if (isValid(myRow+1, myCol) && !buttons[myRow+1][myCol].clicked) {
        buttons[myRow+1][myCol].mousePressed();
      }
      if (isValid(myRow+1, myCol-1) && !buttons[myRow+1][myCol-1].clicked) {
        buttons[myRow+1][myCol-1].mousePressed();
      }
    }
  }
  public void draw ()
  {    
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) )
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else
      fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(myLabel, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+ newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }
}
