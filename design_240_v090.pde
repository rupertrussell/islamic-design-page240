// Design from page 240 of Islamic Geometric Designs by Eric Broug
// ISBN 978-0-500-51695-9
// Code by Rupert Russell
// 26 February 2020
// Thanks to: COLLISION DETECTION by Jeff Thompson  
// http://jeffreythompson.org/collision-detection/index.php
// Using Objects to reduce the code length

int test = 0;
float scale = 970;
int designWeight = 4;
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
Lineline myLineline21;
Lineline myLineline22;
Lineline myLineline23;
Lineline myLineline24;
Lineline myLineline25;
Lineline myLineline26;
Lineline myLineline27;
Lineline myLineline28;
Lineline myLineline29;
Lineline myLineline30;
Lineline myLineline31;
Lineline myLineline32;
Lineline myLineline33;
Lineline myLineline34;
Lineline myLineline35;
Lineline myLineline36;
Lineline myLineline37;
Lineline myLineline38;
Lineline myLineline39;
Lineline myLineline40;

Lineline myLineline41;
Lineline myLineline42;
Lineline myLineline43;
Lineline myLineline44;
Lineline myLineline45;
Lineline myLineline46;
Lineline myLineline47;
Lineline myLineline48;
Lineline myLineline49;
Lineline myLineline50;

// use the CalculatePoints class to create multiple myCircle objects
CalculatePoints myCircle1;
CalculatePoints myCircle2;
CalculatePoints myCircle3;
CalculatePoints myCircle4; // used in step 9

import processing.pdf.*;

void setup() {
  background(255);
  noLoop(); 
  size(800, 800); // width x height
  smooth();
  noFill();
  rectMode(CENTER);
  ellipseMode(CENTER);
  
  beginRecord(PDF, "design_240_v90.pdf");

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
  background(255);
  translate(width/2, height/2);
  //   CalculatePoints(Start Saving at [index]counterStart, Number of Points to calculate, scale of circle, OffsetX to center H, OffsetY to center K, Display )  
  myCircle1 = new CalculatePoints(0, 20, scale* 1.5, 0, 0, false);  // used for the ends of the spokes
  myCircle2 = new CalculatePoints(20, 20, scale, 0, 0, false);  
  myCircle3 = new CalculatePoints(40, 20, innerScale, 0, 0, false); // used for the parallel lines
  myCircle4 = new CalculatePoints(60, 10, 0.18163545 * 2 * scale, saveCircleX[27], saveCircleY[27], false); // used for step9

  rectangle(false);
  lozenge(false);
  spokes(false);
  step3(false);
  circles(false);
  parallelLines(false);
  step6(false);
  step7(false);
  step8A(false);
  step8B(false);
  step9(false); // end of guide lines

  strokeWeight(designWeight);
  stroke(255, 0, 0);
  step10(true); // start of final design lines
  step11A(true);
  step11B(true);
  step11C(true);
  step11D(true);
  step11E(true);
  step11F(true);
  step11G(true);
  step12A(true);
  step12B(true);
  step12C(true);
  step12D(true);  
  step12E(true);
  step12F(true);
  step12G(true);
  step12H(true);
  save("design_240_v090.png");
  endRecord();
  
  // exit();
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

      saveIntersectionX[index] = intersectionX;
      saveIntersectionY[index] = intersectionY;

      strokeWeight(designWeight);
      stroke(255, 0, 0);

      return true ;
    }
    strokeWeight(designWeight);
    stroke(255, 0, 0);
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
  // Top line of rectangle
  xx[28] = saveCircleX[23];
  yy[28] = saveCircleY[23];
  xx[29] = saveCircleX[27];
  yy[29] = saveCircleY[27];

  xx[48] = saveCircleX[27]; // Left line of rect
  yy[48] = saveCircleY[27]; // Left line of rect
  xx[49] = saveCircleX[33]; // Left line of rect
  yy[49] = saveCircleY[33]; // Left line of rect

  if (displayConstructionLines) {
    line( saveCircleX[23], saveCircleY[23], saveCircleX[27], saveCircleY[27]); // Top line of rectangle
    line( saveCircleX[27], saveCircleY[27], saveCircleX[33], saveCircleY[33]); // Left line of rect
    line( saveCircleX[33], saveCircleY[33], saveCircleX[37], saveCircleY[37]); // Bottom line of rectangle
    line( saveCircleX[37], saveCircleY[37], saveCircleX[23], saveCircleY[23]); // Right line of rectangle
  }
} // end rectangle

