
// Design from page 240 of Islamic Geometric Designs by Eric Broug
// ISBN 978-0-500-51695-9
// Code by Rupert Russell
// 2 February 2020
// Thanks to: COLLISION DETECTION by Jeff Thompson  
// http://jeffreythompson.org/collision-detection/index.php
// Using Objects to reduce the code length

float scale = 900;
float innerScale;
float middleScale;

float[] saveIntersectionX;
float[] saveIntersectionY;

float[] saveCircleX;
float[] saveCircleY;

boolean displayConstructionLines = false;

float[] xx, yy; // used to store working intersection test lines

// use the Lineline class to create multiple myLine objects
Lineline myLineline0;
Lineline myLineline1;
Lineline myLineline2;
Lineline myLineline3;
Lineline myLineline4;
Lineline myLineline5;
Lineline myLineline6;
Lineline myLineline7;
Lineline myLineline8;
Lineline myLineline9;
Lineline myLineline10;
Lineline myLineline11;
Lineline myLineline12;
Lineline myLineline13;
Lineline myLineline14;
Lineline myLineline15;
Lineline myLineline16;
Lineline myLineline17;
Lineline myLineline18;
Lineline myLineline19;
Lineline myLineline20;

// use the CalculatePoints class to create multiple myCircle objects
CalculatePoints myCircle1;
CalculatePoints myCircle2;
CalculatePoints myCircle3;
CalculatePoints myCircle4; // used in step 9
//CalculatePoints myCircle5;
//CalculatePoints myCircle6;
//CalculatePoints myCircle7;
//CalculatePoints myCircle8;  

void setup() {
  background(255);
  noLoop(); 
  size(800, 800); // width x height
  smooth();
  noFill();
  rectMode(CENTER);
  ellipseMode(CENTER);

  saveIntersectionX = new float[100]; // store x Points for the intersections
  saveIntersectionY = new float[100]; // store y Points for the intersections

  saveCircleX = new float[100]; // store x Points for the circles
  saveCircleY = new float[100]; // store y Points for the circles

  xx = new float[100];
  yy = new float[100];


  innerScale = 0.18163545 * 2 * scale;
  middleScale = 0.24999997 * scale;
}

void draw() {
  translate(width/2, height/2);
  //   CalculatePoints(Start Saving at [index]counterStart, Number of Points to calculate, scale of circle, OffsetX to center H, OffsetY to center K, Display )  
  myCircle1 = new CalculatePoints(0, 20, scale* 1.5, 0, 0, false);  // used for the ends of the spokes
  myCircle2 = new CalculatePoints(20, 20, scale, 0, 0, false);  
  myCircle3 = new CalculatePoints(40, 20, innerScale, 0, 0, false); // used for the parallel lines
  myCircle4 = new CalculatePoints(60, 10, 0.18163545 * 2 * scale, saveCircleX[27], saveCircleY[27], false); // used for step9

  rectangle(true);
  lozenge(false);
  spokes(true);
  step3(true);
  circles(false);
  parallelLines(true);
  step6(true);
  step7(true);
  step8a(false);
  step8b(false);
  step9(false);
  step10(true);




  save("design_240_v059.png");
}

// Construct the Lineline object
class Lineline {
  int index;  // hold the index numbers for the intersection use to store points in array
  float x1;
  float y1;
  float x2;
  float y2;
  float x3;
  float y3;
  float x4;
  float y4;
  boolean displayLine;
  boolean displayInterection;
  char colour;
  float weight;

  float intersectionX;
  float intersectionY;

  // The Constructor is defined with arguments.
  Lineline(int tempIndex, float tempX1, float tempY1, float tempX2, float tempY2, float tempX3, float tempY3, float tempX4, float tempY4, boolean tempDisplayLine, boolean tempDisplayInterection, char tempColour, float tempWeight) {
    index =tempIndex;
    x1 = tempX1;
    y1 = tempY1;
    x2 = tempX2;
    y2 = tempY2;
    x3 = tempX3;
    y3 = tempY3;
    x4 = tempX4;
    y4 = tempY4;
    displayLine = tempDisplayLine;
    displayInterection = tempDisplayInterection;
    colour = tempColour;
    weight = tempWeight;
  }

