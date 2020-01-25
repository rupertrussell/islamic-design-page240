// Design from page 240 of Islamic Geometric Designs by Eric Broug
// ISBN 978-0-500-51695-9
// Code by Rupert Russell
// 19 January 2020
// Thanks to: COLLISION DETECTION by Jeff Thompson  
// http://jeffreythompson.org/collision-detection/index.php


float scale = 600;
float[] outerX; // store xPoints for the 10 points on the outer circle
float[] outerY; // store yPoints for the 10 points on the outer circle

float[] innerX; // store xPoints for the 10 points on the outer circle
float[] innerY; // store yPoints for the 10 points on the outer circle

float[] topRightX; 
float[] topRightY;

float[] topLeftX;
float[] topLeftY; 

float[] bottomRightX; 
float[] bottomRightY;

float[] bottomLeftX;
float[] bottomLeftY; 



float innerScale;
float middleScale;
float intersectionX;
float intersectionY;

float intersection9X;
float intersection9Y;

float stepX;
float stepY;

float x1 = 0;
float y1 = 0;
float x2 = 0;
float y2 = 0;
float x3 = 0;
float y3 = 0;
float x4 = 0;
float y4 = 0;


void setup() {
  background(255);
  noLoop(); 
  size(800, 800); // width x height
  smooth();
  noFill();
  rectMode(CENTER);
  ellipseMode(CENTER);

  outerX = new float[20]; // store x Points for the 10 points on the outer circle
  outerY = new float[20]; // store y Points for the 10 points on the outer circle

  innerX = new float[10]; // store x Points for the 10 points on the outer circle
  innerY = new float[10]; // store y Points for the 10 points on the outer circle

  topRightX = new float[10];  
  topRightY = new float[10]; 

  topLeftX = new float[10]; 
  topLeftY = new float[10];  

  bottomRightX = new float[10];  
  bottomRightY = new float[10]; 

  bottomLeftX = new float[10]; 
  bottomLeftY = new float[10];
}


void draw() {
  translate(width/2, height/2);
  calculateOuterPoints(20, scale, 0, 0);


  innerScale = 0.18163545 * 2 * scale;
  middleScale = 0.24999997 * scale;
  calculateInnerPoints(10, innerScale);

  guides();

  save("design_240_v024.png");
}

void guides() {
  circle(0, 0, scale);
  spokes();
  rectangle();
  step10();
  lozenge();
  circles();
  parallelLines();
  step6();
  step8();
  step9();
  step11();
}



  //x1 = 0;
  //y1 = 0;
  //x2 = 0;
  //y2 = 0;
  //x3 = 0;
  //y3 = 0;
  //x4 = 0;
  //y4 = 0;
  
  

void step11() {
  // top right
  line(0.22451404 *scale, -0.40450858 * scale, 0.2938926 *scale, -0.3090171 * scale);
  // top left
  line(-0.22451404 *scale, -0.40450858 * scale, -0.2938926 *scale, -0.3090171 * scale);
  // bottom left
  line(-0.22451404 *scale, 0.40450858 * scale, -0.2938926 *scale, 0.3090171 * scale);
  // bottom right
  line(0.22451404 *scale, 0.40450858 * scale, 0.2938926 *scale, 0.3090171 * scale);
}

