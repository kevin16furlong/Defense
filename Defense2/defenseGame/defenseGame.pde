/* a defense game using a basic tower defense stratgdgy*/

// A demo of abstract classes and interfaces

//Remove stars. Make screen bigger
void setup()
{
  size(700, 700);
  Ship ship = new Ship('A', 'D','S', width/2, height/2, color(255,0,0));
  gameObjects.add(ship);
  //AiShip aiship = new AiShip();
  //gameObjects.add(aiship);
  

}

// The class name always starts with uppercase!!
ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();

boolean[] keys = new boolean[512];

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

void draw()
{
  background(0);

  for (int i = gameObjects.size() - 1; i >= 0; i --)
  {
    GameObject go = gameObjects.get(i);
    go.update();
    go.render();
  }

  // Create aiShips 
  if (frameCount % 60 == 0)
  {
    GameObject aiship = null;
    aiship = new AiShip();
    gameObjects.add(aiship);
    
  }

  //checkCollisions();
}


// Check every bullet against every aiship
void checkCollisions()
{
/*for (int i = gameObjects.size() - 1; i >= 0; i --)
  {
    GameObject go = gameObjects.get(i);
    if (go instanceof Ship)
    {
      for (int j = gameObjects.size() - 1; j >= 0; j --)
      {
        GameObject other = gameObjects.get(j);
        if (other instanceof Powerup) // Check the type of a object
        {
          // Bounding circle collisions
          if (go.pos.dist(other.pos) < go.halfW + other.halfW)
          {
            // Do some casting
            ((Powerup) other).applyTo((Ship)go);
            gameObjects.remove(other);
          }
        }
      }
    }
  }
  */
  //Collisions between bullet and ship. If Aiship is hit with bullet, remove bullet & AiShip

  for (int i = 0; i < gameObjects.size(); i++)
  {
    GameObject aiship = gameObjects.get(i);

    if (aiship instanceof Ship)
    {
      for (int j = 0; j < gameObjects.size(); j++)
      {
        GameObject bullet = gameObjects.get(j);
        if(bullet instanceof Bullet)
        {
          //if bullet distance
          if(aiship.pos.dist(bullet.pos) < aiship.halfW)
          {
            //Casting from GameObject to Ship
            gameObjects.remove(aiship);
            gameObjects.remove(bullet);
          }
        }
      }
    }
  }
}

