/**
  The Square class is responsible for tracking if it has been marked and by whom. It will display the appropriate picture as necessary.
**/
import g4p_controls.*; //needed for action listeners
import processing.core.*; //a g4p dependency

public class Square extends GImageButton { 
   private boolean isAvailable = true; 
   private int takenBy = 30; //30 means the square is available, 1=Human occupied 0=AI occupied 
   private String currentImage = ""; //the image to be displayed on the square
   
  public Square(PApplet theApplet, float p0, float p1, float p2, float p3, String[] fnames) {
      super(theApplet, p0, p1, p2, p3, fnames, null);
      currentImage = fnames[0];
  }
    
  //sets the image of a square 
  //fnames is an array of file locations, index 0 holds file location for 
  //the picture the button displays on click
  //index 1 is the image location for the button on hover
  //index 2 is the image location for the button on click and hold
  protected void setImage(String[] fnames) {
    bimage = ImageManager.loadImage(winApp, fnames);
    currentImage = fnames[0];
    if(bimage.length != 3){
        PImage[] temp = new PImage[3];
        for(int i = 0; i < 3; i++)
          temp[i] = bimage[Math.min(i, bimage.length - 1)];
        bimage = temp;
        }
  }
   protected String getCurrentImage(){
      return currentImage;
    }
    protected void setAvailable(boolean availability){
      isAvailable = availability;
    }
    
    protected boolean getAvailability(){
      return isAvailable;
    }
    protected void setTakenBy(int x){
      takenBy = x;
    }
    protected int getTakenBy(){
      return takenBy;
    }
}
