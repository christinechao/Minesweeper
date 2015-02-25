

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //declare and initialize buttons
  buttons = new MSButton [NUM_ROWS][NUM_COLS];
  for (int i =0; i < NUM_ROWS; i++) {
    for (int j=0; j< NUM_COLS; j++) {
      buttons[i][j] = new MSButton(i, j);
    }
  }
  bombs = new ArrayList <MSButton>();
  //setting the number of bombs
  int i=0;
  while (i<30) {
    setBombs();
    i++;
  }
}

public void setBombs()
{
  int randomRow= (int)(Math.random()*20);
  int randomColumn= (int)(Math.random()*20);
  if (!bombs.contains(buttons[randomRow][randomColumn])) {
    bombs.add(buttons[randomRow][randomColumn]);
  }
}

public void draw ()
{
  background(0);
  if (isWon())
    displayWinningMessage();
}
public boolean isWon()
{
  for (int i =0; i< bombs.size (); i++) {
    if (bombs.get(i).isMarked() == false) {
      return false;
    }
  }
  return true;
}
public void displayLosingMessage()
{
  buttons[9][6].setLabel("Y");
  buttons[9][7].setLabel("O");
  buttons[9][8].setLabel("U");
  buttons[9][9].setLabel(" ");
  buttons[9][10].setLabel("L");
  buttons[9][11].setLabel("O");
  buttons[9][12].setLabel("S");
  buttons[9][13].setLabel("E");
  for (int i =0; i < bombs.size (); i++) {
    bombs.get(i).marked = false;
    bombs.get(i).clicked = true;
  }
}
public void displayWinningMessage()
{
  buttons[9][6].setLabel("Y");
  buttons[9][7].setLabel("O");
  buttons[9][8].setLabel("U");
  buttons[9][9].setLabel(" ");
  buttons[9][10].setLabel("W");
  buttons[9][11].setLabel("I");
  buttons[9][12].setLabel("N");
}

public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;

  public MSButton ( int rr, int cc )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }

  public void mousePressed () 
  {
    clicked = true;
    if (mouseButton == RIGHT) {
      marked = !marked;
    } else if (bombs.contains(this)) {
      displayLosingMessage();
    } else if ( countBombs(r, c) > 0) {fill(255); 
      setLabel(str(countBombs(r, c)));
    } else {
      if (isValid(r, c-1) && buttons[r][c-1].isClicked() == false) {
        buttons[r][c-1].mousePressed();
      }
      if (isValid(r, c+1) && buttons[r][c+1].isClicked() == false) {
        buttons[r][c+1].mousePressed();
      }
      if (isValid(r-1, c-1) && buttons[r-1][c-1].isClicked() == false) {
        buttons[r-1][c-1].mousePressed();
      }
      if (isValid(r-1, c) && buttons[r-1][c].isClicked() == false) {
        buttons[r-1][c].mousePressed();
      }
      if (isValid(r-1, c+1) && buttons[r-1][c+1].isClicked() == false) {
        buttons[r-1][c+1].mousePressed();
      }
      if (isValid(r+1, c) && buttons[r+1][c].isClicked() == false) {
        buttons[r+1][c].mousePressed();
      }
      if (isValid(r+1, c+1) && buttons[r+1][c+1].isClicked() == false) {
        buttons[r+1][c+1].mousePressed();
      }
      if (isValid(r+1, c-1) && buttons[r+1][c-1].isClicked() == false) {
        buttons[r+1][c-1].mousePressed();
      }
    }
  }

  public void draw () 
  { 
    stroke(255);   
    if (marked) {
      fill(0);
    } else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 209, 212, 255);
    else 
      fill( 168, 194, 255);

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    return (r>=0 && r<NUM_ROWS) && (c>=0 && c<NUM_COLS);
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;
    if (isValid(r-1, c) && bombs.contains(buttons[r-1][c])) {
      numBombs++;
    }
    if (isValid(r, c-1) && bombs.contains(buttons[r][c-1])) {
      numBombs++;
    }
    if (isValid(r, c+1) && bombs.contains(buttons[r][c+1])) {
      numBombs++;
    }
    if (isValid(r-1, c-1) && bombs.contains(buttons[r-1][c-1])) {
      numBombs++;
    }
    if (isValid(r-1, c+1) && bombs.contains(buttons[r-1][c+1])) {
      numBombs++;
    }
    if (isValid(r+1, c) && bombs.contains(buttons[r+1][c])) {
      numBombs++;
    }
    if (isValid(r+1, c+1) && bombs.contains(buttons[r+1][c+1])) {
      numBombs++;
    }
    if (isValid(r+1, c-1) && bombs.contains(buttons[r+1][c-1])) {
      numBombs++;
    }
    return numBombs;
  }
}
