// The class name starts with uppercase
class AiShip extends GameObject
{ 
  float thetaDir;
  float w = width;
  float h = height;
  float HW = halfW;
  float side =0;
  //int lives=1;
  
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
      
      
      if (pos.y - halfW <= side)
      {
        theta = HALF_PI;
        pos.y = HW;
      }
      if (pos.x + halfW >= w)
      {
        theta = PI;
        pos.x = w - halfW;
      }
      if (pos.y + halfW >= h)
      {
        theta = PI + HALF_PI;
        pos.y = h - halfW;
      }
      if (pos.x <= halfW)
      {
        theta = 0;
        pos.x = HW;
      }
      HW+=0.05;
      w-=0.05;
      h-=0.05;
      
   
  }
 

}

