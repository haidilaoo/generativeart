class Circle
{
  float x;
  float y;
  float radius;
  float dx;
  float dy;
  
  Circle()
  {
    x = random(width);
    y = random(height);
    radius = random(radiusMin, radiusMax);
    
    float angle = random(PI * 2);
    float speed = random(speedMin, speedMax); //set in main code file
    dx = cos(angle) * speed; //POSITION OF CIRCLE
    dy = sin(angle) * speed; //POSITION OF CIRCLE
  }

  //TO MAKE CIRCLE MOVING
  void update()
  {
    x += dx;
    y += dy;
    
    if (x <= 0)
    {
      x = 0;
      dx *= -1; //OFFSET POSITION OF CIRCLE
    }

    if (x > width)
    {
      x = width;
      dx *= -1;
    }
    
    if (y <= 0)
    {
      y = 0;
      dy *= -1; //OFFSET POSITION OF CIRCLE
    }

    if (y > height)
    {
      y = height;
      dy *= -1;
    }
  }
  
}
