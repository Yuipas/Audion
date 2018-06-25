
class gui
{
  Vec2 cornerA = new Vec2(0, 0); //A-----------
  Vec2 cornerB = new Vec2(0, 0); //-----------B

  PFont textfont;
  boolean show;
  int mouseDegrade = 200;
  int stableDegrade = 125;
  int background = 255;

  boolean mouseReleased, mouseActived;
  boolean otherslocked = false;

  boolean iskeyPressed = false;
  boolean haskeyReleased = false;
  char wkey;
  int kCode = -1;

  gui(Vec2 pA, Vec2 pB) {cornerA = pA.copy(); cornerB = pB.copy();}


  void show(boolean state) {this.show = state;}

  void loop() {

    noStroke();
    fill(background);
    rect(cornerA.x, cornerA.y, cornerB.x, cornerB.y);
    iskeyPressed = false;

    if(keyPressed && haskeyReleased) {
      iskeyPressed = true;
      haskeyReleased = false;
      wkey = key;
      kCode = keyCode;
    }

    if(!haskeyReleased && !keyPressed) haskeyReleased = true;

    if(wkey != key) haskeyReleased = true;

    mouseActived = false;
    if(!mousePressed) mouseReleased = true;
    if(mousePressed && mouseReleased) {mouseActived = true; mouseReleased = false;}
  }

  class button {

    Vec2 pA = new Vec2(0, 0);
    Vec2 pB = new Vec2(0, 0);
    String id;

    boolean mouseOnTop = false;
    boolean action = false;
    String text = null;

    int textSize = 14;

    color textColor = 0;
    color strokeColor;
    color defaultColor;

    button(Vec2 size) {
      pB = size;
      check();
    }

    void check() {
      if(pA.dist(new Vec2(0, 0)) > pB.dist(new Vec2(0, 0))) {
        Vec2 temp = pB.copy();
        pB = pA.copy();
        pA = temp;
      }
    }

    void translate(Vec2 position) {
      pA.sum(position);
      pB.sum(position);
      check();
    }

    void translate(Vec2 pA, Vec2 pB) {pA.sum(pA); pB.sum(pB); check();}

    void show()
    {
      if(show)
      {
        rectMode(CORNERS);
        stroke(strokeColor);
        fill(defaultColor, mouseOnTop ? mouseDegrade : stableDegrade);
        rect(pA.x, pA.y, pB.x, pB.y);

        if(text != null)
        {
          Vec2 pos = pA.copy().average(pB);
          textAlign(CENTER);
          fill(textColor);
          textSize(textSize);
          if(textfont != null) textFont(textfont);
          text(text, pos.x, pos.y);
        }
      }

      update();

    }

    void update() {

      Vec2 mouse = new Vec2(mouseX, mouseY);

      if((pA.x < mouse.x && pA.y < mouse.y) && (pB.x > mouse.x && pB.y > mouse.y))
        mouseOnTop = true;
      else mouseOnTop = false;

      action = false;

      if(mouseOnTop && mouseActived) action = true;
    }

  }

  class toggle {

    Vec2 pA = new Vec2(0, 0);
    Vec2 pB = new Vec2(0, 0);
    String id;

    boolean mouseOnTop = false;
    boolean toggled = false;
    String text = null;

    int textSize = 12;

    color textColor = 0;
    color strokeColor;
    color colorOn = green;
    color colorOff = red;

    toggle(Vec2 size) {
      pB = size;
      check();
    }

    void check() {
      if(pB.dist(new Vec2(0, 0)) < pA.dist(new Vec2(0, 0))) {
        Vec2 temp = pB.copy();
        pB = pA.copy();
        pA = temp;
      }
    }

    void translate(Vec2 position) {
      pA.sum(position);
      pB.sum(position);
      check();
    }

    void translate(Vec2 pA, Vec2 pB) {pA.sum(pA); pB.sum(pB); check();}

    void show()
    {
      if(show)
      {
        rectMode(CORNERS);
        stroke(strokeColor);

        fill(toggled ? colorOn : colorOff, mouseOnTop ? mouseDegrade : stableDegrade);
        rect(pA.x, pA.y, pB.x, pB.y);

        if(text != null)
        {
          Vec2 pos = pA.copy().average(pB);
          textAlign(CENTER);
          fill(textColor);
          textSize(textSize);
          if(textfont != null) textFont(textfont);
          text(text, pos.x, pos.y);
        }

        if(!otherslocked && mouseOnTop && mouseActived) toggled = !toggled;
      }

      update();

    }

    void update() {

      Vec2 mouse = new Vec2(mouseX, mouseY);

      if((pA.x < mouse.x && pA.y < mouse.y) && (pB.x > mouse.x && pB.y > mouse.y))
        mouseOnTop = true;
      else mouseOnTop = false;

    }


  }

  class scroller {

    Vec2 pA = new Vec2(0, 0);
    Vec2 pB = new Vec2(0, 0);
    String id;

    float enabled = 1;
    boolean mouseOnTop = false;
    boolean mouselocked = false;
    boolean showValue = true;
    boolean interactable = true;

