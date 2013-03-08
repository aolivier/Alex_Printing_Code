/*
 *
 * Written by Alex Olivier
 * 3/6/2013
 * ITP Printing Code
 * Typography Assignment
 *
 */
 
import geomerative.*;
import processing.pdf.*;

//my vars
int myStroke = 0;
int myStrokeWeight = 1;
int fontSize = 15;
int letterSpacing = 41;
int vertSpacing = 30;

float print_width = 17;
float print_height = 20;
float make_bigger = 40;
int center_x = int((print_width * make_bigger)/2);
int center_y = int((print_height * make_bigger)/2);

void setup() 
{ 
  // set up everything for PDF
  size(round(print_width * make_bigger), round(print_height * make_bigger));
  beginRecord(PDF, "grab.pdf"); 
  smooth();
  background(255);
  fill(0);
  strokeWeight(myStrokeWeight);  

  //draw the word isomer several times
  for (int i = 0; i<10; i ++){
    drawIsomer(letterSpacing,240,i*70+82);
  }
  endRecord();
}

//draw the wor
void drawIsomer(float space, float x, float y){
 
  char[] isomer = {'I','S','O','M', 'E', 'R'}; 
  for (int i=0; i<6; i++){
   drawLetter(isomer[i], x, y);
   x+=space; 
  }
}

void dashedLine(float oldX, float oldY, float newX, float newY){
  
  //how long is the line?
  float distance = dist(oldX, oldY, newX, newY);
  float adjacent = abs(oldX - newX);
  float angle = acos(adjacent/distance);
  float increment = distance/10;
  
  //do tiny lines
  float currX = oldX;
  float currY = oldY;
  
  for(int i=0; i<10; i++){
  float nextX = currX + (cos(angle)*increment);
  float nextY = currY + (sin(angle)*increment);
  
  if (i%2==0){
   noStroke(); 
  }else{
    stroke(myStroke);
  }
  line(currX, currY, nextX, nextY);

  currX = nextX;
  currY = nextY;  
}
}

void wedgeLine(float oldX, float oldY, float newX, float newY){
  //myStroke!
  //find the distance from old point to new point
  float distance = dist(oldX, oldY, newX, newY);
  float triX = abs(oldX - newX);
  float triSize = 2;
  float angle = acos(triX/distance);
  
  float littleX = triSize*(sin(angle));
  float littleY = triSize*(cos(angle));
  float line1X = newX + littleX;
  float line1Y = newY - littleY;
  float line2X = newX - littleX;
  float line2Y = newY + littleY;  
  
  fill(0);
  noStroke();
  beginShape();
  vertex(oldX, oldY);
  vertex(line1X, line1Y);
  vertex(line2X, line2Y);
  endShape(CLOSE);
}


void doubleLine(float oldX, float oldY, float newX, float newY){
 line(oldX, oldY, newX, newY);
  
}

RPoint[] getPoints(float thisX, float thisY){

  float shapeRadius = fontSize;
  
  RPoint[] hexPoints = new RPoint[6]; 
  float numVertices = 6;
  float vertexDegree = 360 / numVertices;
  
  for(int i = 0; i < numVertices; i++)
  {
    float x = cos(radians(i * vertexDegree)) * shapeRadius;
    float y = sin(radians(i * vertexDegree)) * shapeRadius;
    hexPoints[i] = new RPoint(x,y);
  } 
  return hexPoints;
}

void connectPoints(int[][] connections, RPoint[] myPoints){
  
  stroke(myStroke);
  
  //for all connections
  for (int i=0; i<connections.length; i++){
   
   int indA = connections[i][0];
   int indB = connections[i][1];
   RPoint pointA = myPoints[indA]; 
   RPoint pointB = myPoints[indB];
   line(pointA.x, pointA.y, pointB.x, pointB.y);
  }
}

float[] hexyChain(int chainLength, float x, float y){
 //draw a hexy chain from this point on
float randNum = random(0,10);

if (randNum > 5){
  for (int i=0; i<chainLength; i++){
 //start up
 float newX = x + (fontSize * (cos(radians(30))));
 float newY = y + (fontSize * (sin(radians(30))));
 line(x,y,newX,newY);
 x = newX;
 y = newY;
 newX = x + (fontSize * (cos(radians(30))));
 newY = y - (fontSize * (sin(radians(30))));
 line(x,y,newX,newY);
 x = newX;
 y = newY;
 
} 
}else{
  for (int i=0; i<chainLength; i++){
 //start up
 float newX = x + (fontSize * (cos(radians(30))));
 float newY = y - (fontSize * (sin(radians(30))));
 line(x,y,newX,newY);
 x = newX;
 y = newY;
 newX = x + (fontSize * (cos(radians(30))));
 newY = y + (fontSize * (sin(radians(30))));
 line(x,y,newX,newY);
 x = newX;
 y = newY;
 
} 
}

  float[] lastPoints = new float[2];
  lastPoints[0] = x;
  lastPoints[1] = y;
  //[x,y];
  return lastPoints;
}


