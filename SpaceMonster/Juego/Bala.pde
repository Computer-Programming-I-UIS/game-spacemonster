class Bullet {
  float x, y;
  float velocity;

  Bullet(float x, float y, float velocity) {
    this.x = x;
    this.y = y;
    this.velocity = velocity;
  }
  void display() {
    noStroke();
    fill(#00CCFF);
    circle(this.x -13, this.y-15, 20);
  }
  void move() {
    this.x-=this.velocity;
    if (this.y > height || this.y < 0) {
      bullets.remove(this);
    }
  }
}
