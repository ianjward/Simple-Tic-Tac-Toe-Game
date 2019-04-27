/**
  The BoardData tracks the state of the game currently in progress.
**/
protected boolean gameOver = false, userWon = false, aiWon = false, endedInDraw = false;
protected int movesCompleted = 0;
protected char userIcon; //an X or O
protected char aiIcon;
//the sum of all the markers in row/coumn/diagonal
//a human square counts as 1, AI = 0, available = 30
private int row1; 
private int row2;
private int row3;
private int column1;
private int column2;
private int column3;
private int topLeftDiag;
private int botLeftDiag;
Square[] allSquares = new Square[9]; //current state of squares on the board
ArrayList<Integer> moveOrder = new ArrayList();

//wipes the board clean
protected void newBoard(){
  gameOver = false;
  userWon = false;
  aiWon = false;
  endedInDraw = false;
  movesCompleted = 0;
  moveOrder = new ArrayList();
 
  double randomDouble = Math.random();   //pick whether user is X or O
  if(randomDouble > .5){
      userIcon = 'x';
      aiIcon = 'o';
  }
  else{
     userIcon = 'o';
     aiIcon = 'x';
  }
  
  for(int i = 0; i < 9; i++){  //reset all squares
     allSquares[i].setAvailable(true);
     allSquares[i].setTakenBy(30); 
     allSquares[i].setImage(new String[] { "blank.png", userIcon + ".png", "blank.png" });
  }
  
  if(userIcon == 'o'){ //make sure X always starts
     aiPick(); 
  }
}

//checks if game is over
protected void checkForVictory(){
  //sum the rows columns and diagonals
  row1 = allSquares[0].getTakenBy() + allSquares[1].getTakenBy() + allSquares[2].getTakenBy();
  row2 = allSquares[3].getTakenBy() + allSquares[4].getTakenBy() + allSquares[5].getTakenBy(); 
  row3 = allSquares[6].getTakenBy() + allSquares[7].getTakenBy() + allSquares[8].getTakenBy();
  
  column1 = allSquares[0].getTakenBy() + allSquares[3].getTakenBy() + allSquares[6].getTakenBy();
  column2 = allSquares[1].getTakenBy() + allSquares[4].getTakenBy() + allSquares[7].getTakenBy();
  column3 = allSquares[2].getTakenBy() + allSquares[5].getTakenBy() + allSquares[8].getTakenBy();
  
  topLeftDiag = allSquares[0].getTakenBy() + allSquares[4].getTakenBy() + allSquares[8].getTakenBy();
  botLeftDiag = allSquares[6].getTakenBy() + allSquares[4].getTakenBy() + allSquares[2].getTakenBy();
  
  //check for AI victory
  if( row1 == 0| row2 == 0| row3 == 0| topLeftDiag == 0| botLeftDiag == 0 | column1 == 0 | column2 == 0 |column3 == 0 ){
    gameOver = true;
    lockSquares();
    aiWon = true;
 }
  //Check for human victory
  if( row1 == 3| row2 == 3| row3 == 3| topLeftDiag == 3| botLeftDiag == 3 | column1 == 3 | column2 == 3 | column3 == 3 ){
    gameOver = true;
    lockSquares();
    userWon = true;
  }
}

//makes all squares unclickable
protected void lockSquares(){
   for(int i = 0; i < 9; i++){
     allSquares[i].setAvailable(false);
     allSquares[i].setImage(new String[] { allSquares[i].getCurrentImage(), allSquares[i].getCurrentImage(), "blank.png" });
   }
}

//makes all squares that were made unclickable at the end of the game clickable
protected void unlockSquares(){
   for(int i = 0; i < 9; i++){
     if(allSquares[i].getCurrentImage() == "blank.png"){
        allSquares[i].setImage(new String[] {"blank.png", userIcon + ".png", "blank.png"}); //make sure the user icon is reenabled on hover
        allSquares[i].setAvailable(true);
        allSquares[i].setTakenBy(30);
     }
   }
}
 
//execute an AI turn 
public void aiPick(){
    int chosenSquare = suggestAiMove();
    checkMove(chosenSquare, allSquares[chosenSquare], 0);
  }
