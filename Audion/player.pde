class Player {

  String nickName;
  PImage texture;

  float speed;
  float life = 100;
  int coins = 0;

  Vec2[] positions = {new Vec2(), new Vec2(), new Vec2(), new Vec2()};

  Vec2 pos = new Vec2(0, 0);
  Vec2 vel = new Vec2(0, 0);
  Vec2 ace = new Vec2(0, 0);

  float rotation;
  float ang_rota;

  float temperature;
  ship inShip;
  color col;

  Array ships = new Array();

  public Player(String nickName) {
    this.nickName = nickName;
    pos = positions[p.universe];
  }

  void loop() {
    vel.sum(ace);
    pos.sum(vel);

    show();
  }

  void buyShip(ship s, int price) {
    ships.add(s);
    coins -= price;
  }

  void sellShip(ship s, int price) {
    ships.remove(s);
    coins += price;
  }

  void show() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);
    image(inShip == null ? texture : inShip.getImage(), 0, 0);
    popMatrix();
  }

  void control(boolean[] buttons) {

    if(life < 0) return;

    if(buttons[0])
    {
      if(inShip == null) {/*on land, jump*/ ace.sum(new Vec2(0, 0)); return;} //CHANGE ACCELERATION
      if(inShip != null) {/*inside ship, active engine*/}
    }

    if(buttons[1])
    {
      //TURN LEFT
    }

    if(buttons[2])
    {
      //TURN RIGHT
    }

  }

}



color playerColor(int i) {
  switch(i) {
    case 0:
      return blue;
    case 1:
      return red;
    case 2:
      return green;
    case 3:
      return yellow;
    default:
      return white;
  }
}
