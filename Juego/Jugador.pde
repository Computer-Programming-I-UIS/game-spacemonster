class Player {
  //Variables de la clase
  float x, y, gr, vel;
  int pos;
  int tls;
  int coolDown;
  boolean salto, mostrar = true;
  PImage[] img;
  int vida;
  public  Player() {
    //Constructor de la clase
    this.x = width/2;
    this.y = height-50;
    this.tls = 0;
    this.coolDown = 300;
    x= 50;
    y= 345;
    gr= 0.2;
    vel= 7;
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
  void display() {//Se dibuja al personaje
    if (mostrar)image(img[pos], x, y, 150, 130);
    y += vel;
    if (y+33<380) {
      vel += gr;
    } else if(salto) {
      salto = false;
      vel = 0;
      pos = 0;
    }
    //Se dibujan los movientos del personaje
    if (keyPressed && key == CODED)
    {
      switch(keyCode) {
      case LEFT:
        if (x >= 0)
          x-= 5;
        pos--;
        if (pos < 0)
          pos =7;
        break;
      case RIGHT:
        if (x <= 850)
          x+= 5;
        pos++;
        if (pos > 7)
          pos =1;
        break;
      }
      if ( keyCode == UP && !salto )
      {
        vel=-8;
        salto = true;
      }
    }

    if (salto) {
      pos++;
      if (pos > 12)
        pos = 0;
    }
  }
  void shoot() {//Disparo
    if (millis() - tls > coolDown) {
      Bullet bullet = new Bullet(this.x+13, this.y, -speed);
      bullets.add(bullet);
      tls = millis();
    }
  }
  void live(){//Barra de vida
    carga = int(map(gamer.vida, 0, 4, 0, 200));
  }
}
void keyPressed() {//Se confirma si se oprimió la tecla designada para el disparo
  if (key == 'x')
    gamer.shoot();
}
