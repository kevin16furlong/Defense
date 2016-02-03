/* a defense game using a basic tower defense stratgdgy*/

// A demo of abstract classes and interfaces

//Remove stars. Make screen bigger
void setup()
{
  size(700, 700);
  Ship ship = new Ship('A', 'D','S', 350, height-50, color(0, 255, 255));
  gameObjects.add(ship);
 // AiShip aiship = new AiShip();
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

  /*// Create a powerup every second
  if (frameCount % 60 == 0)
  {
    GameObject powerup = null;
    int i = (int) random(0, 2);
    switch (i)
    {
    case 0:
      //powerup = new AmmoPowerup();
      break;
    case 1:
   //   powerup = new LivesPowerup();
      break;
    }
    gameObjects.add(powerup);
  }

  //checkCollisions();
}
*/
/*
// Check every ship against every powerup
void checkCollisions()
{
  for (int i = gameObjects.size() - 1; i >= 0; i --)
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
  
/*  //Collisions between bullet and ship. If ship is hit with bullet, ship lives decreases, remove bullet

  for (int i = 0; i < gameObjects.size(); i++)
  {
    GameObject ship = gameObjects.get(i);

    if (ship instanceof Ship)
    {
      for (int j = 0; j < gameObjects.size(); j++)
      {
        GameObject bullet = gameObjects.get(j);
        if(bullet instanceof Bullet)
        {
          //if bullet distance less ta
          if(ship.pos.dist(bullet.pos) < ship.halfW)
          {
            //Casting from GameObject to Ship
            ((Ship) ship).lives--;
            gameObjects.remove(bullet);
          }
        }
      }
    }
  }*/
}

