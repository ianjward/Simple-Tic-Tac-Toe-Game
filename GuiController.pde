/**
  The GuiController is responsible for initializing the GUI and handling all events the GUI generates.
**/

import g4p_controls.*;
import peasy.*;
import javax.swing.JOptionPane;  

private String userMessage = "";
private boolean gameOver = false, userWon = false, aiWon = false, endedInDraw = false;
private String oPicture = "o.png";
private String xPicture = "x.png";
private char userIcon;
private char aiIcon;
private int movesCompleted = 0;
private Square[] allSquares = new Square[9];

public void setup(){
  size(480, 320, JAVA2D);
  createGUI();
  drawGrid();
  newGame();
}

public void draw(){  
  //create an end of game message if needed
  if(userWon | aiWon | endedInDraw){
     Menu.setText(userMessage);
  }
}

private void drawGrid(){
   color c = color(255,255,255);
   background(c, 230);
   PShape cross1, cross2, vertCross1, vertCross2;
  
   cross1 = createShape(RECT,0,120,width,10);
   cross1.setFill(color(0,0,0,0));
   
   cross2 = createShape(RECT,0,220,width,10);
   cross2.setFill(color(0,0,0,0));
   
   vertCross1 = createShape(RECT,150,0,10,height);
   vertCross1.setFill(color(0,0,0,0));
   
   vertCross2 = createShape(RECT,300,0,10,height);
   vertCross2.setFill(color(0,0,0,0));
   
   shape(cross1);
   shape(cross2);
   shape(vertCross1);
   shape(vertCross2);
}

protected void newGame(){
  userMessage = "";
  Menu.setText(userMessage);
  Menu.setLocalColorScheme(GCScheme.BLUE_SCHEME); //set menu color
  
  gameOver = false; 
  movesCompleted = 0;
  userWon = false;
  aiWon = false;
  endedInDraw = false;
  
  //reset all squares
  for(int i = 0; i < 9; i++){
     allSquares[i].isAvailable = true;
     allSquares[i].takenBy = 30; 
     allSquares[i].setImage(new String[] { "blank.png", "blank.png", "blank.png" });
  }
  
  //pick whether user is X or O
  double randomDouble = Math.random();  
  if(randomDouble > .5){
    userIcon = 'x';
    aiIcon = 'o';
  }
  else{
    userIcon = 'o';
    aiIcon = 'x';
  }
  if(userIcon == 'o'){
     aiPick(); 
  }
}

private void checkMove(Square square, boolean userSelectedMove){
  boolean aValidSquareWasPicked = false;
  if(square.isAvailable){
    square.setImage(selectProperIcon(userSelectedMove));
    square.isAvailable = false;
    square.setTakenBy(userSelectedMove);
    movesCompleted++;
    checkForVictory();
    aValidSquareWasPicked = true;
  }
  if(movesCompleted == 9 & !gameOver){
      gameOver = true;
      endedInDraw = true;
      Menu.setLocalColorScheme(GCScheme.GOLD_SCHEME);
      userMessage = "The game was a draw, click restart to play again!";
      lockSquares();
   }
  else if(userWon){
      Menu.setLocalColorScheme(GCScheme.GREEN_SCHEME);
      userMessage = "You won in " + movesCompleted + " moves, click restart to play again!"; 
      lockSquares();
   }
  else if(aiWon){
      Menu.setLocalColorScheme(GCScheme.RED_SCHEME);
      userMessage = "You are garbage and lost in " + movesCompleted + " moves, click restart to play again!"; 
      lockSquares();
  }
  else if(userSelectedMove && aValidSquareWasPicked){
      aiPick();
   }
}

private void checkForVictory(){
  int row1 = allSquares[0].takenBy + allSquares[1].takenBy + allSquares[2].takenBy;
  int row2 = allSquares[3].takenBy + allSquares[4].takenBy + allSquares[5].takenBy; 
  int row3 = allSquares[6].takenBy + allSquares[7].takenBy + allSquares[8].takenBy;
  
  int column1 = allSquares[0].takenBy + allSquares[3].takenBy + allSquares[6].takenBy;
  int column2 = allSquares[1].takenBy + allSquares[4].takenBy + allSquares[7].takenBy;
  int column3 = allSquares[2].takenBy + allSquares[5].takenBy + allSquares[8].takenBy;
  
  int topLeftDiag = allSquares[0].takenBy + allSquares[4].takenBy + allSquares[8].takenBy;
  int botLeftDiag = allSquares[6].takenBy + allSquares[4].takenBy + allSquares[2].takenBy;
  
  if( row1 == 0| row2 == 0| row3 == 0| topLeftDiag == 0| botLeftDiag == 0 | column1 == 0 | column2 == 0 |column3 == 0 ){
    gameOver = true;
    lockSquares();
    aiWon = true;
   
  }
  if( row1 == 3| row2 == 3| row3 == 3| topLeftDiag == 3| botLeftDiag == 3 | column1 == 3 | column2 == 3 | column3 == 3 ){
    gameOver = true;
    lockSquares();
    userWon = true;
  }
}

public void aiPick(){
  boolean userSelectedMove = false;
  int choosenSquare = (int) Math.floor(Math.random() * 9); 
  while(allSquares[choosenSquare].isAvailable == false){ //make sure ai does't choose an unavailable square
      choosenSquare = (int) Math.floor(Math.random() * 9); 
  }
  checkMove(allSquares[choosenSquare], userSelectedMove);
}

private String[] selectProperIcon(boolean userSelectedMove){
  if(userIcon == 'x' & !userSelectedMove){
     return new String[] {"o.png","o.png","o.png"};
  }else if(userIcon == 'x' & userSelectedMove){
     return new String[] {"x.png","x.png","x.png"};
  }else if(userIcon == 'o' & !userSelectedMove){
    return new String[] {"x.png","x.png","x.png"};
  }else{
    return new String[] {"o.png","o.png","o.png"};
  }
}

//makes all squares unclickable
private void lockSquares(){
 for(int i = 0; i < 9; i++){
   allSquares[i].isAvailable = false;
 }
}
