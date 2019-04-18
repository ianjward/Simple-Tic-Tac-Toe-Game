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

public void setup(){
  size(384, 312, JAVA2D); //size is specifically scaled to png image sizes
  createGUI();
  initializeSuggestions(); //
  newGame();
}

public void draw(){  
  Menu.setText(userMessage); //display any messages to player
  if(!gameOver & moveMade){   //suggest a move
    moveMade = false;
    suggestedSquare = suggestMove();
    allSquares[suggestedSquare].setImage(new String[] {"gray" + userIcon + ".png", userIcon + ".png", "blank.png"});
  }
}

//wipes the board and starts a fresh game
protected void newGame(){
  newBoard();
  userMessage = "";
  Menu.setText(userMessage);
  Menu.setLocalColorScheme(GCScheme.BLUE_SCHEME); //set menu color
  moveMade = true;
}

//checks if a desired move is not already taken, displays the appropriate icon if move is legal
//checks for end game states with helper method checkForVictory()
protected void checkMove(int index, Square square, boolean userSelectedMove){
  boolean aValidSquareWasPicked = false;
  if(square.getAvailability()){
    square.setImage(selectIconToDisplay(userSelectedMove));
    square.setAvailable(false);
    square.setTakenBy(userSelectedMove);
    movesCompleted++;
    checkForVictory();
    aValidSquareWasPicked = true;
    moveMade = true; //so draw doesnt suggest multiple squares 
    
    if(suggestedSquare != index & userSelectedMove){ //erase suggestion
      allSquares[suggestedSquare].setImage(new String[] {"blank.png", userIcon + ".png", "blank.png"});
    }
  }
  
  //check for end game states or have AI make a move
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
      userMessage = "Way to go!!!! You lost in " + movesCompleted + " moves"; 
      lockSquares();
  }
  else if(userSelectedMove && aValidSquareWasPicked){
      aiPick();
   }
}

//selects the correct icon to display on the screen based on whose turn it is (userSelectedMove indicates user turn)
private String[] selectIconToDisplay(boolean userSelectedMove){
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