void lozenge(boolean displayConstructionLines) {
  xx[13] = saveCircleX[27]; // bottom left
  yy[13] = saveCircleY[30]; // bottom left
  xx[14] = saveCircleX[35]; // bottom left
  yy[14] = saveCircleY[33]; // bottom left

  xx[40] = saveCircleX[25]; // lozenge top left 
  yy[40] = saveCircleY[23]; // lozenge top left 
  xx[41] = saveCircleX[27]; // lozenge top left 
  yy[41] = saveCircleY[30]; // lozenge top left 

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

  deltaX = saveCircleX[40] - saveCircleX[52];
  deltaY = saveCircleY[40] - saveCircleY[52];
  xx[11] = saveCircleX[40] - deltaX * 3;
  yy[11] = saveCircleY[40] - deltaY * 3;

  xx[12] = saveCircleX[52] + deltaX * 3;
  yy[12] = saveCircleY[52] + deltaY * 3;

  if (displayConstructionLines) {
    //  set 1
    line(saveCircleX[40] - deltaX * 3, saveCircleY[40] - deltaY * 3, saveCircleX[52] + deltaX * 3, saveCircleY[52] + deltaY * 3); // Bottom 1
    line(saveCircleX[42] - deltaX * 3, saveCircleY[42] - deltaY * 3, saveCircleX[50] + deltaX * 3, saveCircleY[50] + deltaY * 3); // Top 1
  }

  xx[64] = saveCircleX[42] - deltaX * 3; // Parallal 1 top
  yy[64] = saveCircleY[42] - deltaX * 3; // Parallel 1 top
  xx[65] = saveCircleX[50] + deltaX * 3; // Parallel 1 top
  yy[65] = saveCircleY[50] + deltaY * 3; // Parallel 1 top

  xx[80] = saveCircleX[40] - deltaX * 3;
  yy[80] = saveCircleY[40] - deltaY * 3;
  xx[81] = saveCircleX[52] + deltaX * 3;
  yy[81] = saveCircleY[52] + deltaY * 3;

  xx[82] = saveCircleX[42] - deltaX * 3;
  yy[82] = saveCircleY[42] - deltaY * 3;
  xx[83] = saveCircleX[50] + deltaX * 3;
  yy[83] = saveCircleY[50] + deltaY * 3;

  //  set 2
  deltaX = saveCircleX[44] - saveCircleX[52];
  deltaY = saveCircleY[44] - saveCircleY[52];

  xx[23] = saveCircleX[44] - deltaX * 3;
  yy[23] = saveCircleY[44] - deltaY * 3;

  xx[24] = saveCircleX[52] + deltaX * 3;
  yy[24] = saveCircleY[52] + deltaY * 3;

  if (displayConstructionLines) {
    line(saveCircleX[44] - deltaX * 3, saveCircleY[44] - deltaY * 3, saveCircleX[52] + deltaX * 3, saveCircleY[52] + deltaY * 3); // top 3
    line(saveCircleX[42] - deltaX * 3, saveCircleY[42] - deltaY * 3, saveCircleX[54] + deltaX * 3, saveCircleY[54] + deltaY * 3); // Bottom 3
  }

  // Center Lines 3 // Verticle center pair
  deltaX = saveCircleX[46] - saveCircleX[54];
  deltaY = saveCircleY[46] - saveCircleY[54];

  // Center Left  parallel line
  xx[26] = saveCircleX[46] - deltaX * 3; // Center Left  parallel line
  yy[26] = saveCircleY[46] - deltaY * 3; // Center Left  parallel line
  xx[27] = saveCircleX[54] + deltaX * 3; // Center Left  parallel line
  yy[27] = saveCircleY[54] + deltaY * 3; // Center Left  parallel line


  xx[51] = saveCircleX[44] - deltaX * 3; // Center Right  parallel line
  yy[51] = saveCircleY[44] - deltaY * 3; // Center Right  parallel line
  xx[54] = saveCircleX[44] - deltaX * 3; // Center Right  parallel line // testing
  yy[54] = saveCircleY[44] - deltaY * 3; // Center Right  parallel line // testing

  xx[52] = saveCircleX[56] + deltaX * 3; // Center Right  parallel line
  yy[52] = saveCircleY[56] + deltaY * 3; // Center Right  parallel line


  if (displayConstructionLines) {
    line(saveCircleX[46] - deltaX * 3, saveCircleY[46] - deltaY * 3, saveCircleX[54] + deltaX * 3, saveCircleY[54] + deltaY * 3); // Center Left  
    line(saveCircleX[44] - deltaX * 3, saveCircleY[44] - deltaY * 3, saveCircleX[56] + deltaX * 3, saveCircleY[56] + deltaY * 3); // Center Right
  }

  xx[3] = saveCircleX[44] - deltaX * 3;
  yy[3] = saveCircleY[44] - deltaY * 3;
  xx[4] = saveCircleX[56] + deltaX * 3;
  yy[4] = saveCircleY[56] + deltaY * 3;

  xx[15] = saveCircleX[48] - deltaX * 3; // parallel  5
  yy[15] = saveCircleY[48] - deltaY * 3; // parallel  5
  xx[16] = saveCircleX[56] + deltaX * 3; // parallel  5
  yy[16] = saveCircleY[56] + deltaY * 3; // parallel  5

  // Lines 4
  deltaX = saveCircleX[47] - saveCircleX[57];
  deltaY = saveCircleY[47] - saveCircleY[57];

  xx[17] = saveCircleX[48] - deltaX * 3; // parallel  5
  yy[17] = saveCircleY[48] - deltaY * 3; // parallel  5
  xx[18] = saveCircleX[56] + deltaX * 3; // parallel  5
  yy[18] = saveCircleY[56] + deltaY * 3; // parallel  5

  xx[21] = saveCircleX[48] - deltaX * 3; // line lower left paralel for end of star
  yy[21] = saveCircleY[48] - deltaY * 3;
  xx[22] = saveCircleX[56] + deltaX * 3;
  yy[22] = saveCircleY[56] + deltaY * 3;

  xx[44] = saveCircleX[46] - deltaX * 3; // top parallel par 4
  yy[44] = saveCircleY[46] - deltaY * 3; // top parallel par 4
  xx[45] = saveCircleX[58] + deltaX * 3; // top parallel par 4 
  yy[45] = saveCircleY[58] + deltaY * 3; // top parallel par 4 

  xx[46] = saveCircleX[48] - deltaX * 3; // bottom parallel par 4
  yy[46] = saveCircleY[48] - deltaY * 3; // bottom parallel par 4
  xx[47] = saveCircleX[56] + deltaX * 3; // bottom parallel par 4 
  yy[47] = saveCircleY[56] + deltaY * 3; // bottom parallel par 4 

  if (displayConstructionLines) {  
    line(saveCircleX[48] - deltaX * 3, saveCircleY[48] - deltaY * 3, saveCircleX[56] + deltaX * 3, saveCircleY[56] + deltaY * 3); // 4 Lower  
    line(saveCircleX[46] - deltaX * 3, saveCircleY[46] - deltaY * 3, saveCircleX[58] + deltaX * 3, saveCircleY[58] + deltaY * 3); // 4 Upper
  }
  // Lines 5

  xx[56] = saveCircleX[50] - deltaX * 3; // Parallel 5 bottom
  yy[56] = saveCircleY[50] - deltaY * 3; // Parallel 5 bottom
  xx[57] = saveCircleX[58] + deltaX * 3; // Parallel 5 bottom
  xx[57] = saveCircleY[58] + deltaY * 3; // Parallel 5 bottom

  deltaX = saveCircleX[49] - saveCircleX[59];
  deltaY = saveCircleY[49] - saveCircleY[59];

  xx[7] = saveCircleX[48] - deltaX * 3;
  yy[7] = saveCircleY[48] - deltaY * 3;
  xx[8] = saveCircleX[40] + deltaX * 3;
  yy[8] = saveCircleY[40] + deltaY * 3;
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


  if (displayConstructionLines) {
    circle(0, 0, radius * 2);  // extra circle
  }

  deltaX = saveIntersectionX[2] - 0;
  deltaY = -radius - saveIntersectionY[2] ;

  myLineline3 = new Lineline(3, -x1, y1, -x2, y2, x3, y3, x4, y4, false, false, 'b', 3);
  myLineline3.displayIntersection();

  xx[1] = x1; 
  yy[1] = y1;
  xx[2] = x2;
  yy[2] = y2;

  xx[19] = x1; 
  yy[19] = -y1;
  xx[20] = x2;
  yy[20] = -y2;

  xx[36] = -x1; // Step 6 top lower west upper east
  yy[36] = y1;  // Step 6 top lower west upper east
  xx[37] = -x2; // Step 6 top lower west upper east
  yy[37] = y2;  // Step 6 top lower west upper east

  xx[38] = x1; // step6 top upper west lower east
  yy[38] = y1; // step6 top upper west lower east
  xx[39] = x2; // step6 top upper west lower east
  yy[39] = y2; // step6 top upper west lower east

  xx[50] = -x1; // step 6 top lower west upper east
  yy[50] =  y1; // step 6 top lower west upper east
  xx[51] = -x2; // step 6 top lower west upper east
  yy[51] =  y2; // step 6 top lower west upper east

  xx[55] = -x2; // step 6 top lower west upper east // testing
  yy[55] =  y2; // step 6 top lower west upper east // testing

  if (displayConstructionLines) {
    line( x1, y1, x2, y2);  // top upper west lower east
    line(-x1, y1, -x2, y2);  // top lower west upper east
    line( x1, -y1, x2, -y2);  // bottom lower west upper east
    line(-x1, -y1, -x2, -y2);  // bottom upper west lower east
  }
}

