// Dec 2008 
// http://www.abandonedart.org
// http://www.zenbullets.com
//
// with lots of thanks to Erik Natzke (obviously)
// http://jot.eriknatzke.com/
//
// and James Alliban, who saved me the job of doing the conversion
// http://jamesalliban.wordpress.com/2008/12/04/2d-ribbons/
//
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

int _numRibbons = 6;
int _numParticles = 40;
float _randomness = .3;
RibbonManager ribbonManager;

float _a, _b, _centx, _centy, _x, _y;
float _noiseoff;
int _angle;

//================================= init

void setup() {
  size(500, 300);
  smooth(); 
  frameRate(12);
  background(0);
  
  clearBackground();
  
  _centx = (width / 2);
  _centy = (2* height / 3);
  restart();
}    

void restart() {
  _noiseoff = random(1);
  _angle = 1; 
  _a = 3.5;
  _b = _a + (noise(_noiseoff) * 1) - 0.5;
  
  ribbonManager = new RibbonManager(_numRibbons, _numParticles, _randomness);   
  ribbonManager.setRadiusMax(40);                 // default = 8
  ribbonManager.setRadiusDivide(2);              // default = 10
  ribbonManager.setGravity(-0.09);                   // default = .03
  ribbonManager.setFriction(1.1);                  // default = 1.1
  ribbonManager.setMaxDistance(40);               // default = 40
  ribbonManager.setDrag(2.5);                      // default = 2
  ribbonManager.setDragFlare(.015);                 // default = .008
  
}

void clearBackground() {
  background(0);
}


//================================= frame loop

void draw() {
  clearBackground();
  
  float newx = sin(_a + radians(_angle) + PI / 2) * _centx;  
  float newy = sin(_b + radians(_angle)) * _centy; 
  _angle = int(random(360));
  _noiseoff += 0.05;
  _b = (noise(_noiseoff) * 8) +1;
  _a = _b;
  
  translate(_centx, _centy);
  ribbonManager.update(newx* 0.1, newy*0.1);
}



//================================= interaction

void mousePressed() {
 
  _centx = mouseX;
  _centy = mouseY;
  
  restart();
}



//================================= objects
// modified from original code by http://jamesalliban.wordpress.com/


//======== manager

class RibbonManager {
  // PImage img;
  int _numRibbons;
  int _numParticles;
  float _randomness;
  Ribbon[] ribbons;       // ribbon array
  
  RibbonManager(int _numRibbons, int _numParticles, float _randomness) {
    this._numRibbons = _numRibbons;
    this._numParticles = _numParticles;
    this._randomness = _randomness;
    init();
  }
  
  void init() {
    addRibbon();
  }

  void addRibbon() {
    ribbons = new Ribbon[_numRibbons];
    for (int i = 0; i < _numRibbons; i++) {
      color ribbonColour = color(random(255), ((40/_numRibbons) * i) ) ;
      ribbons[i] = new Ribbon(_numParticles, ribbonColour, _randomness);
    }
  }
  
  void update(float currX, float currY)  {
    for (int i = 0; i < _numRibbons; i++)
    {
      float randX = currX;
      float randY = currY;
      
      ribbons[i].update(randX, randY);
    }
  }
  
  void setRadiusMax(float value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].radiusMax = value; } }
  void setRadiusDivide(float value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].radiusDivide = value; } }
  void setGravity(float value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].gravity = value; } }
  void setFriction(float value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].friction = value; } }
  void setMaxDistance(int value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].maxDistance = value; } }
  void setDrag(float value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].drag = value; } }
  void setDragFlare(float value) { for (int i = 0; i < _numRibbons; i++) { ribbons[i].dragFlare = value; } }
}


//======== ribbon

class Ribbon {
  int _numRibbons;
  float _randomness;
  int _numParticles;         // length of the Particle Array (max number of points)
  int particlesAssigned = 0;        // current amount of particles currently in the Particle array                                
  float radiusMax = 8;              // maximum width of ribbon
  float radiusDivide = 10;          // distance between current and next point / this = radius for first half of the ribbon
  float gravity = .03;              // gravity applied to each particle
  float friction = 1.1;             // friction applied to the gravity of each particle
  int maxDistance = 40;             // if the distance between particles is larger than this the drag comes into effect
  float drag = 2;                   // if distance goes above maxDistance - the points begin to grag. high numbers = less drag
  float dragFlare = .008;           // degree to which the drag makes the ribbon flare out
  RibbonParticle[] particles;       // particle array
  color ribbonColor;
  
  Ribbon(int _numParticles, color ribbonColor, float _randomness) {
    this._numParticles = _numParticles;
    this.ribbonColor = ribbonColor;
    this._randomness = _randomness;
    init();
  }
  
  void init() {
    particles = new RibbonParticle[_numParticles];
  }
  
  void update(float randX, float randY){
    addParticle(randX, randY);
    drawCurve();
  }
  
  void addParticle(float randX, float randY) {
    if(particlesAssigned == _numParticles) {
      for (int i = 1; i < _numParticles; i++) {
        particles[i-1] = particles[i];
      }
      particles[_numParticles - 1] = new RibbonParticle(_randomness, this);
      particles[_numParticles - 1].px = randX;
      particles[_numParticles - 1].py = randY;
      return;
    } else {
      particles[particlesAssigned] = new RibbonParticle(_randomness, this);
      particles[particlesAssigned].px = randX;
      particles[particlesAssigned].py = randY;
      ++particlesAssigned;
    }
    if (particlesAssigned > _numParticles) ++particlesAssigned;
  }
  
