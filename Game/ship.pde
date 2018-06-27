class ship {

  String name;

  Vec2 position = new Vec2(0, 0);
  Vec2 velocity = new Vec2(0, 0);

  Player owner;

  int maxComponents = 1;

  Component body;

  Component[] components;
  Vec2[] componentsPositions;

  Array inventory = new Array();

  ship() {name = generateName(rand);}

  void show() {
      image(getImage(), position.x, position.y);
  }

  PImage getImage() {
    return new PImage();
  }

  void addComponent(Component comp) {

    if(maxComponents > components.length) {

      components = (Component[]) append(components, comp);
    }

  }

}

class Component {

  ship belongsTo;
  ComponentDef properties;

  public Component(ComponentDef def) {

    properties = def;

  }
}


class ComponentDef {

  PImage imag;
  float power;

  PShape shape;
  color col = white;

  ComponentDef() {

  }

}


class ParticleSystem {

  Vec2 center;
  Vec2 gravity = new Vec2(0, 0.098);

  Array particles;

  int maxlifetime = 15;

  ParticleSystem(int x, int y) {
    center = new Vec2(x, y);
    particles = new Array();
  }

  void add(int i) {
    for(int n = 0; n < i; n++) particles.add(this.new Particle(-0.5, 0.5, 0.1, 5));
  }

  void show() {
    for(Object ob : particles.array) {
      Particle p = (Particle) ob;
      p.loop();

      if(p.lifetime > maxlifetime) particles.remove(p);
    }
  }

  class Particle {

    Vec2 position = center.copy();
    Vec2 velocity;

    color strokeColor = white;
    color fillColor = -1;

    int lifetime = 0;

    Particle(float xmin, float xmax, float ymin, float ymax) {
      velocity = new Vec2(random(xmin, xmax), random(ymin, ymax));
    }

    void loop() {
      position.sum(velocity);
      velocity.sum(gravity);

      if(fillColor == -1) noFill();
      else fill(fillColor, map(lifetime, 0, maxlifetime, 255, 0));

      if(strokeColor == -1) noStroke();
      else stroke(strokeColor, map(lifetime, 0, maxlifetime, 255, 0));
      lifetime++;
      ellipse(position.x, position.y, 1.5, 1.5);
    }

  }
}
