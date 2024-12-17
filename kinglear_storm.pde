ArrayList<Raindrop> raindrops = new ArrayList<Raindrop>();
boolean lightning = false;
float rainFrequency = 0.05;  
int lightningCounter = 0;  
void setup() {
  size(800,600);
  noStroke();
}

void draw() {
  background(0,0,0);
  
  // rainFrequency 
  if (frameCount % rainFrequency == 0) {
    raindrops.add(new Raindrop());
  }
  

  for (int i = raindrops.size() - 1; i >= 0; i--) {
    Raindrop r = raindrops.get(i);
    r.update();
    r.show();
    if (r.offScreen()) {
      raindrops.remove(i);
    }
  }

  if (random(1) < 0.01) {
    lightning = true;
  }


  if (lightning) {
    drawLightning();
    increaseRain();
    lightning = false;
  }
}

class Raindrop {
  float x, y, z, len, yspeed;
  color c;
  
  Raindrop() {
    x = random(width);
    y = random(-100, -10);
    z = random(0, 30);
    len = map(z, 0, 20, 10, 30);
    yspeed = map(z, 0, 20, 1, 20);
    c = color(random(255), random(255), random(255));  
  }
  
  void update() {
    y += yspeed;
  }
  
  void show() {
    fill(c);
    ellipse(x, y, 5, len);
  }
  
  boolean offScreen() {
    return y > height;
  }
}


void drawLightning() {
  stroke(255, 255, 255, 150);
  strokeWeight(4);
  
  float x = random(width);
  float y = 0;
  float endY = random(height / 2);
  

  while (y < endY) {
    float nextX = x + random(-20, 20);
    float nextY = y + random(10, 30);
    line(x, y, nextX, nextY);
    x = nextX;
    y = nextY;
  }
  

  fill(255, random(50, 150));
  rect(0, 0, width, height);
}


void increaseRain() {
  lightningCounter++;
  

  rainFrequency = max(1, rainFrequency - 1);  
  println(": " + lightningCounter + ",: " + rainFrequency);
}
