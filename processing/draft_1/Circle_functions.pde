int mode = 2; //STARTING AT 1= white first, starting at not 0/1 = white second , mode =0 random
int speed = 1;

int circle_mode = 0; //to switch circle generated based on button pressed

void step()
{
  for (Circle circle : circles)
  {
    circle.update(); //calling update function in Circle class
  
  }
  
  //RANDOM COLOUR FOR CIRCLE
  //using hsb color due to colorMode(HSB, etc)
  float r = (noise(frameCount * speed * 0.00004) * 255 * 10) % 255;
  //float r = 1;
  float h, s, b;
  
  switch (mode)
  {
    case 0:
      h = 0;
      s = 0;
      b = 0;
      break;
      
    case 1:
      h = 0;
      s = 0;
      b = r;
      break;
      
    default:
      h = r;
      s = 255;
      b = 255;
      break;
  }

//TO SWITCH ACCORDING TO BUTTON PRESSED
  switch(circle_mode) 
  {
    case 0:
      //println("circe mode is " + circle_mode);
      noFill();
      stroke(h, s, b, 10); //ONLY OUTLINE OF CIRLCE
      break;
      
    case 1:    
      //println("circe mode is " + circle_mode);
      fill(h, s, b, 10); //MAKE CIRCLE GENERATED FILLED 
      break;
    
    //Red & Yellow button not pressed
    case 3: 
      //println("circe mode is " + circle_mode);
      noFill();
      noStroke();
      break;
   
  }
  
  for (Circle circle1 : circles)
  {
    for (Circle circle2 : circles)
    {
      if (circle1 == circle2)
        continue;
      
      float distance = dist(circle1.x, circle1.y, circle2.x, circle2.y);
      if (distance <= circle1.radius + circle2.radius)
      {
        float centerX = (circle1.x + circle2.x) / 2; //CHANGING POSITION OF CIRCLE
        float centerY = (circle1.y + circle2.y) / 2;
        //float size = distance; //SET SIZE TO DIST BTW CIRCLE 1 & 2
        float size = sensorVal; //to vary size according to force values
        ellipse(centerX, centerY, size, size);
      }
    }
  }
}
