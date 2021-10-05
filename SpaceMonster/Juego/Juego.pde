import ddf.minim.*;
Minim minim;
AudioPlayer afondo;
ArrayList bullets; //Declarar array para los disparos
Player gamer; //Se declara la clase gamer
int speed = 10; //Velocidad de movimiento
//Se crear la ventana

void setup() {
  frameRate(50);
  size(900, 650);
  PImage fondo, plataforma;
  fondo = loadImage("fondo.jpg");
  plataforma = loadImage("plataforma.png");
  image(fondo, 0, 0);
  image(plataforma, 0, 250);

  minim = new Minim(this);
  afondo = minim.loadFile("fondo.mp3");
  afondo.play();
  afondo.loop();
  startGame();
}
void draw() {
  PImage fondo, plataforma;
  fondo = loadImage("fondo.jpg");
  plataforma = loadImage("plataforma.png");
  image(fondo, 0, 0);
  image(plataforma, 0, 250);
  gamer.display();
  handleBullets();
}

void handleBullets() {
  for (int i = 0; i < bullets.size(); i++) {
    Bullet b = (Bullet) bullets.get(i);
    b.move();
    b.display();
  }
}
void startGame() {
  gamer = new Player();
  bullets = new ArrayList();
}
