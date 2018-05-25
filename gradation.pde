import processing.serial.*;
import ddf.minim.*;

//Serial
Serial serial;
int portIndex = 2;
int baudRate = 9600;

//Zoom
float zoom = 1.0; //zoom
boolean zoomState = false;
float zoomNum = 0.2;
float zoomMax = 2.4;

PImage im;

//width and height that after traslate
int w, h;

int fadeValue = 0;

Minim minim;
AudioPlayer player;
boolean isPlaying = false;

KeyState keyState = new KeyState();

KnobWindow knobWindow;


void setup() {
  size(500, 500);
  im=loadImage("lena.bmp");
  surface.setResizable(true);
  surface.setSize(im.width, im.height);
  surface.setResizable(false);
  surface.setLocation(100, 100);
  im.resize(width, height);
  w = width / 2;
  h = height / 2;
  background(0);

  //Load BGM
  minim = new Minim(this);  //初期化
  player = minim.loadFile("bgm.mp3"); //mp3ファイルを指定する 

  //create Serial. if you have arduino please uncomment under the three lines below.
  //serial = new Serial(this, Serial.list()[2], baudRate);
  //serial.clear();
  //serial.bufferUntil('\n');s

  //start knobWindow
  String[] args = {"TwoFrame"};
  knobWindow = new KnobWindow();
  PApplet.runSketch(args, knobWindow);
}

//get data from Arduino example -> {"fade", 128}
void serialEvent(Serial port) {
  String dataStr = port.readStringUntil('\n');
  dataStr = trim(dataStr);
  String[] s = splitTokens(dataStr);
  int value = Integer.parseInt(s[1]);
  int maped_value = (int)map(value, 0, 1024, 0, 255); //Map the value between 0 and 1024

  switch(s[0]) {
  case "fade":
    fadeValue = maped_value;
    knobWindow.setKnobValue(4, maped_value);
    break;
  case "sort":
    maxThreshold = maped_value;
    knobWindow.setKnobValue(3, maped_value);
    break;
  case "noiseImage2":
    noiseImage2Value = maped_value;
    knobWindow.setKnobValue(2, maped_value);
    break;
  case "noiseImage":
    noiseImageValue = maped_value;
    knobWindow.setKnobValue(1, maped_value);
    break;
  case "colorShift":
    colorShiftValue = maped_value;
    knobWindow.setKnobValue(0, maped_value);
    break;
  }
  port.write('D'); //cue finish
}

void draw() {
  if (isPlaying) {
    player.play();  //再生
  } else {
    player.pause();
  }

  translate(w, h);
  scale(zoom);
  noTint();
  image(im, -w, -h);

  fill(0, 0, 0, fadeValue);
  //rect(-w, -h, width, height);

  if (keyState.getState('f') == true) {
    noiseImage2();
  }
  if (keyState.getState('d') == true) {
    noiseImage();
  }
  if (keyState.getState('s') == true) {
    pixelSort();
  }
  if (keyState.getState('a') == true) {
    colorShift();
  }
  if (zoomState == true && zoom < zoomMax) {
    zoom += zoomNum;
  } else if (zoom > 1.0) {
    zoom -= zoomNum;
  }
}

void keyPressed()
{
  keyState.putState(key, true);
  if (key == 'g' || key == 'G') {
    zoomState = true;
  }
}

void keyReleased()
{
  keyState.putState(key, false);
  if (key == 'g' || key == 'G') {
    zoomState = false;
  }
}
