// Design from page 240 of Islamic Geometric Designs by Eric Broug
// ISBN 978-0-500-51695-9
// Code by Rupert Russell
// 19 January 2020
// Thanks to: COLLISION DETECTION by Jeff Thompson  
// http://jeffreythompson.org/collision-detection/index.php


float scale = 500;
float[] outerX; // store xPoints for the 10 points on the outer circle
float[] outerY; // store yPoints for the 10 points on the outer circle

float[] innerX; // store xPoints for the 10 points on the outer circle
float[] innerY; // store yPoints for the 10 points on the outer circle
float innerScale;
float middleScale;

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
}


void draw() {
  translate(width/2, height/2);
  calculateOuterPoints(20, scale);

  innerScale = 0.18163545 * 2 * scale;
  middleScale = 0.24999997 * scale;
  calculateInnerPoints(10, innerScale);

  guides();

  save("design_240_v016.png");
}

void guides() {
  circle(0, 0, scale);
  spokes();
  rectangle();
  lozenge();
  circles();
  parallelLines();
  step6();

  // test line 1
  strokeWeight(3);

  circle(0,0, middleScale * 2);

  stroke(0,0,255); // blue
  
  circle(0,-middleScale, 20);  // end point of gurdline 
  // todo find the starting point of this line (thin blue circle) in terms of scale
  // draw 1/2 of the guideline and then extend it to edge of rectangle
  // for step 6
  
  stroke(255, 0, 0);


  // lines to test for intersection
  //  outerX[3], outerY[0], outerX[5], outerY[3]


  float x1 = innerX[5] + ( innerX[5] - innerX[1] );
  float y1 = innerY[5] + ( innerY[5] - innerY[1] );
  float x2 = innerX[1] - ( innerX[5] - innerX[1] );
  float y2 = innerY[1] - ( innerY[5] - innerY[1] );
  float x3 = outerX[17];
  float y3 = outerY[17];
  float x4 = outerX[3];
  float y4 = outerY[3];

  strokeWeight(6); 
  stroke(0, 255, 0);
  line(outerX[3], outerY[0], outerX[5], outerY[3]);

  println(dist(73.473175, -101.12709, 0, 0));
  strokeWeight(1); 
  stroke(0, 0, 0);
 
  strokeWeight(1); 
  stroke(0, 0, 0);

  boolean test = lineLine( x1, y1, x2, y2, x3, y3, x4, y4);
  println(test);

  // float dist = dist(-88.16764, -64.05766, 0, 0);
  // println("dist = " + dist);
}


void calculateOuterPoints(float numPoints, float scale) {
  // calculate and store n points around the outer circle
  int counter = 0;
  double step = radians(360/numPoints); 
  float h = 0; 
  float k = 0;
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
  float r =  scale / 2 ;
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
  }

  strokeWeight(4);
  line( outerX[3], outerY[3], outerX[13], outerY[13]);
  stroke(0, 0, 0);
  strokeWeight(1);
} // end spokes


void rectangle() {
  line( outerX[3], outerY[3], outerX[7], outerY[7]); // Top
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
  stroke(255, 0, 0);
  circle(0, 0, 0.18163545 * 2 * scale);

  stroke(0);
  circle(outerX[3], outerY[3], 0.18163545 * 2 * scale);
  circle(outerX[7], outerY[7], 0.18163545 * 2 * scale);
  circle(outerX[13], outerY[13], 0.18163545 * 2 * scale);
  circle(outerX[17], outerY[17], 0.18163545 * 2 * scale);
} // end circles


void parallelLines() {

  line(innerX[3], -310, innerX[3], 310 );
  line(innerX[2], -310, innerX[2], 310 );


  line(innerX[4] + ( innerX[4] - innerX[0] ), innerY[4] + ( innerY[4] - innerY[0] ), innerX[0] - ( innerX[4] - innerX[0] ), innerY[0] - ( innerY[4] - innerY[0] ) );
  line(innerX[5] + ( innerX[5] - innerX[9] ), innerY[5] + ( innerY[5] - innerY[9] ), innerX[9] - ( innerX[5] - innerX[9] ), innerY[9] - ( innerY[5] - innerY[9] ) );
  strokeWeight(1);

  line(innerX[7] + ( innerX[7] - innerX[1] ), innerY[7] + ( innerY[7] - innerY[1] ), innerX[1] - ( innerX[7] - innerX[1] ), innerY[1] - ( innerY[7] - innerY[1] ) );
  strokeWeight(1);
  line(innerX[6] + ( innerX[6] - innerX[2] ), innerY[6] + ( innerY[6] - innerY[2] ), innerX[2] - ( innerX[6] - innerX[2] ), innerY[2] - ( innerY[6] - innerY[2] ) );


  line(innerX[7] + ( innerX[7] - innerX[1] ), innerY[7] + ( innerY[7] - innerY[1] ), innerX[1] - ( innerX[7] - innerX[1] ), innerY[1] - ( innerY[7] - innerY[1] ) );
  strokeWeight(1);
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



// LINE/LINE 
// Thanks to: COLLISION DETECTION by Jeff Thompson  
// http://jeffreythompson.org/collision-detection/index.php
// from http://jeffreythompson.org/collision-detection/line-line.php
boolean lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {

  // calculate the distance to intersection point
  float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

  // if uA and uB are between 0-1, lines are colliding
  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {

    // optionally, draw a circle where the lines meet
    float intersectionX = x1 + (uA * (x2-x1));
    float intersectionY = y1 + (uA * (y2-y1));
    noFill();
    stroke(0, 0, 225);
    ellipse(intersectionX, intersectionY, 20, 20);
    println("("+ intersectionX+ "," + intersectionY +")");
    return true;
  }
  return false;
}