void step7(boolean displayConstructionLines) {
  float x1, y1, x2, y2;
  // calculate intersection points
  x1 = saveIntersectionX[3];
  y1 = height / 2;

  x2 = saveIntersectionX[3];
  y2 = height / 2;

  xx[9] = x1; // right
  yy[9] = -y1;
  xx[10] = x2;
  yy[10] = y2;

  xx[32] = -x1; // left of step 7
  yy[32] = -y1;
  xx[33] = -x2; // left of step 7
  yy[33] = y2;

  xx[62] =  x1; // Right of step 7
  yy[63] = y1; // Right of step 7
  xx[63] =  x2; // Right of step 7
  yy[63] =  -y2; // Right of step 7

  if (displayConstructionLines) {
    line( x1, y1, x2, -y2);  // Right
    line( -x1, -y1, -x2, y2);  // left
  }
}

void step8A(boolean displayConstructionLines) {
  float x1, y1, x2, y2, x3, y3, x4, y4;
  float deltaX, deltaY;
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

  myLineline4 = new Lineline(4, x1, y1, x2, y2, x3, y3, x4, y4, false, false, 'b', 3);
  myLineline4.displayIntersection();

  x1 = saveIntersectionX[4];
  y1 = saveIntersectionY[4];
  x2 = x3 + innerScale /2;
  y2 = saveCircleY[27];

  xx[34] = x1; // top left of step 8a
  yy[34] = y1;
  xx[35] = x2; // top left of step 8a
  yy[35] = y2; 

  if (displayConstructionLines) {
    line( x1, y1, x2, y2);  // top left
    line(-x1, y1, -x2, y2);  // top right
    line( x1, -y1, x2, -y2);  // bottom left
    line(-x1, -y1, -x2, -y2);  // bottom right
  }
}

