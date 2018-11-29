
Point[] seeds;
float percent = 0.5;

ArrayList<Point> points;

float angle = 0;
float angler = 0.004;

int numToAdd = 10;

Point temp;
Point current;

Point choosen;
float x;
float y;
float z;

void setup() {
  size(500, 500, P3D);

  seeds = new Point[4];
  //for (int i = 0; i < seeds.length; i ++) {
  //  seeds[i] = new Point(PVector.random3D().mult(width/2), -1);
  //}

  /*
  (1, 0, -1/sqrt(2))
  (-1, 0, -1/sqrt(2))
  (0, 1, 1/sqrt(2))
  (0, -1, 1/sqrt(2))
   */
  PVector  temp;
  temp = new PVector(1, 0, -1/sqrt(2));
  seeds[0] = new Point(temp.mult(width/2.5), -1);

  temp = new PVector(-1, 0, -1/sqrt(2));
  seeds[1] =  new Point(temp.mult(width/2.5), -1);

  temp = new PVector(0, 1, 1/sqrt(2));
  seeds[2] =  new Point(temp.mult(width/2.5), -1);

  temp = new PVector(0, -1, 1/sqrt(2));
  seeds[3] =  new Point(temp.mult(width/2.5), -1);

  points = new ArrayList<Point>();
  current = new Point(PVector.random3D().mult(width/2), -2);
  points.add(current);
}

void draw() {
  background(51);

  translate(width/2, height/2, -100);
  rotateY(angle);
  rotateX(angle);
  angle+=angler;

  strokeWeight(2);
  for (Point p : seeds) {
    stroke(p.c);
    point(p.pos.x, p.pos.y, p.pos.z);
  }

  strokeWeight(3);
  for (Point p : points) {
    stroke(p.c);
    point(p.pos.x, p.pos.y, p.pos.z);
  }

  for (int i = 0; i < numToAdd; i++) {
    int toChoose = floor(random(seeds.length));
    choosen = seeds[toChoose];
    x = lerp(current.pos.x, choosen.pos.x, percent);
    y = lerp(current.pos.y, choosen.pos.y, percent);
    z = lerp(current.pos.z, choosen.pos.z, percent);
    temp = new Point(new PVector(x, y, z), toChoose); //TODO
    points.add(temp);
    current = temp;
  }

  if (frameCount%3 == 0) {
    saveFrame("output/chaos-####.png");
  }
}

class Point {
  PVector pos;
  color c;
  Point(PVector p, int s) {

    this.pos = p;

    if (s == 0) {
      this.c = color(0, 255, 0, 100);
    } else if (s == 1) {
      this.c = color(0, 255, 255, 100);
    } else if (s == 2) {
      this.c = color(255, 0, 255, 100);
    } else if (s == 3) {
      this.c = color(255, 255, 0, 100);
    }

    if (s == -1) {
      this.c = color(255, 100);
    } else if ( s == -2) {
      this.c = color(0, 100);
    }
  }
}