  boolean displayIntersection() {
    // LINE/LINE 
    // Thanks to: COLLISION DETECTION by Jeff Thompson  
    // http://jeffreythompson.org/collision-detection/index.php
    // from http://jeffreythompson.org/collision-detection/line-line.php

    // calculate the distance to intersection point
    float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

    // if uA and uB are between 0-1, lines are colliding
    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {

      // optionally, draw a circle where the lines meet
      intersectionX = x1 + (uA * (x2-x1));
      intersectionY = y1 + (uA * (y2-y1));
      noFill();

      switch(colour) {
      case 'r': 
        stroke(255, 0, 0);
        break;
      case 'g': 
        stroke(0, 255, 0);
        break;
      case 'b': 
        stroke(0, 0, 255);
        break;        
      case 'm': 
        stroke(255, 0, 255);
        break;    
      default:
        stroke(0, 0, 0); // black
        break;
      }

      if (displayLine) {
        strokeWeight(weight);
        line(x1, y1, x2, y2);
        line(x3, y3, x4, y4);
      }

      if (displayInterection) {
        strokeWeight(weight);
        stroke(0, 0, 255); // blue
        ellipse(intersectionX, intersectionY, 20, 20);
      }
      // println("("+ intersectionX+ "," + intersectionY +")");
      saveIntersectionX[index] = intersectionX;
      saveIntersectionY[index] = intersectionY;
      println("INDEX = " + index);
      stroke(0);
      strokeWeight(1);
      return true ;
    }
    stroke(0);
    strokeWeight(1);
    return false;
  }
}
//  end of constructor for Lineline class

// Start of Constructor for CalculatePoints defined with arguments
// calculate points around a circle and store n points around a circle
class CalculatePoints {
  int numPoints;
  float scale;
  float h;
  float k;
  int counterStart;
  boolean displayCrcles;

  // The Constructor is defined with arguments and sits inside the class 
  CalculatePoints(int tempCounterStart, int tempNumPoints, float tempScale, float tempH, float tempK, boolean tmpDisplayCrcles) {
    numPoints = tempNumPoints;
    scale = tempScale;
    h = tempH;
    k = tempK;
    counterStart = tempCounterStart;
    displayCrcles = tmpDisplayCrcles;

    int counter = counterStart;

    double step = radians(360/numPoints); 
    float r =  scale / 2 ;
    for (float theta=0; theta < 2 * PI; theta += step) {
      float x = h + r * cos(theta);
      float y = k - r * sin(theta); 

      // store the calculated coordinates
      saveCircleX[counter] = x;
      saveCircleY[counter] = y;
      if (displayCrcles) {
        circle(saveCircleX[counter], saveCircleY[counter], 10);  // draw small circles to show points
      }
      counter ++;
    }
  }
} // End of Constructor for CalculatePoints


void rectangle(boolean displayConstructionLines) {
  if (displayConstructionLines) {
    line( saveCircleX[23], saveCircleY[23], saveCircleX[27], saveCircleY[27]); // Top line of rectangle
    line( saveCircleX[27], saveCircleY[27], saveCircleX[33], saveCircleY[33]); // Left line of rect
    line( saveCircleX[33], saveCircleY[33], saveCircleX[37], saveCircleY[37]); // Bottom line of rectangle
    line( saveCircleX[37], saveCircleY[37], saveCircleX[23], saveCircleY[23]); // Right line of rectangle
  }
} // end rectangle

void lozenge(boolean displayConstructionLines) {
  if ( displayConstructionLines) {
    line( saveCircleX[25], saveCircleY[23], saveCircleX[27], saveCircleY[30]);  // top left
    line( saveCircleX[27], saveCircleY[30], saveCircleX[35], saveCircleY[33]); // bottom left
    line( saveCircleX[35], saveCircleY[33], saveCircleX[23], saveCircleY[20]); // borom right
    line( saveCircleX[23], saveCircleY[20], saveCircleX[25], saveCircleY[23]); // top right
  }
} // end lozenge

void spokes(boolean displayConstructionLines) {
  if (displayConstructionLines) {
    for (int counter = 0; counter < 10; counter++) {
      line( saveCircleX[counter], saveCircleY[counter], saveCircleX[counter + 10], saveCircleY[counter + 10]);
    }
  }
} // end spokes

