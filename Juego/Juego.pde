/*
-----------------------------SpaceMonster-------------------------------
Proyecto Final de la materia Programación de Computadores I

Autores: Jonathan Gil
         Carlos Cuadros

Fecha: 20/10/2021

Descripción:   SpaceMonster es un juego de un solo jugador con la misión de recorrer 
               la mayor distancia posible.
               
               Charly(El personaje) empieza en una distancia 0 y va avanzando, en el
               camino se cruza con diferentes Aliens y rocas que caen del cielo.
               Charly está equipado con un arma que es capaz de destruir a los Aliens
               y a las rocas. De no destruir a alguno, este chocara con Charly 
               causandole daño haciendo que este pierda energia, Charly solo puede 
               sobrevivir a cuatro choques, recargalo en el camino para ir más lejos.
               
               
*Requiere libreria Sound               

*/

import processing.sound.*; //Se importa la libreria Sound
SoundFile afondo;//Se nombra el objeto de audio
Player gamer;//Se nombra el jugador(gamer) como un objeto de la clase Player
Botones jugar, salir, opciones, audon, regresar, reglas, creditos, pausa, continuar;//Se nombran todos los objetos de la clase Botones

//Declaración de la variables
int posx=0, pos, posEne, speed = 10, posObj;
int distancia =0, max_distancia, menu=0, carga;
boolean press;
float referenciaInicio = 0;
PImage fondo, plataforma, titulo, regla, credito, clasificación, continua, rayo, agotado, cara;
PImage grupo, audios, apk, diseñadores, diseñoentorno, diseñopersonajes, programadores, musica, Plataforma, personajes, puntaje, muerto;

//Declaración de todos los Array
ArrayList<Bullet> bullets; //Declarar array para los disparos
ArrayList<Sprite>enemy;//Declarar array para los enemigos
ArrayList<Rite>object;//Declarar array para los meteoros
ArrayList<Tite>Rayo;//Declarar array para los rayos
PFont arcade;//Se llama a una fuente de texto

