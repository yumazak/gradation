public class KeyState {
  HashMap<Character, Boolean> key;
  KeyState() {
    this.key = new HashMap<Character, Boolean>();
    this.key.put('a', false);
    this.key.put('s', false);
    this.key.put('d', false);
    this.key.put('f', false);
    //this.key.put('g', false);
  }
  
  public void putState(char name, boolean state) {
    this.key.put(name, state);
  }
  
  boolean getState(char name){
    return this.key.get(name);
  }
}