void step10() {

  // find the point of interscrion line and top Rignt circle

  float x1 = innerX[7] + stepX * 2;
  float y1 = innerY[7] + stepY * 2;
  float x2 = innerX[7] - stepX * 4;
  float y2 = innerY[7] - stepY * 4;

  float cx = outerX[3];
  float cy = outerY[3];
  float r =  0.18163545 * 2 * scale;
  int counter = 0;

  double step = radians(360/10); 
  r =  0.18163545  * scale;
  for (float theta=0; theta < 2 * PI; theta += step) {
    float x = cx + r * cos(theta);
    float y = cy - r * sin(theta); 
    topRightX[counter] = x;
    topRightY[counter] = y;

    // circle(x, y, 10);  // draw small circles to show points
    counter ++;
  }
  // line(topRightX[1], topRightY[1], topRightX[5], topRightY[5]);
  // continue line
  stepX = topRightX[5] - topRightX[1];
  stepY = topRightY[5] - topRightY[1];

  //  find point of intersection middle line and 
  x1 = topRightX[5] ;
  y1 = topRightY[5];
  x2 = topRightX[5] + stepX;
  y2 = topRightY[5] + stepY;


  x3 = 0;
  y3 = outerY[17];
  x4 = 0;
  y4 = outerY[3];

  boolean test2 = lineLine( x1, y1, x2, y2, x3, y3, x4, y4);

  // v guide lines
  line(intersectionX, intersectionY, topRightX[1], topRightY[1]);
  line(intersectionX, intersectionY, - topRightX[1], topRightY[1]);

  line(-intersectionX, -intersectionY, - topRightX[1], - topRightY[1]);
  line(intersectionX, -intersectionY, topRightX[1], - topRightY[1]);
  stroke(0, 0, 0);
  strokeWeight(1);
}

void calculateOuterPoints(float numPoints, float scale, float h, float k) {
  // calculate and store n points around the outer circle
  int counter = 0;
  double step = radians(360/numPoints); 
  float r =  scale / 2 ;
  for (float theta=0; theta < 2 * PI; theta += step) {
    float x = h + r * cos(theta);
    float y = k - r * sin(theta); 

    // store the calculated coordinates
    outerX[counter] = x;
    outerY[counter] = y;
    // circle(outerX[counter], outerY[counter], 10);  // draw small circles to show points
    counter ++;
  }
} // end  calculateNPoints

void calculateInnerPoints(float numPoints, float scale) {
  // calculate and store n points around the outer circle
  int counter = 0;
  double step = radians(360/numPoints); 
  float h = 0; 
  float k = 0;
  float r =  scale * 0.5 ;
  for (float theta=0; theta < 2 * PI; theta += step) {
    float x = h + r * cos(theta);
    float y = k - r * sin(theta); 

    // store the calculated coordinates
    innerX[counter] = x;
    innerY[counter] = y;

    circle(innerX[counter], innerY[counter], 10);  // draw small circles to show points
    counter ++;
  }
} // end calculateInnerPoints

void spokes() {
  for (int counter = 0; counter < 10; counter++) {
    line( outerX[counter], outerY[counter], outerX[counter + 10], outerY[counter + 10]);
    strokeWeight(1);
  }


  line(outerX[3], outerY[3], outerX[13], outerY[13]);
  stroke(0, 0, 0);
  strokeWeight(1);
} // end spokes


void rectangle() {
  stroke(255, 0, 0);
  line( outerX[3], outerY[3], outerX[7], outerY[7]); // Top
  stroke(0);
  line( outerX[7], outerY[7], outerX[13], outerY[13]);  // Left
  line( outerX[13], outerY[13], outerX[17], outerY[17]); // Bottom
  line( outerX[17], outerY[17], outerX[3], outerY[3]); // Right
} // end rectangle

void lozenge() {
  line( outerX[5], outerY[3], outerX[7], outerY[10]);
  line( outerX[7], outerY[10], outerX[15], outerY[13]);
  line( outerX[15], outerY[13], outerX[3], outerY[0]);
  line( outerX[3], outerY[0], outerX[5], outerY[3]); // top right


  strokeWeight(1);
} // end lozenge

void circles() {
  circle(0, 0, 0.18163545 * 2 * scale);

  stroke(255, 0, 0);

  circle(outerX[3], outerY[3], 0.18163545 * 2 * scale);
  stroke(0);

  circle(outerX[7], outerY[7], 0.18163545 * 2 * scale);
  circle(outerX[13], outerY[13], 0.18163545 * 2 * scale);
  circle(outerX[17], outerY[17], 0.18163545 * 2 * scale);
} // end circles


