/**
  The Square class is responsible for tracking if it has been marked and by whom. It will display the appropriate picture as necessary.
**/

import g4p_controls.*;
import processing.core.*;

public class Square extends GImageButton { 
   private boolean isAvailable = true;
   private int takenBy = 30; //30 was choosen as the calculations for deciding victory can not possibly sum to 30
   private String currentImage = "";
   
    public Square(PApplet theApplet, float p0, float p1, float p2, float p3, String[] fnames) {
        super(theApplet, p0, p1, p2, p3, fnames, null);
        currentImage = fnames[0];
    }
    
    protected void setTakenBy(boolean takenByUser){
      if(takenByUser)
        takenBy = 1;
      else
        takenBy = 0;
    }
    
    protected void setImage(String[] fnames) {
    //======================================
    bimage = ImageManager.loadImage(winApp, fnames);
    currentImage = fnames[0];
    if(bimage.length != 3){
        PImage[] temp = new PImage[3];
        for(int i = 0; i < 3; i++)
          temp[i] = bimage[Math.min(i, bimage.length - 1)];
        bimage = temp;
    }
   
    //======================================
    // resize images if needed
  
   /* for(int i = 0; i < bimage.length; i++){
      System.out.println(width);
   
        if(bimage[i].width != width || bimage[i].height != height)
          bimage[i].resize((int)width, (int)height);                    
     }  */
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
