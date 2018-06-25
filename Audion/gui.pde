color green = color(101, 255, 101);
color red = color(255, 101, 101);
color yellow = color(255, 255, 0);
color blue = color(101, 101, 255);
color violet = color(255, 0, 255);
color white = color(236);
color black = color(19);

//GUI DISPLAY
int scene = 0;

gui canvas;
/*MAIN MENU*/
gui.button playB;
gui.button playersB;
gui.button worldsB;
gui.button preferencesB;
gui.button exitB;
gui.box profileB;
/*INGAME*/
gui.button resume_button;
gui.scroller volume_scroller;
gui.button exit_button;
/*PREFERENCES*/
gui.button backB;
gui.button applyB;
gui.scroller performanceS;
gui.scroller res_wS;
gui.scroller res_hS;
gui.scroller fpsS;
gui.toggle logT;
gui.scroller volumeS;
/*PLAYERS MENU*/
gui.button selectP1;
gui.textBox textsP1;
gui.button selectP2;
gui.textBox textsP2;
gui.button selectP3;
gui.textBox textsP3;
gui.button selectP4;
gui.textBox textsP4;
/*WORLDS MENU*/
gui.button selectW1;
gui.button selectW2;
gui.button selectW3;
gui.button selectW4;
/*CREATING PLAYER-MENU*/
gui.box playerDisplayBox;
gui.textBox textBoxN;
gui.button randomName;
gui.scrollableList specieList;
gui.button doneB;
/*CREATING WORLD-MENU*/
gui.textBox uniName;
gui.button randomNameUn;
gui.textBox seedUn;
gui.button button4;
gui.button button5;

public void guiSetup()
{
  textAlign(CENTER, CENTER);

  int w = width;
  int h = height;

  canvas = new gui(new Vec2(0, 0), new Vec2(w, h));

  loadScene(0);

  canvas.background = black;
  canvas.textfont = loadFont("data/Uni0553-18.vlw");
  canvas.show(true);

  profileB = canvas.new box(new Vec2(0.1*w, 0.1*h));
  profileB.defaultColor = playerColor(p.profile);
}


public void guiDraw()
{
  int w = width;
  int h = height;

  canvas.loop();

  if(scene == 0) /*MAIN MENU*/ {
    playB.show();
    playersB.show();
    worldsB.show();
    preferencesB.show();
    exitB.show();
    profileB.show();

    if(playB.action) {loadScene(1); actPlayer = p.p[p.profile]; actUniverse = p.w[p.universe]; return;}
    if(playersB.action) {loadScene(2); return;}
    if(worldsB.action) {loadScene(3); return;}
    if(preferencesB.action) {loadScene(4); return;}
    if(exitB.action) {exit(); p.save(); return;}
  } else
  if(scene == 1) /*PLAY SCENE*/ {

  } else
  if(scene == 2) /*PLAYERS MENU*/ {
    selectP1.show();
    selectP2.show();
    selectP3.show();
    selectP4.show();
    textsP1.show();
    textsP2.show();
    textsP3.show();
    textsP4.show();

    if(selectP1.action) {
      p.profile = 0;
      if(p.p[0] == null) {
        loadScene(5);
      } else loadScene(0);
    }
    else if(selectP2.action) {
      p.profile = 1;
      if(p.p[1] == null) {
        loadScene(5);
      } else loadScene(0);
    }
    else if(selectP3.action) {
      p.profile = 2;
      if(p.p[2] == null) {
        loadScene(5);
      } else loadScene(0);
    }
    else if(selectP4.action) {
      p.profile = 3;
      if(p.p[3] == null) {
        loadScene(5);
      } else loadScene(0);
    }

    if(scene == 5) playerDisplayBox.defaultColor = playerColor(p.profile);

  } else
  if(scene == 3) /*WORLDS MENU*/ {
    selectW1.show();
    selectW2.show();
    selectW3.show();
    selectW4.show();

    if(selectW1.action) {
      p.universe = 0;
      if(p.w[0] == null) {
        loadScene(6);
      } else loadScene(0);
    }
    else if(selectW2.action) {
      p.universe = 1;
      if(p.w[1] == null) {
        loadScene(6);
      } else loadScene(0);
    }
    else if(selectW3.action) {
      p.universe = 2;
      if(p.w[2] == null) {
        loadScene(6);
      } else loadScene(0);
    }
    else if(selectW4.action) {
      p.universe = 3;
      if(p.w[3] == null) {
        loadScene(6);
      } else loadScene(0);
    }
  } else
  if(scene == 4) /*PREFERENCES MENU*/ {
    backB.show();
    applyB.show();
    performanceS.show();
    res_hS.show();
    res_wS.show();
    fpsS.show();
    logT.show();
    volumeS.show();

    volumeS.update();
    res_wS.update();
    res_hS.update();
    fpsS.update();
    performanceS.update();

    if(backB.action) {guiSetup(); return;}
    if(applyB.action) {
      int[] temp = {int(res_wS.enabled()), int(res_hS.enabled())};
      p.performance = int(performanceS.enabled());
      p.resolution = temp;
      p.log = logT.toggled;
      p.frameRate = int(fpsS.enabled());
      p.volume = (volumeS.enabled());
      reset();
      loadScene(4);
    }
  } else
  if(scene == 5) /*CREATING PLAYER MENU*/ {
    playerDisplayBox.show();
    textBoxN.show();
    randomName.show();
    specieList.show();
    specieList.update();
    doneB.show();
    if(randomName.action) textBoxN.text = generateName();
    if(doneB.action) if(applyB.action) {p.p[p.profile] = new Player(uniName.text); loadScene(0);}
    for(int i = 0; i < 4; i++) if(((gui.button) specieList.content.get(i)).action) {playerDisplayBox.defaultColor = playerColor(i); p.profile = i; specieList.opened = false; ((gui.button) specieList.content.get(i)).action = false; return;}
  } else
  if(scene == 6) /*CREATING WORLD MENU*/ {
    uniName.show();
    randomNameUn.show();
    seedUn.show();
    button4.show();
    button5.show();
    backB.show();
    applyB.show();

    if(randomNameUn.action) uniName.text = generateName();
    if(applyB.action) {p.w[p.universe] = new Universe(); loadScene(0);}

  }
}