void parallelLines() {

  line(innerX[3], - scale * 0.7, innerX[3], scale * 0.6 );
  line(innerX[2], - scale * 0.7, innerX[2], scale * 0.6  );


  line(innerX[4] + ( innerX[4] - innerX[0] ), innerY[4] + ( innerY[4] - innerY[0] ), innerX[0] - ( innerX[4] - innerX[0] ), innerY[0] - ( innerY[4] - innerY[0] ) );
  line(innerX[5] + ( innerX[5] - innerX[9] ), innerY[5] + ( innerY[5] - innerY[9] ), innerX[9] - ( innerX[5] - innerX[9] ), innerY[9] - ( innerY[5] - innerY[9] ) );

  // guide line for step v shape lines *** 


  stepX = innerX[7] - innerX[1];
  stepY = innerY[7] - innerY[1];
  circle(innerX[7] + stepX, innerY[7] + stepY, 10);


  line(innerX[7] + stepX * 2, innerY[7] + stepY * 2, innerX[7] - stepX * 4, innerY[7] - stepY * 4 );

  stroke(0, 0, 0);

  stroke(255, 0, 0);
  strokeWeight(3);
  // guide lines to intersect with ***
  line(innerX[6] + ( innerX[6] - innerX[2] ), innerY[6] + ( innerY[6] - innerY[2] ), innerX[2] - ( innerX[6] - innerX[2] ), innerY[2] - ( innerY[6] - innerY[2] ) );
  line(innerX[7] + ( innerX[7] - innerX[1] ), innerY[7] + ( innerY[7] - innerY[1] ), innerX[1] - ( innerX[7] - innerX[1] ), innerY[1] - ( innerY[7] - innerY[1] ) );
  strokeWeight(1);
  stroke(0, 0, 0);


  line(innerX[6] + ( innerX[6] - innerX[2] ), innerY[6] + ( innerY[6] - innerY[2] ), innerX[2] - ( innerX[6] - innerX[2] ), innerY[2] - ( innerY[6] - innerY[2] ) );

  line(innerX[8] + ( innerX[8] - innerX[4] ), innerY[8] + ( innerY[8] - innerY[4] ), innerX[4] - ( innerX[8] - innerX[4] ), innerY[4] - ( innerY[8] - innerY[4] ) );
  line(innerX[3] + ( innerX[3] - innerX[9] ), innerY[3] + ( innerY[3] - innerY[9] ), innerX[9] - ( innerX[3] - innerX[9] ), innerY[9] - ( innerY[3] - innerY[9] ) );

  strokeWeight(1);
  line(innerX[5] + ( innerX[5] - innerX[1] ), innerY[5] + ( innerY[5] - innerY[1] ), innerX[1] - ( innerX[5] - innerX[1] ), innerY[1] - ( innerY[5] - innerY[1] ) );
  strokeWeight(1);

  line(innerX[6] + ( innerX[6] - innerX[0] ), innerY[6] + ( innerY[6] - innerY[0] ), innerX[0] - ( innerX[6] - innerX[0] ), innerY[0] - ( innerY[6] - innerY[0] ) );
} // end parallelLines


void step6() {

  // top upper left to lower right
  strokeWeight(1);
  // line(146.94635, -77.25424, 0, -midScale / 2);
  strokeWeight(1);
  // radius of inner circle = y
  // r =  scale / 2 ;
}

void step8() {
  float x1 = innerX[5] + ( innerX[5] - innerX[1] );
  float y1 = innerY[5] + ( innerY[5] - innerY[1] );
  float x2 = innerX[1] - ( innerX[5] - innerX[1] );
  float y2 = innerY[1] - ( innerY[5] - innerY[1] );
  float x3 = outerX[17];
  float y3 = outerY[17];
  float x4 = outerX[3];
  float y4 = outerY[3];

  boolean test = lineLine8( x1, y1, x2, y2, x3, y3, x4, y4);
  // TOP PAIR
  line(- intersectionX, -middleScale -( middleScale+intersectionY), intersectionX, intersectionY);


  line(- intersectionX, -middleScale +( middleScale+intersectionY), intersectionX, -middleScale -( middleScale+intersectionY));


  // Bottom Pair
  line(- intersectionX, -middleScale -( middleScale+intersectionY) + middleScale * 2, intersectionX, intersectionY + middleScale * 2);
  line(- intersectionX, -middleScale +( middleScale+intersectionY) + middleScale * 2, intersectionX, -middleScale -( middleScale+intersectionY) + middleScale * 2 );
}


