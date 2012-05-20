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

float _boost = 0.02;
int _num = 1000;
int _nodes = 5;
Particle[] _dotArr = new Particle[_num];
Node[] _nodeArr = new Node[_nodes];

//================================= init

void setup(){
  size(500, 300);
  smooth(); 
  frameRate(12);
  restart();
}

void restart() {
  clearBackground();
  for(int i=0;i<_num;i++){
    _dotArr[i]=new Particle();
  }
  for(int i=0;i<_nodes;i++){
    _nodeArr[i]=new Node();
  }
}

void clearBackground() {
  background(140);
}

//================================= frame loop

void draw(){
  clearBackground();
  for(int i=0;i<_num;i++){
    _dotArr[i].update();
    _dotArr[i].drawMe();
  }
  for(int i=0;i<_nodes;i++){
    _nodeArr[i].drawMe();
  }  
}

//================================= interaction

void mousePressed(){
  restart();
}

//================================= objects

class Particle {
  float xpos,ypos,vx,vy,gain;
  Particle() {
    xpos=random(width);
    ypos=random(height);
  }
  
  void update(){
    for(int i=0; i<_nodes; i++){
      gain = dist(xpos, ypos, _nodeArr[i].xpos, _nodeArr[i].ypos);
      if (gain > 1) {
        vx+=((_nodeArr[i].xpos-xpos) * _boost) /gain;
        vy+=((_nodeArr[i].ypos-ypos) * _boost) /gain;
        xpos += vx;
        ypos += vy;
      }
    }
  }
  
  void drawMe() {
  	strokeWeight(1);
    stroke(0,100);
    fill(255, 100);
    ellipse(xpos,ypos,10,10);
  }
}

class Node {
  float xpos,ypos;
  
  Node(){
    xpos = random(-100, width+100);
    ypos = random(-100, height+100);
  }
  
  void drawMe() {
    strokeWeight(3);
    noFill();
    stroke(255,20,0, 100);
    ellipse(xpos,ypos,20,20);
  }
    
}
