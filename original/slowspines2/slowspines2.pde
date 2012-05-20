
// Sept 2008 
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



int num = 2400;        

// colCycle - four cycles, black, colour1, white, colour2
String colCycle =  "colour2";

Particle[] partArr;

void setup() {
  size(500,300);     
  frameRate(12);

   
  background(0);
  
  partArr = new Particle[num];

  for (int i=0;i<num;i++) {
   float r = PI*i/num;
    partArr[i] = new Particle(r);
  }

}

void draw() {
  for (int i=0;i<num;i++) {
    partArr[i].move();
  }
}

void mousePressed() {
    // manually switch colCycle periods
    if (colCycle == "colour1") {
      colCycle = "black";
    } else if (colCycle == "black")  {
      colCycle = "colour2";
    } else if (colCycle == "colour2")  {
      colCycle = "white";
    } else if (colCycle == "white")  {
      colCycle = "colour1";
    }
    
  for (int i=0;i<num;i++) {
    partArr[i].origin(mouseX, mouseY);
  }
}


class Particle {
  float ox, oy;
  float x, y;
  float xx, yy;

  float vx;
  float vy;
  int age=int(random(200));
  
  // colour
  int rc;
  int gc;
  int bc;
  int alph = 100;
  
  // line
  int maxline = 7;
  int linethick;

  Particle(float r) {
    ox = 250;
    oy = 20;
    x = ox;
    y = oy;
    
    xx = 0;           
    yy = 0;          

    vx = 2*cos(r);     
    vy = 2*sin(r);    

    rc = int(random(255));
   gc = int(random(255));
  bc = int(random(255)); 
  
  linethick = int(random(maxline)); 
  }
  
  void origin(float ex, float why) {
    // ox = ex;
    oy = why;
  }

  void move() {
    xx=x;
    yy=y;

    x+=vx;
    y+=vy;

    vx += (random(200)-random(200))*0.005;
    vy += (random(200)-random(200))*0.005;

      strokeWeight(1);
    if (colCycle == "colour1") {
      strokeWeight(linethick * 2);
      stroke(rc,gc,bc,60);
    } else if (colCycle == "colour2") {
      stroke(rc,gc,bc,60);
    } else if (colCycle == "black") {
      strokeWeight(linethick / 2);
      stroke(0,0,0,alph);
    } else if (colCycle == "white") {
      stroke(255,255,255,60);
    }
    
    line(ox+xx,oy+yy,ox+x,oy+y);
    line(ox-xx,oy+yy,ox-x,oy+y);

    age++;
    if (age>200) {
      x = ox;
      x = oy;
      xx=0;
      yy=0;
      vx=0;
      vy=0;
      age=0;
    }
  }
}