void step3(boolean displayConstructionLines) {
  int a, b, c, d, e, f, g, h;
  a = 25;
  b = 23;
  c = 27;
  d = 30;

  e = 19;
  f = 19;
  g = 9;
  h = 9;

  // calculate intersection points
  myLineline0 = new Lineline(0, saveCircleX[23], saveCircleY[20], saveCircleX[25], saveCircleY[23], 0, 0, saveCircleX[3], saveCircleY[3], false, false, 'b', 3);
  myLineline0.displayIntersection();
  myLineline1 = new Lineline(1, saveCircleX[a], saveCircleY[b], saveCircleX[c], saveCircleY[d], saveCircleX[e], saveCircleY[f], saveCircleX[g], saveCircleY[h], false, false, 'r', 3);
  myLineline1.displayIntersection();

  if (displayConstructionLines) {
    strokeWeight(1);
    line(saveIntersectionX[0], saveIntersectionY[0], saveIntersectionX[1], saveIntersectionY[1]);  //  Guide ine from step 3
  }
}

void circles(boolean displayConstructionLines) {
  if (displayConstructionLines) {
    circle(0, 0, 0.18163545 * 2 * scale);
    circle(saveCircleX[23], saveCircleY[23], 0.18163545 * 2 * scale);  // top right
    circle(saveCircleX[27], saveCircleY[27], 0.18163545 * 2 * scale); // top left
    circle(saveCircleX[33], saveCircleY[33], 0.18163545 * 2 * scale);
    circle(saveCircleX[37], saveCircleY[37], 0.18163545 * 2 * scale);
  }
} // end circles

