
// Dec 2008 
// http://www.abandonedart.org
// http://www.zenbullets.com
//
// This work is licensed under a Creative Commons 3.0 License.
// (Attribution - NonCommerical - ShareAlike)
// http://creativecommons.org/licenses/by-nc-sa/3.0/
// 
// This basically means, you are free to use it as long as you:
// 1. give http://www.zenbullets.com a credit
// 2. don't use it for commercial gain
// 3. share anything you create with it in the same way I have
//
// These conditions can be waived if you want to do something groovy with it 
// though, so feel free to email me via http://www.zenbullets.com



//================================= global vars

float boxSize = 50;
float margin = 65;


//================================= init

void setup() {
  size(500, 300, P3D);
  frameRate(12);
  noStroke();
}


void clearBackground() {
  background(0);
}

//================================= frame loop


void draw() {
  clearBackground();
  
  // Center and spin grid
  translate(width/2, height/2, 0);
  rotateY(frameCount * 0.01);
  rotateX(frameCount * 0.01);

  // Build grid using multiple translations 
  for (float i =- height+margin; i <= height-margin; i += margin){
    pushMatrix();
    for (float j =- height+margin; j <= height-margin; j += margin){
      pushMatrix();
      for (float k =- width+margin; k <= width-margin; k += margin){
        pushMatrix();
        translate(k, j, i);
        fill(255, 20);
        box(boxSize, boxSize, boxSize);
        popMatrix();
      }
      popMatrix();
    }
    popMatrix();
  }
}


