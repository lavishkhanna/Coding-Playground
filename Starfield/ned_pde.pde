Star[] star = new Star[500];   

void setup() {
    
  size(600, 600);
  for(int i=0;i<star.length;i++){
    star[i] = new Star();
  }
}


int u=10;

class Star{
    float x;
    float y;
    float z;


    Star(){
        this.x=random(-width,width);
        this.y=random(-height,height);
        z=random(width);
    }

    void show(){
        fill(255);
        noStroke();

        float sx = map(x / z, 0, 1, 0, width/2);
        float sy = map(y / z, 0, 1, 0, height/2);

        float sz=map(z ,0, width, 8, 0 );

        circle(sx, sy,sz);
    }

    void update(){

        z=z-5;
        if(z<1){
            z=width;
            x=random(-width,width);
            y=random(-height,height);
        }
        
    }
};




void draw() {
    background(0);
    translate(width/2, height/2);
    
    for(int i=0;i<star.length;i++){
        star[i].update();
        star[i].show();
    }
}
