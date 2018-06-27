class Vec2 {

  float x;
  float y;

  String tag;

  PApplet parent;

  Vec2(float x, float y) {

    this.x = x;
    this.y = y;
  }

  Vec2(Random r) {
    x = r.nextFloat();
    y = r.nextFloat();
  }

  Vec2(PVector temp) {
    this.x = temp.x;
    this.y = temp.y;
  }

  Vec2(Vec2 temp) {
    this.x = temp.x;
    this.y = temp.y;
  }

  Vec2() {

  }


  Vec2 copy() {
    return new Vec2(x, y);
  }

  float[] array() {
    float[] array = {x, y};
    return array;
  }

  Vec2 rotate(float theta) {
    PVector temp = new PVector(x, y);
    temp.rotate(theta);
    x = temp.x;
    y = temp.y;
    return this;
  }


  void printf() {
    println(info());
  }

  String info() {
    return ("("+x+", "+y+")");
  }

  boolean equals(Vec2 target)
  {
    return sq(target.x) + sq(target.y) == sq(x) + sq(y);
  }

  float dist(Vec2 p) {
    return sqrt(sq(p.x-x) + sq(p.y-y));
  }

  boolean greater(Vec2 target)
  {
    return sq(target.x) + sq(target.y) < sq(x) + sq(y);
  }

  Vec2 average(Vec2 marks)
  {
    return sum(marks).div(2);
  }

  Vec2 constrain(Vec2 xrange, Vec2 yrange) {

    x = parent.constrain(x, xrange.x, xrange.y);
    y = parent.constrain(y, yrange.x, yrange.y);

    return this;
  }

  Vec2 constrain(float min, float max) {

    x = parent.constrain(x, min, max);
    y = parent.constrain(y, min, max);

    return this;
  }

  Vec2 map(float fminv, float fmaxv, float rminv, float rmaxv) {

    x = parent.map(x, fminv, fmaxv, rminv, rmaxv);
    y = parent.map(y, fminv, fmaxv, rminv, rmaxv);

    return this;
  }

  Vec2 map(Vec2 iX, Vec2 oX, Vec2 iY, Vec2 oY) { //i = inputs, o = outputs. vec2.x = min value, vec2.y = max value
    this.x = parent.map(x, iX.x, iX.y, oX.x, oX.y);
    this.y = parent.map(y, iY.x, iY.y, oY.x, oY.y);

    return this;
  }

  Vec2 sum(Object s) {
    if(s.getClass() == float.class) {x += (float) s; y += (float) s;}
    if(s.getClass() == Integer.class) {x += (int) s; y += (int) s;}
    if(s.getClass() == PVector.class) {PVector add = (PVector) s; x += add.x; y += add.y;}
    if(s.getClass() == Vec2.class) {Vec2 add = (Vec2) s; x += add.x; y += add.y;}

    return this;
  }

  Vec2 sum(float x, float y) {
    this.x += x;
    this.y += y;
    return this;
  }

  Vec2 sumX(Object s) {
    if(s.getClass() == float.class) {x += (float) s;}
    if(s.getClass() == Integer.class) {x += (int) s;}
    if(s.getClass() == PVector.class) {PVector add = (PVector) s; x += add.x;}
    if(s.getClass() == Vec2.class) {Vec2 add = (Vec2) s; x += add.x;}

    return this;
  }

  Vec2 sumY(Object s) {
    if(s.getClass() == float.class) {y += (float) s;}
    if(s.getClass() == Integer.class) {y += (int) s;}
    if(s.getClass() == PVector.class) {PVector add = (PVector) s; y += add.y;}
    if(s.getClass() == Vec2.class) {Vec2 add = (Vec2) s; y += add.y;}

    return this;
  }

  Vec2 mult(Object s) {
    if(s.getClass() == float.class) {x *= (float) s; y *= (float) s;}
    if(s.getClass() == Integer.class) {x *= (int) s; y *= (int) s;}
    if(s.getClass() == PVector.class) {PVector add = (PVector) s; x *= add.x; y *= add.y;}
    if(s.getClass() == Vec2.class) {Vec2 add = (Vec2) s; x *= add.x; y *= add.y;}

    return this;
  }

  Vec2 div(Object s) {

    if(s.getClass() == float.class) {x /= (float) s; y /= (float) s;}
    if(s.getClass() == Integer.class) {x /= (int) s; y /= (int) s;}
    if(s.getClass() == PVector.class) {PVector add = (PVector) s; x /= add.x; y /= add.y;}
    if(s.getClass() == Vec2.class) {Vec2 add = (Vec2) s; x /= add.x; y /= add.y;}

    return this;
  }


  Vec2 sub(Object s) {

    if(s.getClass() == float.class) {x -= (float) s; y -= (float) s;}
    if(s.getClass() == Integer.class) {x -= (int) s; y -= (int) s;}
    if(s.getClass() == PVector.class) {PVector add = (PVector) s; x -= add.x; y -= add.y;}
    if(s.getClass() == Vec2.class) {Vec2 add = (Vec2) s; x -= add.x; y -= add.y;}

    return this;
  }

  Vec2 abs() {
    x = parent.abs(x);
    y = parent.abs(y);

    return this;
  }

  Vec2 sincos(float ang, float armd) {
    x += cos(ang) * armd;
    y += sin(ang) * armd;
    return this;
  }

  void rct(Vec2 targ) {
    rect(this.x, this.y, targ.x, targ.y);
  }

  void lne(Vec2 targ) {
    line(this.x, this.y, targ.x, targ.y);
  }

  void ellip(float w, float h) {
    ellipse(x, y, w, h);
  }
}

Vec2 fromAngle(float angle) {
  Vec2 ret = new Vec2();
  ret.sincos(angle, 1);
  return ret;
}
