class Sprite {
  //Variables de la clase
  PImage img, rayo;
  PVector center, cambio;
  int alto, ancho, tipo;

  Sprite(PImage archivo, int x, int y, int tipo)
  {
    //Constructor de la clase
    img = archivo;
    alto = img.height;
    ancho = img.width;
    center = new PVector(x, y);
    cambio= new PVector(0, 0);
    this.tipo = tipo;
  }
  void mostrar() {//Se dibujan los Aliens
    image(img, center.x, center.y, 75, 75);
  }
  void mover()//Movimiento de los Aliens
  {
    center.x += cambio.x;
    if (center.y > 0 && center.y < 400)
      center.y += 1;
    if (center.x < 0) {
      reset();
    }
  }
  void display() {//Se dibuja el rayo
    image(rayo, center.x-100, center.y, 25, 25);
  }
  void move()//Movimiento del rayo
  {
    center.x += cambio.x;
    if (center.x < 0) {
      reset();
    }
  }
  void reset() {
    center.x = width;
    center.y = random(100, 400);
  }
}
