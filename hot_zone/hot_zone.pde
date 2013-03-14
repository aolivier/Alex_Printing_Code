/* Alex Olivier
 * Printing Code
 * NYU ITP
 * 3/13/2013
 * Book Cover
 */


import processing.pdf.*;
import toxi.color.*;
import toxi.color.theory.*;
import toxi.util.datatypes.*;

// Set these variables to the print size you want (in inches)
// The resulting PDF will be this aspect ratio
float print_width = 13;
float print_height = 17;

// This will help make the sketch window bigger
float make_bigger = 40;
  
float center_x = (print_width * make_bigger)/2;
float center_y = (print_height * make_bigger)/2;

void setup()
{
  
  size(round(print_width * make_bigger), round(print_height * make_bigger));
  beginRecord(PDF, "grab.pdf");
  smooth();
  
  colorMode(HSB, 1, 1, 1);
  background(1, .9, .8); //set background color
  
  int cols = round(4);
  int rows = round(10);
  int gutterSize = round(3);
  int pageMargin = round(20);
  ModularGrid grid = new ModularGrid(cols, rows, gutterSize, pageMargin);
 
  int fontSize = 20;
  int fontSize2 = 15;
  
  String s = "The Hot Zone";
  String name = "Richard Preston";
  
  Module startModule = grid.modules[2][2];
  // lets fill the rectangle with text. As you can see, Processing leaves a lot to be desired about text rendering
  //grid.display();
  float maskX = startModule.x;
  float maskY = startModule.y;
  drawMask(maskX, maskY, 100, 100);
  scale(1.0);
  
  //do the words on 
  //pushMatrix();
  fill(0,0,1);
  //ModularGrid grid2 = new ModularGrid(cols, rows, gutterSize, pageMargin);
  //Module nameModule = grid2.modules[1][5];
  //Module authorModule = grid2.modules[1][6];
  Module t2 = grid.modules[1][6];
  Module t1 = grid.modules[1][6];
  fontSize = 50;
  fontSize2 = 50;
  PFont helvetica = createFont("Impact", fontSize);
  PFont helvetica2 = createFont("Impact", fontSize2);
  textFont(helvetica);
  textFont(helvetica2);

  beginShape();
  fill(0,0,0);
  vertex(pageMargin, pageMargin);
  vertex(pageMargin, pageMargin+((rows-1)*gutterSize)+(rows*t1.h));
  vertex(pageMargin+((cols-1)*gutterSize)+(cols*t1.w), pageMargin+((rows-1)*gutterSize)+(rows*t1.h));
  println(((cols-1)*gutterSize)+(cols*t1.w));
  println(((rows-1)*gutterSize)+(rows*t1.h));
  println(degrees(atan(480/640)));
  endShape(CLOSE);
  
  pushMatrix();
  //translate(pageMargin+t1.w+gutterSize,pageMargin+(gutterSize*3)+(t1.h*4));
  rotate(radians(53));
  fill(1, .9, .8);
  //text("Richard Preston", 500, height/3);
  
  stroke(.5,0,1);
  strokeWeight(2);
  popMatrix();
  
 // translate(pageMargin, pageMargin+(gutterSize*3)+(t1.h*4))
  text("The Hot Zone", pageMargin, pageMargin+(gutterSize*9)+(t1.h*10));
  //text("Richard Preston", pageMargin, pageMargin+(gutterSize*9)+(t1.h*10));
  fill(1, .9, .8);
  textFont(helvetica2);
  fill(0,0,1);
 //text("Richard Preston", pageMargin+t1.w + t1.w, pageMargin+(gutterSize*9)+(t1.h*10));
 // popMatrix()

 endRecord();
  
}

void drawMask(float thisX, float thisY, float thisW, float thisH){
 //draw the head
 pushMatrix();
 thisX = 238;
 thisY = 137;
 
 scale(1.6);
  noStroke();
  fill(.1, .9, .05);
  ellipse(thisX, thisY, 100, 150);
  ellipse(thisX, thisY-10, 120, 150);
  
  //draw the eyes
  fill(1, .9, .8);
  ellipse(thisX-30, thisY-10, 30,8);
  ellipse(thisX+30, thisY-10, 30, 8);
  
  //draw mouth
  fill(1, .9, .8);
  ellipse(thisX, thisY+60, 30, 10);

 //draw nose
 fill(1, .9, .8);
 beginShape();
 vertex(thisX, thisY-10);
 vertex(thisX-8, thisY+40);
 vertex(thisX, thisY+45);
 vertex(thisX+8, thisY+40);
 endShape();
  
  //decorations
  for (int i=0; i<10; i++){
  
    stroke(1, .9, .8);
    noFill();
    ellipse(thisX, thisY+i-90, 10*i, 13*i);
  }
  noStroke();

popMatrix();
}


