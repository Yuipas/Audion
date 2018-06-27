class Universe {

  Random rnd;
  Array systems;
  float systemProbability = 0.0001;
  float blackHoleProbability = 0.001;
  int seed;
  gobernament gob;

  Universe(int seed) {
    rnd = new Random(seed);
    gob = new gobernament();
    systems = new Array(0);
    this.seed = seed;
  }

  void seed(int n) {
    rnd = new Random(n);
    seed = n;
  }

  JSONObject save() {
    return new JSONObject();
  }


  void generate(Vec2 center, int wradius, int hradius)
  {
    //log.println("generating universe");

    //    for(int x = -wradius; x < wradius; x++)
    //    {
    //      for(int y = -hradius; y < hradius; y++)
    //      {
    //        if(rnd.nextFloat() < systemProbability)
    //        {
    //          Vec2 pos = new Vec2(x, y).sum(center);
    //          println(pos.info());
    //          system act = this.new system(pos);
    //          act.generate();
    //
    //          systems.add(act);
    //
    //        }
    //
    //      }
    //
    //    }
    int length = wradius*hradius;
    float area = PI*length;

    println(area*systemProbability);

    for(int i = 0; i < area*systemProbability; i++)
    {
      Vec2 des = new Vec2(rnd);
      des.mult(length);

      system ss = this.new system(center);
      ss.generate();
      systems.add(ss);

      center.sum(des);
    }

    println("done");
  }



  class system {

    Vec2 position;

    Array stars;
    Array astros;

    system(Vec2 pos) {
      position = pos.copy();
    }

    void generate()
    {
      stars = new Array(getStars(rnd));
      astros = new Array(getAstros(rnd, stars.length()));

      println(astros.length(), stars.length());

      for(int i = 0; i < max(stars.length(), astros.length()); i++) {
        if(i < stars.length()) stars.set(i, new star());
        if(i < astros.length()) astros.set(i, new astro());
      }

    }

    class star {

      Vec2 dim;
      float mass;
      float temperature;

      boolean isBlackHole;

      star() {
        isBlackHole = rnd.nextFloat() < blackHoleProbability;
        temperature = (rnd.nextFloat()*.6+0.7) * (isBlackHole ? 0 : 1000);
        mass = map(rnd.nextFloat(), 0, 1, 0.7, 1) * 200;
        dim = new Vec2(mass*map(rnd.nextFloat(), 0, 1, .6, 1), mass*map(rnd.nextFloat(), 0, 1, .6, 1));
      }

      star(boolean b, float t, float m, Vec2 d) {
        isBlackHole = b;
        temperature = t;
        mass = m;
        dim = d;
      }


      Vec2 getPosition(int C)
      {
        Vec2 ret = position.copy();

        switch(stars.length()) {
          case 2:
          int n = C == 0 ? -1 : 1;
          ret.sumX(dim.copy().mult(n));
          break;
          case 3:
          n = C-1;
          if(n == 0) ret.sub(new Vec2(0, dim.y));
          else {
            ret.sum(new Vec2(dim.x, 0).mult(n));
            ret.y += dim.y/2;
          }
          break;
          case 4:
          int a = C % 2 == 0 ? -1 : 1;
          int b = C <= 1 ? -1 : 1;
          Vec2 c = new Vec2(dim.x*a, dim.y*b);
          ret.sum(c);
          break;
          case 5:
          a = C % 2 == 0 ? -1 : 1;
          b = C <= 1 ? -1 : 1;
          c = new Vec2(dim.x*a, dim.y*b);
          if(C != 4)
          ret.sum(c);
        }
        return ret;
      }


    }

    class astro {

      float ang;
      Vec2 dimension = new Vec2();

      int planetN;
      Vec2 gravity = new Vec2();
      float mass = 1;

      float temperatureAmbient;
      float temperature;

      astro() {
        temperature = (rnd.nextFloat()*1) * 1000;
        mass = map(rnd.nextFloat(), 0, 1, 0.7, 1) * 50;
        dimension = new Vec2(mass*map(rnd.nextFloat(), 0, 1, .6, 1), mass*map(rnd.nextFloat(), 0, 1, .6, 1));
      }

      astro(float pos, Vec2 dim) {
        ang = pos;
        dimension = new Vec2(dim);

        mass = dim.x*dim.y*PI;

        planetN = astros.length(); //0 FIRST, 1 SECOND...

        ang = rand.nextFloat() * TWO_PI;
      }

      Vec2 getPos() {
        return position.copy().sincos(ang, planetN*100);
      }

      void show()
      {
        rotate(ang);
        getPos().ellip(dimension.x, dimension.y);
      }


    }

  }

  class gobernament {

    String name;
    Player president;

    gobernament() {
      president = new Player(generateName(rnd));
    }

  }

}

Integer getStars(Random r) {

  Array pap = new Array(loadStrings("data/starsCount.txt"));

  return int(cast(pap.get(r.nextInt(pap.length()))));
}

int getAstros(Random r, int stars) {
  return max(r.nextInt(7*stars)-1, 0);
}

int seedToInt(String seed) {
  String abc =   "abcdefghijklmnopqrstuvwxyz0123456789";
  int[] values = {3, 100, 12, 91, 18, 20, 19, 69, 18, 45, 53, 55, 36, 50, 47, 81, 19, 78, 19, 94, 43, 31, 74, 80, 60, 21, 54, 11, 89, 54, 80, 13, 43, 35, 28, 19};
  // Totally random numbers :)
  int se = 0;

  for(int i = 0; i < seed.length(); i++)
  {
    char c = seed.charAt(i);
    int index = abc.indexOf(c);
    if(index != -1)
      se += values[index]*(i+1);
  }

  return se;
}
