//changes boids colour by reseting hue values

boolean pause;

void reset(boolean keepHue)
{
  if (!keepHue)
    hueOffset = random(0, 360);
  
  boids.clear();
  for (int i = 0; i < 100; i++)
  {
    boids.add(new Boid(new PVector(random(0, width), random(0, height))));
  }

  background(0);
  stroke(255, 5); 
  pause = false;
  
}