void step8B(boolean displayConstructionLines) {
  float x1, y1, x2, y2, x3, y3, x4, y4;
  float deltaX, deltaY;

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

  xx[42] = x1; // Step8B top left 
  yy[42] = y1; // Step8B top left 
  xx[43] = x2; // Step8B top left  
  yy[43] = y2; // Step8B top left  

  if (displayConstructionLines) {
    line( x1, y1, x2, y2);  // top left
    line(-x1, y1, -x2, y2);  // top right
    line( x1, -y1, x2, -y2);  // bottom left
    line(-x1, -y1, -x2, -y2);  // bottom right
  }
} // end of step8b

void step9(boolean displayConstructionLines) {
  float x1, y1, x2, y2;
  float deltaX, deltaY;

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

  xx[30] = x1;   // Step 9 top left
  yy[30] = y1;   // Step 9 top left
  xx[31] = x2;   // Step 9 top left
  yy[31] = y2;   // Step 9 top left

  if (displayConstructionLines) {
    line( x1, y1, x2, y2);  // top left
    line(-x1, y1, -x2, y2);  // top right
    line( x1, -y1, x2, -y2);  // bottom left
    line(-x1, -y1, -x2, -y2);  // bottom right
    stroke(0);
  }
}

// draw inner star design lines
void step10(boolean displayDesignLines ) {

  float x1, y1, x2, y2;
  myLineline8 = new Lineline(8, xx[1], yy[1], xx[2], yy[2], xx[3], yy[3], xx[4], yy[4], false, false, 'b', 2); // line 1 in step 10 Inner Star
  myLineline8.displayIntersection();

  myLineline9 = new Lineline(9, xx[3], yy[3], xx[4], yy[4], xx[7], yy[7], xx[8], yy[8], false, false, 'b', 5); // top parallen line 1 in step 10 Inner Star
  myLineline9.displayIntersection();

  myLineline10 = new Lineline(10, xx[9], yy[9], xx[10], yy[10], xx[7], yy[7], xx[8], yy[8], false, false, 'b', 2); // top parallen line 1 in step 10 Inner Star  ??
  myLineline10.displayIntersection();

  myLineline11 = new Lineline(11, xx[11], yy[11], xx[12], yy[12], xx[13], yy[13], xx[14], yy[14], false, false, 'b', 6); // bottom parallen line 1 in step 10 Inner Star
  myLineline11.displayIntersection();

  myLineline12 = new Lineline(12, xx[11], yy[11], xx[12], yy[12], xx[17], yy[17], xx[18], yy[18], false, false, 'B', 9); // bottom parallen line 1 in step 10 Inner Star
  myLineline12.displayIntersection();

  myLineline13 = new Lineline(13, xx[17], yy[17], xx[18], yy[18], xx[19], yy[19], xx[20], yy[20], false, false, 'm', 2); // top parallen line 1 in step 10 Inner Star
  myLineline13.displayIntersection();

  myLineline14 = new Lineline(14, xx[13], yy[13], xx[14], yy[14], xx[11], yy[11], xx[12], yy[12], false, false, 'B', 2); // top parallen line 1 in step 10 Inner Star
  myLineline14.displayIntersection();

  myLineline15 = new Lineline(15, xx[23], yy[23], xx[24], yy[24], xx[21], yy[21], xx[22], yy[22], false, false, 'b', 2); // top parallen line 1 in step 10 Inner Star
  myLineline15.displayIntersection();

  myLineline16 = new Lineline(16, xx[13], yy[13], xx[14], yy[14], xx[23], yy[23], xx[24], yy[24], false, false, 'g', 2); // top parallen line 1 in step 10 Inner Star
  myLineline16.displayIntersection();

  x1 = saveIntersectionX[8];
  y1 = saveIntersectionY[8];

  x2 = saveIntersectionX[9];
  y2 = saveIntersectionY[9];

  if (displayDesignLines) {
    stroke(255, 0, 0); // red
    strokeWeight(designWeight);

    // Center verticle lines
    line( x1, y1, x2, y2);  // top right
    line(-x1, y1, -x2, y2);  // top left
    line( x1, -y1, x2, -y2);  // bottom right
    line(-x1, -y1, -x2, -y2);  // bottom left

    x1 = saveIntersectionX[9];
    y1 = saveIntersectionY[9];
    x2 = saveIntersectionX[10];
    y2 = saveIntersectionY[10];

    line( x1, y1, x2, y2);  // middle pair
    line(-x1, y1, -x2, y2);
    line( x1, -y1, x2, -y2);
    line(-x1, -y1, -x2, -y2);

    x1 = saveIntersectionX[12];
    y1 = saveIntersectionY[12];
    x2 = saveIntersectionX[13];
    y2 = saveIntersectionY[13];

    line( x1, y1, x2, y2); // center top and bttom 
    line(-x1, y1, -x2, y2);
    line( x1, -y1, x2, -y2);
    line(-x1, -y1, -x2, -y2);

    x1 = saveIntersectionX[11];
    y1 = saveIntersectionY[11];
    x2 = saveIntersectionX[12];
    y2 = saveIntersectionY[12];

    xx[60] = x1;
    yy[60] = y1;
    xx[61] = x2;
    yy[61] = y2;

    xx[58] = x1;
    yy[58] = -y1;
    xx[59] = x2;
    yy[59] = -y2;

    line( x1, y1, x2, y2);  // parralel pair 6  
    line(-x1, y1, -x2, y2);  // lower 5
    line( x1, -y1, x2, -y2); // upper 5
    line(-x1, -y1, -x2, -y2);

    x1 = saveIntersectionX[15];
    y1 = saveIntersectionY[15];
    x2 = saveIntersectionX[16];
    y2 = saveIntersectionY[16];

    line( x1, y1, x2, y2);  // top right
    line(-x1, y1, -x2, y2);  // top left
    line( x1, -y1, x2, -y2);  // bottom right
    line(-x1, -y1, -x2, -y2);  // bottom left
  }
}      // end of the star