void drawLetter(char letter, float thisX, float thisY){
  
  pushMatrix();
  translate(thisX, thisY);
  RPoint[] myPoints = getPoints(thisX, thisY); //get points for a hexagon in this location
  //int[][] connections;

 //connectPoints(connections, myPoints);
 float newX1 = ((myPoints[4].x) + (myPoints[5].x))/2;
 float newX2 = ((myPoints[2].x) + (myPoints[1].x))/2;
 
 //line(newX1, myPoints[4].y, newX2, myPoints[2].y);
 //hexyChain(1, myPoints[1].x, myPoints[1].y);
  //popMatrix();
  float randNum = random(0,10);
  
 switch (letter){
  case 'I':
  int[][] iConnections = {{4,5},{1,2}};
  connectPoints(iConnections, myPoints);
  newX1 = ((myPoints[4].x) + (myPoints[5].x))/2;
  newX2 = ((myPoints[2].x) + (myPoints[1].x))/2;
  line(newX1, myPoints[4].y, newX2, myPoints[2].y);
  break;
 
  case 'S':
  int[][] sConnections = {{0,1},{1,2},{3,4},{4,5},{3,0}};
  connectPoints(sConnections, myPoints);
   newX1 = ((myPoints[4].x) + (myPoints[5].x))/2;
   newX2 = ((myPoints[2].x) + (myPoints[1].x))/2;
   if (randNum <5){
 
 line(myPoints[0].x-5, myPoints[0].y-4, myPoints[3].x+5, myPoints[3].y-4);
   }
  break;
 
  case 'O':
  int[][] oConnections = {{0,1},{1,2},{2,3},{3,4},{4,5},{5,0}};
  connectPoints(oConnections, myPoints);
  if (randNum <3){
 
   noFill();
   strokeWeight(1);
   ellipse(0, 0, fontSize+5, fontSize+5);
   
   }else if (randNum <6){
    //draw some lines...
    int fontSizeOld = fontSize;
    fontSize = fontSize - 5;
   fontSize = fontSizeOld;
   int[][] innerConnections = {{0,1},{2,3},{4,5}};
   connectPoints(innerConnections, myPoints);
   }
   
    if (randNum <5){
 //line(myPoints[0].x, myPoints[0].y, myPoints[3].x, myPoints[3].y);
 hexyChain(1, myPoints[5].x, myPoints[5].y);
 
   //line(myPoints[0].x, myPoints[0].y, myPoints[3].x, myPoints[3].y);
 }else{
   hexyChain(1, myPoints[1].x, myPoints[1].y);   
 }
  break;
  
  case 'M':
  int[][] mConnections = {{0,1},{2,3},{3,4},{4,5},{5,0}};
  connectPoints(mConnections, myPoints);
  newX1 = ((myPoints[4].x) + (myPoints[5].x))/2;
  newX2 = ((myPoints[2].x) + (myPoints[1].x))/2;
  
  if (randNum <3){
    wedgeLine(newX1, myPoints[4].y, newX2, myPoints[2].y);  
 }else if (randNum <6){
    dashedLine(newX1, myPoints[4].y, newX2, myPoints[2].y);
 }else{
    line(newX1, myPoints[4].y, newX2, myPoints[2].y);
 }
 
  break;
  
  case 'E':
  int[][] eConnections = {{1,2},{2,3},{3,4},{4,5}};
  connectPoints(eConnections, myPoints);
  //float randNum = random(0,10);
  if (randNum < 3){
    wedgeLine(myPoints[0].x, myPoints[0].y, myPoints[3].x, myPoints[3].y);
 }else if (randNum < 6){
   line(myPoints[0].x, myPoints[0].y, myPoints[3].x, myPoints[3].y);
   line(myPoints[0].x-5, myPoints[0].y-4, myPoints[3].x+5, myPoints[3].y-4);
 }else{
   line(myPoints[0].x, myPoints[0].y, myPoints[3].x, myPoints[3].y);
 }
  break;
  
  case 'R':
  int[][] rConnections = {{0,3},{2,3},{3,4},{4,5},{5,0}};
  connectPoints(rConnections, myPoints);
  
  if (randNum <3){
   wedgeLine(newX1, myPoints[3].y, myPoints[1].x, myPoints[1].y);
  }else if (randNum <6){
   dashedLine(newX1, myPoints[3].y, myPoints[1].x, myPoints[1].y);
  }else{
  line(newX1, myPoints[3].y, myPoints[1].x, myPoints[1].y);  
  }
  
  randNum = random(0,10);
  if (randNum <5){
  line(myPoints[0].x-5, myPoints[0].y-4, myPoints[3].x+5, myPoints[3].y-4);
 }
  randNum = random(0,10);
  if (randNum <5){
  hexyChain(1, myPoints[5].x, myPoints[5].y);
  }else{
   hexyChain(1, myPoints[2].x, myPoints[2].y);   
  }
  break;
 } 
  //hexy end
  hexyChain(1, myPoints[1].x, myPoints[1].y);
  popMatrix();
}
