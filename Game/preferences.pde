language english;
language spanish;

class preferences
{
  language lang;

  int scene = 0;
  float scene_transition;
  boolean intrasition = false;

  int profile; //index of p (Player[])
  int universe; //index of w (Universe[])
  boolean log = false;
  int[] resolution = {500, 500};
  int performance = 10;
  int frameRate = 40;
  float volume;

  //represents the players which has been already created.
  boolean[] activePlayers = {false, false, false, false};

  Player[] p = new Player[4];
  Universe[] w = new Universe[4];

  preferences() {
    english = new language("English", loadStrings("data/languages/english.lang"));
    //spanish = new language("Español", loadStrings("data/languages/spanish.lang"));
    lang = english;
  }

  void save() {

    JSONObject json = new JSONObject();

    json.setFloat("volume", volume);
    json.setInt("FPS", frameRate);
    json.setInt("performance", performance);
    json.setInt("profile", profile);
    json.setBoolean("log", log);

    JSONObject playersActived = new JSONObject();
    for(int i = 0; i < activePlayers.length; i++) playersActived.setBoolean(str(i), activePlayers[i]);
    json.setJSONObject("activePlayers", playersActived);

    JSONObject resol = new JSONObject();
    resol.setInt("width", resolution[0]);
    resol.setInt("height", resolution[1]);
    json.setJSONObject("resolution", resol);

    saveJSONObject(json, "data/options.txt");
  }

  void load() {
    JSONObject json = loadJSONObject("data/options.txt");

    volume = json.getFloat("volume");
    performance = json.getInt("performance");
    profile = json.getInt("profile");
    log = json.getBoolean("log");
    frameRate = json.getInt("FPS");

    JSONObject resol = new JSONObject();

    resol = json.getJSONObject("resolution");
    this.resolution[0] = resol.getInt("width");
    this.resolution[1] = resol.getInt("height");

    JSONObject playersActived = json.getJSONObject("activePlayers");
    JSONArray players = json.getJSONArray("players");

    for(int i = 0; i < p.length; i++) {

      while(!playersActived.getBoolean(str(i))) {i++; if(i >= p.length) return;}

      JSONObject pl = players.getJSONObject(i);
      Player ob = new Player("");


      ob.nickName = pl.getString("nickName");
      ob.life = pl.getFloat("life");
      ob.pos = new Vec2(pl.getFloat("x"), pl.getFloat("y"));
      ob.coins = pl.getInt("coins");

      Array ships = new Array();

      JSONArray temp = pl.getJSONArray("ships");

      for(int j = 0; j < ob.ships.length(); j++) {

        ship s = new ship();
        JSONObject sh = temp.getJSONObject(j);

        s.name = sh.getString("name");
        s.maxComponents = sh.getInt("maxComponents");
        s.position = new Vec2(sh.getFloat("x"), sh.getFloat("y"));

        ships.add(s);
      }

      ob.ships = ships.copy();

    }

  }

}


class language {

  String name;
  String directory;
  Array dictionary;

  language(String a, String[] b) {
    name = a;
    dictionary = new Array(b);
  }

  language() {

  }


  void save(String directory) {
    JSONArray json = new JSONArray();

    for(int i = 0; i < dictionary.length(); i++)
    {
      JSONObject obj = new JSONObject();
      /*SEE 'data/languages/___.lang'*/

      json.setJSONObject(i, obj);
    }
  }

  String get(int i) {
    return (String) dictionary.get(i);
  }

  int getId(String str) {

    for(int i = 0; i < dictionary.length(); i++) {
      if(str.equals(get(i))) {
        return i;
      }
    }

    return -1;
  }

  String find(String ob) {
    return (String) dictionary.get(english.getId(ob));
  }


}


language load(String name, String directory) {
  return new language(name, loadStrings(directory));
}
