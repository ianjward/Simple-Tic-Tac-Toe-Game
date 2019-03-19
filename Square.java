/**
  The Square class is responsible for tracking if it has been marked and by whom. It will display the appropriate picture as necessary.
**/

import g4p_controls.*;
import processing.core.*;

public class Square extends GImageButton { 
   boolean isAvailable = true;
   int takenBy = 30; //30 was choosen as the calculations for deciding victory can not possibly sum to 30
   
    public Square(PApplet theApplet, float p0, float p1, float p2, float p3, String[] fnames) {
        super(theApplet, p0, p1, p2, p3, fnames, null);
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
    if(bimage.length != 3){
        PImage[] temp = new PImage[3];
        for(int i = 0; i < 3; i++)
          temp[i] = bimage[Math.min(i, bimage.length - 1)];
        bimage = temp;
    }
    //======================================
    // resize images if needed
  
    for(int i = 0; i < bimage.length; i++){
        if(bimage[i].width != width || bimage[i].height != height)
          bimage[i].resize((int)width, (int)height);                    
     }  
  }
}
