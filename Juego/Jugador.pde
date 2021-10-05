class Player {
  float x, y, gr, vel;
  int pos;
  int tls;
  int coolDown;
  boolean salto;
  PImage[] img;
  public  Player() {
    this.x = width/2;
    this.y = height-50;
    this.tls = 0;
    this.coolDown = 300;
    x= 50;
    y= 300;
    gr= 9;
    vel= 5;
    pos= 0;
    salto = true;
    img = new PImage[15];
    img[0] = loadImage("Run(0).png");
    img[1] = loadImage("Run(1).png");
    img[2] = loadImage("Run(2).png");
    img[3] = loadImage("Run(3).png");
    img[4] = loadImage("Run(4).png");
    img[5] = loadImage("Run(5).png");
    img[6] = loadImage("Run(6).png");
    img[7] = loadImage("Run(7).png");
    img[8] = loadImage("Salto(1).png");
    img[9] = loadImage("Salto(1).png");
    img[10] = loadImage("Salto(2).png");
    img[11] = loadImage("Salto(3).png");
    img[12] = loadImage("Salto(4).png");
  }
  void display() {
    image(img[pos], x, y, 150, 130);
    if (y+33<350)
      y+= gr;
    else
      salto = false;
    if (keyPressed && key == CODED)
    {
      switch(keyCode) {
      case LEFT:
        if (x >= 0)
          x-= 15;
        pos--;
        if (pos < 0)
          pos =7;
        break;
      case RIGHT:
        if (x <= 850)
          x+= 15;
        pos++;
        if (pos > 7)
          pos =1;
        break;
      }
      if ( keyCode == UP && !salto )
      {
        y-=300;
        salto = true;
        pos = 0;
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
