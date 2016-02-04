// The class name starts with uppercase
class AiShip extends GameObject
{ 
  float thetaDir;
  
  AiShip()
  {
    super(width-50, height-50, 50);    
    c = color(0, 0, 255);
    forward.x = random(-1, 1);
    forward.y = random(-1, 1);
    forward.normalize();
    thetaDir = random(-0.2f, 0.2f);
       
  }
   
  
    void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    stroke(c);
    float lastX = 0; float lastY = - halfW;
    int sides = 5;
    float thetaInc = TWO_PI / sides;
    for(int i = 0 ; i <= sides ; i ++)
    {
      float t = i * thetaInc;
      float x = sin(t) * halfW;
      float y = -cos(t) * halfW;
      line(lastX, lastY, x, y);
      lastX = x;
      lastY = y;
    }
    popMatrix();
  }
  // This OVERRIDES the update method from the superclass
  void update()
  {
      forward.x = sin(theta);
      forward.y = - cos(theta);
      
      // Move in the direction we are rotated
      forward.mult(speed);
      pos.add(forward);
      
      
      if (pos.y - halfW < 0)
      {
        theta = HALF_PI;
        pos.y = halfW;
      }
      if (pos.x + halfW > width)
      {
        theta = PI;
        pos.x = width - halfW;
      }
      if (pos.y + halfW > height)
      {
        theta = PI + HALF_PI;
        pos.y = height - halfW;
      }
      if (pos.x < halfW)
      {
        theta = 0;
        pos.x = halfW;
      }
    
  }

}
