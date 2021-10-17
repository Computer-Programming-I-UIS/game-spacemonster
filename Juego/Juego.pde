import processing.sound.*; //Se importa la libreria Sound
SoundFile afondo;
Player gamer;
Botones jugar, salir, opciones, audon, regresar, reglas, creditos, pausa, continuar;
ArrayList<Bullet> bullets; //Declarar array para los disparos
int posx=0, pos, posEne, speed = 10;
int distancia =0, max_distancia = 0, menu=0;
PImage fondo, plataforma, titulo, regla, credito, clasificación, continua;
PImage grupo, audios, apk, diseñadores, diseñoentorno, diseñopersonajes, programadores, musica, Plataforma, personajes, puntaje;
PImage enemigo;
ArrayList<Sprite>enemy;
boolean movimiento, press;
float referenciaInicio = 0;

void setup() {
  frameRate(35);
  size(900, 649);
  fondo = loadImage("fondo.jpg");
  plataforma = loadImage("plataforma.png");
  titulo = loadImage("titulo.png");
  regla = loadImage("reglas.jpg");
  afondo = new SoundFile(this, "fondo.mp3");
  credito = loadImage("creditos.png");
  diseñoentorno = loadImage("disenoentorno.png");
  apk = loadImage("apk.png");
  Plataforma = loadImage("Plataforma-CC.png");
  diseñopersonajes = loadImage("disenopersonajes.png");
  personajes = loadImage("personajes.png");
  audios = loadImage("audios.png");
  musica = loadImage("musica.png");
  diseñadores = loadImage("disenadores.png");
  grupo = loadImage("grupo.png");
  programadores = loadImage("programadores.png");
  clasificación = loadImage("clasificacion.png");
  puntaje = loadImage("puntaje.png");
  continua = loadImage("continue.jpg");
  movimiento = false;
  startGame();
}
void draw() {
  switch(menu) {
  case 0:
    posx=0;
    image(fondo, posx, 0);
    clasificación.resize(50, 70);
    image(clasificación, 0, 0);
    image(titulo, 220, 150);

    jugar.display();
    opciones.settings();
    salir.end();
    reglas.rules();
    creditos.make();
    if (jugar.click()==true) {
      menu=1;
      gamer.vida = 4;
      referenciaInicio= millis()/80;
    }
    if (opciones.click()==true)menu=2;
    if (reglas.click()==true)menu=3;
    if (creditos.click()==true)menu=4;
    if (salir.click()==true)exit();
    break;
  case 1:
    inicio();
    break;
  case 2:
    setting();
    break;
  case 3:
    rules();
    break;
  case 4:
    creadores();
    break;
  case 5:
    pausa();
    break;
  /*case 6:
  
    break;*/
  }
  jugar.click();
  opciones.click();
  salir.click();
  regresar.click();
  audon.click();
  reglas.click();
  creditos.click();
}

