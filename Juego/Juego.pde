import ddf.minim.*;
Minim minim;//Se declaran las clases Minim,Sprite, Player
AudioPlayer afondo;
Sprite enemy;
Player gamer; 
Botones jugar,salir,opciones,audon,regresar,reglas;
ArrayList bullets; //Declarar array para los disparos
int speed = 10; //Velocidad de movimiento
int posx=0;
int distancia =0, max_distancia, menu=0;
PImage fondo, plataforma,titulo,regla;
PImage enemigo;

void setup() {
  frameRate(50);
  size(900, 649);
  fondo = loadImage("fondo.jpg");
  plataforma = loadImage("plataforma.png");
  enemigo = loadImage("0.png");
  titulo = loadImage("titulo.png");
  regla = loadImage("reglas.jpg");
  /*minim = new Minim(this);
  afondo = minim.loadFile("fondo.mp3");
  afondo.play();
  afondo.loop();*/
  startGame();
  
}
void draw() {
  switch(menu){
    case 0: 
    image(fondo, posx, 0);
    image(titulo,220,150);
    jugar.display();
    opciones.settings();
    salir.end();
    reglas.rules();
    if(jugar.click()==true)menu=1;
    if(opciones.click()==true)menu=2;
    if(reglas.click()==true)menu=3;
    if(salir.click()==true)exit();
    break;
    case 1:
    inicio();
    break;
    case 2: setting();
    break;
    case 3: rules();
    break;
  }
  jugar.click();
  opciones.click();
  salir.click();
  regresar.click();
  audon.click();
  reglas.click();
}

void handleBullets() {
  for (int i = 0; i < bullets.size(); i++) {
    Bullet b = (Bullet) bullets.get(i);
    b.move();
    b.display();
  }
}
void inicio(){
  image(fondo, posx, 0);
  image(plataforma, posx, 425);
  image(fondo, posx+1262, 0);
  image(plataforma, posx+1262, 425);
  posx-=3;
  if ((posx+1262)<=0)posx=0;
  gamer.display();
  enemy.mostrar();
  enemy.mover();
  handleBullets();
  distancia =millis()/80;
  textSize(20);
  fill(255);
  text(distancia, 800,20);
}
void startGame() {
  jugar= new Botones(400, 400,113,27);
  opciones= new Botones(370, 437,173,27);
  reglas= new Botones(315, 477,279,21);
  salir= new Botones(810, 620,82,21);
  regresar=new Botones(720, 590,179,27);
  audon= new Botones(((width/2)-80), height/2,182,21);
  gamer = new Player();
  bullets = new ArrayList();
  enemy = new Sprite(enemigo, width, 250);
  enemy.cambio.x = -10;
}
void setting() {
  image(fondo, posx, 0);
  salir.end();
  regresar.back();
  if(audon.click()==false)audon.sound();
  if(audon.click()==true)audon.sounds();
  if(salir.click()==true)exit();
  if(regresar.click()==true)menu=0;
  salir.click();
  regresar.click();
}
void rules(){
  background(#252850);
  image(regla,0,0);
}
