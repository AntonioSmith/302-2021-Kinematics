Bone bone = new Bone(5);
Bone draggedBone;
Bone mostRecentlyAddedBone;

void setup() 
{
  size(600, 600);
  
  //bone.child = new Bone();
  //bone.child.parent = bone; // sets child bone's parent property
}

void draw() 
{
  background(128);
  
  if (draggedBone != null) draggedBone.drag();
  bone.calc();
  bone.draw();
}

void mousePressed()
{
 //bone = new Bone(5); 
 Bone clickedBone = bone.onClick();
 
 if(Keys.SHIFT())
 {
   if (clickedBone != null)
   {
    mostRecentlyAddedBone = clickedBone.AddBone(1); 
   }
 } else // no keys held
 {
   draggedBone = clickedBone; // start dragging
 }
}

void mouseReleased()
{
 draggedBone = null; // stop dragging 
}