    String text, mag;
    float minv = 0;
    float maxv = 1;

    int textSize = 14;

    color textColor = 0;
    color strokeColor;
    color colorOn = green;
    color colorOff = red;

    scroller(Vec2 size) {
      pB = size;
      check();
    }

    void check() {
      if(pB.dist(new Vec2(0, 0)) < pA.dist(new Vec2(0, 0))) {
        Vec2 temp = pB.copy();
        pB = pA.copy();
        pA = temp;
      }
    }


    void translate(Vec2 position) {
      pA.sum(position);
      pB.sum(position);
      check();
    }

    void translate(Vec2 pA, Vec2 pB) {pA.sum(pA); pB.sum(pB); check();}

    void show()
    {
      if(show)
      {
        rectMode(CORNERS);
        stroke(strokeColor);

        fill(colorOff, mouseOnTop || mouselocked ? mouseDegrade : stableDegrade);
        rect(pA.x, pA.y, pB.x, pB.y);

        float x = map(enabled, 0, 1, pA.x, pB.x);
        fill(colorOn, mouseOnTop || mouselocked ? mouseDegrade : stableDegrade);
        rect(pA.x, pA.y, x, pB.y);

        Vec2 cords = pA.copy().average(pB);

        if(showValue || text != null) {
          fill(textColor);
          textAlign(CENTER, CENTER);
          textSize(textSize);
          String resultT = (text != null ? text + (showValue ? ": " + nf(enabled(), 1, 1) : "") : "") + (mag != null ? mag : "");
          text(resultT, cords.x, cords.y);
        }
      }

    }

    float enabled() {
      return map(enabled, 0, 1, minv, maxv);
    }

    void set(float value) {
      enabled = map(value, minv, maxv, 0, 1);
    }

    void update() {

      if(interactable)
      {
        Vec2 mouse = new Vec2(mouseX, mouseY);

        if((pA.x < mouse.x && pA.y < mouse.y) && (pB.x > mouse.x && pB.y > mouse.y))
          mouseOnTop = true;
        else mouseOnTop = false;

        if(mouseOnTop && mousePressed && !otherslocked) {mouselocked = otherslocked = true;}
        if(!mousePressed) mouselocked = otherslocked = false;

        if(mouselocked) enabled = map(mouseX, pA.x, pB.x, 0, 1);
      }

      enabled = constrain(enabled, 0, 1);
    }

  }

  class textBox {

    Vec2 pA = new Vec2(0, 0);
    Vec2 pB = new Vec2(0, 0);
    String id;

    boolean isModificable = false;
    boolean mouseOnTop = false;
    boolean showbox = false;
    boolean typing = false;
    boolean show = true;

    String text = "";
    int maxChars = 0;
    int alignX = CENTER;
    int alignY = CENTER;
    int textSize = 12;

    color defaultColor;
    color strokeColor;
    color textColor;

    textBox(String content) {
      text = content;
    }

    textBox(Vec2 b, String content) {
      pB = b;
      text = content;
    }


    void check() {
      if(pB.dist(new Vec2(0, 0)) < pA.dist(new Vec2(0, 0))) {
        Vec2 temp = pB.copy();
        pB = pA.copy();
        pA = temp;
      }
    }

    void translate(Vec2 position) {
      pA.sum(position);
      pB.sum(position);
      check();
    }

    void translate(Vec2 pA, Vec2 pB) {pA.sum(pA); pB.sum(pB); check();}

    void show() {

      if(show)
      {
        stroke(strokeColor);

        if(showbox)
        {
          fill(defaultColor, mouseOnTop||typing ? mouseDegrade : stableDegrade);
          rect(pA.x, pA.y, pB.x, pB.y);
        }

        textAlign(alignX, alignY);
        textSize(textSize);
        fill(textColor);
        if(textfont != null) textFont(textfont);
        Vec2 c = getTextCords();
        text(text, c.x, c.y);

      }

      update();

    }

    void update() {

      Vec2 mouse = new Vec2(mouseX, mouseY);

      if(isModificable)
      {
        if((pA.x < mouse.x && pA.y < mouse.y) && (pB.x > mouse.x && pB.y > mouse.y))
          mouseOnTop = true;
        else mouseOnTop = false;

        if(mouseOnTop && mousePressed) {typing = true;}
        if(!mouseOnTop && mousePressed) {typing = false;}

        if(typing && iskeyPressed && (maxChars == 0 || maxChars > text.length() || key == BACKSPACE)) {

          if(key == BACKSPACE) {
            String newtext = "";

            for(int i = 0; i < text.length()-1; i++) {
              newtext += text.charAt(i);
            }
            text = newtext;
          }

          else text += key;
        }

      }

    }

    Vec2 getTextCords() { return pA.copy().average(pB); }

  }

  class box {

    Vec2 pA = new Vec2(0, 0);
    Vec2 pB = new Vec2(0, 0);
    String id;

    boolean mouseOnTop = false;

    color defaultColor;
    color strokeColor;

    box(Vec2 size) {
      pB = size;
    }