void parallelLines(boolean displayConstructionLines) {
  float deltaX;
  float deltaY;
  if ( displayConstructionLines) {
    //  set 1
    deltaX = saveCircleX[40] - saveCircleX[52];
    deltaY = saveCircleY[40] - saveCircleY[52];

    line(saveCircleX[40] - deltaX * 3, saveCircleY[40] - deltaY * 3, saveCircleX[52] + deltaX * 3, saveCircleY[52] + deltaY * 3); // Bottom 1
    line(saveCircleX[42] - deltaX * 3, saveCircleY[42] - deltaY * 3, saveCircleX[50] + deltaX * 3, saveCircleY[50] + deltaY * 3); // Top 1

    ////  set 2 
    //deltaX = saveCircleX[43] - saveCircleX[51];
    //deltaY = saveCircleY[43] - saveCircleY[51];
    //line(saveCircleX[43] - deltaX * 3, saveCircleY[43] - deltaY * 3, saveCircleX[51] + deltaX * 3, saveCircleY[51] + deltaY * 3); // top 2
    //line(saveCircleX[41] - deltaX * 3, saveCircleY[41] - deltaY * 3, saveCircleX[53] + deltaX * 3, saveCircleY[53] + deltaY * 3); // Bottom 2

    //  set 3
    deltaX = saveCircleX[44] - saveCircleX[52];
    deltaY = saveCircleY[44] - saveCircleY[52];

    line(saveCircleX[44] - deltaX * 3, saveCircleY[44] - deltaY * 3, saveCircleX[52] + deltaX * 3, saveCircleY[52] + deltaY * 3); // top 3


    line(saveCircleX[42] - deltaX * 3, saveCircleY[42] - deltaY * 3, saveCircleX[54] + deltaX * 3, saveCircleY[54] + deltaY * 3); // Bottom 3
    stroke(0);
    strokeWeight(1);
    ////  set 4
    //deltaX = saveCircleX[44] - saveCircleX[54];
    //deltaY = saveCircleY[44] - saveCircleY[54];
    //line(saveCircleX[45] - deltaX * 3, saveCircleY[45] - deltaY * 3, saveCircleX[53] + deltaX * 3, saveCircleY[53] + deltaY * 3); // top  
    //line(saveCircleX[43] - deltaX * 3, saveCircleY[43] - deltaY * 3, saveCircleX[55] + deltaX * 3, saveCircleY[55] + deltaY * 3); // Bottom  

    // Center Lines 5 // Verticle center pair
    deltaX = saveCircleX[46] - saveCircleX[54];
    deltaY = saveCircleY[46] - saveCircleY[54];
    line(saveCircleX[46] - deltaX * 3, saveCircleY[46] - deltaY * 3, saveCircleX[54] + deltaX * 3, saveCircleY[54] + deltaY * 3); // Center Left  

    xx[3] = saveCircleX[44] - deltaX * 3;
    yy[3] = saveCircleY[44] - deltaY * 3;

    xx[4] = saveCircleX[56] + deltaX * 3;
    yy[4] = saveCircleY[56] + deltaY * 3;

    line(saveCircleX[44] - deltaX * 3, saveCircleY[44] - deltaY * 3, saveCircleX[56] + deltaX * 3, saveCircleY[56] + deltaY * 3); // Center Right  
    stroke(0);
    strokeWeight(1);

    //// Lines 6
    //deltaX = saveCircleX[46] - saveCircleX[56];
    //deltaY = saveCircleY[46] - saveCircleY[56];
    //line(saveCircleX[47] - deltaX * 3, saveCircleY[47] - deltaY * 3, saveCircleX[55] + deltaX * 3, saveCircleY[55] + deltaY * 3); // 6 Left  
    //line(saveCircleX[45] - deltaX * 3, saveCircleY[45] - deltaY * 3, saveCircleX[57] + deltaX * 3, saveCircleY[57] + deltaY * 3); // 6 Right  

    // Lines 7

    deltaX = saveCircleX[47] - saveCircleX[57];
    deltaY = saveCircleY[47] - saveCircleY[57];
    line(saveCircleX[48] - deltaX * 3, saveCircleY[48] - deltaY * 3, saveCircleX[56] + deltaX * 3, saveCircleY[56] + deltaY * 3); // 7 Left  
    line(saveCircleX[46] - deltaX * 3, saveCircleY[46] - deltaY * 3, saveCircleX[58] + deltaX * 3, saveCircleY[58] + deltaY * 3); // 7 Right  



    //// Lines 8
    //deltaX = saveCircleX[48] - saveCircleX[58];
    //deltaY = saveCircleY[48] - saveCircleY[58];
    //line(saveCircleX[49] - deltaX * 3, saveCircleY[49] - deltaY * 3, saveCircleX[57] + deltaX * 3, saveCircleY[57] + deltaY * 3); // 8 Left  
    //line(saveCircleX[47] - deltaX * 3, saveCircleY[47] - deltaY * 3, saveCircleX[59] + deltaX * 3, saveCircleY[59] + deltaY * 3); // 8 Right  

    // Lines 9 

    deltaX = saveCircleX[49] - saveCircleX[59];
    deltaY = saveCircleY[49] - saveCircleY[59];
    line(saveCircleX[50] - deltaX * 3, saveCircleY[50] - deltaY * 3, saveCircleX[58] + deltaX * 3, saveCircleY[58] + deltaY * 3); // 9 Bottom  

    xx[7] = saveCircleX[48] - deltaX * 3;
    yy[7] = saveCircleY[48] - deltaY * 3;

    xx[8] = saveCircleX[40] + deltaX * 3;
    yy[8] = saveCircleY[40] + deltaY * 3;

    line(xx[7], yy[7], xx[8], yy[8]); // Pair 9 Top  

    strokeWeight(1);
    stroke(0);


    //// Lines 10 horizontal
    //deltaX = saveCircleX[49] - saveCircleX[41];
    //deltaY = saveCircleY[49] - saveCircleY[41];
    //line(saveCircleX[51] - deltaX * 3, saveCircleY[51] - deltaY * 3, saveCircleX[59] + deltaX * 3, saveCircleY[59] + deltaY * 3); // 10 Horzontal  Bottom
    //line(saveCircleX[49] - deltaX * 3, saveCircleY[49] - deltaY * 3, saveCircleX[41] + deltaX * 3, saveCircleY[41] + deltaY * 3); // 10  Horzontal top
  }
}

