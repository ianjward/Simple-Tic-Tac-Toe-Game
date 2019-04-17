private String[] currentMoves = new String[8];
private char[] squareValues = new char[9];
private HashMap<String,Integer> indexLookup = new HashMap<String,Integer>();

protected int suggestMove(){
  int suggestion = -1;
  currentMoves = new String[8]; //each index is a row,column or diagonal
  squareValues = new char[9]; //each state a square is in
  getCurrentMovesOnBoard(); //convert square takenby integers from 30,0,1 to H,A,C H=human,c+computer,A=available
  setRows(); 
  //check for 2 in a row
  if(indexLookup.get(checkForTwoInARow('H')) != null){
      println("you have 2 in a row");
      return indexLookup.get(checkForTwoInARow('H'));
  }
  //check for opponent 2 in a row
  if(indexLookup.get(checkForTwoInARow('C')) != null){
      println("opponent 2 in a row");
      return indexLookup.get(checkForTwoInARow('C'));
  }
  //insert check for fork
  
  //insert check for fork block
  
  //check for center
  if(squareValues[4] == 'A'){
    println("center open");
     return 4;
  }
  //check for oponent in corner
   if(indexLookup.get(checkIfOpponentInCorner('C', 'H')) != null){
       println("pick the opposite corner");
      return indexLookup.get(checkIfOpponentInCorner('C', 'H'));
  }
  
  //select corner
    
    if(squareValues[0] == 'A'){
    println("corner open");
     return 0;
    }
    if(squareValues[2] == 'A'){
    println("corner open");
     return 2;
    }
    if(squareValues[6] == 'A'){
    println("corner open");
     return 6;
    }
    if(squareValues[8] == 'A'){
    println("corner open");
     return 8;
    }
    
  suggestion = (int) Math.floor(Math.random()*8);
  while(!allSquares[suggestion].getAvailability()){
     suggestion = (int) Math.floor(Math.random()*8);
  }
  return suggestion;
}

protected int suggestAiMove(){
   int suggestion = -1;
  currentMoves = new String[8]; //each index is a row,column or diagonal
  squareValues = new char[9]; //each state a square is in
  getCurrentMovesOnBoard(); //convert square takenby integers from 30,0,1 to H,A,C H=human,c+computer,A=available
  setRows(); 
  //check for 2 in a row
  if(indexLookup.get(checkForTwoInARow('C')) != null){
      println("you have 2 in a row");
      return indexLookup.get(checkForTwoInARow('C'));
  }
  //check for opponent 2 in a row
  if(indexLookup.get(checkForTwoInARow('H')) != null){
      println("opponent 2 in a row");
      return indexLookup.get(checkForTwoInARow('H'));
  }
  //insert check for fork
  
  //insert check for fork block
  
  //check for center
  if(squareValues[4] == 'A'){
    println("center open");
     return 4;
  }
  //check for oponent in corner
   if(indexLookup.get(checkIfOpponentInCorner('H', 'C')) != null){
       println("pick the opposite corner");
      return indexLookup.get(checkIfOpponentInCorner('H', 'C'));
  }
  
  //select corner
    
    if(squareValues[0] == 'A'){
    println("corner open");
     return 0;
    }
    if(squareValues[2] == 'A'){
    println("corner open");
     return 2;
    }
    if(squareValues[6] == 'A'){
    println("corner open");
     return 6;
    }
    if(squareValues[8] == 'A'){
    println("corner open");
     return 8;
    }
    
  suggestion = (int) Math.floor(Math.random()*8);
  while(!allSquares[suggestion].getAvailability()){
     suggestion = (int) Math.floor(Math.random()*8);
  }
  return suggestion;
}

private void getCurrentMovesOnBoard(){
  for(int i = 0; i < 9;i++){
    //A = available square, C=computer owned square, H=human owned square
    if(allSquares[i].getTakenBy() == 30){
      squareValues[i] = 'A';
    }else if(allSquares[i].getTakenBy() == 0){
      squareValues[i] = 'C';
    }else{
      squareValues[i] = 'H';
    }
  }
}

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
