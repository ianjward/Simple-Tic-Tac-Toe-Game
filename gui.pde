/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void imgButton1_click1(GImageButton source, GEvent event) { //_CODE_:imgButton1:581601:
  println("imgButton1 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButton1:581601:

public void imgButton2_click1(GImageButton source, GEvent event) { //_CODE_:imgButton2:699378:
  println("imgButton2 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButton2:699378:

public void imgButton3_click1(GImageButton source, GEvent event) { //_CODE_:imgButton3:279131:
  println("imgButton3 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButton3:279131:

public void Menuclick(GPanel source, GEvent event) { //_CODE_:Menu:303702:
  println("Menu - GPanel >> GEvent." + event + " @ " + millis());
} //_CODE_:Menu:303702:

public void button1_click1(GButton source, GEvent event) { //_CODE_:button1:491820:
  println("button1 - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:button1:491820:

public void imgButton4_click1(GImageButton source, GEvent event) { //_CODE_:imgButton4:994874:
  println("imgButton4 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButton4:994874:

public void imgButton5_click1(GImageButton source, GEvent event) { //_CODE_:imgButton5:471892:
  println("imgButton5 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButton5:471892:

public void imgButton6_click1(GImageButton source, GEvent event) { //_CODE_:imgButton6:368319:
  println("imgButton6 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButton6:368319:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  imgButton1 = new GImageButton(this, 40, 24, 90, 90, new String[] { "tra.png", "o.png", "o.png" } );
  imgButton1.addEventHandler(this, "imgButton1_click1");
  imgButton2 = new GImageButton(this, 200, 24, 90, 90, new String[] { "x.png", "o.png", "x.png" } );
  imgButton2.addEventHandler(this, "imgButton2_click1");
  imgButton3 = new GImageButton(this, 40, 128, 90, 90, new String[] { "x.png", "o.png", "x.png" } );
  imgButton3.addEventHandler(this, "imgButton3_click1");
  Menu = new GPanel(this, 0, 0, 480, 16, "");
  Menu.setOpaque(true);
  Menu.addEventHandler(this, "Menuclick");
  button1 = new GButton(this, 400, 0, 80, 16);
  button1.setText("Restart");
  button1.setLocalColorScheme(GCScheme.GOLD_SCHEME);
  button1.addEventHandler(this, "button1_click1");
  Menu.addControl(button1);
  imgButton4 = new GImageButton(this, 200, 128, 90, 90, new String[] { "o.png", "o.png", "o.png" } );
  imgButton4.addEventHandler(this, "imgButton4_click1");
  imgButton5 = new GImageButton(this, 336, 24, 90, 90, new String[] { "o.png", "o.png", "o.png" } );
  imgButton5.addEventHandler(this, "imgButton5_click1");
  imgButton6 = new GImageButton(this, 336, 128, 90, 90, new String[] { "x.png", "x.png", "x.png" } );
  imgButton6.addEventHandler(this, "imgButton6_click1");
}

// Variable declarations 
// autogenerated do not edit
GImageButton imgButton1; 
GImageButton imgButton2; 
GImageButton imgButton3; 
GPanel Menu; 
GButton button1; 
GImageButton imgButton4; 
GImageButton imgButton5; 
GImageButton imgButton6; 
