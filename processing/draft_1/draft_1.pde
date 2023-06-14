//CIRCLE TRAIL
import processing.serial.*; 

Serial myPort;      // Initializing a vairable named 'myPort' for serial communication
String val;

float radiusMin = 10;
float radiusMax = 30;
float speedMin = 0.2;
float speedMax = 2;
int circleCountMin = 20;
int circleCountMax = 40;

ArrayList<Circle> circles = new ArrayList<Circle>();
ArrayList<Boid> boids = new ArrayList<Boid>();

void setup(){
  
  //SERIAL COMMUNICATION
  myPort  =  new Serial (this, "COM6",  9600);
  
  //fullScreen();
  size(800, 800, P2D); //OPENGL FOR CIRCLES BUT P2D IS GOOD FOR BOIDS
  
  
  blendMode(ADD);
  colorMode(HSB, 360, 100, 100, 255);
  noFill();
  reset(false);
  
  //TO DRAW CIRCLE TRAIL
  int circleCount = (int)random(circleCountMin, circleCountMax);
  
  for (int i = 0; i < circleCount; i++)
  {
    circles.add(new Circle());
  }
  
}

void draw(){
  
  
  buttonPressed();
   
  //BOID aka GLOWING LINES CODE 
  if(circle_mode == 3) 
  {
    boid_start();

  }
    
    //TO DRAW CIRCLE TRAIL
    for (int i = 0; i < speed; i++)
    {
      step();
    }
    

    forcePressed();

    save("art4.jpg"); //change file name after each save
  
}






 
