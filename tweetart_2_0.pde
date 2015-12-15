// code by @fabiolr
// will get trending topics for chosen city, then search for tweets with those 10 keywords, and display them randomly in a nice, artfull style

import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.dynamics.contacts.*;


Box2DProcessing box2d;


// A list for fixed boundaries
ArrayList<Boundary> boundaries;
// A list for falling tweets' boxes
ArrayList<Box> boxes;

Twitter twitter;
List<Status> tweets;
ResponseList<Trends> dailyTrends;
Trend[] trend;
int currentTweet;
int currentTrend;
int currentRefresh;
int defColor = 102;
int bdColor = 122;
PFont f;



// Set location for Trending topics and failover Search Query for displayed tweets here.
String searchString = "Miami";
int woeid = 2450022; // Miami


void setup() {
    size(1200,710);
    smooth();
    // Initialize box2d physics and create the world
    box2d = new Box2DProcessing(this);
    box2d.createWorld();
    //Custom gravity
    box2d.setGravity(0, -10);
    
    // Create ArrayLists  
    boxes = new ArrayList<Box>();
    boundaries = new ArrayList<Boundary>();
  

    // Connect to Twitter, get the data 
    twitterConnect();

    getTrends();
    currentTweet = 0;
    currentTrend = 0;
    currentRefresh = 0;
    getNewTweets();
    

    thread("refreshTweets");
    thread("refreshTrends");

  addBoundaries();
  
  // Set the font
 // printArray(PFont.list());
  f = createFont("Nexa Light.otf", 14);
  textFont(f);


}



void refreshTweets() {
    while (true)
    {
        getNewTweets();
        println("Updated Tweets " + currentTweet);
        currentRefresh ++;
        delay(30000);
    }
}


void refreshTrends() {
    while (true)
    {
        getTrends();
        println("Updated Trends " + currentTrend);
        currentTrend ++;
        delay(300000);
    }
}



void getNewTweets() {
    try
    {
        searchString = trend[int(random(10))].getName();
        System.out.println(searchString);

        Query query = new Query(searchString);
        QueryResult result = twitter.search(query);
        tweets = result.getTweets();
        int remQ = twitter.getRateLimitStatus().get("/search/tweets").getRemaining();
        int remT = twitter.getRateLimitStatus().get("/trends/place").getRemaining();
        println("Remaining " + remQ + " search calls and " + remT + " trends calls");
    }
    catch (TwitterException te)
    {
        System.out.println("Failed to search tweets: " + te.getMessage());
        System.exit(-1);
    }
}

void getTrends() {
    try {
           //Trends dailyTrends = twitter.getPlaceTrends(23424977);
           Trends dailyTrends = twitter.getPlaceTrends(woeid);
           trend = dailyTrends.getTrends();
            for (int i = 0; i < 10; i++) {
             System.out.println((i+1) + " " + trend[i].getName());
            }
           
         }
    catch (TwitterException te)
    {
        System.out.println("Failed to search tweets: " + te.getMessage());
        System.exit(-1);
    }
}


void addBoundaries() {
    // Add a bunch of fixed boundaries
  
    boundaries.add(new Boundary(bdColor, width/4,height-60,width/2-200,10));  
    boundaries.add(new Boundary(bdColor, 3*width/4,height-60,width/3,10));
  
 
  
  /*
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

 */
  
  
}