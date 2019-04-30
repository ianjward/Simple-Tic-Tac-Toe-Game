/**
  The MoveSuggestor is responsible for looking at the current game board and picking the optimal move.
**/
private String[] currentMoves = new String[8]; //each index represents a row/column/diagonal state on the board 
// ex: if index 0 is "HAC" the top row is  Human | Available | Computer
private char[] squareValues = new char[9]; //an H,C or A for each board position
private HashMap<String,Integer> indexLookup = new HashMap<String,Integer>(); // a map for converting row/column/diagonal indices to 
// a board position 


//returns the index of the best human move
protected int suggestMove(){
  int suggestion = -1;//the index of a suggested move
  currentMoves = new String[8]; //reset rows/columns/diagonals
  squareValues = new char[9]; //reset board positions
  getCurrentMovesOnBoard(); //update board positions
  setRows(); //update rows/columns/diagonals
  
  //check for 2 in a row
  if(indexLookup.get(checkForTwoInARow('H')) != null){
      return indexLookup.get(checkForTwoInARow('H'));
  }
  
  //check for opponent 2 in a row
  if(indexLookup.get(checkForTwoInARow('C')) != null){
      return indexLookup.get(checkForTwoInARow('C'));
  }
  
  //check for center
  if(squareValues[4] == 'A'){
     return 4;
  }
  
  //check for oponent in corner
  if(indexLookup.get(checkIfOpponentInCorner('C', 'H')) != null){
      return indexLookup.get(checkIfOpponentInCorner('C', 'H'));
  }
  //select corner
  if(squareValues[0] == 'A'){
     return 0;
  }
  if(squareValues[2] == 'A'){
    return 2;
  }
  if(squareValues[6] == 'A'){
    return 6;
  }
  if(squareValues[8] == 'A'){
    return 8;
  }
    
  //return random available square  
  suggestion = (int) Math.floor(Math.random()*8);
  while(!allSquares[suggestion].getAvailability()){
     suggestion = (int) Math.floor(Math.random()*8);
  }
  return suggestion;
}

//suggests the best move for AI
protected int suggestAiMove(){
  int suggestion = -1;//the index of a suggested move
  currentMoves = new String[8]; //reset rows/columns/diagonals
  squareValues = new char[9]; //reset board positions
  getCurrentMovesOnBoard(); //update board positions
  setRows(); //update rows/columns/diagonals
  
  //check for 2 in a row
  if(indexLookup.get(checkForTwoInARow('C')) != null){
      return indexLookup.get(checkForTwoInARow('C'));
  }
  
  //check for opponent 2 in a row
  if(indexLookup.get(checkForTwoInARow('H')) != null){
      return indexLookup.get(checkForTwoInARow('H'));
  }
  
  //check for fork
  if(movesCompleted < 5){
    if(checkForFork() != -1){
       return checkForFork(); 
    }
  }
 
  //check for fork block
  if(movesCompleted == 3){
    if(checkForForkBlock() != -1){
      return checkForForkBlock();
    }
  }
  
  //check for center
  if(squareValues[4] == 'A'){
     return 4;
  }
  
  //check for oponent in corner
   if(indexLookup.get(checkIfOpponentInCorner('H', 'C')) != null){
      return indexLookup.get(checkIfOpponentInCorner('H', 'C'));
  }
  
  //select corner
  if(squareValues[0] == 'A'){
     return 0;
  }
  if(squareValues[2] == 'A'){
     return 2;
  }
  if(squareValues[6] == 'A'){
     return 6;
  }
  if(squareValues[8] == 'A'){
     return 8;
  }
    
  //suggest random available square  
  suggestion = (int) Math.floor(Math.random()*8);
  while(!allSquares[suggestion].getAvailability()){
     suggestion = (int) Math.floor(Math.random()*9);
  }
  return suggestion;
}

//fill squareValues[] with 'H' 'C' or 'A' based on current board status
private void getCurrentMovesOnBoard(){
  for(int i = 0; i < 9;i++){
    if(allSquares[i].getTakenBy() == 30){
      squareValues[i] = 'A';
    }else if(allSquares[i].getTakenBy() == 0){
      squareValues[i] = 'C';
    }else{
      squareValues[i] = 'H';
    }
  }
}