// draw step11A
void step11A(boolean displayDesignLines ) {

  float x1, y1, x2, y2;

  myLineline17 = new Lineline(17, xx[26], yy[26], xx[27], yy[27], xx[30], yy[30], xx[31], yy[31], false, false, 'g', 2); // Left of center parallel line and top of rectangle
  myLineline17.displayIntersection();

  myLineline18 = new Lineline(18, xx[28], yy[28], xx[29], yy[29], xx[30], yy[30], xx[31], yy[31], false, false, 'b', 2); // Left of center parallel line and top of rectangle
  myLineline18.displayIntersection();

  x1 = saveIntersectionX[17];
  y1 = saveIntersectionY[17];

  x2 = saveIntersectionX[18];
  y2 = saveIntersectionY[18];

  myLineline19 = new Lineline(19, xx[34], yy[34], xx[35], yy[35], xx[28], yy[28], xx[29], yy[29], false, false, 'b', 2); // 
  myLineline19.displayIntersection();

  if (displayDesignLines) {
    stroke(255, 0, 0); // red
    strokeWeight(designWeight);
    line( x1, y1, x2, y2);  // top right
    line(-x1, y1, -x2, y2);  // top left
    line( x1, -y1, x2, -y2);  // bottom right
    line(-x1, -y1, -x2, -y2);  // bottom left
  }
}

// draw step11B
void step11B(boolean displayDesignLines ) {

  float x1, y1, x2, y2;

  myLineline19 = new Lineline(19, xx[34], yy[34], xx[35], yy[35], xx[28], yy[28], xx[29], yy[29], false, false, 'r', 2); // 
  myLineline19.displayIntersection();

  myLineline20 = new Lineline(20, xx[32], yy[32], xx[33], yy[33], xx[34], yy[34], xx[35], yy[35], false, false, 'b', 2); // 
  myLineline20.displayIntersection();

  x1 = saveIntersectionX[19];
  y1 = saveIntersectionY[19];

  x2 = saveIntersectionX[20];
  y2 = saveIntersectionY[20];

  if (displayDesignLines) {
    stroke(255, 0, 0); // red
    strokeWeight(designWeight);
    line( x1, y1, x2, y2);  // top right
    line(-x1, y1, -x2, y2);  // top left
    line( x1, -y1, x2, -y2);  // bottom right
    line(-x1, -y1, -x2, -y2);  // bottom left
  }
}

