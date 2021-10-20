class Bullet {
  //Variables de la clase
  float x, y;
  float velocity;
  PImage img;
  Bullet(float x, float y, float velocity) {
    //Constructor de la clase
    this.x = x+90;
    this.y = y+55;
    this.velocity = velocity;
    img = new PImage();
    img = loadImage("Bala(1).png");
  }
  void display() {//Se dibujan las balas
    image(img, this.x, this.y, 30, 30);
  }
  void move() {//Se mueven las balas
    this.x-=this.velocity;
    if (this.y > height || this.y < 0) {
      bullets.remove(this);
    }
  }
}
