Star[] star = new Star[700];   

void setup() {
    
  size(800, 800);
  for(int i=0;i<star.length;i++){
    star[i] = new Star();
  }
}


int u=10;

class Star{
    float x;
    float y;
    float z;

    float pz;


    Star(){
        this.x=random(-width,width);
        this.y=random(-height,height);
        z=random(width);

        pz=z;
    }

    void show(){
        fill(255);
        noStroke();

        float sx = map(x / z, 0, 1, 0, width/2);
        float sy = map(y / z, 0, 1, 0, height/2);

        float sz=map(z ,0, width, 8, 0 );

        circle(sx, sy,sz);
       

        float px = map(x / pz, 0, 1, 0, width/2);
        float py = map(y / pz, 0, 1, 0, height/2);

        pz = z;

        stroke(255);
        line(px, py, sx, sy);
    }

    void update(){

        z=z-10;
        if(z<1){
            z=width;
            x=random(-width,width);
            y=random(-height,height);
            pz=z;
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