// draw step11C
void step11C(boolean displayDesignLines ) {
  float x1, y1, x2, y2;
  myLineline23 = new Lineline(23, xx[32], yy[32], xx[33], yy[33], xx[36], yy[36], xx[37], yy[37], false, false, 'g', 2); // 
  myLineline23.displayIntersection();

  x1 = saveIntersectionX[20];
  y1 = saveIntersectionY[20];
  x2 = saveIntersectionX[23];
  y2 = saveIntersectionY[23];

  if (displayDesignLines) {
    line( x1, y1, x2, y2);  // top right
    line(-x1, y1, -x2, y2);  // top left
    line( x1, -y1, x2, -y2);  // bottom right
    line(-x1, -y1, -x2, -y2);  // bottom left
  }
}

// draw step11D
void step11D(boolean displayDesignLines ) {
  float x1, y1, x2, y2;
  myLineline24 = new Lineline(24, xx[40], yy[40], xx[41], yy[41], xx[38], yy[38], xx[39], yy[39], false, false, 'g', 2); // 
  myLineline24.displayIntersection();

  myLineline25 = new Lineline(25, xx[42], yy[42], xx[43], yy[43], xx[38], yy[38], xx[39], yy[39], false, false, 'g', 2); // 
  myLineline25.displayIntersection();

  xx[66] = saveIntersectionX[24];
  yy[66] = saveIntersectionY[24];
  xx[67] = saveIntersectionX[10];
  yy[67] = saveIntersectionY[10];

  x1 = saveIntersectionX[24];
  y1 = saveIntersectionY[24];
  x2 = saveIntersectionX[25];
  y2 = saveIntersectionY[25];

  if (displayDesignLines) {
    stroke(255, 0, 0); // red
    strokeWeight(designWeight);
    line( x1, y1, x2, y2);  // top right
    line(-x1, y1, -x2, y2);  // top left
    line( x1, -y1, x2, -y2);  // bottom right
    line(-x1, -y1, -x2, -y2);  // bottom left
  }
}

// draw step11E  Parallel Lines par 4 top
void step11E(boolean displayDesignLines ) {
  float x1, y1, x2, y2;
  myLineline26 = new Lineline(26, xx[40], yy[40], xx[41], yy[41], xx[44], yy[44], xx[45], yy[45], false, false, 'g', 2); // lozenge top left and top parallel 
  myLineline26.displayIntersection();

  myLineline27 = new Lineline(27, xx[42], yy[42], xx[43], yy[43], xx[44], yy[44], xx[45], yy[45], false, false, 'b', 2); // top parallel 4 top rectangle
  myLineline27.displayIntersection();

  x1 = saveIntersectionX[26];
  y1 = saveIntersectionY[26];
  x2 = saveIntersectionX[27];
  y2 = saveIntersectionY[27];

  if (displayDesignLines) {
    stroke(255, 0, 0); // red
    strokeWeight(designWeight);
    line( x1, y1, x2, y2);  // top right
    line(-x1, y1, -x2, y2);  // top left
    line( x1, -y1, x2, -y2);  // bottom right
    line(-x1, -y1, -x2, -y2);  // bottom left
  }
}

// draw step11G  Parallel Lines par 4 bottom
void step11G(boolean displayDesignLines ) {
  float x1, y1, x2, y2;
  myLineline28 = new Lineline(28, xx[50], yy[50], xx[55], yy[55], xx[46], yy[46], xx[47], yy[47], false, false, 'g', 3); //  was true
  myLineline28.displayIntersection();
  myLineline29 = new Lineline(29, xx[48], yy[48], xx[49], yy[49], xx[46], yy[46], xx[47], yy[47], false, false, 'b', 2); // 
  myLineline29.displayIntersection();

  x1 = saveIntersectionX[28];
  y1 = saveIntersectionY[28];
  x2 = saveIntersectionX[29];
  y2 = saveIntersectionY[29];

  if (displayDesignLines) {
    stroke(255, 0, 0); // red
    strokeWeight(designWeight);
    line( x1, y1, x2, y2);  // top right
    line(-x1, y1, -x2, y2);  // top left
    line( x1, -y1, x2, -y2);  // bottom right
    line(-x1, -y1, -x2, -y2);  // bottom left
  }
}

// draw step11G  Parallel Lines par 4 bottom
void step11F(boolean displayDesignLines ) {
  float x1, y1, x2, y2;
  myLineline30 = new Lineline(30, xx[42], yy[42], xx[43], yy[43], xx[48], yy[48], xx[49], yy[49], false, false, 'g', 2); //   Step8B top left & Left line of rect
  myLineline30.displayIntersection();
  myLineline31 = new Lineline(31, xx[38], yy[38], xx[39], yy[39], xx[42], yy[42], xx[43], yy[43], false, false, 'b', 2); // step6 top upper west lower east and 
  myLineline31.displayIntersection();

  x1 = saveIntersectionX[30];
  y1 = saveIntersectionY[30];
  x2 = saveIntersectionX[31];
  y2 = saveIntersectionY[31];

  if (displayDesignLines) {
    line( x1, y1, x2, y2);  // top right
    line(-x1, y1, -x2, y2);  // top left
    line( x1, -y1, x2, -y2);  // bottom right
    line(-x1, -y1, -x2, -y2);  // bottom left
  }
}