    void check() {
      if(pB.dist(new Vec2(0, 0)) < pA.dist(new Vec2(0, 0))) {
        Vec2 temp = pB.copy();
        pB = pA.copy();
        pA = temp;
      }
    }

    void translate(Vec2 position) {
      pA.sum(position);
      pB.sum(position);
      check();
    }

    void translate(Vec2 pA, Vec2 pB) {pA.sum(pA); pB.sum(pB); check();}

    void show() {

      if(show)
      {
        stroke(strokeColor);
        fill(defaultColor, mouseOnTop ? mouseDegrade : stableDegrade);
        rect(pA.x, pA.y, pB.x, pB.y);
      }

    }

    void update() {


      Vec2 mouse = new Vec2(mouseX, mouseY);

      if((pA.x < mouse.x && pA.y < mouse.y) && (pB.x > mouse.x && pB.y > mouse.y))
        mouseOnTop = true;
      else mouseOnTop = false;

    }

  }

  class scrollableList {

    Vec2 pA = new Vec2(0, 0);
    Vec2 pB = new Vec2(0, 0);
    String id;

    boolean mouseOnTop = false;
    boolean opened = false;
    String text = null;
    Array content = new Array();

    Vec2 size;

    int textSize = 14;

    color textColor = 0;
    color strokeColor;
    color defaultColor;

    scrollableList(Vec2 size) {
      pB = size;
      this.size = pA.copy().sub(pB).abs();
    }

    void check() {
      if(pA.dist(new Vec2(0, 0)) > pB.dist(new Vec2(0, 0))) {
        Vec2 temp = pB.copy();
        pB = pA.copy();
        pA = temp;
      }
    }

    void translate(Vec2 position) {
      pA.sum(position);
      pB.sum(position);
      check();
    }

    void translate(Vec2 pA, Vec2 pB) {pA.sum(pA); pB.sum(pB); check();}

    void addContent(Object guiOb) {
      if(guiOb.getClass() == gui.button.class)
      {
        gui.button but = (gui.button) guiOb;
        but.pA = new Vec2(pA.x, pA.y+(content.length()+1)*size.y);
        but.pB = new Vec2(pB.x, pB.y+(content.length()+1)*size.y);

        content.add(but);
      } else if(guiOb.getClass() == gui.toggle.class) {
        gui.toggle tog = (gui.toggle) guiOb;
        tog.pA = new Vec2(pA.x, pA.y+(content.length()+1)*size.y);
        tog.pB = new Vec2(pB.x, pB.y+(content.length()+1)*size.y);

        content.add(tog);
      } else if(guiOb.getClass() == gui.box.class) {
        gui.box box = (gui.box) guiOb;
        box.pA = new Vec2(pA.x, pA.y+(content.length()+1)*size.y);
        box.pB = new Vec2(pB.x, pB.y+(content.length()+1)*size.y);

        content.add(box);
      }
    }

    void show()
    {
      if(show)
      {
        rectMode(CORNERS);
        stroke(strokeColor);
        fill(defaultColor, mouseOnTop ? mouseDegrade : stableDegrade);
        rect(pA.x, pA.y, pB.x, pB.y);

        Vec2 pC = pA.copy().sumY(size);
        Vec2 pD = pB.copy().sumY(size);

        if(opened) {
          Vec2 pos = pA.copy().average(pB);
          pos.div(2);
          pos.sumY(pos);
          pos.sumX(10);
          triangle(pos.x+pos.x/20, pos.y, pos.x-pos.x/20, pos.y, pos.x, pos.y-pos.y/40);
        } else {
          Vec2 pos = pA.copy().average(pB);
          pos.div(2);
          pos.sumY(pos);
          pos.sumX(10);
          triangle(pos.x+pos.x/20, pos.y, pos.x-pos.x/20, pos.y, pos.x, pos.y+pos.y/40);
        }

        for(int i = 0; opened && i < content.length(); i++) {
          //pC.rct(pD);
          //pC.sumY(size);
          Object guiOb = content.get(i);
          if(guiOb.getClass() == gui.button.class)
          {
            gui.button but = (gui.button) guiOb;
            but.show();
          } else if(guiOb.getClass() == gui.toggle.class) {
            gui.toggle tog = (gui.toggle) guiOb;
            tog.show();
          } else if(guiOb.getClass() == gui.box.class) {
            gui.box box = (gui.box) guiOb;
            box.show();
          }
        }

        if(text != null)
        {
          Vec2 pos = pA.copy().average(pB);
          textAlign(CENTER);
          fill(textColor);
          textSize(textSize);
          if(textfont != null) textFont(textfont);
          text(text, pos.x, pos.y);
        }
      }

    }

    void update() {

      Vec2 mouse = new Vec2(mouseX, mouseY);

      if((pA.x < mouse.x && pA.y < mouse.y) && (pB.x > mouse.x && pB.y > mouse.y))
        mouseOnTop = true;
      else mouseOnTop = false;

      if(mouseOnTop && mouseActived) {
        opened = !opened;
      }

    }

  }
}
