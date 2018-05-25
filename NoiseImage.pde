int copy_w = 512, copy_h = 1, copy_x, copy_y;
int noiseImageValue = 50;
float copy_d;
PImage copy_img;
color[] copy;

void noiseImage() {
  loadPixels();
  background(0);
  for (int i = 0; i < height / copy_h; i++) {
    copy_y = i * copy_h;
    copy_d = random(-noiseImageValue, noiseImageValue);
    copy_img = im.get(copy_x, copy_y, width, copy_h);
    fill(0);
    noStroke();
    image(copy_img, -w + copy_x + copy_d, -h + copy_y);
  }
}
