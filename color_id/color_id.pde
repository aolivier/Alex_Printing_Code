/*  Properties
Written by Alex Olivier
2/19/2013
ITP Printing Code
Color + Identity
_________________________________________________________________ */

import processing.pdf.*;
import toxi.color.*;
import toxi.color.theory.*;
import toxi.util.datatypes.*;

// Set these variables to the print size you want (in inches)
// The resulting PDF will be this aspect ratio
float print_width = 17;
float print_height = 17;

// This will help make the sketch window bigger
float make_bigger = 40;
  
int center_x = int((print_width * make_bigger)/2);
int center_y = int((print_height * make_bigger)/2);

//global variable that stores last-draw info
int type = 0;
int hexSize = 15;
/*  Setup
_________________________________________________________________ */

void setup()
{
  size(round(print_width * make_bigger), round(print_height * make_bigger));
  beginRecord(PDF, "grab.pdf"); 
  smooth();
  
  //create colors
  colorMode(HSB, 1, 1, 1);
  float seedHue = random(.8,1);
  float hue2 = seedHue + .33;
  float hue3 = (seedHue + .66);
  background(0, random(.2,.5), random(.4,.8)); //set background color
  
  for (int i=0; i<50; i++){
  
    float sX = random(0, center_y*2);
    float sY = random(0,center_y*2);
    TColor thisColor = TColor.newHSV(hue3,random(.4,.5), random(.8,1));
    TColor thisColor2 = TColor.newHSV(hue2,random(.4,.5), random(.8,1));
 
    int chooser = int(random(0,2));
    if (chooser==0){
        stroke(thisColor.hue(), thisColor.saturation(), thisColor.brightness());
        fill(thisColor.hue(), thisColor.saturation()+.2, thisColor.brightness()-.1);
    }else{
        stroke(thisColor2.hue(), thisColor2.saturation(), thisColor2.brightness());
        fill(thisColor2.hue(), thisColor2.saturation()+.2, thisColor2.brightness()-.1);
    }
    drawHexy(int(random(10,20)), sX, sY);
  }

  endRecord();
}

ColorList chooseColors(int length){
  // create a color list
  ColorList colors = new ColorList(); 
  
  //seedVal = 1.0;
  for (int i=0; i<length; i++){
    float seedVal = random(0,.25);
  
   TColor randColor = TColor.newHSV(seedVal, .7, random(.5,1));
   colors.add(randColor);
   //seedVal+=0.33; //find the next color
  }
  return colors;
  
}

void hexyLine(int level, float x, float y){
  
  float newX;
  float newY;
  int decider = 0;  //variable to determine angle of next segment
  
  if (level < 1){
    noStroke();
    drawShape(6,x,y); //end it
    return;
   } else {
      
     //based on previous line, pick next random line
      switch(type) {
      case 0: 
        decider = int(random(0,3));
        break;
      case 1: 
        decider = int(random(3,6));
        break;
      case 2:
        decider = int(random(6,9));
        break;
       case 3:
         decider = int(random(9,12));
         break;
       case 4:
         decider = int(random(12,15));
         break;
       case 5:
          decider = int(random(15,18)); 
          break;
      default:
        break;
} 
    // probably a more elegant way to do this...
    switch(decider) {
      case 0: 
        newX = x+15;
        newY = y;
        type = 0;
        break;
      case 1: 
        newX = x + hexSize*cos(radians(60)); 
        newY = y - hexSize*sin(radians(60));
        type = 1;
        break;
      case 2:
        newX = x + hexSize*cos(radians(60));
        newY = y + hexSize*sin(radians(60));
        type = 5;
        break;
      case 3:
         newX = x+hexSize;
         newY = y;
         type = 0;
         break;
      case 4:
        newX = x + hexSize*cos(radians(60)); 
        newY = y - hexSize*sin(radians(60));
        type = 1;
        break;
      case 5:
        newX = x - hexSize*cos(radians(60));
        newY = y - hexSize*sin(radians(60));  
        type = 2;
        break;
      case 6:
        newX = x-hexSize;
        newY = y;
        type = 3;
        break;
       case 7:
         newX = x - hexSize*cos(radians(60)); 
         newY = y -hexSize*sin(radians(60));
         type = 2;
         break;
       case 8: 
         newX = x + hexSize*cos(radians(60)); 
         newY = y -hexSize*sin(radians(60));  
         type = 1;
         break;
       case 9:
         newX = x - hexSize; 
         newY = y ;
         type = 3;
         break;
       case 10:
         newX = x - hexSize*cos(radians(60)); 
         newY = y +hexSize*sin(radians(60));
         type = 4;
         break;
       case 11: 
         newX = x - hexSize*cos(radians(60)); 
         newY =  y - hexSize*sin(radians(60));;
         type = 2;
         break;
       case 12: 
         newX = x -hexSize; 
         newY = y;
         type = 3;
         break;
       case 13:
         newX = x - hexSize*cos(radians(60)); 
         newY = y+hexSize*sin(radians(60));
         type = 4;
         break;
      case 14:
         newX = x + hexSize*cos(radians(60)); 
         newY = y+hexSize*sin(radians(60));
         type = 5;
         break;
      case 15:
        newX = x + hexSize; 
        newY = y +hexSize*sin(radians(60));
        type = 0;
        break;
      case 16:
         newX = x + hexSize*cos(radians(60)); 
         newY = y +hexSize*sin(radians(60));
         type = 5;
         break;
      case 17:
        newX = x - hexSize*cos(radians(60)); 
        newY = y +hexSize*sin(radians(60));
        type = 4;
        break;
      default:
        newX = x + hexSize;
        newY = y;
        break;
} //end switch

    //draw a line
    line(x,y,newX,newY);
    level--; 
    hexyLine(level, newX, newY);
   } 
}
// calls recursive hexyLine function
void drawHexy(int level, float x, float y){
  // base case
   drawShape(6,x,y);
   strokeWeight(3);
   hexyLine(level, x, y); 
}
 
 void drawShape(int numVertices, float x, float y)
{
  pushMatrix();
  translate(x, y);
  
  float vertexDegree = 360 / numVertices;
  float shapeRadius = hexSize;
  
  beginShape();
  for(int i = 0; i < numVertices; i++)
  {
    float vertexX = cos(radians(i * vertexDegree)) * shapeRadius;
    float vertexY = sin(radians(i * vertexDegree)) * shapeRadius;
    vertex(vertexX, vertexY);
  }
  endShape();
  popMatrix();
}
