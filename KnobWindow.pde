public class KnobWindow extends PApplet {
  Knob[] knobs = new Knob[5];
  String[] knobNames = {"ColorShift", "PixelSort", "Noise", "Noise2", "Fade"};
  boolean firstTime = true;
  PlayButton playButton;
  BackButton backButton;
  
  public void settings() {
    size(500, 200);
    int x_diff = width / knobs.length;
    
    for(int i = 0; i < knobs.length; i++) {
      knobs[i] = new Knob(knobNames[i], x_diff * i + x_diff / 2, height / 2, 0, 255);
    }
    
    playButton = new PlayButton();
    backButton = new BackButton();
  }
  
  public void draw() {
    //if first draw then set the location to (100, 700)
    if(firstTime) {
      surface.setLocation(100, 700);
      firstTime = false;
    }
    
    background(51, 51, 51);
    fill(0);
    
    for(int i = 0; i < knobs.length; i++) {
      knobs[i].display();
    }
    
    playButton.display();
    backButton.display();
  }
  
  public void setKnobValue(int i, int value) {
    knobs[i].setValue(value);
  }
  
  class Knob {
    int value = 0,knobWidth = 50, knobOvalWidth = 5, maped_value, x, y, minValue, maxValue;
    String name;
    
    Knob(String name, int x, int y, int minValue, int maxValue){
      this.name = name;
      this.x = x;
      this.y = y;
      this.minValue = minValue;
      this.maxValue = maxValue;
    }
    
    void update(int value) {
      this.value = value;
    }
    
    void display() {
      fill(245,245,245);
      textAlign(CENTER);
      text(this.name, x, y - knobWidth);
      strokeWeight(2);
      stroke(245, 245, 245);
      noFill();
      pushMatrix();
      maped_value = (int)map(value, 0, 255, 30, 330);
      translate(x, y);
      rotate(radians(maped_value));
      ellipse(0, 0, knobWidth, knobWidth);
      line(0, 0, 0, 0 + knobWidth / 2);
      popMatrix();
    }
    
    void setValue(int value) {
      this.value = value;
    }
  }
  
  class PlayButton {
    //boolean isPlaying = true;
    int buttonWidth = 30;
    float stopButtonSpace = 0.3;
    float stopButtonWidth = (1 - stopButtonSpace) / 2;
    float x = width / 2 - buttonWidth / 2;
    float y = height /2 + height / 4;
    PlayButton() {}
    
    void display() {
      fill(245, 245, 245);
      pushMatrix();
      if(isPlaying) {
        translate(x, y);
        rect(0, 0, buttonWidth * stopButtonWidth, buttonWidth);
        rect(buttonWidth * (stopButtonWidth + stopButtonSpace), 0,buttonWidth * stopButtonWidth, buttonWidth);
      } else {
        translate(x, y);
        triangle(0, 0, 0, buttonWidth, buttonWidth, buttonWidth /2);
      }
      popMatrix();
    }
    
    float getX() {
      return x;
    }
    float getY() {
      return y;
    }
    int getButtonWidth() {
      return buttonWidth;
    }
  }
  
  void mouseClicked() {
    if( dist(playButton.getX(),playButton.getY(),mouseX,mouseY) <= playButton.getButtonWidth()) {
      isPlaying = !isPlaying;
    } else if(dist(backButton.getX(),backButton.getY(),mouseX,mouseY) <= backButton.getButtonWidth()) {
      player.rewind();
      println("jo");
    };
  }
  
    class BackButton {
    //boolean isPlaying = true;
    int buttonWidth = 30;
    float triangleWidth = buttonWidth/ 2;
    float x = width / 2 - buttonWidth / 2 - buttonWidth * 2;
    float y = height /2 + height / 4 + triangleWidth / 2;
    BackButton() {}
    void display() {
      fill(245, 245, 245);
      pushMatrix();
      translate(x, y);
      triangle(0, triangleWidth / 2, triangleWidth, 0, triangleWidth, triangleWidth);
      triangle(triangleWidth, triangleWidth /2, triangleWidth * 2, 0, triangleWidth * 2, triangleWidth);
      popMatrix();
    }
    float getX() {
      return x;
    }
    float getY() {
      return y;
    }
    int getButtonWidth() {
      return buttonWidth;
    }
  }
}
