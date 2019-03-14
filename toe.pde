// Need G4P library
import g4p_controls.*;
import peasy.*;
import javax.swing.JOptionPane;  

public void setup(){
  size(480, 320, JAVA2D);//480x320 original
  createGUI();
  newGame();
}

protected void newGame(){
  //need to resize icons so they fit perfectly
  for(int i = 0; i < 9; i++){
     allButtons[i].isAvailable = true;
     allButtons[i].takenBy = 30; 
     allButtons[i].setImage(new String[] { "blank.png", "blank.png", "blank.png" });
  }
  gameOver = false;
  double randomDouble = Math.random();  //set x or o for user
  if(randomDouble > .5){
    userIcon = 'x';
    aiIcon = 'o';
  }else{
    userIcon = 'o';
    aiIcon = 'x';
  }
  movesCompleted = 0;
  userWon = false;
  aiWon = false;
}

public void draw(){
  color c = color(255,255,255);
  background(c, 230);
  drawGrid();
}

private void drawGrid(){
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

public void popUp(String message){
  JOptionPane pane = new JOptionPane();
  int choice = pane.showConfirmDialog(null,message, message, JOptionPane.YES_NO_OPTION);
  if(choice == 0){
    newGame();
  }else{
      lockSquares();
      userWon = false;
      aiWon = false;
  }
}
