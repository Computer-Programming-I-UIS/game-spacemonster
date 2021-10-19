class Rite {
  PImage image;
  PVector center, cambio;
  int alto, ancho, tipo;

  Rite(PImage archivo, int x, int y, int tipo)
  {
    image = archivo;
    alto = image.height;
    ancho = image.width;
    center = new PVector(x, y);
    cambio= new PVector(0, 0);
    this.tipo = tipo;
  }
  void mostrar() {
    image(image, center.x-100, center.y, 75, 75);
  }
  void mover()
  {
    center.x += cambio.x;
    if (center.y > -50 && center.y < 400)
      center.y += 5;
    if (center.x < 0) {
      reset();
    }
  }
  void reset() {
    center.x = width;
    center.y = random(0,50);
  }
}
