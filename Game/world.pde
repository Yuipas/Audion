class Universe {

  Random rnd;
  Array systems;
  int seed;
  gobernament gob;

  Universe(int seed) {
    rnd = new Random(seed);
    gob = new gobernament();
    systems = new Array(1);
    this.seed = seed;
  }


  void generate()
  {
    Vec2 newsystem = new Vec2(rnd);
  }



  class system {

    Vec2 position;

    Array stars;
    Array astros;

    system(Vec2 pos) {
      position = pos.copy();
      systems.add(this);

      stars = new Array(getStars());
      astros = new Array(getAstros(stars.length()));
    }

    class astro {

      float ang;
      Vec2 dimension = new Vec2();

      int planetN;

      Vec2 gravity = new Vec2();
      float mass = 1;

      float temperature;

      astro(float pos, Vec2 dim) {
        ang = pos;
        dimension = new Vec2(dim);

        mass = dim.x*dim.y*PI;

        planetN = astros.length(); //0 FIRST, 1 SECOND...
        astros.add(this);

        ang = rand.nextFloat(TWO_PI);
      }

      Vec2 getPos() {
        return position.copy().sincos(position, planetN*100);
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

Integer getStars() {
  Array pap = new Array();

  for(int i = 0; i < 1000; i++) {
    if(i < 960) {
      pap.add(1);
    } else
    if(i < 999) {
      pap.add(2);
    }
    else pap.add(3);
  }

  return int(cast(pap.get(rand.nextInt(pap.length()))));
}

int getAstros(int stars) {
  return max(rand.nextInt(7*stars)-1, 0);
}
