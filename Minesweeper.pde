

import de.bezier.guido.*;
public final static int NUM_ROWS=20;
public final static int NUM_COLS=20;//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    textSize(15);
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int r = 0;r<NUM_ROWS;r++)
    {
        for(int c=0;c<NUM_COLS;c++)
        {
            buttons[r][c]= new MSButton(r,c);
        }
    }
    setBombs();
    
    for(int i=0;i<100;i++)
    {
    setBombs();
    }
    //System.out.println(bombs);
}
public void setBombs()
{
    int rrow = (int)(Math.random()*NUM_ROWS);//your code
    int rcol = (int)(Math.random()*NUM_COLS);
    if(bombs.contains(buttons[rrow][rcol])==false)
        bombs.add(buttons[rrow][rcol]);
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
    for(int r = 0;r<NUM_ROWS;r++)//your code here
    {
        for(int c = 0;c<NUM_COLS;c++)
        if(bombs.contains(buttons[r][c])==true&&buttons[r][c].isClicked()==true)
            displayLosingMessage();
    }
}
public boolean isWon()
{
    for(int r = 0;r<NUM_ROWS;r++)//your code here
    {
        for(int c = 0;c<NUM_COLS;c++)
        if(buttons[r][c].isMarked()==false&&buttons[r][c].isClicked()==false)
    return false;
    }
    return true;
}
public void displayLosingMessage()
{
    for(int r = 0;r<NUM_ROWS;r++)
    {
        for(int c = 0;c<NUM_COLS;c++)
        buttons[r][c].setLabel("");
    }
        buttons[NUM_ROWS/2-1][(NUM_COLS/4)+1].setLabel("Y");
        buttons[NUM_ROWS/2-1][(NUM_COLS/4)+2].setLabel("O");
        buttons[NUM_ROWS/2-1][(NUM_COLS/4)+3].setLabel("U");
        buttons[NUM_ROWS/2-1][(NUM_COLS/4)+4].setLabel("L");
        buttons[NUM_ROWS/2-1][(NUM_COLS/4)+5].setLabel("O");
        buttons[NUM_ROWS/2-1][(NUM_COLS/4)+6].setLabel("S");
        buttons[NUM_ROWS/2-1][(NUM_COLS/4)+7].setLabel("E"); 
        buttons[NUM_ROWS/2-1][(NUM_COLS/4)+8].setLabel(")-:");//your code here
        noLoop();
}
public void displayWinningMessage()
{
    if(isWon()==true)//your code here
    {
        //rectMode(CENTER);
        fill(255,255,255);
        rect(200, 200, 200, 200);
        text("You Win", 200, 200, 200, 200);
        for(int r = 0;r<NUM_ROWS;r++)//your code here
    {
        for(int c = 0;c<NUM_COLS;c++)
        buttons[r][c].setLabel("");
    }
         buttons[NUM_ROWS/2-1][(NUM_COLS/4)+1].setLabel("Y");
        buttons[NUM_ROWS/2-1][(NUM_COLS/4)+2].setLabel("O");
        buttons[NUM_ROWS/2-1][(NUM_COLS/4)+3].setLabel("U");
        buttons[NUM_ROWS/2-1][(NUM_COLS/4)+4].setLabel("W");
        buttons[NUM_ROWS/2-1][(NUM_COLS/4)+5].setLabel("I");
        buttons[NUM_ROWS/2-1][(NUM_COLS/4)+6].setLabel("N");
        buttons[NUM_ROWS/2-1][(NUM_COLS/4)+7].setLabel("!"); 
        //buttons[NUM_ROWS/2-1][(NUM_COLS/4)+8].setLabel(":-)");
    }
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
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
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;//your code here
        if(mouseButton==RIGHT&&marked==false)
        {
            clicked=false;
            marked=true;
        }
        else if(mouseButton==RIGHT&&marked==true)
        {
            clicked=false;
            marked=false;
        }
        else if(bombs.contains(this)==true)
            displayLosingMessage();
        else if(countBombs(r,c)>0)
            setLabel(""+countBombs(r,c));
        else 
        {
            if(isValid(r,c-1) && buttons[r][c-1].isClicked()==false)
            buttons[r][c-1].mousePressed();
            if(isValid(r-1,c) && buttons[r-1][c].isClicked()==false)
            buttons[r-1][c].mousePressed();
            if(isValid(r,c+1) && buttons[r][c+1].isClicked()==false)
            buttons[r][c+1].mousePressed();
            if(isValid(r+1,c) && buttons[r+1][c].isClicked()==false)
            buttons[r+1][c].mousePressed();
            if(isValid(r+1,c+1) && buttons[r+1][c+1].isClicked()==false)
            buttons[r+1][c+1].mousePressed();
            if(isValid(r-1,c-1) && buttons[r-1][c-1].isClicked()==false)
            buttons[r-1][c-1].mousePressed();
            if(isValid(r+1,c-1) && buttons[r+1][c-1].isClicked()==false)
            buttons[r+1][c-1].mousePressed();
            if(isValid(r-1,c+1) && buttons[r-1][c+1].isClicked()==false)
            buttons[r-1][c+1].mousePressed();
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r<=NUM_ROWS&&c<=NUM_COLS&&r>=0&&c>=0)
            return true;//your code here
        else 
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;//your code here
        if(isValid(row+1,col)&&bombs.contains(buttons[row+1][col])==true)
            numBombs++;
        if(isValid(row-1,col)&&bombs.contains(buttons[row-1][col])==true)
            numBombs++;
        if(isValid(row,col+1)&&bombs.contains(buttons[row][col+1])==true)
            numBombs++;
        if(isValid(row,col-1)&&bombs.contains(buttons[row][col-1])==true)
            numBombs++;
        if(isValid(row-1,col-1)&&bombs.contains(buttons[row-1][col-1])==true)
            numBombs++;
        if(isValid(row-1,col+1)&&bombs.contains(buttons[row-1][col+1])==true)
            numBombs++;
        if(isValid(row+1,col+1)&&bombs.contains(buttons[row+1][col+1])==true)
            numBombs++;
        if(isValid(row+1,col-1)&&bombs.contains(buttons[row+1][col-1])==true)
            numBombs++;
        return numBombs;
    }
}



