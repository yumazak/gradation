int row            = 0, 
  column         = 0, 
  vec            = 10, 
  minThreshold   = 20, 
  threshold      = minThreshold, 
  maxThreshold   = 255, 
  thresholdValue = 0;

int blackValue, brightnessValue, whiteValue, paramsDiv;

void pixelSort() {
  loadPixels();

  row = 0;
  column = 0;

  // loop through rows
  switch(1) {
    case(0):
    while (row < height - 1) {
      sortRow();
      row++;
    }
    break;
    case(1):
    while (column < width - 1) {
      sortColumn();
      column++;
    }
  }

  if (threshold > maxThreshold || threshold < minThreshold) {
    vec *= -1;
  }

  threshold += vec;

  threshold = round(random(minThreshold, maxThreshold));
  updatePixels();
}

void sortRow() {
  int y =    row, 
    x =    0, 
    xend = 0, 
    iRow = y * width;

  while (xend < width - 1) {
    x = getFirstNotBlackX(x, y);
    xend = getNextBlackX(x, y);

    if (x < 0) break;

    int sortLength = xend - x;

    color[] unsorted = new color[sortLength];
    color[] sorted = new color[sortLength];

    for (int i = 0; i < sortLength; i++) {
      unsorted[i] = pixels[x + i + iRow];
    }
    sorted = reverse(unsorted);

    for (int i = 0; i < sortLength; i++) {
      pixels[x + i + iRow] = sorted[i];
    }

    x = xend + 1;
  }
}


void sortColumn() {
  // current column
  int x = column;

  // where to start sorting
  int y = 0;

  // where to stop sorting
  int yend = 0;

  while (yend < height - 1) {
    y = getFirstNotBlackY(x, y);
    yend = getNextBlackY(x, y);

    if (y < 0) break;

    int sortLength = yend - y;

    color[] unsorted = new color[sortLength];
    color[] sorted = new color[sortLength];

    for (int i = 0; i < sortLength; i++) {
      unsorted[i] = pixels[x + (y + i) * width];
    }

    sorted = reverse(unsorted);

    for (int i = 0; i < sortLength; i++) {
      pixels[x + (y + i) * width] = sorted[i];
    }

    y = yend + 1;
  }
}


// black x
int getFirstNotBlackX(int x, int y ) {
  int iRow = y * width;

  while (red(pixels[x + iRow]) > threshold) {
    x++;
    if (x >= width)
      return -1;
  }
  return x;
}


int getNextBlackX( int x, int y ) {
  x++;
  int iRow = y * width;
  //while (pixels[x + iRow] > blackValue) {
  while (red(pixels[x + iRow]) < threshold) {
    x++;
    if (x >= width)
      return width - 1;
  }
  return x - 1;
}


// black y
int getFirstNotBlackY( int x, int y ) {
  if (y < height) {
    while (red(pixels[x + y * width]) > threshold ) {
      y++;
      if (y >= height)
        return -1;
    }
  }
  return y;
}


int getNextBlackY( int x, int y ) {
  y++;
  if (y < height) {
    //while (red(pixels[x + y * width]) < threshold ) {
    while (red(pixels[x + y * width]) < threshold ) {  
      y++;
      if (y >= height)
        return height - 1;
    }
  }
  return y - 1;
}