// draw step12A 4 x shapes diagnal corners  top left of Lozenge to lower west upper east of step 6
void step12A(boolean displayDesignLines ) {
  float x1, y1, x2, y2;

  myLineline32 = new Lineline(32, xx[40], yy[40], xx[41], yy[41], xx[46], yy[46], xx[47], yy[47], false, false, 'g', 2); // Lozenge top left & Bottom Parallel 4
  myLineline32.displayIntersection();
  myLineline33 = new Lineline(33, xx[40], yy[40], xx[41], yy[41], xx[44], yy[44], xx[45], yy[45], false, false, 'b', 2); // // Lozenge top left & Bottom Parallel 4 
  myLineline33.displayIntersection();

  x1 = saveIntersectionX[32];
  y1 = saveIntersectionY[32];
  x2 = saveIntersectionX[33];
  y2 = saveIntersectionY[33];

  if (displayDesignLines) {
    line( x1, y1, x2, y2);  // top right
    line(-x1, y1, -x2, y2);  // top left
    line( x1, -y1, x2, -y2);  // bottom right
    line(-x1, -y1, -x2, -y2);  // bottom left
  }
}

// draw step12B 4 x shapes diagnal corners  top left of Lozenge to lower west upper east of step 6
void step12B(boolean displayDesignLines ) {
  float x1, y1, x2, y2;

  myLineline32 = new Lineline(32, xx[44], yy[44], xx[45], yy[45], xx[50], yy[50], xx[55], yy[55], false, false, 'r', 1); // Lozenge top left & Bottom Parallel 4 // was also true
  myLineline32.displayIntersection();
  myLineline33 = new Lineline(33, xx[50], yy[50], xx[55], yy[55], xx[46], yy[46], xx[47], yy[47], false, false, 'b', 2); // step 6 top lower west upper east & Bottom Parallel 4 // was also true
  myLineline33.displayIntersection();

  x1 = saveIntersectionX[32];
  y1 = saveIntersectionY[32];
  x2 = saveIntersectionX[33];
  y2 = saveIntersectionY[33];

  if (displayDesignLines) {
    line( x1, y1, x2, y2);  // top right
    line(-x1, y1, -x2, y2);  // top left
    line( x1, -y1, x2, -y2);  // bottom right
    line(-x1, -y1, -x2, -y2);  // bottom left
  }
}

//// Center Left  parallel line
//xx[26]  // Center Left  parallel line
//yy[26]  // Center Left  parallel line
//xx[27]  // Center Left  parallel line
//yy[27]  // Center Left  parallel line

//xx[38] // step6 top upper west lower east
//yy[38] // step6 top upper west lower east
//xx[39] // step6 top upper west lower east
//yy[39] // step6 top upper west lower east

//xx[30] = x1;   // Step 9 top left
//yy[30] = y1;   // Step 9 top left
//xx[31] = x2;   // Step 9 top left
//yy[31] = y2;   // Step 9 top left

// draw step12C 2 x shapes Center Parallel Lines top and bottom
void step12C(boolean displayDesignLines ) {
  float x1, y1, x2, y2;

  myLineline32 = new Lineline(32, xx[26], yy[26], xx[27], yy[27], xx[38], yy[38], xx[39], yy[39], false, false, 'g', 4); // Center Left  parallel line & step 6 top upper West 
  myLineline32.displayIntersection();

  myLineline33 = new Lineline(33, xx[26], yy[26], xx[27], yy[27], xx[30], yy[30], xx[31], yy[31], false, false, 'b', 2); // Center Left  parallel line & step 6 top upper West 
  myLineline33.displayIntersection();

  x1 = saveIntersectionX[32];
  y1 = saveIntersectionY[32];

  x2 = saveIntersectionX[33];
  y2 = saveIntersectionY[33];

  if (displayDesignLines) {
    stroke(255, 0, 0); // red
    strokeWeight(designWeight);
    line( x1, y1, x2, y2);  // top right
    line(-x1, y1, -x2, y2);  // top left
    line( x1, -y1, x2, -y2);  // bottom right
    line(-x1, -y1, -x2, -y2);  // bottom left
  }
}

// draw step12D 2 x shapes Center Parallel Lines top and bottom
void step12D(boolean displayDesignLines ) {
  float x1, y1, x2, y2;
  myLineline34 = new Lineline(34, xx[52], yy[52], xx[54], yy[54], xx[36], yy[36], xx[37], yy[37], false, false, 'b', 1); // Center Right  parallel line & step 6 top upper West 
  myLineline34.displayIntersection();

  myLineline35 = new Lineline(35, xx[26], yy[26], xx[27], yy[27], xx[36], yy[36], xx[37], yy[37], false, false, 'g', 6); // Center Left  parallel line & step 6 top lower West 
  myLineline35.displayIntersection();

  x1 = saveIntersectionX[34];
  y1 = saveIntersectionY[34];

  x2 = saveIntersectionX[35];
  y2 = saveIntersectionY[35];

  if (displayDesignLines) {
    line( x1, y1, x2, y2);  // top right
    line(-x1, y1, -x2, y2);  // top left
    line( x1, -y1, x2, -y2);  // bottom right
    line(-x1, -y1, -x2, -y2);  // bottom left
  }
}