void step6(boolean displayConstructionLines) {

  // radius of last construction circle
  float radius = dist(saveIntersectionX[0], saveIntersectionY[0], 0, 0);  
  float deltaX;
  float deltaY;
  float x1, y1, x2, y2, x3, y3, x4, y4;

  deltaX = saveCircleX[40] - saveCircleX[52];
  deltaY = saveCircleY[40] - saveCircleY[52];

  x1 = saveCircleX[42] - deltaX * 3;
  y1 = saveCircleY[42] - deltaY * 3;

  x2 = saveCircleX[50] + deltaX * 3;
  y2 = saveCircleY[50] + deltaY * 3;

  x3 = saveCircleX[37];
  y3 = saveCircleY[37];

  x4 = saveCircleX[23];
  y4 = saveCircleY[23];

  // calculate intersection points
  myLineline2 = new Lineline(2, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'b', 3);
  myLineline2.displayIntersection();

  deltaX = saveIntersectionX[2] - 0;
  deltaY = -radius - saveIntersectionY[2] ;

  x2 = - deltaX;
  y2 = - radius + deltaY;

  x1 = saveIntersectionX[2];
  y1 = saveIntersectionY[2];

  x3 = saveCircleX[3];
  y3 = saveCircleY[3];

  x4 = saveCircleX[13];
  y4 = saveCircleY[13];

  stroke(0);
  circle(0, 0, radius * 2);

  deltaX = saveIntersectionX[2] - 0;
  deltaY = -radius - saveIntersectionY[2] ;

  myLineline3 = new Lineline(3, -x1, y1, -x2, y2, x3, y3, x4, y4, false, false, 'b', 3);
  myLineline3.displayIntersection();

  if (displayConstructionLines) {
    strokeWeight(1);

    xx[1] = x1; 
    yy[1] = y1;
    xx[2] = x2;
    yy[2] = y2;



    line( x1, y1, x2, y2);  // top upper west lower east
    strokeWeight(1);

    line(-x1, y1, -x2, y2);  // top lower west upper east
    line( x1, -y1, x2, -y2);  // bottom lower west upper east
    line(-x1, -y1, -x2, -y2);  // bottom upper west lower east
  }
}


void step7(boolean displayConstructionLines) {

  float x1, y1, x2, y2, x3, y3, x4, y4;

  // calculate intersection points
  int counter = 3;
  if (displayConstructionLines) {
    // line( saveCircleX[counter], saveCircleY[counter], saveCircleX[counter + 10], saveCircleY[counter + 10]);
    x1 = saveIntersectionX[3];
    y1 = height / 2;

    x2 = saveIntersectionX[3];
    y2 = height / 2;

    line( x1, -y1, x2, y2);  // Right
    line( -x1, -y1, -x2, y2);  // left
  }
}


void step8a(boolean displayConstructionLines) {

  float x1, y1, x2, y2, x3, y3, x4, y4;
  float deltaX, deltaY;

  if (displayConstructionLines) {
    float radius = dist(saveIntersectionX[0], saveIntersectionY[0], 0, 0);  

    deltaX = saveIntersectionX[2] - 0;
    deltaY = -radius - saveIntersectionY[2] ;
    x1 = saveIntersectionX[2];
    y1 = saveIntersectionY[2];

    x2 = - deltaX;
    y2 = - radius + deltaY;

    x3 = saveCircleX[27];
    y3 = saveCircleY[27];

    x4 = saveCircleX[33];
    y4 = saveCircleY[33];

    //strokeWeight(2);
    //stroke(255, 0, 0); // red
    //line( x1, y1, x2, y2);  // top upper west lower east
    //line( x3, y3, x4, y4);  // Left line of rect
    //circle(x3 + innerScale /2, y3, 10);

    myLineline4 = new Lineline(4, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'b', 3);
    myLineline4.displayIntersection();

    x1 = saveIntersectionX[4];
    y1 = saveIntersectionY[4];

    x2 = x3 + innerScale /2;
    y2 = saveCircleY[27];

    // line(saveIntersectionX[4], saveIntersectionY[4], x3 + innerScale /2, y3);
    line( x1, y1, x2, y2);  // top left
    line(-x1, y1, -x2, y2);  // top right
    line( x1, -y1, x2, -y2);  // bottom left
    line(-x1, -y1, -x2, -y2);  // bottom right
    strokeWeight(1);
    stroke(0);
  }
}

