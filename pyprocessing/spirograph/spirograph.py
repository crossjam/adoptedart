from pyprocessing import *
from random import randint

NUM = 2
STEP = 10

centx, centy = 0.0, 0.0

pArr = []

def setup():
    global centx, centy, NUM
    size(500,300)
    frameRate(12)
    clearBackground()
    smooth()

    centx = width / 2.0
    centy = height / 2.0

    for i in range(NUM):
        pArr.append(Particle(i))

    print "Setup centx: %s, centy: %s" % (centx, centy)

def clearBackground():
    global centx, centy
    background(255)

    gap = 10
    strokeWeight(1)
    stroke(140, 40)
    for x in range(0, width, gap):
        line(x, 0, x, height)

    for y in range(0, height, gap):
        line(0, y, width, y)

    print "Centx: %s, centy %s" % (centx, centy)

def draw():
    global centx, centy
    
    for particle in pArr:
        particle.update()

def mousePressed():
    global centx, centy
    clearBackground()
    centx = mouse.x
    centy = mouse.y

    for particle in pArr:
        particle.init()

class Particle:
    def __init__(self, num):
        self.id = num
        self.count = 0
        self.life = 0
        self.step = 0
        self.origx = 0.0
        self.origy = 0.0
        self.x1 = 0.0
        self.y1 = 0.0
        self.x2 = 0.0
        self.y2 = 0.0

        self.rd = 0
        self.gr = 0
        self.bl = 0
        self.alpha = 0

        self.angle = 0.0
        self.radius = 0.0

    def trace(self, str):
        print "Particle %d: %s, %s, %s" % (self.id, str, centx, centy)

    def init(self):
        self.trace("init")
        self.count = 0
        self.step = 10
        self.life = 720
        self.radius = randint(0, width * 2) + 50.0

        self.origx = centx + (self.radius * cos(self.angle))
        self.origy = centy + (self.radius * sin(self.angle))
        self.x1 = self.origx
        self.y1 = self.origy

        self.rd = randint(0, 255)
        self.bl = self.rd
        self.gr = self.rd
    
    def update(self):
        self.count += self.step
        self.angle = self.count

        self.x2 = centx + (self.radius * cos(self.angle))
        self.y2 = centy + (self.radius * sin(self.angle))

        strokeWeight(1)
        stroke(self.rd, self.gr, self.bl)
        line(self.x1, self.y1, self.x2, self.y2)

        self.x1 = self.x2
        self.y1 = self.y2

        if self.count >= self.life:
            self.init()

if __name__ == '__main__':
    run()