// draw step12E 2 "X" Y Center of design & Left of rectangle
void step12E(boolean displayDesignLines ) {
  float x1, y1, x2, y2;
  myLineline37 = new Lineline(37, xx[26], yy[26], xx[27], yy[27], xx[36], yy[36], xx[37], yy[37], false, false, 'g', 6); // 
  myLineline37.displayIntersection();

  x1 = saveIntersectionX[58];  
  y1 = saveIntersectionY[58];
  x2 = 0;
  y2 = yy[48] ;

  if (displayDesignLines) {
    line(xx[58], yy[58], xx[48], 0);  // top left
    line(xx[48], 0, xx[60], yy[60]);  // bottom left
    line(-xx[58], yy[58], -xx[48], 0);  // top right
    line(-xx[48], 0, -xx[60], yy[60]);  // bottom right
  }
}

void step12F(boolean displayDesignLines ) {
  float x1, y1, x2, y2;
  x1 = saveIntersectionX[2];
  y1 = saveIntersectionY[2];

  myLineline38 = new Lineline(38, x1, y1, saveIntersectionX[4], saveIntersectionY[4], xx[62], yy[62], xx[63], yy[63], false, false, 'g', 9); // 
  myLineline38.displayIntersection();

  x2 = saveIntersectionX[38];
  y2 = saveIntersectionY[38];

  if (displayDesignLines) {
    strokeWeight(designWeight);
    stroke(255, 0, 0); // red
    line( x1, y1, x2, y2);  // top right
    line(-x1, y1, -x2, y2);  // top left
    line( x1, -y1, x2, -y2);  // bottom right
    line(-x1, -y1, -x2, -y2);  // bottom left
  }
}

void step12G(boolean displayDesignLines ) {
  float x1, y1, x2, y2;
  x1 = saveIntersectionX[2];
  y1 = saveIntersectionY[2];

  myLineline39 = new Lineline(39, x1, y1, saveIntersectionX[4], saveIntersectionY[4], xx[62], yy[62], xx[63], yy[63], false, false, 'g', 9); // 
  myLineline39.displayIntersection();

  myLineline40 = new Lineline(40, saveIntersectionX[2], saveIntersectionY[2], saveCircleX[42], saveCircleY[42], xx[62], yy[62], xx[63], yy[63], false, false, 'g', 9); // 
  myLineline40.displayIntersection();

  x1 = saveIntersectionX[2];
  y1 = saveIntersectionY[2];

  x2 = saveIntersectionX[40];
  y2 = saveIntersectionY[40];

  if (displayDesignLines) {
    line( x1, y1, x2, y2);  // top right
    line(-x1, y1, -x2, y2);  // top left
    line( x1, -y1, x2, -y2);  // bottom right
    line(-x1, -y1, -x2, -y2);  // bottom left

    myLineline41 = new Lineline(41, xx[62], yy[62], xx[63], yy[63], xx[11], yy[11], xx[12], yy[12], false, false, 'g', 5); // 
    myLineline41.displayIntersection();

    myLineline42 = new Lineline(42, xx[62], yy[62], xx[63], yy[63], xx[11], yy[11], xx[12], yy[12], false, false, 'r', 6); // 
    myLineline42.displayIntersection();

    myLineline43 = new Lineline(43, xx[62], yy[62], xx[63], yy[63], xx[64], yy[64], xx[65], yy[65], false, false, 'g', 6); // 
    myLineline43.displayIntersection();

    myLineline44 = new Lineline(44, xx[82], yy[82], xx[83], yy[83], xx[62], yy[62], xx[63], yy[63], false, false, 'g', 6); // 
    myLineline44.displayIntersection();

    x1 = saveIntersectionX[42];
    y1 = saveIntersectionY[42];

    x2 = saveIntersectionX[44];
    y2 = saveIntersectionY[44];

    if (displayDesignLines) {
      line( x1, y1, x2, y2);  // top right
      line(-x1, y1, -x2, y2);  // top left
      line( x1, -y1, x2, -y2);  // bottom right
      line(-x1, -y1, -x2, -y2);  // bottom left
    }
  }
}

void step12H(boolean displayDesignLines ) {
  float x1, y1, x2, y2;

  x1 = xx[66];
  y1 = yy[66];

  x2 = xx[40];
  y2 = yy[40]; 

  if (displayDesignLines) {
    line( x1, y1, x2, y2);  // top right
    line(-x1, y1, -x2, y2);  // top left
    line( x1, -y1, x2, -y2);  // bottom right
    line(-x1, -y1, -x2, -y2);  // bottom left

    // end of design
  }
}
