/*TODO - not showing last move 
*/

boolean gameOver = false, userWon = false, aiWon = false;
String oPicture = "o.png";
String xPicture = "x.png";
char userIcon;
char aiIcon;
int movesCompleted = 0;
MyImageButton[] allButtons = new MyImageButton[9];
GPanel Menu; 
GButton resetButton; 
MyImageButton imgButton1; 
MyImageButton imgButton2; 
MyImageButton imgButton3; 
MyImageButton imgButton4; 
MyImageButton imgButton5; 
MyImageButton imgButton6; 
MyImageButton imgButton7; 
MyImageButton imgButton8;
MyImageButton imgButton9; 

 public void Menuclick(GPanel source, GEvent event) { //_CODE_:Menu:303702:
  println("Menu - GPanel >> GEvent." + event + " @ " + millis());
} //_CODE_:Menu:303702:

public void resetButton_click1(GButton source, GEvent event) { //_CODE_:button1:491820:
  newGame();
  //reset the board
} //_CODE_:button1:491820:
 
public void imgButton1_click1(MyImageButton source, GEvent event) { //_CODE_:imgButton1:581601:
  checkMove(imgButton1, 1);
} //_CODE_:imgButton1:581601:

public void imgButton2_click1(MyImageButton source, GEvent event) { //_CODE_:imgButton2:699378:
   checkMove(imgButton2, 1);
} //_CODE_:imgButton2:699378:

public void imgButton3_click1(MyImageButton source, GEvent event) { //_CODE_:imgButton3:279131:
   checkMove(imgButton3, 1);
} //_CODE_:imgButton3:279131:

public void imgButton4_click1(MyImageButton source, GEvent event) { //_CODE_:imgButton4:994874:
   checkMove(imgButton4, 1);
} //_CODE_:imgButton4:994874:

public void imgButton5_click1(MyImageButton source, GEvent event) { //_CODE_:imgButton5:471892:
   checkMove(imgButton5, 1);
} //_CODE_:imgButton5:471892:

public void imgButton6_click1(MyImageButton source, GEvent event) { //_CODE_:imgButton6:368319:
   checkMove(imgButton6, 1);
} //_CODE_:imgButton6:368319:

public void imgButton7_click1(MyImageButton source, GEvent event) { //_CODE_:imgButton6:368319:
  checkMove(imgButton7, 1);
} //_CODE_:imgButton6:368319:

public void imgButton8_click1(MyImageButton source, GEvent event) { //_CODE_:imgButton6:368319:
  checkMove(imgButton8, 1);
} //_CODE_:imgButton6:368319:

public void imgButton9_click1(MyImageButton source, GEvent event) { //_CODE_:imgButton6:368319:
   checkMove(imgButton9, 1);
} //_CODE_:imgButton6:368319:

