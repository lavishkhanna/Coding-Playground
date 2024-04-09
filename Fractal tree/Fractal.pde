void setup() {
  size(400, 400);
  background(0);
}

float leng = 5;

void func(int x, float cur_x, float cur_y,int rot) {
  if (x <= 1) {
    return;
  }

  translate(width/2, height/2);
  rotate(rot+45);
  line(cur_x, cur_y, cur_x + leng, cur_y + leng);
  func(x - 1, cur_x + leng , cur_y + leng , 0);

  rotate(rot-90);
  line(cur_x, cur_y, cur_x + leng, cur_y + leng);
  func(x - 1, cur_x + leng , cur_y + leng , 0);
}

void branch(float len, float angle, float thickness) {
  stroke(thickness); // Adjust thickness for a smooth visual effect

  if (len <= 1) {
    return;
  }

  // Translate along the branch
  translate(0, -len);

  
  pushMatrix(); 
  rotate(angle);
  line(0, 0, 0, -len * 0.67);
  branch(len * 0.67, angle, thickness);
  popMatrix();  

  rotate(-angle);
  line(0, 0, 0, -len * 0.67);
  branch(len * 0.67, angle, thickness); 
}

float angle=30;

void draw() {
  background(0);

  translate(200,height);
  stroke(255);
  line(0,0,0,-100);

  if (keyPressed) {
    if (keyCode == UP) angle += 0.01;
    if (keyCode == DOWN) angle -= 0.01;
  }

  branch(100,angle,255);
}
