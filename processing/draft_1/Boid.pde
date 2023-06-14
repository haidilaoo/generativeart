//glowing lines

float hueOffset;

class Boid
{
  PVector velocity;
  PVector position;
  PVector previousPosition;
  float maxSpeed = 7;
  float maxForce = 0.2;
  float angle;
  float index;
  float hue;
  ArrayList<Boid> closest = new ArrayList<Boid>();
  
  Boid(PVector position)
  {
    this.position = position;
    
    angle = random(0, PI*2);
    this.velocity = new PVector(cos(angle) * maxSpeed, sin(angle) * maxSpeed);
    
    PVector delta = new PVector(width / 2 - position.x, height / 2 - position.y);
    delta.normalize();
    if ((delta.x == 0) && (delta.y == 0))
    {
      delta.x = 1;
    }
    
    previousPosition = new PVector(position.x, position.y);
    
    index = random(0, 1000000);
    
    hue = (hueOffset + random(-1, 1) * 10 + 360) % 360;
  }
  
  void update()
  {
    if (closest.size() == 0)
    {
      float neighborDistance = 100;
      for (Boid boid : boids)
      {
        if (boid == this)
          continue;
        
        float dist = PVector.dist(boid.position, position);
        if (dist > neighborDistance)
          continue;
  
        closest.add(boid);
      }
    }
    
    PVector sep = separate();
    PVector ali = align();
    PVector coh = cohesion();
    PVector wan = wander();
    
    sep.mult(1.5);
    ali.mult(1);
    coh.mult(1);
    wan.mult(1.5);
    
    velocity.add(sep);
    velocity.add(ali);
    velocity.add(coh);
    velocity.add(wan);
    
    velocity.limit(maxSpeed);
    
    position.add(velocity);
  }
  
  void draw()
  {
    stroke(hue, 100, 100, 1);
    
    float neighborDistance = 150;
    float closenessSum = 0;
    int count = 0;
    float averageHue = 0;
    for (Boid boid : boids)
    {
      if (boid == this)
        continue;
      
      float dist = PVector.dist(boid.position, position);
      if (dist > neighborDistance)
        continue;

      float closeness = 1 - (dist / neighborDistance);
      closenessSum += closeness;
      count++;
      
     
      averageHue += boid.hue;
      
    }
    
    if (count > 0)
    {
      averageHue = averageHue / count;
     
    }

    strokeWeight(min(closenessSum / 2, 3));
    stroke(hue, 100, 100, closenessSum * 3);
    
    line(previousPosition.x, previousPosition.y, position.x, position.y);
    previousPosition.x = position.x;
    previousPosition.y = position.y;
  }
  
  float lerpHue(float h1, float h2, float amt)
  {
     // figure out shortest direction around hue
     float z = 360;
     float dh12 = (h1>=h2) ? h1-h2 : z-h2+h1;
     float dh21 = (h2>=h1) ? h2-h1 : z-h1+h2;
     float h = (dh21 < dh12) ? h1 + dh21 * amt : h1 - dh12 * amt;
     if (h < 0.0) h += z;
     else if (h > z) h -= z;
     return h;
  }
  
  
  PVector wander()
  {
    angle += lerp(-1, 1, noise(index + frameCount * 0.001)) * 0.1;

    PVector dir = new PVector(cos(angle) * maxSpeed, sin(angle) * maxSpeed);
    
    PVector steer = PVector.sub(dir, velocity);
    steer.limit(maxForce);
    return steer;
  }

  PVector separate()
  {
    //float neighborDistance = 50;
    PVector sum = new PVector();
    int count = 0;
    for (Boid boid : closest)
    {
      if (boid == this)
        continue;
           
      PVector delta = PVector.sub(position, boid.position);
      
      delta.normalize();
      delta.div(delta.mag());
      sum.add(delta);
      count++;
    }
    
    if (count == 0)
      return new PVector();
    
    sum.div(count);
    
    PVector steer = PVector.sub(sum, velocity);
    steer.limit(maxForce);
    return steer;
  }

  PVector align()
  {
    //float neighborDistance = 150;
    PVector sum = new PVector();
    int count = 0;
    for (Boid boid : closest)
    {
      if (boid == this)
        continue;
        
      sum.add(boid.velocity);
      count++;
    }
    
    if (count == 0)
      return new PVector();
    
    sum.setMag(maxSpeed);
    
    PVector steer = PVector.sub(sum, velocity);
    steer.limit(maxForce);
    return steer;
  }

  PVector cohesion()
  {
    //float neighborDistance = 150;
    PVector sum = new PVector();
    int count = 0;
    for (Boid boid : closest)
    {
      if (boid == this)
        continue;

      sum.add(boid.position);
      count++;
    }
    
    if (count == 0)
      return new PVector();
      
    sum.div(count);

    PVector dir = PVector.sub(sum, position);
    
    PVector steer = PVector.sub(dir, velocity);
    steer.limit(maxForce);
    return steer;
  }
}
