class Bullet {
  float x, y;
  float velocity;
  PImage img;
  Bullet(float x, float y, float velocity) {
    this.x = x+90;
    this.y = y+55;
    this.velocity = velocity;
    img = new PImage();
    img = loadImage("Bala(1).png");
  }
  void display() {
    image(img, this.x, this.y, 30, 30);
  }
  void move() {
    this.x-=this.velocity;
    if (this.y > height || this.y < 0) {
      bullets.remove(this);
    }
  }
}
