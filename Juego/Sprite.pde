class Sprite {
  PImage img;
  PVector center, cambio;
  int alto, ancho, tipo;

  Sprite(PImage archivo, int x, int y, int tipo)
  {
    img = archivo;
    alto = img.height;
    ancho = img.width;
    center = new PVector(x, y);
    cambio= new PVector(0, 0);
    this.tipo = tipo;
  }
  void mostrar() {
    image(img, center.x, center.y, 75, 75);
  }
  void mover()
  {
    center.x += cambio.x;
    center.y = random(0,400);
    if (center.x < 0) {
      reset();
    }
  }
  void reset() {
    center.x = width;
    center.y = random(200, 400);
  }
  boolean izquierda()
  {
    if (center.x < 0)
      return true;
    else
      return false;
  }
}