void loadScene(int i)
{
  int w = width;
  int h = height;

  {
    playB = null;
    playersB = null;
    worldsB = null;
    preferencesB = null;
    exitB = null;
    resume_button = null;
    volume_scroller = null;
    exit_button = null;
    backB = null;
    applyB = null;
    performanceS = null;
    res_wS = null;
    res_hS = null;
    fpsS = null;
    logT = null;
    volumeS = null;
    selectP1 = null;
    textsP1 = null;
    selectP2 = null;
    textsP2 = null;
    selectP3 = null;
    textsP3 = null;
    selectP4 = null;
    textsP4 = null;
    selectW1 = null;
    selectW2 = null;
    selectW3 = null;
    selectW4 = null;
    playerDisplayBox = null;
    textBoxN = null;
    randomName = null;
    specieList = null;
    doneB = null;
    uniName = null;
    randomNameUn = null;
    seedUn = null;
    button4 = null;
    button5 = null;
  }

  if(i == 0) /*MAIN MENU*/
  {
    playB = canvas.new button(new Vec2(0.88*w, 0.133334*h));
    playersB = canvas.new button(new Vec2(0.4*w, 0.08*h));
    worldsB = canvas.new button(new Vec2(0.373386*w, 0.08001129*h));
    preferencesB = canvas.new button(new Vec2(0.82678324*w, 0.08001123*h));
    exitB = canvas.new button(new Vec2(0.2933747*w, 0.053340882*h));

    playB.translate(new Vec2(0.053340856*w, 0.42672685*h));
    playersB.translate(new Vec2(0.080011286*w, 0.5867494*h));
    worldsB.translate(new Vec2(0.5334086*w, 0.5867494*h));
    preferencesB.translate(new Vec2(0.080011286*w, 0.69343114*h));
    exitB.translate(new Vec2(0.34671557*w, 0.82678324*h));

    playB.defaultColor = green;
    playersB.defaultColor = worldsB.defaultColor = blue;
    preferencesB.defaultColor = yellow;
    exitB.defaultColor = red;

    playB.text = p.lang.find("Play");
    playersB.text = p.lang.find("Players");
    worldsB.text = p.lang.find("Worlds");
    preferencesB.text = p.lang.find("Options");
    exitB.text = p.lang.find("Exit");
  } else
  if(i == 1) /*PLAY SCENE*/
  {
    resume_button = canvas.new button(new Vec2(0.32004514*w, 0.08001123*h));
    volume_scroller = canvas.new scroller(new Vec2(0.34671554*w, 0.08001123*h));
    exit_button = canvas.new button(new Vec2(0.106681705*w, 0.08001123*h));

    resume_button.translate(new Vec2(0.026670428*w, 0.88012415*h));
    volume_scroller.translate(new Vec2(0.42672685*w, 0.88012415*h));
    exit_button.translate(new Vec2(0.82678324*w, 0.88012415*h));
  } else
  if(i == 2) /*PLAYERS MENU*/
  {
    selectP1 = canvas.new button(new Vec2(0.7824429*w, 0.17782795*h)); //SIZE = 114
    selectP2 = canvas.new button(new Vec2(0.7824429*w, 0.17782794*h));
    selectP3 = canvas.new button(new Vec2(0.7824429*w, 0.17782794*h));
    selectP4 = canvas.new button(new Vec2(0.7824429*w, 0.17782794*h));

    textsP1 = canvas.new textBox(new Vec2(1.25*w, 0.27669676*h), "Player blue");
    textsP2 = canvas.new textBox(new Vec2(1.25*w, 0.6940903*h), "Player red");
    textsP3 = canvas.new textBox(new Vec2(1.25*w, 1.1240838*h), "Player green");
    textsP4 = canvas.new textBox(new Vec2(1.25*w, 1.5438774*h), "Player yellow");

    selectP1.translate(new Vec2(0.10669676*w, 0.10669676*h));
    selectP2.translate(new Vec2(0.10669676*w, 0.3200903*h));
    selectP3.translate(new Vec2(0.10669676*w, 0.5334838*h));
    selectP4.translate(new Vec2(0.10669676*w, 0.7468774*h));

    selectP1.defaultColor = blue;
    selectP2.defaultColor = red;
    selectP3.defaultColor = green;
    selectP4.defaultColor = yellow;

  } else
  if(i == 3) /*WORLDS MENU*/
  {
    selectW1 = canvas.new button(new Vec2(0.7824429*w, 0.17782795*h));
    selectW2 = canvas.new button(new Vec2(0.7824429*w, 0.17782794*h));
    selectW3 = canvas.new button(new Vec2(0.7824429*w, 0.17782794*h));
    selectW4 = canvas.new button(new Vec2(0.7824429*w, 0.17782794*h));

    selectW1.translate(new Vec2(0.10669676*w, 0.10669676*h));
    selectW2.translate(new Vec2(0.10669676*w, 0.3200903*h));
    selectW3.translate(new Vec2(0.10669676*w, 0.5334838*h));
    selectW4.translate(new Vec2(0.10669676*w, 0.7468774*h));

    selectW1.defaultColor = white;
    selectW2.defaultColor = white;
    selectW3.defaultColor = white;
    selectW4.defaultColor = white;
  } else
  if(i == 4) /*PREFERENCES MENU*/
  {
    backB = canvas.new button(new Vec2(0.24895914*w, 0.07113116*h));
    applyB = canvas.new button(new Vec2(0.24895911*w, 0.07113116*h));
    performanceS = canvas.new scroller(new Vec2(0.71131176*w, 0.07113118*h));
    res_wS = canvas.new scroller(new Vec2(0.6401806*w, 0.07113119*h));
    res_hS = canvas.new scroller(new Vec2(0.6401806*w, 0.07113116*h));
    fpsS = canvas.new scroller(new Vec2(0.71131176*w, 0.07113116*h));
    logT = canvas.new toggle(new Vec2(0.71131176*w, 0.07113122*h));
    volumeS = canvas.new scroller(new Vec2(0.21339352*w, 0.07113116*h));

    backB.translate(new Vec2(0.03556559*w, 0.8891397*h));
    applyB.translate(new Vec2(0.71131176*w, 0.8891397*h));
    performanceS.translate(new Vec2(0.14226235*w, 0.10669676*h));
    res_wS.translate(new Vec2(0.17782794*w, 0.21339352*h));
    res_hS.translate(new Vec2(0.17782794*w, 0.3200903*h));
    fpsS.translate(new Vec2(0.14226235*w, 0.5690494*h));
    logT.translate(new Vec2(0.14226235*w, 0.67574614*h));
    volumeS.translate(new Vec2(0.39122146*w, 0.8891397*h));

    backB.text = p.lang.find("Back");
    applyB.text = p.lang.find("Done");
    performanceS.text = p.lang.find("Efficency");
    res_wS.text = p.lang.find("Width");
    res_hS.text = p.lang.find("Height");
    fpsS.text = p.lang.find("FPS");
    logT.text = p.lang.find("Print log");

    backB.defaultColor = white;
    applyB.defaultColor = white;

    res_wS.minv = res_hS.minv = 50;
    res_wS.maxv = res_hS.maxv = 900;
    res_hS.mag = res_wS.mag = " px";

    fpsS.minv = 5;
    fpsS.maxv = 80;
    fpsS.mag = " fps";
    volumeS.text = p.lang.find("vol");
    volumeS.mag = " %";
    volumeS.minv = 0;
    volumeS.maxv = 100;
    performanceS.minv = 1;
    performanceS.maxv = 10;

    performanceS.set(p.performance);
    fpsS.set(p.frameRate);
    volumeS.set(p.volume);
    res_wS.set(width);
    res_hS.set(height);
    logT.toggled = p.log;

  } else
  if(i == 5) /*CREATING PLAYER MENU*/
  {
    playerDisplayBox = canvas.new box(new Vec2(0.3912215*w, 0.3912215*h));
    textBoxN = canvas.new textBox(new Vec2(0.2845247*w, 0.10669676*h), p.lang.find("Name"));
    randomName = canvas.new button(new Vec2(0.2133935*w, 0.07113118*h));
    specieList = canvas.new scrollableList(new Vec2(0.3200903*w, 0.07113116*h));
    doneB = canvas.new button(new Vec2(0.39122143*w, 0.14226232*h));

    playerDisplayBox.translate(new Vec2(0.10669676*w, 0.10669676*h));
    textBoxN.translate(new Vec2(0.604615*w, 0.10669676*h));
    randomName.translate(new Vec2(0.6401806*w, 0.24895912*h));
    specieList.translate(new Vec2(0.14226235*w, 0.5334838*h));
    doneB.translate(new Vec2(0.5690494*w, 0.81800854*h));

    textBoxN.showbox = true;
    textBoxN.isModificable = true;
    textBoxN.textSize = 250;
    textBoxN.maxChars = 20;
    textBoxN.defaultColor = randomName.defaultColor = specieList.defaultColor = doneB.defaultColor = white;
    randomName.text = p.lang.find("Random");
    doneB.text = p.lang.find("Create");
    specieList.text = p.lang.find("Specie");

    for(int c = 0; c < 4; c++) {
      gui.button b1 = canvas.new button(new Vec2());
      b1.defaultColor = playerColor(c);
      b1.id = "specie b" + str(c);
      b1.text = null;
      specieList.addContent(b1);
    }

  } else
  if(i == 6) /*CREATING WORLD MENU*/
  {
    uniName = canvas.new textBox(new Vec2(0.7824429*w, 0.10669676*h), generateName());
    randomNameUn = canvas.new button(new Vec2(0.49791828*w, 0.07113118*h));
    seedUn = canvas.new textBox(new Vec2(0.7824429*w, 0.10669678*h), p.lang.find("Seed"));
    button4 = canvas.new button(new Vec2(0.2845247*w, 0.07113116*h));
    button5 = canvas.new button(new Vec2(0.2845247*w, 0.07113116*h));
    backB = canvas.new button(new Vec2(0.24895914*w, 0.07113116*h));
    applyB = canvas.new button(new Vec2(0.24895911*w, 0.07113116*h));

    uniName.translate(new Vec2(0.10669676*w, 0.10669676*h));
    randomNameUn.translate(new Vec2(0.24895912*w, 0.24895912*h));
    seedUn.translate(new Vec2(0.10669676*w, 0.42678705*h));
    button4.translate(new Vec2(0.10669676*w, 0.604615*h));
    button5.translate(new Vec2(0.604615*w, 0.604615*h));
    backB.translate(new Vec2(0.03556559*w, 0.8891397*h));
    applyB.translate(new Vec2(0.71131176*w, 0.8891397*h));


    uniName.showbox = uniName.isModificable = seedUn.showbox = seedUn.isModificable = true;
    uniName.defaultColor = randomNameUn.defaultColor = seedUn.defaultColor = white;
    randomNameUn.text = p.lang.find("Random");

    backB.text = p.lang.find("Back");
    applyB.text = p.lang.find("Done");
    backB.defaultColor = white;
    applyB.defaultColor = white;
  }

  scene = i;
}


float rounded(float value, float ac)
{
  float temp = pow(10, ac) * value;
  temp = round(temp);
  temp /= pow(10, ac);
  return temp;
}