public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");

  Menu = new GPanel(this, 0, 0, 480, 16, "");
  Menu.setOpaque(true);
  Menu.addEventHandler(this, "Menuclick");
  
  resetButton = new GButton(this, 400, 0, 80, 16);
  resetButton.setText("Restart");
  resetButton.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  resetButton.addEventHandler(this, "resetButton_click1");
  Menu.addControl(resetButton);
  
  //row1
  imgButton1 = new MyImageButton(this, 40, 24, 85, 85, new String[] { "blank.png", "blank.png", "blank.png" } );
  imgButton1.addEventHandler(this, "imgButton1_click1");
  allButtons[0] = imgButton1;
  
  imgButton2 = new MyImageButton(this, 190, 24, 85, 85, new String[] { "blank.png", "blank.png", "blank.png" } );  
  imgButton2.addEventHandler(this, "imgButton2_click1");
  allButtons[1] = imgButton2;
  
  imgButton3 = new MyImageButton(this, 360, 24, 85, 85, new String[] { "blank.png", "blank.png", "blank.png" } );
  imgButton3.addEventHandler(this, "imgButton3_click1");
  allButtons[2] = imgButton3;
  

  //row2
  imgButton4 = new MyImageButton(this, 40, 133, 85, 85, new String[] { "blank.png", "blank.png", "blank.png" } );
  imgButton4.addEventHandler(this, "imgButton4_click1");
  allButtons[3] = imgButton4;
  
  imgButton5 = new MyImageButton(this, 190, 133, 85, 85, new String[] { "blank.png", "blank.png", "blank.png" } );
  imgButton5.addEventHandler(this, "imgButton5_click1");
  allButtons[4] = imgButton5;

  imgButton6 = new MyImageButton(this, 360, 133, 85, 85, new String[] { "blank.png", "blank.png", "blank.png" } );
  imgButton6.addEventHandler(this, "imgButton6_click1");
  allButtons[5] = imgButton6;
  
  
  //row 3
  imgButton7 = new MyImageButton(this, 40, 235, 85, 85, new String[] { "blank.png", "blank.png", "blank.png" } );
  imgButton7.addEventHandler(this, "imgButton7_click1");
  allButtons[6] = imgButton7;
  
  imgButton8 = new MyImageButton(this, 190, 235, 85, 85, new String[] { "blank.png", "blank.png", "blank.png" } );
  imgButton8.addEventHandler(this, "imgButton8_click1");
  allButtons[7] = imgButton8;
  
  imgButton9 = new MyImageButton(this, 360, 235, 85, 85, new String[] { "blank.png", "blank.png", "blank.png" } );
  imgButton9.addEventHandler(this, "imgButton9_click1");
  allButtons[8] = imgButton9;
}

private void checkMove(MyImageButton square, int caller){
  if(square.isAvailable){
    square.setImage(choosePicture(caller));
    square.isAvailable = false;
    square.takenBy = caller;
    movesCompleted++;
    checkForVictory();
  }
   if(movesCompleted == 9 & !gameOver){
       gameOver = true;
       popUp("The game was a draw, would you like to play again?");
   }else if(!gameOver & caller == 1){
        aiPick();
   }else if(userWon){
      popUp("You won, would you like to play again?"); 
   }else if(aiWon){
      popUp("You lost, would you like to play again?"); 
   }
}

private void checkForVictory(){
  int row1 = allButtons[0].takenBy + allButtons[1].takenBy + allButtons[2].takenBy;
  int row2 = allButtons[3].takenBy + allButtons[4].takenBy + allButtons[5].takenBy; 
  int row3 = allButtons[6].takenBy + allButtons[7].takenBy + allButtons[8].takenBy;
  
  int column1 = allButtons[0].takenBy + allButtons[3].takenBy + allButtons[6].takenBy;
  int column2 = allButtons[1].takenBy + allButtons[4].takenBy + allButtons[7].takenBy;
  int column3 = allButtons[2].takenBy + allButtons[5].takenBy + allButtons[8].takenBy;
  
  int topLeftDiag = allButtons[0].takenBy + allButtons[4].takenBy + allButtons[8].takenBy;
  int botLeftDiag = allButtons[6].takenBy + allButtons[4].takenBy + allButtons[2].takenBy;
  
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
  int randomSquare = (int) Math.floor(Math.random() * 9); 
  while(allButtons[randomSquare].isAvailable == false){
      randomSquare = (int) Math.floor(Math.random() * 9); 
  }
  checkMove(allButtons[randomSquare], 0);
}

//int aiPick == 0 means this method was called by the ai
protected String[] choosePicture(int aiPick){
  if(userIcon == 'x' & aiPick == 0){
     return new String[] {"o.png","o.png","o.png"};
  }else if(userIcon == 'x' & aiPick == 1){
     return new String[] {"x.png","x.png","x.png"};
  }else if(userIcon == 'o' & aiPick == 0){
    return new String[] {"x.png","x.png","x.png"};
  }else{
    return new String[] {"o.png","o.png","o.png"};
  }
}

private void lockSquares(){
 for(int i = 0; i < 9; i++){
   allButtons[i].isAvailable = false;
 }
}
