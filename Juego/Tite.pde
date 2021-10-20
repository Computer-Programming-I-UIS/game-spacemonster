class Tite {
  //Variables de la clase
  PImage imagenes;
  PVector center, cambio;
  int alto, ancho, tipo;

  public  Tite(PImage archivo, int x, int y, int tipo)
  {
    //Constructor de la clase
    imagenes = archivo;
    alto = imagenes.height;
    ancho = imagenes.width;
    center = new PVector(x, y);
    cambio= new PVector(0, 0);
    this.tipo = tipo;
  }
  void mostrar() {
    image(imagenes, center.x, center.y, 100, 100);
  }
  void mover()
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
