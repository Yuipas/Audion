class Array {

  Object[] array = new Object[0];
  Class clss;

  Array() {

  }

  Array(int length) {
    array = new Object[length];
  }

  Array(Object[] cont) {
    array = cont;
  }

  Array(Class c) {
    clss = c;
  }

  int length() {
    return array.length;
  }

  String[] info() {

    String[] info = new String[length()];
    for(int i = 0; i < info.length; i++) info[i] = cast(get(i));

    return info;
  }

  String[] printf() {
    Array pr = new Array(0);

    for(Object ob : array) {
      pr.add(ob.getClass().toString() +", "+ cast(ob));
    }

    printArray(pr.info());

    return pr.info();
  }

  Object get(int i) {
    if(i < 0) return new Object();
    return array[i];
  }

  int indexOf(Object ob) {
    for(int i = 0; i < length(); i++) if(get(i) == ob) return i;
    return -1;
  }

  Array set(int i, Object val) {
    array[i] = val;
    return this;
  }

  Array copy() {
    return new Array(array);
  }

  Array add(Object ob) {
    array = (Object[]) append(array, ob);
    return this;
  }

  Array find(Class c) {
    Array matches = new Array(0);

    for(Object ob : array) {
      if(ob.getClass() == c) {
        matches.add(ob);
      }
    }
    return matches;
  }

  Array remove(int index) {
    Array newc = new Array();
    for(int i = 0; i < length(); i++) if(i != index) newc.add(get(i));
    array = newc.array;
    return this;
  }

  Array remove(Object ob) {
    Array newc = new Array();
    for(int i = 0; i < length(); i++) if(!get(i).equals(ob)) newc.add(get(i));
    array = newc.array;
    return this;
  }

  Array expand(int length) {
    array = (Object[]) PApplet.expand(array, length);
    return this;
  }

  Array reverse() {
    array = (Object[]) PApplet.reverse(array);
    return this;
  }

  boolean contains(Object ob)
  {
    for(int i = 0; i < length(); i++) {
      if(get(i).equals(ob)) return true;
    }
    return false;
  }

}
