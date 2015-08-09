import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

//-- mode variables
int MODE_WORD_FREQUENCIES = 1;
int MODE_CORRELATIONS = 2;
int displayMode;

//-- sentiment names
int NUM_SENTIMENTS = 8;
String [] sentimentNames;


//-- word frequencies
int [] sentimentColors;   // we convert from string to color with unhex() 
float [][] wordFrequencies;    // 1st index is sentiment, 2nd is the values themselves
int NUM_TIME_SLICES = 6;

float graphBoxX;
float graphBoxY;
float graphBoxWidth;
float graphBoxHeight;

boolean bDisplayOne = false;

void setup() {
  size(1440,900, OPENGL );
  
  displayMode = MODE_CORRELATIONS; 
  
  graphBoxX = 150;
  graphBoxY = 150;
  graphBoxWidth = width - (graphBoxX*2);
  graphBoxHeight = height - (graphBoxY*2);

  initWordFrequencies();
}

void draw() {
  if( displayMode == MODE_WORD_FREQUENCIES )
    drawWordFrequencies();
   else
    drawCorrelation();
}

void keyPressed() {
  if( key == ' ' ) {
     if( displayMode == MODE_WORD_FREQUENCIES )
       displayMode = MODE_CORRELATIONS;
     else
       displayMode = MODE_WORD_FREQUENCIES;
  }
  else if( key == 's' ) {
      String saveName;
     if( displayMode == MODE_WORD_FREQUENCIES ) {
       if( bDisplayOne )
        saveName = "oneWordFrequencies.png";
       else
         saveName = "allWordFrequencies.png";
       
     }
     else
       saveName = "correlations.png";
       
     save(saveName); 
  }
  else if( key == 'r' ) {
    initWordFrequencies();
  }
  else if( key == 'd' ) {
    bDisplayOne = !bDisplayOne; 
  }
}

//-- private --//

void drawWordFrequencies() {
   background(255);
   strokeWeight(1);
   
   stroke(0);
   noFill();
   line(graphBoxX, graphBoxY, graphBoxX, graphBoxY + graphBoxHeight );
   line(graphBoxX, graphBoxY + graphBoxHeight, graphBoxX + graphBoxWidth, graphBoxY + graphBoxHeight );
   
   float drawX;
   float lastDrawX = 0;
   
   float drawY;
   float lastDrawY = 0; 
  
   int numDisplay = NUM_SENTIMENTS;
   if( bDisplayOne )
      numDisplay = 1;
      
   for( int i = 0; i < numDisplay; i++ ) {
      float segmentLength = (graphBoxWidth - 2)/NUM_TIME_SLICES;
      
       for(int j = 0; j < NUM_TIME_SLICES; j++ ) {
         // make a variant based on the previous
         //drawX = wordFrequencies[i][j];
         
         // map X, according to segments
         drawX = map(j, 0, NUM_TIME_SLICES-1, graphBoxX+1, graphBoxX + graphBoxWidth-1);
         drawY = map(wordFrequencies[i][j], 0, .25, graphBoxY + graphBoxHeight-1, graphBoxY+1);
         
         if( j != 0 ) {
           stroke(sentimentColors[i]);
           strokeWeight(4);
           noFill();
           
           line( lastDrawX,  lastDrawY, drawX, drawY );
         
            noStroke();
           fill(sentimentColors[i]);
           ellipse(drawX, drawY, 4, 4);
         }
         
         lastDrawY = drawY;
         lastDrawX = drawX;
     }
   }
 }


void drawCorrelation() {
  background(0);
}


void initWordFrequencies() {
   initSentimentArray();
   initRandomFequencies();   
}

//-- names of strings and their colors
void initSentimentArray() {
   sentimentNames = new String[NUM_SENTIMENTS];
   sentimentColors = new int[NUM_SENTIMENTS];
   
   sentimentNames[0] = "Joy";
   sentimentColors[0] = #f1b336;
   
   sentimentNames[1] = "Trust";
   sentimentColors[1] = #a2b549;
   
   sentimentNames[2] = "Fear";
   sentimentColors[2] = #218e60;
    
   sentimentNames[3] = "Surprise";
   sentimentColors[3] = #56bccb;
   
   sentimentNames[4] = "Sadness";
   sentimentColors[4] = #4783c4;
    
   sentimentNames[5] = "Disgust";
   sentimentColors[5] = #b0469a;
    
   sentimentNames[6] = "Anger";
   sentimentColors[6] = #c74340;
    
   sentimentNames[7] = "Anticipation";
   sentimentColors[7] = #e67134;
}

//-- random frequencies
/*
joy,joy,0.132443776167,#66CC66
trust,trust,0.125907617901,#99FF99
fear,fear,0.129223904916,#FF9966
surprise,surprise,0.117938286604,#CCFF99
sadness,sadness,0.148897901232,#FFCC66
disgust,disgust,0.154521843175,#FFCC66
anger,anger,0.131325910092,#CC6666
anticipation,anticipation,0.0597407599119,#FFFF99
*/
void initRandomFequencies() {
   //-- first is time slices, for easier randomization
   wordFrequencies = new float[NUM_SENTIMENTS][NUM_TIME_SLICES];
   
   wordFrequencies[0][0] = 0.132443776167;
   wordFrequencies[1][0] = 0.125907617901;
   wordFrequencies[2][0] = 0.129223904916;
   wordFrequencies[3][0] = 0.117938286604;
   wordFrequencies[4][0] = 0.148897901232;
   wordFrequencies[5][0] = 0.154521843175;
   wordFrequencies[6][0] = 0.131325910092;
   wordFrequencies[7][0] = 0.0597407599119;
   
   for(int i = 1; i < NUM_TIME_SLICES; i++ ) {
     for(int j = 0; j < NUM_SENTIMENTS; j++ ) {
         // make a variant based on the previous
         wordFrequencies[j][i] = wordFrequencies[j][i-1] + random(-.05, .05);
     }
   }
}  

