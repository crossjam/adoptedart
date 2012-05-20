
// Sep 2008 
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

int num = 20;
Particle[] pArr;

int gap;

//================================= init

void setup() {
  size(500,300);
  frameRate(60);
  background(0);
  //clearBackground();
  smooth();
  
  gap = height / (num+1);
  
  pArr = new Particle[num];
  for (int i=0;i<num;i++) {
    pArr[i] = new Particle(i);
  }
  restart();
}

void clearBackground() {
  fill(0, 5);
  noStroke();
  rect(0,0,width,height);
}

void restart() {
  clearBackground();
  for (int i=0;i<num;i++) {
    pArr[i].init();
  }
}

//================================= frame loop

void draw() {
  clearBackground();
  for (int i=0;i<num;i++) {
    pArr[i].update();
  }
}

//================================= interaction

void mousePressed() { 
  restart();
}

//================================= objects

class Particle {
  int id;
  int x, y;
  int x1 = 11;
  int x2, y1, y2;
  int vx, vy;
  int rd, gr, bl, alph;
  float noiseoff;
  int dir = -2;
  
  int len = width;
  
  Particle (int num) {
    id = num;
    init();
  }
  
  void init() {
    y = (gap * id) + gap + gap;
    y1 = y;
    dir = dir * -1;
    vx = dir;
    
    this.noiseoff = random(100);
    
    rd = 255;
    bl = gr = rd;  // grey
    alph = 255;
  }
  
  void update() {
   
   x2 = x1 + vx;
   y2 = y1;
   
   int prox;
   if (x1 < (width/2)) {
     prox = x1;
   } else {
     prox = width - x1;
   }
   prox = (prox / 10);
   
   
    noiseoff += 0.3;
   if (prox > 10) {
     y2 = int ((noise(noiseoff) * prox) - (prox * prox * 0.065) )  + (gap * id) + gap + gap;
   } else {
     y2 = (gap * id) + gap + gap;
   }
   
   strokeWeight(2);
   stroke(rd, gr, bl, alph);
   line(x1, y1, x2, y2);
   
    
    // reset for next update
    x1 = x2 + (vx/2); 
    y1 = y2; 
    if ((x1 >= (width-10)) || (x1 <= 10)) {
     init(); 
    }
  }
  
}