  void drawCurve() {
    smooth();
    for (int i = 1; i < particlesAssigned - 1; i++) {
      RibbonParticle p = particles[i];
      p.calculateParticles(particles[i-1], particles[i+1], _numParticles, i);
    }

    fill(30);
    for (int i = particlesAssigned - 3; i > 1 - 1; i--) {
      RibbonParticle p = particles[i];
      RibbonParticle pm1 = particles[i-1];
      fill(ribbonColor, 255);
      if (i < particlesAssigned-3) {
        noStroke();
        beginShape();
        vertex(p.lcx2, p.lcy2);
        bezierVertex(p.leftPX, p.leftPY, pm1.lcx2, pm1.lcy2, pm1.lcx2, pm1.lcy2);
        vertex(pm1.rcx2, pm1.rcy2);
        bezierVertex(p.rightPX, p.rightPY, p.rcx2, p.rcy2, p.rcx2, p.rcy2);
        vertex(p.lcx2, p.lcy2);
        endShape();
      }
    }
  }
}


//======== particle

class RibbonParticle {
  float px, py;                                       // x and y position of particle (this is the bexier point)
  float xSpeed, ySpeed = 0;                           // speed of the x and y positions
  float cx1, cy1, cx2, cy2;                           // the avarage x and y positions between px and py and the points of the surrounding Particles
  float leftPX, leftPY, rightPX, rightPY;             // the x and y points of that determine the thickness of this segment
  float lpx, lpy, rpx, rpy;                           // the x and y points of the outer bezier points
  float lcx1, lcy1, lcx2, lcy2;                       // the avarage x and y positions between leftPX and leftPX and the left points of the surrounding Particles
  float rcx1, rcy1, rcx2, rcy2;                       // the avarage x and y positions between rightPX and rightPX and the right points of the surrounding Particles
  float radius;                                       // thickness of current particle
  float _randomness;
  Ribbon ribbon;
  
  RibbonParticle(float _randomness, Ribbon ribbon) {
    this._randomness = _randomness;
    this.ribbon = ribbon;
  }
  
  void calculateParticles(RibbonParticle pMinus1, RibbonParticle pPlus1, int particleMax, int i) {
    float div = 2;
    cx1 = (pMinus1.px + px) / div;
    cy1 = (pMinus1.py + py) / div;
    cx2 = (pPlus1.px + px) / div;
    cy2 = (pPlus1.py + py) / div;

    // calculate radians (direction of next point)
    float dx = cx2 - cx1;
    float dy = cy2 - cy1;

    float pRadians = atan2(dy, dx);

    float distance = sqrt(dx*dx + dy*dy);

    if (distance > ribbon.maxDistance) {
      float oldX = px;
      float oldY = py;
      px = px + ((ribbon.maxDistance/ribbon.drag) * cos(pRadians));
      py = py + ((ribbon.maxDistance/ribbon.drag) * sin(pRadians));
      xSpeed += (px - oldX) * ribbon.dragFlare;
      ySpeed += (py - oldY) * ribbon.dragFlare;
    }
    
    ySpeed += ribbon.gravity;
    xSpeed *= ribbon.friction;
    ySpeed *= ribbon.friction;
    px += xSpeed + random(.3);
    py += ySpeed + random(.3);
    
    float randX = ((_randomness / 2) - random(_randomness)) * distance;
    float randY = ((_randomness / 2) - random(_randomness)) * distance;
    px += randX;
    py += randY;
    
    //float radius = distance / 2;
    //if (radius > radiusMax) radius = ribbon.radiusMax;
    
    if (i > particleMax / 2) {
      radius = distance / ribbon.radiusDivide;
    } else {
      radius = pPlus1.radius * .9;
    }
    
    if (radius > ribbon.radiusMax) radius = ribbon.radiusMax;
    if (i == particleMax - 2 || i == 1) {
      if (radius > 1) radius = 1;
    }

    // calculate the positions of the particles relating to thickness
    leftPX = px + cos(pRadians + (HALF_PI * 3)) * radius;
    leftPY = py + sin(pRadians + (HALF_PI * 3)) * radius;
    rightPX = px + cos(pRadians + HALF_PI) * radius;
    rightPY = py + sin(pRadians + HALF_PI) * radius;

    // left and right points of current particle
    lpx = (pMinus1.lpx + lpx) / div;
    lpy = (pMinus1.lpy + lpy) / div;
    rpx = (pPlus1.rpx + rpx) / div;
    rpy = (pPlus1.rpy + rpy) / div;

    // left and right points of previous particle
    lcx1 = (pMinus1.leftPX + leftPX) / div;
    lcy1 = (pMinus1.leftPY + leftPY) / div;
    rcx1 = (pMinus1.rightPX + rightPX) / div;
    rcy1 = (pMinus1.rightPY + rightPY) / div;

    // left and right points of next particle
    lcx2 = (pPlus1.leftPX + leftPX) / div;
    lcy2 = (pPlus1.leftPY + leftPY) / div;
    rcx2 = (pPlus1.rightPX + rightPX) / div;
    rcy2 = (pPlus1.rightPY + rightPY) / div;
  }
}
