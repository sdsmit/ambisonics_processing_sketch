import java.io.*;
import processing.opengl.*;
import java.util.*;
import peasy.*;

PeasyCam cam;

int rotation = 0;
int sphereWeight = 40;
int i;
float a1;
Float[] userAz = new Float[2000];
Float[] userEl = new Float[2000];
Float[] sourceEl = new Float[2000];
Float[] sourceAz = new Float[2000];
int size = 0;
int counter = 0;
PVector LastXYZ = new PVector();
PVector LastXYZ1 = new PVector();

void setup() {
  double distance = 800;
  cam = new PeasyCam(this, width/2, height/2, 0, 1000);
  
  
  String[] lines = loadStrings("trial1MusicForeheadContinous.txt");
  size = lines.length;
  for (int i = 0; i < size; i++) {
  }

  String[][] linesFields = new String[size][9];

  for (int i = 0; i < size; i++) {
    linesFields[i] = lines[i].split("\\s");
  }
  for (int i = 0; i < size; i++) {
    userAz[i] = Float.parseFloat(linesFields[i][1]);
    userEl[i] = Float.parseFloat(linesFields[i][2]);
    sourceEl[i] = Float.parseFloat(linesFields[i][3]);
    sourceAz[i] = Float.parseFloat(linesFields[i][4]);
  }

  size(800, 800, P3D);

  background(0);
  translate(width/2, height/2);
  stroke(sphereWeight);
  noFill();
  sphere(300);
  int r = 300;
  LastXYZ.x = r * (sin(sourceEl[0]) * cos(sourceAz[0]));
  LastXYZ.y = r * (sin(sourceEl[0]) * sin(sourceAz[0]));
  LastXYZ.z = r * (cos(sourceEl[0]));

  LastXYZ1.x = r * (sin(userEl[0]) * cos(userAz[0]));
  LastXYZ1.y = r * (sin(userEl[0]) * sin(userAz[0]));
  LastXYZ1.z = r * (cos(userEl[0]));
}

void draw() {
  //clears canvas

  background(0);
  pushMatrix();
  translate(width/2, height/2);
  stroke(sphereWeight);
  noFill();
  sphere(300);
  popMatrix();
  
  PVector XYZ = new PVector();
  PVector XYZ1 = new PVector();
  int numPoints = size;
  int r = 300;
  i =  counter % numPoints;
  
  fill(255);
  text("Frame", 25, 100);
  text(counter % size, 105, 100);
  fill(255, 0, 0);
  text("Source Elv.", 25, 120);
  text(sourceEl[i], 100, 120);
  text("Source Az.", 25, 140);
  text(sourceAz[i], 100, 140);
  
  fill(0, 0, 255);
  text("User Elv.", 25, 160);
  text(userEl[i], 100, 160);
  text("User Az.", 25, 180);
  text(userAz[i], 100, 180);

 
  //for (int i = 0; i < size; i++) {
  translate(width/2, height/2);
  XYZ.x = r * (sin(sourceEl[i]) * cos(sourceAz[i]));
  XYZ.y = r * (sin(sourceEl[i]) * sin(sourceAz[i]));
  XYZ.z = r * (cos(sourceEl[i]));

  XYZ1.x = r * (sin(userEl[i]) * cos(userAz[i]));
  XYZ1.y = r * (sin(userEl[i]) * sin(userAz[i]));
  XYZ1.z = r * (cos(userEl[i]));

  pushMatrix();
  //source is red
  translate(XYZ.x, XYZ.y, XYZ.z);
  fill(255, 0, 0);
  noStroke();
  sphere(3);
  popMatrix();

  pushMatrix();
  //user is blue
  translate(XYZ1.x, XYZ1.y, XYZ1.z);
  fill(0, 0, 255);
  noStroke();
  sphere(3);
  popMatrix();
  //}
  
  stroke(255, 0, 0, 100);
  line(LastXYZ.x, LastXYZ.y, LastXYZ.z, XYZ.x, XYZ.y, XYZ.z);
  stroke(0, 0, 255, 100);
  line(LastXYZ1.x, LastXYZ1.y, LastXYZ1.z, XYZ1.x, XYZ1.y, XYZ1.z);
  
  LastXYZ.x = XYZ.x;
  LastXYZ.y = XYZ.y;
  LastXYZ.z = XYZ.z;

  LastXYZ1.x = XYZ1.x;
  LastXYZ1.y = XYZ1.y;
  LastXYZ1.z = XYZ1.z;
  
  counter++;
 
  delay(100);
}
