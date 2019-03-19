import g4p_controls.*;
import processing.core.*;

public class MyImageButton extends GImageButton { 
   boolean isAvailable = true;
   int takenBy = 30; //30 was choosen as the calculations for deciding victory can not contain 30
   
    public MyImageButton(PApplet theApplet, float p0, float p1, float p2, float p3, String[] fnames) {
        super(theApplet, p0, p1, p2, p3, fnames, null);
    }
    
    public void setImage(String[] fnames) {
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
