/**
  The GuiController is responsible for initializing the GUI and handling all events the GUI generates.
**/

import g4p_controls.*;
import peasy.*;
import javax.swing.JOptionPane;  
private String userMessage = "";
private String oPicture = "o.png";
private String xPicture = "x.png";
private boolean moveMade = true;
private int suggestedSquare;

public void setup(){
  size(384, 312, JAVA2D);
  createGUI();
  initializeSuggestions();
  newGame();
}

public void draw(){  
  //create an end of game message if needed
  if(userWon | aiWon | endedInDraw){
     Menu.setText(userMessage);
  }
  //make a suggestion --moveMade boolean ensures draw does not suggest more than 1 move per turn
  if(!gameOver & mouseHovering() & moveMade){
    moveMade = false;
    suggestedSquare = suggestMove();
      allSquares[suggestedSquare].setImage(new String[] {"gray" + userIcon + ".png", userIcon + ".png", "blank.png"});
  }
}

protected void newGame(){
  newBoard();
  userMessage = "";
  Menu.setText(userMessage);
  Menu.setLocalColorScheme(GCScheme.BLUE_SCHEME); //set menu color
  moveMade = true;
}

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
    //erase suggestion
    if(suggestedSquare != index & userSelectedMove){
      allSquares[suggestedSquare].setImage(new String[] {"blank.png", userIcon + ".png", "blank.png"});
    }
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
      userMessage = "You are garbage and lost in " + movesCompleted + " moves"; 
      lockSquares();
  }
  else if(userSelectedMove && aValidSquareWasPicked){
      aiPick();
   }
}

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

private boolean mouseHovering(){
    return true;
}

