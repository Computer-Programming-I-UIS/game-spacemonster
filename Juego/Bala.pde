class Bullet {
  float x, y;
  float velocity;
  PImage img;
  Bullet(float x, float y, float velocity) {
    this.x = x;
    this.y = y;
    this.velocity = velocity;
    img = new PImage();
    img = loadImage("Bala(1).png");
  }
  void display() {
    noStroke();
    fill(#00CCFF);
    image(img,this.x+90, this.y+55, 30,30);
  }
  void move() {
    this.x-=this.velocity;
    if (this.y > height || this.y < 0) {
      bullets.remove(this);
    }
  }
}
