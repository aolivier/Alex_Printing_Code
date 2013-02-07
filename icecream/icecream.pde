/*  Properties
_________________________________________________________________ */

import processing.pdf.*;

// Set these variables to the print size you want (in inches)
// The resulting PDF will be this aspect ratio
float print_width = 8.5;
float print_height = 11;

// This will help make the sketch window bigger
float make_bigger = 40;
  float x_center = print_width*make_bigger/2;
  float y_center = print_height*make_bigger/2;

/*  Setup
_________________________________________________________________ */

void setup()
{
  size(round(print_width * make_bigger), round(print_height * make_bigger));
  


  beginRecord(PDF, "grab.pdf"); 

background(0,0,0); 
  smooth();
  fill(255,255,255);
  noStroke();
 
  triangle(x_center-45,130,x_center+45,130,x_center,405);
  ellipse(x_center,y_center-90,90,90);
  sprinkles();
  endRecord();
}

public void sprinkles(){
 
 int numSprinkles = int(random(30,60));

 for (int i=0; i<numSprinkles; i++){
   
   fill(0,0,0);
   rectMode(CENTER);
   int x = int(random(x_center-50,x_center+50));
   int y = int(random(y_center-150,y_center-100));
   pushMatrix();
   translate(x, y);
   rotate(radians(random(0,360)));     
   translate(-x, -y);
   rect(x,y,15,4,4,4,4,4); 
   popMatrix();
}


}

