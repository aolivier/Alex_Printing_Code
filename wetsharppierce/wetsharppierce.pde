/* Alex Olivier
 * Still have to change a few things to match original...
 *
 *
 */

/*  Properties
_________________________________________________________________ */

import processing.pdf.*;

// Set these variables to the print size you want (in inches)
// The resulting PDF will be this aspect ratio
float print_width = 22;
float print_height = 15;

// This will help make the sketch window bigger
float make_bigger = 40;
  float x_center = print_width*make_bigger/2;
  float y_center = print_height*make_bigger/2;
  
  int center_x = int((print_width * make_bigger)/2);
  int center_y = int((print_height * make_bigger)/2);


/*  Setup
_________________________________________________________________ */

void setup()
{
  size(round(print_width * make_bigger), round(print_height * make_bigger));
  noiseDetail(3,1.1);
  noiseSeed(1);
  

  beginRecord(PDF, "grab.pdf"); 
  background(50);
  smooth();
  fill(255,255,255);
  noStroke();
  water();
  sharp();
  
  endRecord();
}

  public void sharp(){
    
    float noiseScale = 0.02;
    //translate(width/2, height/2, 0);
    fill(255,255,255,150);
    spikes();
}

void spikes(){
 for (int i=0; i<100; i++){
  beginShape();
  float spikeWidth = random(3,5);
    vertex(i*3+width/2,0);
  int j = int(random(10,15));
  vertex(3*i+j+width/2,random(100,300));
  vertex(3*i+j-random(3,6)+width/2,0);
  endShape();
  }
  
}

void water(){
 
  strokeWeight(1);
  stroke(255,255,255,50);
  fill(255,255,255,50);
  pushMatrix();
  translate((width / 2), (height / 2)+200);
  
  int circleRadius = 50;
  float numVertices = 75;
  float vertexDegree = 360 / numVertices;

  beginShape();
  for(int i = 0; i < numVertices; i++)
  {//strokeWeight(random(1,4));
    float x = cos(radians(i * vertexDegree)) * (circleRadius*5 + random(-8, 8));
    float y = sin(radians(i * vertexDegree)) * (circleRadius);
    curveVertex(x, y);
  }
  endShape(CLOSE);
  translate(-((width / 2)-30), -((height / 2)+30));
  popMatrix();
}


