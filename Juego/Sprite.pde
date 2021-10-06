class Sprite {
  PImage img;
  PVector center, cambio;
  int alto, ancho;

  Sprite(PImage archivo, int x, int y)
  {
    img = archivo;
    alto = img.height;
    ancho = img.width;
    center = new PVector(x, y);
    cambio= new PVector(0, 0);
  }
  void mostrar() {
    image(img, center.x, center.y, 75, 75);
  }
  void mover()
  {
    center.x += cambio.x;
    if (center.x < 0) {
      center.x = width;
      center.y = random(200,400);
    }
  }
}