void step9() {

  line(- intersectionX, -middleScale +( middleScale+intersectionY), intersectionX, -middleScale -( middleScale+intersectionY));

  float x1 = - intersectionX;
  float y1= -middleScale +( middleScale+intersectionY);
  float x2 = intersectionX;
  float y2= -middleScale -( middleScale+intersectionY);

  float x3 = outerX[3];
  float y3 = outerY[3];
  float x4 = outerX[13];
  float y4 = outerY[13];

  boolean test = lineLine9( x1, y1, x2, y2, x3, y3, x4, y4);
  stroke(255, 0, 0);
  line(intersection9X, intersection9Y - scale * 0.3, intersection9X, -intersection9X + scale *.85);  // Right
  line(-intersection9X, intersection9Y - scale * 0.3, -intersection9X, -intersection9X + scale *.85);  // Left


  stroke(0);
}



// LINE/LINE 
// Thanks to: COLLISION DETECTION by Jeff Thompson  
// http://jeffreythompson.org/collision-detection/index.php
// from http://jeffreythompson.org/collision-detection/line-line.php

boolean lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  println("0 intersectionX before = "  + intersectionX);

  // calculate the distance to intersection point
  float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

  // if uA and uB are between 0-1, lines are colliding
  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {

    // optionally, draw a circle where the lines meet
    intersectionX = x1 + (uA * (x2-x1));
    intersectionY = y1 + (uA * (y2-y1));
    noFill();

    strokeWeight(1);
    stroke(0, 0, 255); // blue
    ellipse(intersectionX, intersectionY, 20, 20);
    stroke(0);
    strokeWeight(1);
    println("("+ intersectionX+ "," + intersectionY +")");
    return true;
  }
  return false;
}


// LINE/LINE giude step 8
boolean lineLine8(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {

  // calculate the distance to intersection point
  float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

  // if uA and uB are between 0-1, lines are colliding
  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {

    // optionally, draw a circle where the lines meet
    intersectionX = x1 + (uA * (x2-x1));
    intersectionY = y1 + (uA * (y2-y1));
    return true;
  }
  return false;
}


// LINE/LINE giude step 9
boolean lineLine9(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {

  // calculate the distance to intersection point
  float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

  // if uA and uB are between 0-1, lines are colliding
  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {

    // optionally, draw a circle where the lines meet
    intersection9X = x1 + (uA * (x2-x1));
    intersection9Y = y1 + (uA * (y2-y1));
    stroke(0, 0, 255);
    // circle(intersection9X, intersection9Y, 20);
    stroke(0);
    return true;
  }
  return false;
}


// LINE/LINE 
// Thanks to: COLLISION DETECTION by Jeff Thompson  
// http://jeffreythompson.org/collision-detection/index.php
// from http://jeffreythompson.org/collision-detection/line-line.php

boolean lineLine11(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  println("11 intersectionX before = "  + intersectionX);

  // calculate the distance to intersection point
  float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

  // if uA and uB are between 0-1, lines are colliding
  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {

    // optionally, draw a circle where the lines meet
    intersectionX = x1 + (uA * (x2-x1));
    intersectionY = y1 + (uA * (y2-y1));
    noFill();

    strokeWeight(1);
    stroke(0, 0, 255); // blue
    ellipse(intersectionX, intersectionY, 20, 20);
    stroke(0);
    strokeWeight(1);
    println("("+ intersectionX+ "," + intersectionY +")");
    return true;
  }
  return false;
}
