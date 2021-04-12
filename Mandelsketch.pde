/**
 * MandelSketch.pde -- allow tracing of iterative orbits of points under Mandelbrot
 *   iteration
 * A. Thall
 * 5/29/19
 * Based on example of same functionality in Numberfile video
 */

PImage paper;
float cx, cy;

void setup() {
  size(1024, 780);
  paper = loadImage("paper1024x780.png");
}

void draw() {
  background(paper);

  // Draw coordinate axes
  strokeWeight(2);
  stroke(128);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  stroke(0);

  float cx, cy;
  float zx, zy;
  
  // Draw light grey mandelbrot set (just points for regular grid)
  stroke(64);
  for (int row = 0; row < width; row += 4) {
    for (int col = 0; col < height; col += 4) {
      zx = 0;
      zy = 0;
      cx = (col - width/2.0)*2.2/height;
      cy = (row - height/2.0)*2.2/height;
      int i = 0;
      for (i = 0; i < 100; i++) {
        float znx = zx*zx - zy*zy + cx;
        float zny = 2*zx*zy + cy;
        zx = znx;
        zy = zny;
        if (zx*zx + zy*zy > 4.0) 
          break;
      }
      if (i >= 100)
          point((float) cx*height/2.2 + width/2, 
                (float) cy*height/2.2 + height/2);
    }
  }
  
  // Compute C offset for Z = Z + c iteration
  cx = (mouseX - width/2)*2.2/height;
  cy = (mouseY - height/2)*2.2/height;
  
  fill(255, 0, 0);
  zx = 0;
  zy = 0;
  
  // draw filled circle at (0, 0)
  strokeWeight(1);
  fill(0, 0, 255);
  stroke(0);
  ellipse(width/2, height/2, 10, 10);
  
  // Compute orbit of Z = Z + c for first 50 iterations
  for (int i = 0; i < 50; i++) {
    float znx = zx*zx - zy*zy + cx;
    float zny = 2*zx*zy + cy;

    // back to screen coordinates
    float fznx = znx*height/2.2 + width/2;
    float fzny = zny*height/2.2 + height/2;
    float fzx = zx*height/2.2 + width/2;
    float fzy = zy*height/2.2 + height/2;
    line(fznx, fzny, fzx, fzy);  // line from previous to current
    fill(255/50.0*i);  // color points on black to white gradient
    ellipse(fznx, fzny, 10, 10); // filled circle at current
    zx = znx;
    zy = zny;
  }

  // draw filled circle at initial c in red
  fill(255, 0, 0);
  ellipse(cx*height/2.2 + width/2, cy*height/2.2 + height/2, 10, 10);
  
  text("(" + cx + ", " + cy + ")", 20, height - 30);
}