void step8b(boolean displayConstructionLines) {

  float x1, y1, x2, y2, x3, y3, x4, y4;
  float deltaX, deltaY;

  if (displayConstructionLines) {
    deltaX = saveCircleX[47] - saveCircleX[57];
    deltaY = saveCircleY[47] - saveCircleY[57];

    x1 = saveCircleX[46] - deltaX * 3;
    y1 = saveCircleY[46] - deltaY * 3;

    x2 = saveCircleX[58] + deltaX * 3;
    y2 = saveCircleY[58] + deltaY * 3;

    x3 = saveCircleX[23];
    y3 = saveCircleY[23];

    x4 = saveCircleX[27];
    y4 = saveCircleY[27];

    myLineline5 = new Lineline(5, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'b', 2);
    myLineline5.displayIntersection();

    x1 = saveCircleX[48] - deltaX * 3;
    y1 = saveCircleY[48] - deltaY * 3;

    x2 = saveCircleX[56] + deltaX * 3;
    y2 = saveCircleY[56] + deltaY * 3;

    x3 = saveCircleX[27];
    y3 = saveCircleY[27];

    x4 = saveCircleX[33];
    y4 = saveCircleY[33];

    myLineline6 = new Lineline(6, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'r', 2);
    myLineline6.displayIntersection();

    x1 = saveIntersectionX[5];
    y1 = saveIntersectionY[5];

    x2 = saveIntersectionX[6];
    y2 = saveIntersectionY[6];

    line( x1, y1, x2, y2);  // top left
    line(-x1, y1, -x2, y2);  // top right
    line( x1, -y1, x2, -y2);  // bottom left
    line(-x1, -y1, -x2, -y2);  // bottom right
    strokeWeight(1);
    stroke(0);
  }
} // end of step8b



void step9(boolean displayConstructionLines) {

  float x1, y1, x2, y2, x3, y3, x4, y4;
  float deltaX, deltaY;

  if (displayConstructionLines) {

    x1 = saveCircleX[60];
    y1 = saveCircleY[60];

    x2 = saveCircleX[64];
    y2 = saveCircleY[64];

    deltaX = x1 - x2;
    deltaY = y1 - y2;

    float x5 = 0;
    float y5 = - height;

    float x6 = 0;
    float y6 = height;

    float x7 = x1 + deltaX;
    float y7 = y1 + deltaY;

    float x8 = x2;
    float y8 = y2;

    myLineline7 = new Lineline(7, x5, y5, x6, y6, x7, y7, x8, y8, false, false, 'r', 2);
    myLineline7.displayIntersection();

    x1 = saveCircleX[64];
    y1 = saveCircleY[64];

    x2 = saveIntersectionX[7];
    y2 = saveIntersectionY[7];

    line( x1, y1, x2, y2);  // top left
    line(-x1, y1, -x2, y2);  // top right
    line( x1, -y1, x2, -y2);  // bottom left
    line(-x1, -y1, -x2, -y2);  // bottom right
    stroke(0);
  }
}

// draw inner star
void step10(boolean displayConstructionLines ) {

  float x1, y1, x2, y2, x3, y3, x4, y4;
  myLineline8 = new Lineline(8, xx[1], yy[1], xx[2], yy[2], xx[3], yy[3], xx[4], yy[4], true, true, 'b', 2); // line 1 in step 10 Inner Star
  myLineline8.displayIntersection();

  myLineline9 = new Lineline(9, xx[3], yy[3], xx[4], yy[4], xx[7], yy[7], xx[8], yy[8], true, true, 'r', 2); // line 1 in step 10 Inner Star
  myLineline9.displayIntersection();

  //line(xx[3], yy[3], xx[4], yy[4]);
  //line(xx[7], yy[7], xx[8], yy[8]);

  x1 = saveIntersectionX[8];
  y1 = saveIntersectionY[8];

  x2 = saveIntersectionX[9];
  y2 = saveIntersectionY[9];

  if (displayConstructionLines) {
    stroke(255, 0, 0); // red
    strokeWeight(6);

    line( x1, y1, x2, y2);  // top left
    line(-x1, y1, -x2, y2);  // top right
    line( x1, -y1, x2, -y2);  // bottom left
    line(-x1, -y1, -x2, -y2);  // bottom right
    stroke(0);


    //  line( saveCircleX[2], saveCircleY[2], saveCircleX[2 + 10], saveCircleY[2 + 10]);
    stroke(0);
    strokeWeight(1);
  }
}
