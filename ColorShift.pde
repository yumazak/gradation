int colorShiftValue = 100;

void colorShift() {
  loadPixels();
  PImage disp = get();
  displayImage(disp);
}

void displayImage(PImage pict) {
  int alp = 120;

  tint(0, 0, 255, alp);
  image(pict, -w, -h + random(-colorShiftValue, colorShiftValue));
  tint(0, 255, 0, alp);
  image(pict, -w, -h + random(-colorShiftValue, colorShiftValue));
  tint(255, 0, 0, alp);
  image(pict, -w, -h + random(-colorShiftValue, colorShiftValue));

}
