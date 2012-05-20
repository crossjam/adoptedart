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

float _A = 3.0;
float _B = 2.0;
int _xsin1 = 0;
int _xsin2 = 0;
int _xsin3 = 0;
int _ysin1 = 0;
int _ysin2 = 0;
int _ysin3 = 0;
int _pointcount = 0;
float _x = 0;
float _y = 0;

//================================= init

void setup() {
  size(500, 300);
  frameRate(60);
  smooth();
  restart();
}

void restart() {
  clearBackground();
  stroke(255, 50);
  _A = int(random(8)) + 1;
  _B = int(random(8)) + 1;
  _xsin1 = int(random(5));
  _xsin2 = int(random(5));
  _xsin3 = int(random(5));
  _ysin1 = int(random(5));
  _ysin2 = int(random(5));
  _ysin3 = int(random(5));
  println(_A + " : " + _B);
  println(_xsin1 + " : " + _xsin2 + " : " + _xsin3);
  println(_ysin1 + " : " + _ysin2 + " : " + _ysin3);
  _pointcount = 0;
}

void clearBackground() {
  background(0);
}


//================================= frame loop


void draw() {
  for (int i = 0; i < 400; i++) {
    nextPoint();
    line(_x, _y, _x, _y);
    _pointcount++;
  }
  if (_pointcount > 300000) {
    restart();
  }
}

void nextPoint() {
  float sinAx = sin(_A * _x);
  float sinAy = sin(_A * _y);
  float sinBx = sin(_B * _x);
  float sinBy = sin(_B * _y);
  
  float newx = 0;
  float newy = 0; 
  
  if (_xsin1 == 1) {
    newx += sinAx;
  } else if (_xsin1 == 2) {
    newx += sinAy;
  } else if (_xsin1 == 3) {
    newx += sinBx;
  } else if (_xsin1 == 4) {
    newx += sinBy;
  }
  if (_ysin1 == 1) {
    newy += sinAx;
  } else if (_ysin1 == 2) {
    newy += sinAy;
  } else if (_ysin1 == 3) {
    newy += sinBx;
  } else if (_ysin1 == 4) {
    newy += sinBy;
  }
  
  if (_xsin2 == 1) {
    newx += (sinAx * sinAx);
  } else if (_xsin2 == 2) {
    newx += (sinAy * sinAy);
  } else if (_xsin2 == 3) {
    newx += (sinBx * sinBx);
  } else if (_xsin2 == 4) {
    newx += (sinBy * sinBy);
  }
  if (_ysin2 == 1) {
    newy += (sinAx * sinAx);
  } else if (_ysin2 == 2) {
    newy += (sinAy * sinAy);
  } else if (_ysin2 == 3) {
    newy += (sinBx * sinBx);
  } else if (_ysin2 == 4) {
    newy += (sinBy * sinBy);
  }
  
  if (_xsin3 == 1) {
    newx += (sinAx * sinAx * sinAx);
  } else if (_xsin3 == 2) {
    newx += (sinAy * sinAy * sinAy);
  } else if (_xsin3 == 3) {
    newx += (sinBx * sinBx * sinBx);
  } else if (_xsin3 == 4) {
    newx += (sinBy * sinBy * sinBy);
  }
  if (_ysin3 == 1) {
    newy += (sinAx * sinAx * sinAx);
  } else if (_ysin3 == 2) {
    newy += (sinAy * sinAy * sinAy);
  } else if (_ysin3 == 3) {
    newy += (sinBx * sinBx * sinBx);
  } else if (_ysin3 == 4) {
    newy += (sinBy * sinBy * sinBy);
  }
  
  _x = 185 + (newx * 130);
  _y = 100 + (newy * 85);
}


//================================= interaction

void mousePressed() { 
  restart();
}

