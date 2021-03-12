class Bone 
{  
  // properties?
  
  // relative direction the bone points, radians
  // if 0, then this bone points same way as parent
  float dir = random(-1, 1);
  
  // the length of the bone, in pixels
  float mag = 100;
  
  // references to parent and child bones
  // implementing linked list
  Bone parent;
  ArrayList<Bone> children = new ArrayList<Bone>();
  
  // cached / derived values:
  PVector worldStart; // start of bone in world space
  PVector worldEnd; // end of bone in world space
  float worldDir = 0; // world-space angle of the bone
  
  Bone(){}
  Bone(int chainLength)
  {
     if (chainLength > 1)
     {
      AddBone(chainLength - 1);
     }
  }
  
  Bone AddBone(int chainLength)
  {
    if (chainLength < 1) chainLength = 1;
    
    Bone newBone = new Bone();    
    children.add(newBone);    
    newBone.parent = this;
    
    if (chainLength > 1)
    {
     newBone.AddBone(chainLength - 1); 
    }
    return newBone;
  }
  
  void removeFromParent()
  {
   if (parent 
  }
  
  void draw()
  {
    // draw line from bone start to bone end 
    line(worldStart.x, worldStart.y, worldEnd.x, worldEnd.y);
    
    fill(100, 100, 200);
    ellipse(worldStart.x, worldStart.y, 20, 20);
    
    for(Bone child : children) child.draw();
    
    fill(150, 150, 255);
     ellipse(worldEnd.x, worldEnd.y, 10, 10);
  }
  
  void calc()
  {
   // calc bone start
   
   if (parent != null)
   {
      worldStart = parent.worldEnd;
      worldDir = parent.worldDir + dir;
   } else // if no parent, use default values
   {   
     // if parent, then "worldDir" = "parent.worldDir" + "dir"
     // else:
     worldStart = new PVector(100, 100);
     worldDir = dir;
   }
   
   // calc bone end
   PVector localEnd = PVector.fromAngle(worldDir);
   localEnd.mult(mag);
   
   worldEnd = PVector.add(worldStart, localEnd);
   
   for(Bone child : children) child.calc();
  }
  
  Bone onClick()
  {
    PVector mouse = new PVector(mouseX, mouseY);
    PVector vToMouse = PVector.sub(mouse, worldEnd); // mouse - worldEnd
    if (vToMouse.magSq() < 20 * 20) return this; // if disToMouse < 20px, retun this bone
    
    // checks all child bones:
    for (Bone child : children) 
    {
     Bone b = child.onClick(); 
     if (b != null) return b;
    }
    
    return null;
  }
  
  void drag()
  {
     PVector mouse = new PVector(mouseX, mouseY);
     PVector vToMouse = PVector.sub(mouse, worldStart);
     
     if (parent != null) 
     {
     dir = parent.worldDir - vToMouse.heading(); //atan2(vToMouse.y, vToMouse.x);
     } else
     {
       dir = vToMouse.heading(); // root bone can point right at mouse
     }
     
     mag = vToMouse.mag();
     
  }
}
