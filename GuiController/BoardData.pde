/**
  The GuiController is responsible for initializing the GUI and handling all events the GUI generates.
**/

import g4p_controls.*; //A procesing graphics library used for creating buttons
import peasy.*;// A g44p dependency
private String userMessage = ""; //any screen dialog to be shown to the user
private String oPicture = "o.png"; //The relative png location for an O
private String xPicture = "x.png"; //The relative png location for an X
private boolean moveMade = true; //Used to track the turn so the draw method does not spam suggest moves
private int suggestedSquare; //The grid location of a suggested move 0-8. 0 is top left, left to right top to bottom
private boolean aValidSquareWasPicked = false; //indicates if the last attempted selection by the AI or human was an available move 

public void setup(){
  size(384, 312, JAVA2D); //size is specifically scaled to png image sizes
  createGUI();
  initializeSuggestions(); //
  newGame();
}

public void draw(){  
  Menu.setText(userMessage); //display any messages to player
  if(!gameOver & moveMade & aValidSquareWasPicked){   //suggest a move
    moveMade = false;
    suggestedSquare = suggestMove();
    allSquares[suggestedSquare].setImage(new String[] {"gray" + userIcon + ".png", userIcon + ".png", "blank.png"});
  }
   if(movesCompleted == 0 & userIcon == 'x'){   //suggest a move if X
    moveMade = false;
    suggestedSquare = suggestMove();
    allSquares[suggestedSquare].setImage(new String[] {"gray" + userIcon + ".png", userIcon + ".png", "blank.png"});
  }
  if(movesCompleted == 1 & userIcon == 'o'){   //suggest a first move if O
    moveMade = false;
    suggestedSquare = suggestMove();
    allSquares[suggestedSquare].setImage(new String[] {"gray" + userIcon + ".png", userIcon + ".png", "blank.png"});
  }
}

//monitors system for crtl+z and to un do a move
void keyPressed() {
     if (key == 0x1A) { //cntrl + z combo
       if(movesCompleted == 1 & userIcon == 'x'){
           resetSquare(moveOrder.remove(moveOrder.size() -1));
           allSquares[suggestedSquare].setImage(new String[] {"blank.png", userIcon + ".png", "blank.png"});  //erase suggestion
           userMessage = "";
           moveMade = true;
           Menu.setLocalColorScheme(GCScheme.BLUE_SCHEME);
           return;
       }
       if(userIcon == 'x' & movesCompleted == 9){
           resetSquare(moveOrder.remove(moveOrder.size() -1));
           allSquares[suggestedSquare].setImage(new String[] {"blank.png", userIcon + ".png", "blank.png"});  //erase suggestion
           userMessage = "";
           moveMade = true;
           gameOver = false; userWon = false; aiWon = false; endedInDraw = false; //unend game if undoing last move
           Menu.setLocalColorScheme(GCScheme.BLUE_SCHEME);
           allSquares[suggestedSquare].setImage(new String[] {"blank.png", userIcon + ".png", "blank.png"});  //erase suggestion
           unlockSquares();
           return;
       }
       if(movesCompleted < 2 ){//ensure user cant undo a move before they have made one
          Menu.setLocalColorScheme(GCScheme.RED_SCHEME);
          userMessage = "You haven't made a move yet!";
          return;
       }
      
     gameOver = false; userWon = false; aiWon = false; endedInDraw = false; //unend game if undoing last move
     resetSquare(moveOrder.remove(moveOrder.size() -1)); //set last square to be empty
     resetSquare(moveOrder.remove(moveOrder.size() -1));

     allSquares[suggestedSquare].setImage(new String[] {"blank.png", userIcon + ".png", "blank.png"});  //erase suggestion
     unlockSquares();
     moveMade = true;
     userMessage = "";
     Menu.setLocalColorScheme(GCScheme.BLUE_SCHEME);
  }
}
//if user goes first and finishes game allows to back up until goes first 2x

//resets menu color to blue when ctrl+z is released
void keyReleased(){
   if (key == 0x1A) { //cntrl + z combo
       userMessage = "";
       Menu.setLocalColorScheme(GCScheme.BLUE_SCHEME);
   }
   if (key == 'z') { //cntrl + z combo
       userMessage = "";
       Menu.setLocalColorScheme(GCScheme.BLUE_SCHEME);
   }
}

//resets a board index with a blank picture and resets its state to be available
private void resetSquare(int square){
    movesCompleted--;
    allSquares[square].setImage(new String[] {"blank.png", userIcon+".png", "blank.png"});
    allSquares[square].setAvailable(true);
    allSquares[square].setTakenBy(30);
}

//wipes the board and starts a fresh game
protected void newGame(){
  newBoard();
  userMessage = "";
  Menu.setText(userMessage);
  Menu.setLocalColorScheme(GCScheme.BLUE_SCHEME); //set menu color
  moveMade = true;
  aValidSquareWasPicked = false;
}

//be O and and pick bottom left

//checks if a desired move is not already taken, displays the appropriate icon if move is legal
//checks for end game states with helper method checkForVictory()
//userSelected move 0=AI is calling this method, 1=human is calling
protected void checkMove(int index, Square square, int userSelectedMove){
  aValidSquareWasPicked = false;
  if(square.getAvailability()){
    square.setImage(selectIconToDisplay(userSelectedMove));
    square.setAvailable(false);
    square.setTakenBy(userSelectedMove);
    movesCompleted++;
    checkForVictory();
    aValidSquareWasPicked = true;
    moveMade = true; //so draw doesnt suggest multiple squares 
    moveOrder.add(index);
    if(suggestedSquare != index & userSelectedMove == 1 & movesCompleted != 9){ //erase suggestion if it wasn't choosen
      allSquares[suggestedSquare].setImage(new String[] {"blank.png", userIcon + ".png", "blank.png"});
    }
  }

  //check for end game states or have AI make a move
  if(movesCompleted == 9 & !gameOver){
      gameOver = true;
      endedInDraw = true;
      Menu.setLocalColorScheme(GCScheme.GOLD_SCHEME);
      userMessage = "The game was a draw, click restart!";
      lockSquares();
   }
  else if(userWon){
      Menu.setLocalColorScheme(GCScheme.GREEN_SCHEME);
      userMessage = "You won in " + movesCompleted + " moves, click restart!"; 
      lockSquares();
   }
  else if(aiWon){
      Menu.setLocalColorScheme(GCScheme.RED_SCHEME);
      userMessage = "Way to go!!!! You lost in " + movesCompleted + " moves"; 
      lockSquares();
  }
  else if(userSelectedMove == 1 && aValidSquareWasPicked){
      aiPick();
   }
}

//selects the correct icon to display on the screen based on whose turn it is (userSelectedMove indicates user turn)
private String[] selectIconToDisplay(int userSelectedMove){
  if(userIcon == 'x' & userSelectedMove == 0){
     return new String[] {"o.png","o.png","o.png"};
  }else if(userIcon == 'x' & userSelectedMove == 1){
     return new String[] {"x.png","x.png","x.png"};
  }else if(userIcon == 'o' & userSelectedMove == 0){
    return new String[] {"x.png","x.png","x.png"};
  }else{
    return new String[] {"o.png","o.png","o.png"};
  }
}
