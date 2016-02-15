class Ship extends GameObject
{
  char left;
  char right;
  char fire;
  int lives;
  Ship()
  {
    super(width * 0.5f, height  * 0.5f, 50);     
  }
  
  Ship(char left, char right, char fire, float startX, float startY, color c)
  {
    super(startX, startY, 50);
    
    this.left = left;
    this.right = right;
    this.fire = fire;
    this.c = c; 
  }

  int elapsed = 12;
  
  void update()
  {
    forward.x = sin(theta);
    forward.y = - cos(theta);
    forward.mult(speed);
        
    if (keys[left])
    {
      theta -= 0.1f;
    }
    if (keys[right])
    {
      theta += 0.1f;
    }      
    if (keys[fire]  && elapsed > 12)  // && ammo > 0)
    {
      // Create a new bullet instance and add it to the arraylist of bullets
      Bullet bullet = new Bullet();
      bullet.pos.x = pos.x;
      bullet.pos.y = pos.y;
      bullet.pos.add(PVector.mult(forward, 6));
      bullet.c = c;
      bullet.theta = theta;
      gameObjects.add(bullet);
      elapsed = 0;
      
    }
    
    if (pos.x < 0)
    {
      pos.x = width;
    }
    
    if (pos.x > width)
    {
      pos.x = 0;
    }
    
    if (pos.y < 0)
    {
      pos.y = height;
    }
    
    if (pos.y > height)
    {
      pos.y = 0;
    }
    elapsed ++;
  }
  
  void render()
  {
    pushMatrix(); // reset the translation and rotation
    translate(pos.x, pos.y);
    stroke(c);
    fill(0,0,0);
    fill(c);
    text("Points: " + points, 10, 5); 
    rotate(theta); 
     
    line(- halfW, halfW, 0, - halfW);
    line(0, - halfW, halfW, halfW);
    line(halfW, halfW, 0, 0);
    line(- halfW, halfW, 0, 0);
    
    popMatrix();
  }   
}
