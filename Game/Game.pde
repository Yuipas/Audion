import shiffman.box2d.*;

/*TODO LIST
  - CREATE PLAYER CREATING MENU
  - CREATE GAME MECHANICS
  - CREATE AUTOGENERATIVE WORLDS
*/

preferences p;
Player actPlayer;
Universe actUniverse;

boolean[] pushingButtons = {
  false, //Up (w) i=0
  false, //left (a) i=1
  false, //right (d) i=2
  false, //down (s) i=3
};

void setup() {

  size(500, 500);
  p = new preferences();
  p.load();

  surface.setTitle("Audion");
  surface.setFrameRate(p.frameRate);
  surface.setSize(p.resolution[0], p.resolution[1]);

  imageMode(CENTER);
  guiSetup();

  actPlayer = p.p[p.profile];
  actUniverse = p.w[p.universe];

}

void reset()
{
  surface.setTitle("Audion");
  surface.setFrameRate(p.frameRate);
  surface.setSize(p.resolution[0], p.resolution[1]);
  guiSetup();
}


void draw() {
  guiDraw();
  if(scene == 1 && actPlayer != null) {
    actPlayer.show();
    actPlayer.control(pushingButtons);
  }
}

void keyPressed() {
  if(key == 'w') {
    pushingButtons[0] = true;
  }
  if(key == 'a') {
    pushingButtons[1] = true;
  }
  if(key == 'd') {
    pushingButtons[2] = true;
  }
  if(key == 's') {
    pushingButtons[3] = true;
  }

  if(key == 'e') {
    println("open inventory");
  }

  if(key == 'p') {
    println(p.w[p.universe].systems.length());
    for(int i = 0; i < p.w[p.universe].systems.length(); i++)
    {
      Universe.system ss = (Universe.system) p.w[p.universe].systems.get(i);
      println(ss.position.x, ss.position.y);
    }
  }
}



void keyReleased() {
  if(key == 'w') {
    pushingButtons[0] = false;
  }
  if(key == 'a') {
    pushingButtons[1] = false;
  }
  if(key == 'd') {
    pushingButtons[2] = false;
  }
  if(key == 's') {
    pushingButtons[3] = false;
  }
}
