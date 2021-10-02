class Player {
  float x, y, gr, vel;
  int tls;
  int coolDown;
  boolean salto;
  public  Player() {
    this.x = width/2;
    this.y = height-50;
    this.tls = 0;
    this.coolDown = 300;
    x= 50;
    y= 450;
    gr= 7;
    vel= 5;
    salto = true;
  }
  //Se dibuja la nave
  void display() {
    rect(x, y, 23, 23);
    if (y+33<650)
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
