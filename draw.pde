

void draw() {
    
    color boxColor = color(int(random(160,190)), 30);
    int tweetColor = int(random (70,190));
    if (tweetColor > 160) {
     boxColor = color(int(random(60,110)), 30);
    } else if (tweetColor < 110) {
     boxColor = color(int(random(170,200)), 30);
    } else {
     boxColor = color(int(random(190,210)), 30);
    }
    // stepping...
  box2d.step();
  
  background(defColor);

// loops thru tweets so we get a random one among the query result each time
    currentTweet = currentTweet + 1;
    if (currentTweet >= tweets.size()) {
        currentTweet = 0;
        }
    Status status = tweets.get(currentTweet);
    
  
// tweet spawns every so often, increase constant to increase density.
  if (random(1) < 0.01) {
    Box p = new Box(tweetColor, boxColor, status.getText(),width/2,30);  // position of spawn spot
    boxes.add(p);
  }
  
  // Display  boundaries
  
  
  // Left Floor + Edge
  boundaries.add(new Boundary(bdColor, width/4,height-10,width/2-50,10));  
  boundaries.add(new Boundary(bdColor, (width/4)-(width/2-60)/2,height-60,10,100));
  
  
  // Right Floor + Edge
  boundaries.add(new Boundary(bdColor, 3*width/4,height-60,width/2-50,10));
  boundaries.add(new Boundary(bdColor, (3*width/4)+(width/2-60)/2,height-110,10,100));

// center nose
  boundaries.add(new Boundary(bdColor, (width/2),height/2,10,10));
  boundaries.add(new Boundary(bdColor, (width/2+10),height/2-10,10,10));
  boundaries.add(new Boundary(bdColor, (width/2-10),height/2-10,10,10));

// eyes
  boundaries.add(new Boundary(bdColor, (width/3),height/2-100,30,10));
  boundaries.add(new Boundary(bdColor, (2*width/3),height/2-100,30,10));
  
  
    // Display  boxes
  for (Box b: boxes) {
    b.display();
  }

  
  // Show current trending
    for (Boundary wall: boundaries) {
    wall.display();
  }
  
  

text(trend[1].getName(), 20, 20);
text(trend[2].getName(), 20, 35);
text(trend[3].getName(), 20, 50);
text(trend[4].getName(), 20, 65);
text(trend[5].getName(), 20, 80);
text(trend[6].getName(), 20, 95);
text(trend[7].getName(), 20, 110);
text(trend[8].getName(), 20, 125);
text(trend[9].getName(), 20, 140);
text(trend[0].getName(), 20, 155);




  // Delete boxes that left screen, from box2d and list
  for (int i = boxes.size()-1; i >= 0; i--) {
    Box b = boxes.get(i);
    if (b.done()) {
      boxes.remove(i);
    }
  }


  /*
    fill(200);
    text(status.getText(), random(width), random(height), 300, 100);
    //text(trend[1].getName(), random(width-300), random(height-150), 300, 200);
    //text(trend[int(random(10))].getName(), random(width), random(height), 300, 200);

    delay(1000);
    */
    
}