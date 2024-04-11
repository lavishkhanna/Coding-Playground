class Boundry { 
  float x1;
  float y1;
  float x2;
  float y2;

  Boundry(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }

  float slope() {
    return (y2 - y1) / (x2 - x1);
  }

  void show() {
    stroke(255);
    line(x1, y1, x2, y2);
  }
}

Boundry bound; 
Ray ray;

Boundry bot_b;
Boundry right_b;
Boundry left_b;
Boundry top_b;

float mousex=mouseX-height/2;
float mousey=mouseY-width/2;

ArrayList<Boundry> boundries = new ArrayList<Boundry>();



void setup() {
  size(800, 800);
  
  top_b = new Boundry(-800, -800, 800,-800);
  left_b = new Boundry(-800, 800, -800,-800); 
  right_b = new Boundry(800, 800, 800,-800); 
  bot_b = new Boundry(800, 800, -800,800); 

  boundries.add(bot_b);
  boundries.add(top_b);
  boundries.add(left_b);
  boundries.add(right_b);





  float num_bound=7;

  for(int i=0;i<num_bound;i++){
    float x1 =(float) (Math.random() * 2 * height/2 - height/2);
    float y1 =(float) (Math.random() * 2 * width/2 - width/2);
    float x2 =(float) (Math.random() * 2 * height/2 - height/2);
    float y2 =(float) (Math.random() * 2 * width/2 - width/2);


    Boundry B=new Boundry(x1,y1,x2,y2);

    boundries.add(B);
  }

}

class pair{
  float x;
  float y;

  pair(float x1,float y1){
    x=x1;
    y=y1;
  }

}

pair doIntersect(Ray l1, Boundry l2) {
    float x1=l2.x1;
    float x2=l2.x2;
    float y1=l2.y1;
    float y2=l2.y2;

    float x3=l1.x1;
    float x4=l1.x2;
    float y3=l1.y1;
    float y4=l1.y2;

    pair p;


  float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
  if (den == 0) {
      p=new pair(0,0);
      return p;
  }

  float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;
  float u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den;

  if (t > 0 && t < 1 && u > 0){
    float x=x1 + t * (x2 - x1);
    float y= y1 + t * (y2 - y1);


    p=new pair(x,y);
    return p;
  }
  p=new pair(0,0);
  return p;


}

class Ray{
  float x1=mouseX-height/2;
  float y1=mouseY-width/2;
  float x2=0;
  float y2=0;
  
  Ray(float x2, float y2){
    this.x2=x2;
    this.y2=y2;
  }

  float slope() {
    return (y2 - y1) / (x2 - x1);
  }

  void show(){
    stroke(255);
    line(x1, y1,x2,y2);
  }
}


void draw() {
  translate(height/2,width/2);
  background(0);

  float mousex=mouseX-height/2;
  float mousey=mouseY-width/2;
  ray=new Ray(mousex,mousey);
  ray.show();



  ArrayList<Ray> rays = new ArrayList<Ray>();


  for(int i=0;i<=360;i=i+1){
    float angleRadians = radians(i);
    float x2 = mousex + cos(angleRadians) * (800+height); 
    float y2 = mousey + sin(angleRadians) * (800+width); 

    ray=new Ray(x2,y2);

    rays.add(ray);

  
  }


  for(int i=0;i<boundries.size();i++){
    Boundry B=boundries.get(i);

    B.show();
  }

  pair pnt = null; 

  for (int i = 0; i < rays.size(); i++) {
      Ray ray = rays.get(i);
      ArrayList<pair> inter_points = new ArrayList<pair>();
      float least = Integer.MAX_VALUE;

      for (int j = 0; j < boundries.size(); j++) {
          Boundry B = boundries.get(j);
          pair inter = doIntersect(ray, B);

          if (inter.x != 0.0 && inter.y != 0.0) {
              float distance = (float) Math.sqrt(Math.pow(ray.x1 - inter.x, 2) + Math.pow(ray.y1 - inter.y, 2));

              if (least > distance) {
                  least = distance;
                  pnt = new pair(inter.x, inter.y);
              }
          }
      }
      if (pnt != null) {
          line(ray.x1, ray.y1, pnt.x, pnt.y);
      }
  }


}
