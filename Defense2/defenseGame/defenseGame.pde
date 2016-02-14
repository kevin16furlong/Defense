/* a defense game using a basic tower defense stratgdgy*/

int points=0;
int Object=0;
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
 
    if(points <100 )
    {
      if (frameCount % 60 == 0)
      {
        GameObject aiship = null;
        aiship = new AiShip();
        gameObjects.add(aiship);
        Object++;
      }
    }
    else if(points > 100 && points < 500)
    {  
     if (frameCount % 30 == 0)
      {
        GameObject aiship = null;
        aiship = new AiShip();
        gameObjects.add(aiship);
        Object++;
      }
    }
    else if (points >500 && points < 1000)
    {
      if (frameCount % 15 == 0)
      {
        GameObject aiship = null;
        aiship = new AiShip();
        gameObjects.add(aiship);
        Object++;
      }
    }
    else
    {
      if (frameCount % 5 == 0 && Object<600)
      {
        GameObject aiship = null;
        aiship = new AiShip();
        gameObjects.add(aiship);
        Object++;
      }
    }


  checkCollisions();
}


// Check every bullet against every aiship
void checkCollisions()
{
  for (int i = gameObjects.size() - 1; i >= 0; i --)
  {
    GameObject go = gameObjects.get(i);
    if (go instanceof Bullet)
    {
      for (int j = gameObjects.size() - 1; j >= 0; j --)
      {
        GameObject other = gameObjects.get(j);
        if (other instanceof AiShip) // Check the type of a object
        {
          if (go.pos.dist(other.pos) < go.halfW + other.halfW)
          {
           points+=10;
           gameObjects.remove(go);
           gameObjects.remove(other);
          }
        }
      }
    }
  }
  //check if aiships have reached inner circle
  
  for (int i = gameObjects.size() - 1; i >= 0; i --)
  {
    GameObject go = gameObjects.get(i);
    if (go instanceof AiShip)
    {
      for (int j = gameObjects.size() - 1; j >= 0; j --)
      {
        GameObject other = gameObjects.get(j);
        if (other instanceof Ship) // Check the type of a object
        {
          if (go.pos.dist(other.pos) < go.halfW + other.halfW)
          {
                   
           gameObjects.remove(go);
           gameObjects.remove(other);
           
          }
        }
      }
    }
  }
  
}

