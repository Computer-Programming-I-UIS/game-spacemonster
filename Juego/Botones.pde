class Botones {
  int x, y, alto, ancho; //Variables de la clase
  Botones(int x, int y, int ancho, int alto) {
    //Constructor de la clase
    this.x=x;
    this.y=y;
    this.alto=alto;
    this.ancho=ancho;
  }
  //Se dibujan los botones
  void display() {
    PImage jugar;
    jugar = loadImage("jugar.png");
    image(jugar, this.x, this.y);
  }
  void settings() {
    PImage opciones;
    opciones = loadImage("opciones.png");
    image(opciones, this.x, this.y);
  }
  void end() {
    PImage salir;
    salir = loadImage("salir.png");
    image(salir, this.x, this.y);
  }
  void back() {
    PImage regresar;
    regresar = loadImage("regresar.png");
    image(regresar, this.x, this.y);
  }
  void sound() {
    PImage audon;
    audon = loadImage("audon.png");
    image(audon, this.x, this.y);
  }
  void sounds() {
    PImage audoff;
    audoff = loadImage("audoff.png");
    image(audoff, this.x, this.y);
  }
  void rules() {
    PImage reglas;
    reglas = loadImage("reglas.png");
    image(reglas, this.x, this.y);
  }
  void make() {
    PImage creditos;
    creditos = loadImage("creditos.png");
    image(creditos, this.x, this.y);
  }
  void intermedio(){
    PImage pausa;
    pausa = loadImage("pausa.png");
    pausa.resize(70,70);
    image(pausa, this.x, this.y);
  }
  void seguir(){
    PImage continuar;
    continuar = loadImage("continuar.png");
    image(continuar,this.x,this.y);
  }
  //Se confirma si fueron presionados
  boolean click() {
    boolean press = false;
    if (mousePressed) {
      if (mouseX >this.x && mouseX<this.x+this.ancho && mouseY> this.y && mouseY <this.y+this.alto) {
        press=true;
      }
    }
    return press;
  }
}
