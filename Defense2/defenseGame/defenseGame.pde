/* a defense game using a basic tower defense stratgdgy*/

//sort out exceptions   can be a problem at times but game tends to work fine some of the time

//find music??  decided due to not being able to find a track i thought would be good to use, to leave out this function


//inputs
import java.io.File;
import java.io.IOException;

//variables
int points;
int Object = 0;
int set;
int mode = 0;
int lastPoints = 0;
int high = 0;
int []data;

//setup method
void setup()
{
  // Load text file as a string
 loadData();
  
  set = 0;
  points = 0;
  size(600, 600);
  
  Ship ship = new Ship('A', 'D','S', width/2, height/2, color(255,0,0));
  gameObjects.add(ship);
 
  
}
//arrays for objects and booleans for key pressed
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
//draw method
void draw()
{
  background(0);
  for (int i = gameObjects.size() - 1; i >= 0; i --)
  {
    GameObject go = gameObjects.get(i);
    
      go.update();
      go.render();
    
  }
  
  if(set==0)
  {
    //call the home screen
    Home();
  }
  //switch method to swap between game screens
  switch(mode)
  {
    case 0:
    {
      Home();
      break;
    }
    case 1:
    {
     //calls the play game method
      playGame();
      break;
    }
    case 3:
    {
      //ends the game, saves the high score, reverts back to home screen
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
  text("High Score ",X+500,Y+40);
  if(lastPoints<high)
  {
    lastPoints=high;
  }
  text(lastPoints, X+565,Y+40); 
  set=1;
  

}
//end game method
void endGame()
{
  //loop to remove objects
   for (int i = gameObjects.size() - 1; i >= 0; i --)
  {
    GameObject go = gameObjects.remove(i);
    Object--;
      go.update();
      go.render();
    
  }
    //prints text
    text("  Defense  ",X+250,Y+250);
    text("  Game Over  ",X+250,Y+270);
    text("  End Points =  ",X+250,Y+290);
    text(points, X+400,Y+290);
    text("  Press 1 to play a New Game",X,Y+120);
     
  //checks if high score was reached
    if(points > lastPoints)
    {
      lastPoints=points;
      
      for(int i=0;i<data.length;i++)
      {
        if(i==data.length-1)
        {
          data[i]=lastPoints;
        }
      }
      //calls the save method
      save();
      
      
    }
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
  text("High Score ",X+500,Y+40);
  text(lastPoints, X+565,Y+40);
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

// Check every bullet against aiships 
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
  //check if aiships have reached ship
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

//loads in the previous high score allowing for mutiple inputs to be in the file
void loadData()
{
  // Load text file as a string
  String[] score = loadStrings("data.txt");
  println(score);
  // Convert string into an array of integers using ',' as a delimiter 
     data = int(split(score[0], ','));
     
     println(data);
   
   for (int i = 0; i < data.length; i++) 
   {
     if(data[i]>high)
     {
       high=data[i];
     }
   } 

}
//saves to the data file
void save()
{
  int temp=0;
  for(int j =  data.length-1;j>0;j--)
    {
      if(data[j]>data[j-1])
      {
        temp=data[j];
        data[j-1]=data[j];
        data[j-1]=temp;
      }
    }
    println(data);
   
  String x[] = str(data);
   saveStrings("data/data.txt", x);
 
}
