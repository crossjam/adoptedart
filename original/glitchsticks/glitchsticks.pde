
// Jan 2009
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

float _x = 0.0;
float _y = 0.0;
float _angle = 0.0;
float _lasty = 250.0;
float _lastx = 250.0;

float _a = 5.0;
float _b = 3.0;

//================================= init


void setup() {
 frameRate(60); 
 size(500,300);
 background(255);
 smooth();
}


//================================= frame loop

void draw() {  
  _angle += 0.5;
  if (_angle > 360) { _angle -= 360; }
  
  float preva = _a;
  float prevb = _b;
  _a = mouseX/10;
  _b = mouseY/10;
  
  if ((_a != preva) || (_b != prevb)) {
    strokeCap(PROJECT);
    strokeWeight(int(random(55)) + 5);
    stroke(random(255));
  } else {
    strokeCap(ROUND);
    strokeWeight(1);
    stroke(255, 150);
  }
  
  _x = sin(_a * radians(_angle) + PI / 2) * 280;  
  _y = sin(_b * radians(_angle)) * 180;
  _x += 250;
  _y += 150;
  
  line(_x, _y, _lastx, _lasty);
  
  _lastx = _x;
  _lasty = _y;
}


//================================= interaction

void mousePressed() {
  background(255);
}


