
protected boolean gameOver = false, userWon = false, aiWon = false, endedInDraw = false;
protected int movesCompleted = 0;
protected char userIcon;
protected char aiIcon;
Square[] allSquares = new Square[9];
int row1;
int row2;
int row3;
int column1;
int column2;
int column3;
int topLeftDiag;
int botLeftDiag;


protected void newBoard(){
  gameOver = false;
  userWon = false;
  aiWon = false;
  endedInDraw = false;
  movesCompleted = 0;
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
 //reset all squares
 for(int i = 0; i < 9; i++){
     allSquares[i].setAvailable(true);
     allSquares[i].setTakenBy(30); 
     allSquares[i].setImage(new String[] { "blank.png", userIcon + ".png", "blank.png" });
  }
  
 if(userIcon == 'o'){
     aiPick(); 
  }
}

protected void checkForVictory(){
  row1 = allSquares[0].getTakenBy() + allSquares[1].getTakenBy() + allSquares[2].getTakenBy();
  row2 = allSquares[3].getTakenBy() + allSquares[4].getTakenBy() + allSquares[5].getTakenBy(); 
  row3 = allSquares[6].getTakenBy() + allSquares[7].getTakenBy() + allSquares[8].getTakenBy();
  
  column1 = allSquares[0].getTakenBy() + allSquares[3].getTakenBy() + allSquares[6].getTakenBy();
  column2 = allSquares[1].getTakenBy() + allSquares[4].getTakenBy() + allSquares[7].getTakenBy();
  column3 = allSquares[2].getTakenBy() + allSquares[5].getTakenBy() + allSquares[8].getTakenBy();
  
  topLeftDiag = allSquares[0].getTakenBy() + allSquares[4].getTakenBy() + allSquares[8].getTakenBy();
  botLeftDiag = allSquares[6].getTakenBy() + allSquares[4].getTakenBy() + allSquares[2].getTakenBy();
  
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

//makes all squares unclickable
protected void lockSquares(){
   for(int i = 0; i < 9; i++){
     allSquares[i].setAvailable(false);
     allSquares[i].setImage(new String[] { allSquares[i].getCurrentImage(), allSquares[i].getCurrentImage(), "blank.png" });
   }
}
 
public void aiPick(){
    boolean userSelectedMove = false;
    int chosenSquare = suggestAiMove();
    checkMove(chosenSquare, allSquares[chosenSquare], userSelectedMove);
  }