void setup() {
  frameRate(35);
  size(900, 649); //Se crea la pantalla
  cara = loadImage("Cabeza robot.png"); //Se cargan todas las imagenes generales
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
  rayo = loadImage("rayo.png");
  muerto = loadImage("Dead/Dead (8).png");
  agotado = loadImage("Dead/Dead (1).png");
  arcade = createFont("ARCADE.TTF", 128);
  startGame();
}
void draw() {
  switch(menu) {
  case 0: //Se dibuja el menú con el fondo y los diferentes botones q tiene
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
      reiniciarJuego();
      referenciaInicio= millis()/80;
    }
    if (opciones.click()==true)menu=2;
    if (reglas.click()==true)menu=3;
    if (creditos.click()==true)menu=4;
    if (salir.click()==true)exit();
    break;
  case 1:
    inicio(); //Se inicia el juego
    break;
  case 2:
    setting(); //Se dibujan las configuraciones que puede hacer el usuario(Apagar/Encender   el audio)
    break;
  case 3:
    rules(); //Se dibuja un tutorial 
    break;
  case 4:
    creadores(); //Se dibujan los créditos
    break;
  case 5:
    pausa(); //Se dibuja la pantalla de pausa
    break;
  case 6:
    replay(); //Se dibuja la pantalla de fin del juego
    break;
  }
  jugar.click();//Se llama a la función click()
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
  }
  if (distancia >= 100)
    for (int i= 0; i <object.size(); i++)
    {
      object.get(i).mostrar();
      object.get(i).mover();
    }
  if (distancia >= 50)
    for (int i= 0; i <Rayo.size(); i++)
    {
      Rayo.get(i).mostrar();
      Rayo.get(i).mover();
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
      Sprite miRayo = enemy.get(j);
      if (miRayo.center.x < laBala.x+30  && laBala.y+30 > miRayo.center.y && miRayo.center.y+75 > laBala.y ) {

        indiceBalaEliminar = i;

        indiceEnemigoReset = j;
      }
    }
  }
  
  // Se borra el rayo tras el choque
  if ( indiceEnemigoReset != -1 && indiceBalaEliminar != -1) {
    bullets.remove(indiceBalaEliminar);
    Sprite miRayo = enemy.get(indiceEnemigoReset);
    miRayo.reset();
  }
  //Choques balas vs objetos
  int indiceobjectReset = -1, indiceBallaEliminar = -1;
  int cantBallas = bullets.size();
  for (int i = 0; i < cantBallas; i++) {
    Bullet laBala = bullets.get(i);
    int cantobj = object.size();
    for (int j = 0; j < cantobj; j++) {
      Rite miobject = object.get(j);
      if (miobject.center.x < laBala.x+150  && laBala.y+70 > miobject.center.y && miobject.center.y+75 > laBala.y ) {

        indiceBallaEliminar = i;

        indiceobjectReset = j;
      }
    }
  }

  if ( indiceobjectReset != -1 && indiceBallaEliminar != -1) {
    bullets.remove(indiceBallaEliminar);
    Rite miobject = object.get(indiceobjectReset);
    miobject.reset();
  }
  //Choques entre objetos
  int cantEnem = enemy.size();
  for (int w = 0; w < cantEnem; w++) {
    Sprite miRayo = enemy.get(w);
    if ( (miRayo.center.x < gamer.x+30 + 80)  && ( (miRayo.center.y+80 < gamer.y+5+120 && miRayo.center.y+65 > gamer.y ) || (miRayo.center.y < gamer.y+5+120 && miRayo.center.y > gamer.y ) )  ) {
      gamer.vida -= 1;
      miRayo.reset();
    }
  }
    //Choques entre objetos
  int cantRayo = Rayo.size();
  for (int b = 0; b < cantRayo; b++) {
    Tite miRayo = Rayo.get(b);
    if ( (miRayo.center.x < gamer.x+30 + 50)  && ( (miRayo.center.y+20 < gamer.y+5+120 && miRayo.center.y+35 > gamer.y ) || (miRayo.center.y < gamer.y+5+120 && miRayo.center.y > gamer.y ) )  ) {
      gamer.vida += 1;
      miRayo.reset();
    }
  }
  //Choque entre enemigos
  int cantobj = object.size();
  for (int v = 0; v < cantobj; v++) {
    Rite miobject = object.get(v);
    if ( (miobject.center.x < gamer.x+30 + 160)  && ( (miobject.center.y+40 < gamer.y+5+120 && miobject.center.y+65  > gamer.y ) || (miobject.center.y < gamer.y+5+120 && miobject.center.y > gamer.y ) )  ) {
      gamer.vida -= 1;
      miobject.reset();
    }
  }
  if (gamer.vida==0) {
    menu=6;
  }
  image(puntaje, 700, 10);

  textFont(arcade);
  textSize(40);
  fill(255);
  text(distancia, 730, 55);
  fill(0);
  rect(60, 40, 200, 30);
  fill(#2ECC71);
  rect(60, 40, carga, 30);
  cara.resize(110, 110);
  image(cara, 0, 15);
  salir.end();
  pausa.intermedio();
  if (salir.click()==true)exit();
  if (pausa.click()==true)menu=5;
  salir.click();
  pausa.click();
  gamer.live();
}
void startGame() {
  //Se dan los parametros de los constructores
  jugar= new Botones(400, 400, 113, 27);
  opciones= new Botones(370, 437, 173, 27);
  reglas= new Botones(315, 477, 279, 21);
  salir= new Botones(810, 620, 82, 21);
  regresar=new Botones(720, 590, 179, 27);
  pausa=new Botones(625, 6, 70, 70);
  continuar = new Botones(280, 200, 411, 27);
  audon= new Botones(((width/2)-80), height/2, 182, 21);
  creditos= new Botones(20, 615, 117, 15);
  gamer = new Player();
  bullets = new ArrayList<Bullet>();
  enemy = new ArrayList<Sprite>();
  pos = 1;
  //Se crean los enemigos
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
  //Se crean los rayos
  Rayo = new ArrayList<Tite>();//Se declara el objeto de la clase Tite
  pos = 1;
  PImage imagenes =loadImage("rayo"+(pos)+".png");
  Rayo.add(new Tite(imagenes, width, (int)random(200, 400), pos));
  pos++;
  for (Tite s : Rayo)
  {
    s.cambio.x = -5;
  }
  //Se crean las rocas
  object = new ArrayList<Rite>();//Se declara el objeto de la clase Rite
  pos = 1;
  PImage image =loadImage("object"+(pos)+".png");
  object.add(new Rite(image, (int)random(0, 400), width, pos));
  pos++;
  for (int i = 0; i < 1; i++)
  {
    image =loadImage("object"+(pos)+".png");
    object.add(new Rite(image, (int)random(0, 400), width, pos));
    pos++;
    if (pos == 2)
      pos =1;
  }
  for (Rite s : object)
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
  fill(#EC9706);
  textFont(arcade);
  textSize(40);
  text("Agradecimientos", 330, 600);
  fill(#9074E2);
  text("Alex Mantilla", 350, 630);
  salir.end();
  regresar.back();
  if (salir.click()==true)exit();
  if (regresar.click()==true)menu=0;
  regresar.click();
  salir.click();
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
  continua.resize(900, 650);
  image(continua, 0, 0);
  agotado.resize(200, 184);
  image (agotado, 400, 250);
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
void replay() {
  muerto.resize(200, 184);
  image (fondo, 0, 0);
  image(muerto, 350, 160);
  fill(255);
  if (distancia > max_distancia)max_distancia = distancia;
  textSize(65);
  text("Game Over", 300, 100);
  textSize(40);
  text("Tu puntaje: ", 250, 430);
  text(distancia, 600, 430);
  text("Mejor puntaje: ", 250, 500);
  text(max_distancia, 600, 500);
  gamer.x=50;
  salir.end();
  regresar.back();
  if (salir.click()==true)exit();
  if (regresar.click()==true)menu=0;
  salir.click();
  regresar.click();
}

void reiniciarJuego() {

  // Reiniciar Jugador
  gamer.vida = 4;
  gamer.x = 50;
  gamer.y = 345;
  gamer.pos = 0;

  // Reiniciar enemigos
  for (Sprite ene : enemy) {
    ene.reset();
  }


  // Reiniciar rocas
  for (Rite rock : object) {
    rock.reset();
  }
  // Reiniciar balas
  bullets.clear();
}
