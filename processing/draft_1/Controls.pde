void buttonPressed() 
{
  //ARDUINO TO PROCESSING COMMUNICATION
  if ( myPort.available() > 0) {
    
    char val = myPort.readChar(); 
    println(val); //for debugging
    
    if (val == 'R')
    {
      circle_mode = 1;
      redraw();     
    }
    
    else if (val == 'Y')
    {
      circle_mode = 0;
      println("y is pressed, circle mode is " + circle_mode );
      redraw(); 
    }
    
    else if (val == 'G') 
    {
      
      circle_mode = 3;
      println("g is pressed, boid draws");
      redraw();
      
    }
  }
}


Circle circle;

//TO CHANGE SIZE OF CIRCLE TO SENSORVAL
//for now not applicable to glowing lines
int sensorVal = 0;

void forcePressed() 
{
  String force = myPort.readStringUntil('\n'); 
  
  try {
   sensorVal = Integer.valueOf(force.trim());
  }
  catch(Exception e) {
  ;
  }
  println(sensorVal); // read it and store it in vals!
  
  
} 
  
  
  ////ARDUINO TO PROCESSING COMMUNICATION
  //if ( myPort.available() > 0) {
    
  //  if (myPort.read() > 10) {
    
  //    float force = myPort.read();
      
  //    println(force);
  //    force = circle.x;
  //  }
  //}

void boid_start()
{
    //BOID CODE
    if (pause)
      return;
    
    strokeWeight(2);
     for (Boid boid : boids)
    {
      boid.update();
      boid.draw();
    }
    
}

//USE THIS TO INCREASE OR DECREASE SPEED OF CIRCLES GENERATED 
//for now not applicable to glowing lines

void keyPressed()
{
  if (key == '+')
  {
    speed++;
  }
  else if (key == '-')
  {
    if (speed > 1)
      speed--;
  }
}
