/**
  The Gui is responsible for generating the initial blank squares and creating action listeners for each square.
**/
GPanel Menu; //A container for the reset button
GButton resetButton; 
GButton redundantCloseButton;
Square imgButton1; //one imageButton for each clickable square
Square imgButton2; 
Square imgButton3; 
Square imgButton4; 
Square imgButton5; 
Square imgButton6; 
Square imgButton7;
Square imgButton8;
Square imgButton9; 

//initial build of the game board
protected void createGUI(){
  drawGrid();
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");

  //create purple menu
  Menu = new GPanel(this, 0, 0, 480, 16, "");
  Menu.setOpaque(true);
  Menu.setDraggable(false);
  Menu.addEventHandler(this, "Menuclick");
  
  //create reset button
  resetButton = new GButton(this, 280, 0, 60, 16);
  resetButton.setText("Restart");
  resetButton.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  resetButton.addEventHandler(this, "resetButton_click1");
  Menu.addControl(resetButton);
  
  //create redundant close button
  redundantCloseButton = new GButton(this, 345, 0, 40, 16);
  redundantCloseButton.setText("Quit");
  redundantCloseButton.setLocalColorScheme(GCScheme.RED_SCHEME);
  redundantCloseButton.addEventHandler(this, "closeClicked");
  Menu.addControl(redundantCloseButton);
  
  // create row1
  imgButton1 = new Square(this, 0, 16, 120, 90, new String[] { "blank.png", "blank.png", "blank.png" } );
  imgButton1.addEventHandler(this, "imgButton1_click1");
  allSquares[0] = imgButton1;
  
  imgButton2 = new Square(this, 132, 16, 120, 90, new String[] { "blank.png", "blank.png", "blank.png" } );  
  imgButton2.addEventHandler(this, "imgButton2_click1");
  allSquares[1] = imgButton2;
  
  imgButton3 = new Square(this, 264, 16, 120, 90, new String[] { "blank.png", "blank.png", "blank.png" } );
  imgButton3.addEventHandler(this, "imgButton3_click1");
  allSquares[2] = imgButton3;
  

  //create row2
  imgButton4 = new Square(this, 0, 119, 120, 90, new String[] { "blank.png", "blank.png", "blank.png" } );
  imgButton4.addEventHandler(this, "imgButton4_click1");
  allSquares[3] = imgButton4;
  
  imgButton5 = new Square(this, 132, 119, 120, 90, new String[] { "blank.png", "blank.png", "blank.png" } );
  imgButton5.addEventHandler(this, "imgButton5_click1");
  allSquares[4] = imgButton5;

  imgButton6 = new Square(this, 264, 119, 120, 90, new String[] { "blank.png", "blank.png", "blank.png" } );
  imgButton6.addEventHandler(this, "imgButton6_click1");
  allSquares[5] = imgButton6;
  
  
  //create row 3
  imgButton7 = new Square(this, 0, 221, 120, 90, new String[] { "blank.png", "blank.png", "blank.png" } );
  imgButton7.addEventHandler(this, "imgButton7_click1");
  allSquares[6] = imgButton7;
  
  imgButton8 = new Square(this, 132, 221, 120, 90, new String[] { "blank.png", "blank.png", "blank.png" } );
  imgButton8.addEventHandler(this, "imgButton8_click1");
  allSquares[7] = imgButton8;
  
  imgButton9 = new Square(this, 264, 221, 120, 90, new String[] { "blank.png", "blank.png", "blank.png" } );
  imgButton9.addEventHandler(this, "imgButton9_click1");
  allSquares[8] = imgButton9;
}

//draws the lines that seperate the board into 9 sections
private void drawGrid(){
   color c = color(255,255,255);
   background(c, 230);
   PShape cross1, cross2, vertCross1, vertCross2;
  
   cross1 = createShape(RECT,0,107,width,10); //top horizontal 
   cross1.setFill(color(0,0,0,0));
   
   cross2 = createShape(RECT,0,209,width,10); //bottom horizontal
   cross2.setFill(color(0,0,0,0));
   
   vertCross1 = createShape(RECT,120,0,10,height); //left vertical
   vertCross1.setFill(color(0,0,0,0));
   
   vertCross2 = createShape(RECT,251,0,10,height); //right vertical
   vertCross2.setFill(color(0,0,0,0));
   
   //actually draws the shapes on the board
   shape(cross1);
   shape(cross2);
   shape(vertCross1);
   shape(vertCross2);
}

//add all the listeners to the buttons
public void Menuclick(GPanel source, GEvent event) { 
} 

public void resetButton_click1(GButton source, GEvent event) { 
  newGame();
} 

public void closeClicked(GButton source, GEvent event){
   exit();
}
 
public void imgButton1_click1(Square source, GEvent event) { 
  boolean userSelectedMove = true;
  checkMove(0,imgButton1, 1);
} 

public void imgButton2_click1(Square source, GEvent event) { 
   boolean userSelectedMove = true;
   checkMove(1,imgButton2, 1 );
} 

public void imgButton3_click1(Square source, GEvent event) { 
   boolean userSelectedMove = true;
   checkMove(2,imgButton3, 1 );
}

public void imgButton4_click1(Square source, GEvent event) { 
   boolean userSelectedMove = true;
   checkMove(3,imgButton4, 1 );
} 

public void imgButton5_click1(Square source, GEvent event) { 
   boolean userSelectedMove = true;
   checkMove(4,imgButton5, 1 );
} 

public void imgButton6_click1(Square source, GEvent event) { 
   boolean userSelectedMove = true;
   checkMove(5,imgButton6, 1 );
}

public void imgButton7_click1(Square source, GEvent event) { 
  boolean userSelectedMove = true;
  checkMove(6,imgButton7, 1 );
} 

public void imgButton8_click1(Square source, GEvent event) { 
  boolean userSelectedMove = true;
  checkMove(7,imgButton8, 1 );
} 

public void imgButton9_click1(Square source, GEvent event) { 
  boolean userSelectedMove = true;
  checkMove(8,imgButton9, 1 );
} 
