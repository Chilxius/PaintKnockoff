//Bennett Ritchie
//Knock-off Paint

boolean isCircle;
float penSize;
float red, green, blue;

PImage savedSection;

void setup()
{
  //Height was chosen to make color ribbons simpler
  size(800, 512);
  background(255);
  noStroke();
  
  //Pen can change from circle to square
  isCircle = true;
  penSize = 30;
  
  //Initialize all colors to zero
  red = green = blue = 0;
}

void draw()
{
  drawPen();
  drawHUD();
}

void drawPen()
{
  //Keep from drawing when cursor is over the HUD
  if(mousePressed && mouseX > 99 && mouseY > 34 )
  {
    fill(red,green,blue);
    rectMode(CENTER);
    noStroke();
    
    if( isCircle )
      circle(mouseX, mouseY, penSize);
    else
      square(mouseX, mouseY, penSize); 
  }
}

void drawHUD()
{
  rectMode(CORNER);
  noStroke();
  
  //Drawing the color ribbons
  for( int i = 0; i < height; i++ )
  {
    //Red Ribbon
    fill( 255-i, 0, 0 );
    rect( 0, i*2, 33, 2 );
    
    //Green Ribbon
    fill( 0, 255-i, 0 );
    rect( 33, i*2, 33, 2 );
    
    //Blue Ribbon
    fill( 0, 0, 255-i );
    rect( 66, i*2, 33, 2 );
  }
  
  //Draw ribbon sliders
  noFill();
  stroke(0);
  strokeWeight(2);
  
  rect(1,  height-red*2-1,   30, 3);
  rect(34, height-green*2-1, 30, 3);
  rect(67, height-blue*2-1,  30, 3);
  
  //Draw top HUD box
  strokeWeight(4);
  fill(220);
  rect(100,2,width-102,30);
  line(130,0, 130,30);
  
  //Draw color indicator
  fill(red,green,blue);
  if(isCircle)
    circle(115,17,30);
  else
    rect(100,2,30,30);
  
  //Draw the size-change indicator
  strokeWeight(1);
  line(137,27,137,22);
  line(140,27,140,20);
  line(143,27,143,18);
  line(146,27,146,16);
  line(149,27,149,14);
  line(152,27,152,12);
  line(155,27,155,10);
  
  //Draw size bar and slider
  strokeWeight(4);
  line(165,17, 785,17); //620 long
  line(165 + penSize, 10, 165+penSize, 24);
}

void keyPressed()
{
  //Save screenshot
  if( key == 's' )
  {
    savedSection = get(99,35,width-99,height-35);
    savedSection.save("snapshot_" + year() + "_" + month() + "_" + day() + "_" + hour() + "_" + minute() + "_" + second() + ".jpg");
  }
  //Change paintbrush shape
  if( key == ' ' )
    isCircle = !isCircle;
}

void mousePressed()
{
  if( mouseX < 33 ) //Red ribbon
  {
    red = (height - mouseY) / 2;
  }
  else if( mouseX < 66 && mouseX >= 33 ) //Green ribbon
  {
    green = (height - mouseY) / 2;
  }
  else if( mouseX < 99 && mouseX >= 66 ) //Blue ribbon
  {
    blue = (height - mouseY) / 2;
  }
  
  //Mouse is over the size slider
  if( mouseY < 30 && mouseX > 165 && mouseX < 785 )
    penSize = mouseX-165;
}