void handleBullets() {
  for (int i = 0; i < bullets.size(); i++) {
    Bullet b = (Bullet) bullets.get(i);
    b.move();
    b.display();
  }
}
void inicio() {
  image(fondo, posx, 0);
  image(plataforma, posx, 425);
  image(fondo, posx+1262, 0);
  image(plataforma, posx+1262, 425);
  posx-=3;
  if ((posx+1262)<=0)posx=0;
  gamer.display();
  for (int i= 0; i <enemy.size(); i++)
  {
    enemy.get(i).mostrar();
    enemy.get(i).mover();
    if (enemy.get(0).izquierda())
      movimiento =true;
    else
      movimiento =false;
  }
  handleBullets();
  distancia =int( ( millis()/80 ) - referenciaInicio );


  // Choque balas vs enemigo
  int indiceEnemigoReset = -1, indiceBalaEliminar = -1;
  int cantBalas = bullets.size();
  for (int i = 0; i < cantBalas; i++) {
    Bullet laBala = bullets.get(i);
    int cantEnem = enemy.size();
    for (int j = 0; j < cantEnem; j++) {
      Sprite miEnemigo = enemy.get(j);
      if (miEnemigo.center.x < laBala.x+30  && laBala.y+30 > miEnemigo.center.y && miEnemigo.center.y+75 > laBala.y ) {

        indiceBalaEliminar = i;

        indiceEnemigoReset = j;
      }
    }
  }

  if ( indiceEnemigoReset != -1 && indiceBalaEliminar != -1) {
    bullets.remove(indiceBalaEliminar);
    Sprite miEnemigo = enemy.get(indiceEnemigoReset);
    miEnemigo.reset();
  }





  int cantEnem = enemy.size();
  for (int w = 0; w < cantEnem; w++) {
    Sprite miEnemigo = enemy.get(w);
    if ( (miEnemigo.center.x < gamer.x+30 + 90)  && ( (miEnemigo.center.y+75 < gamer.y+5+120 && miEnemigo.center.y+75 > gamer.y ) || (miEnemigo.center.y < gamer.y+5+120 && miEnemigo.center.y > gamer.y ) )  ) {
      gamer.vida -= 1;
      miEnemigo.reset();
    }
  }

  if (gamer.vida==0) {
    exit();
    /*if (distancia > max_distancia)
     max_distancia = distancia;*/
  }
  image(puntaje, 700, 10);
  textSize(40);
  fill(255);
  text(distancia, 730, 55);
  text(gamer.vida, 30, 30);
  salir.end();
  pausa.intermedio();
  if (salir.click()==true)exit();
  if (pausa.click()==true)menu=5;
  salir.click();
  pausa.click();
}
void startGame() {
  jugar= new Botones(400, 400, 113, 27);
  opciones= new Botones(370, 437, 173, 27);
  reglas= new Botones(315, 477, 279, 21);
  salir= new Botones(810, 620, 82, 21);
  regresar=new Botones(720, 590, 179, 27);
  pausa=new Botones(580, 90, 119, 21);
  continuar = new Botones(300,200,411,27);
  audon= new Botones(((width/2)-80), height/2, 182, 21);
  creditos= new Botones(20, 615, 117, 15);
  gamer = new Player();
  bullets = new ArrayList<Bullet>();
  enemy = new ArrayList<Sprite>();
  pos = 1;
  posEne = 50;
  PImage img =loadImage("oponente"+(pos)+".png");
  enemy.add(new Sprite(img, width, (int)random(200, 400), pos));
  pos++;
  for (int i = 0; i < 1; i++)
  {
    img =loadImage("oponente"+(pos)+".png");
    enemy.add(new Sprite(img, width, (int)random(200, 400), pos));
    pos++;
    if (pos == 2)
      pos =1;
  }
  for (Sprite s : enemy)
  {
    s.cambio.x = -10;
  }
}
void setting() {
  image(fondo, posx, 0);
  salir.end();
  regresar.back();

  if (press==false) {
    audon.sounds();
  }
  if (press==true) {
    audon.sound();
  }

  if (salir.click()==true)exit();
  if (regresar.click()==true)menu=0;
  salir.click();
  regresar.click();
}
void rules() {
  background(#252850);
  image(regla, 0, 0);
  salir.end();
  regresar.back();
  if (salir.click()==true)exit();
  if (regresar.click()==true)menu=0;
  salir.click();
  regresar.click();
}
void creadores() {
  image(fondo, posx, 0);
  image(credito, 400, 20);
  image(diseñoentorno, 300, 50);
  image(apk, 290, 80);
  image(Plataforma, 215, 110);
  image(diseñopersonajes, 270, 140);
  image(personajes, 235, 170);
  image(audios, 400, 290);
  image(musica, 110, 330);
  image(diseñadores, 360, 370);
  image(grupo, 330, 400);
  image(programadores, 335, 470);
  image(grupo, 330, 500);
  salir.end();
  regresar.back();
  if (salir.click()==true)exit();
  if (regresar.click()==true)menu=0;
  regresar.click();
}
void mousePressed() {
  switch(menu) {
  case 2:
    if (mousePressed) {
      if (mouseX >((width/2)-80) && mouseX<((width/2)-80)+182 && mouseY> height/2 && mouseY <height/2+21) {
        press=!press;
      }
    }
    if (press==false) {
      audon.sounds();
      if ( afondo.isPlaying() )afondo.pause();
    }

    if (press==true) {
      audon.sound();
      if ( afondo.isPlaying() == false ) {
        afondo.play();
        afondo.loop();
      }
    }
    break;
  }
}
void pausa() {
  continua.resize(900,650);
  image(continua,0,0);
  continuar.seguir();
  salir.end();
  regresar.back();
  if (salir.click()==true)exit();
  if (regresar.click()==true)menu=0;
  if (continuar.click()==true)menu=1;
  continuar.click();
  salir.click();
  regresar.click();
}