//update current rows,columns,diagonals with string representations
private void setRows(){
  //rows
  currentMoves[0] = "" + squareValues[0] + squareValues[1] + squareValues[2];
  currentMoves[1] = "" + squareValues[3] + squareValues[4] + squareValues[5]; 
  currentMoves[2] = "" + squareValues[6] + squareValues[7] + squareValues[8];
  
  //columns
  currentMoves[3] = "" + squareValues[0] + squareValues[3] + squareValues[6];
  currentMoves[4] = "" + squareValues[1] + squareValues[4] + squareValues[7];
  currentMoves[5] = "" + squareValues[2] + squareValues[5] + squareValues[8];
  
  //diagonals
  currentMoves[6] = "" + squareValues[0] + squareValues[4] + squareValues[8];
  currentMoves[7] = "" + squareValues[6] + squareValues[4] + squareValues[2]; 
}

//checks for a row/column/diagonal with two player squares and an available square
//returns String: first char is the row/column/diagonal index and the second is the
//index of the available square in that row, The map converts this string to a single square location.
//returns null if no examples are found
private String checkForTwoInARow(char player){
  for(int i = 0; i < 8; i++){
    if(currentMoves[i].equals("A"+ player + player))
      return (i + "" + 0);
    if(currentMoves[i].equals(player+"A" + player))
      return (i + "" + 1); 
    if(currentMoves[i].equals(""+ player + player + "A"))
      return (i + "" + 2);
  }
   return null;
}

//checks for an opponent row/column/diagonal with two player squares and an available square
//returns String: first char is the row/column/diagonal index and the second is the
//index of the available square in that row, The map converts this string to a single square location.
//returns null if no examples are found
private String checkIfOpponentInCorner(char opponent, char player){
  for(int i = 6; i < 8; i++){
    if(currentMoves[i].equals("AA" + opponent)){
      return (i + "" + 0);
    }
    if(currentMoves[i].equals("A" + player + opponent)){
      return (i + "" + 0);
    }
    if(currentMoves[i].equals(""+ opponent + "AA")){
      return (i + "" + 2);
    }
    if(currentMoves[i].equals("" + opponent + player + "A")){
      return (i + "" + 2);
    } 
  }
  return null;
}

// Check for potential to create any fork
// returns the grid position for the optimal move, -1 if no fork potential
private int checkForFork(){
  for(int i = 6; i < 8; i++){ //6+7 are the diagonals (only possible forks given the computers intelligence)
    if(currentMoves[i].equals("CCH") & squareValues[1] == 'H' & movesCompleted < 6){ //makes sure forks aren't suggested late in game
      return 3;
    }
    if(currentMoves[i].equals("CCH") & squareValues[3] == 'H' & movesCompleted < 6){
      return 1;
    }
    if(currentMoves[i].equals("HCC") & squareValues[5] == 'H' & movesCompleted < 6){
      return 7;
    }
    if(currentMoves[i].equals("HCC") & squareValues[7] == 'H' & movesCompleted < 6){
      return 5;
    }
  }
  return -1;
}

//checks for blocking a future fork
private int checkForForkBlock(){
  if(currentMoves[2].equals("AHA") & currentMoves[5].equals("AHA")){
    return 8;
  }
  for(int i = 6; i < 8; i++){ //6+7 are the diagonals 
    if(currentMoves[i].equals("HCH")){
      return 1;
    }
  }
   return -1;
}

//maps row, column and diagonals to square grid locations ex:
//"00" the first 0 stands for the first row, the second 0 is the 0th element in the first row: 
//    maps to 0 (top left square) --------------------------------------------------------------------> 0 | 1 | 2
//"12" second row, index 2 --> 5                                                                        3 | 4 | 5
//"31" first column, index 1 --> 3                                                                      6 | 7 | 8
//"72" diagonal starting at top left corner, index 2 --> 8                                                                                      
protected void initializeSuggestions(){          
  indexLookup.put("00",0);
  indexLookup.put("01",1);
  indexLookup.put("02",2); 
  indexLookup.put("10",3);
  indexLookup.put("11",4);
  indexLookup.put("12",5);  
  indexLookup.put("20",6);
  indexLookup.put("21",7);
  indexLookup.put("22",8);
  indexLookup.put("30",0);
  indexLookup.put("31",3);
  indexLookup.put("32",6);
  indexLookup.put("40",1);
  indexLookup.put("41",4);
  indexLookup.put("42",7);
  indexLookup.put("50",2);
  indexLookup.put("51",5);
  indexLookup.put("52",8);
  indexLookup.put("60",0);
  indexLookup.put("61",4);
  indexLookup.put("62",8);
  indexLookup.put("70",6);
  indexLookup.put("71",4);
  indexLookup.put("72",2);
}
