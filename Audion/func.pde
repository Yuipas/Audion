import java.util.Random;

Random rand = new Random();

String[] Beginning = { "Kr", "Ca", "Ra", "Mrok", "Cru", "Ray", "Bre", "Zed", "Drak", "Mor", "Jag", "Mer", "Jar", "Mjol", "Zork", "Mad", "Cry", "Gre", "Zur", "Cire", Creo", "Azak", "Yu", "Azur", "Rei", "Cro", "Mar", "Luk"};

String[] Middle = { "air", "ip", "", "ir", "mi", "sor", "mee", "clo", "red", "cra", "ark", "arc", "miri", "lori", "cres", "mur", "zer", "marac", "zoir", "slamar", "salmar", "urak"};

String[] End = { "d", "ed", "ark", "arc", "es", "er", "der", "tron", "as", "med", "ure", "zur", "cred", "mur" };


public String generateName(Random r) {

  return Beginning[r.nextInt(Beginning.length)] +
    Middle[r.nextInt(Middle.length)]+
    End[r.nextInt(End.length)];
}



String cast(Object b) {

  if(b == null) return null;
  if(b.getClass() == Integer.class) return str((int) b);
  if(b.getClass() == Float.class) return str((float) b);
  if(b.getClass() == Boolean.class) return str((boolean) b);
  if(b.getClass() == Character.class) return str((char) b);
  if(b.getClass() == String.class) return (String) b;
  if(b.getClass() == Vec2.class) return ((Vec2) b).info();
  return null;

}
