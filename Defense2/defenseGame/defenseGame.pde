/* a defense game using a basic tower defense stratgdgy*/

//add in last played points
//find music
//fix exceptions on mutiple objects

int points=0;
int Object=0;
int set;
int mode = 0;
int lastPoints=0;
void setup()
{
  for(int i= gameObjects.size() -1 ;i>0;i--)
  {
    gameObjects.get(i);
    gameObjects.remove(i);  
  }
  
  set=0;
  points=0;
  size(600, 600);
  
  Ship ship = new Ship('A', 'D','S', width/2, height/2, color(255,0,0));
  gameObjects.add(ship);
 
  
}

ArrayList<GameObject> gameObjects = new ArrayList<GameObject>();
boolean[] keys = new boolean[512];

void keyPressed()
{
  keys[keyCode] = true;
  
  if (key >= '0' && key <='5')
  {
    mode = key - '0';
  }
  
}

void keyReleased()
{
  keys[keyCode] = false;
}

void draw()
{
  background(0);
  //may not be working as attempted.
  for (int i = gameObjects.size() - 1; i >= 0; i --)
  {
    GameObject go = gameObjects.get(i);
    
      go.update();
      go.render();
    
  }
  if(set==0)
  {
    
    Home();
  }
  switch(mode)
  {
    case 0:
    {
      Home();
      break;
    }
    case 1:
    {
     
      playGame();
      break;
    }
    case 3:
    {
      endGame();
      break;
    }

}
}
//print home screen
void Home()
{

  text("  Defense  ",X,Y+100);
  text("S to shoot",X,Y+20);
  text("A to Rotate left",X,Y+40);
  text("D to Rotate Right",X,Y+60);
  text("  Press 1 to play Game",X,Y+120);
  text("Last points ",X+500,Y+40);
  text(lastPoints, X+565,Y+40); 
  set=1;
  

}
void endGame()
{
  
     for (int i = gameObjects.size() - 1; i >= 0; i --)
  {
    GameObject go = gameObjects.remove(i);
    
      go.update();
      go.render();
    
  }
    text("  Defense  ",X+250,Y+250);
    text("  Game Over  ",X+250,Y+270);
    text("  End Points =  ",X+250,Y+290);
    text(points, X+400,Y+290);
    text("  Press 1 to play a New Game",X,Y+120);
    lastPoints=points;
    set=1;
    if (frameCount % 240 == 0)
    {
      mode=0;
      setup();
    }
}

//game mode
void playGame()
{
  // Create aiShips 
 if(Object < 100){ 
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
      if (frameCount % 10 == 0 && points > 1000)
      {
        GameObject aiship = null;
        aiship = new AiShip();
        gameObjects.add(aiship);
        Object++;
      }
    }
 }
 checkCollisions();
}

// Check every bullet against aiships and collision with ship
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
           Object--;
          }
        }
      }
    }
  }
  //check if aiships have reached inner circle
  
  for (int i = gameObjects.size() - 1; i >= 0; i --)
  {
    GameObject go = gameObjects.get(i);
    if (go instanceof Ship)
    {
      for (int j = gameObjects.size() - 1; j >= 0; j --)
      {
        GameObject other = gameObjects.get(j);
        if (other instanceof AiShip) // Check the type of a object
        {
          if (go.pos.dist(other.pos) < go.halfW + other.halfW)
          {
            gameObjects.remove(go);
            gameObjects.remove(other);
            mode=3;         
          }
        }
      }
    }
  }
  
}

