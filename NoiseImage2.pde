PImage img;
float xoff = 0.0;
int noiseImage2Value = 100;

void noiseImage2() {
  background(0);
  for (int i = 0; i < height / copy_h; i++) {
    xoff += 0.1;

    copy_y = i * copy_h;
    copy_d = noise(xoff) * noiseImage2Value; 

    copy_img = im.get(copy_x, copy_y, width, copy_h);

    fill(0);
    noStroke();
    image(copy_img, -w + copy_x + copy_d, -h + copy_y);
  }
}  
