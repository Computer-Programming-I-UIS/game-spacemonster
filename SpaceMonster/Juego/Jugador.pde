class Player {
  float x, y, gr, vel;
  int tls;
  int coolDown;
  boolean salto;
  PImage img;
  public  Player() {
    this.x = width/2;
    this.y = height-50;
    this.tls = 0;
    this.coolDown = 300;
    x= 50;
    y= 300;
    gr= 9;
    vel= 5;
    salto = true;
    img = loadImage("Run(1).png");
  }
  //Se dibuja la nave
  void display() {
    image(img, x, y,150,130);
      if (y+33<300)
      y+= gr;
    else
      salto = false;
    if (keyPressed && key == CODED)
    {
      switch(keyCode) {
      case LEFT:
        if (x >= 0)
          x-= 15;
        break;
      case RIGHT:
        if (x <= 850)
          x+= 15;
        break;
      }
      if ( keyCode == UP && !gamer.salto )
      {
        gamer.y-=300;
        gamer.salto = true;
      }
    }
  }
  void shoot() {
    if (millis() - tls > coolDown) {
      Bullet bullet = new Bullet(this.x+13, this.y, -speed);
      bullets.add(bullet);
      tls = millis();
    }
  }
}
void keyPressed() {
  if (key == 'x')
    gamer.shoot();
}
