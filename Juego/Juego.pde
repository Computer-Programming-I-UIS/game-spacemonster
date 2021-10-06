//import ddf.minim.*;
//Minim minim;
//AudioPlayer afondo;
Sprite enemy;
PImage enemigo;
ArrayList bullets; //Declarar array para los disparos
Player gamer; //Se declara la clase gamer
int speed = 10; //Velocidad de movimiento
int posx=0;
float distancia =0;
PImage fondo, plataforma;

void setup() {
  frameRate(50);
  size(900, 650);
  fondo = loadImage("fondo.jpg");
  plataforma = loadImage("plataforma.png");
  enemigo = loadImage("0.png");
  enemy = new Sprite(enemigo, width, 250);
  enemy.cambio.x = -10;
  //  minim = new Minim(this);
  //  afondo = minim.loadFile("fondo.mp3");
  //  afondo.play();
  //  afondo.loop();
  startGame();
}
void draw() {
  image(fondo, posx, 0);
  plataforma.resize(1264, 400);
  image(plataforma, posx, 250);
  posx-=3;
  image(fondo, posx+1264, 0);
  image(plataforma, posx+1264, 250);
  if ((posx+1264)<=0)posx=0;
  gamer.display();
  enemy.mostrar();
  enemy.mover();
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
