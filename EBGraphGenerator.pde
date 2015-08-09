import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

//-- mode variables
int MODE_WORD_FREQUENCIES = 1;
int MODE_CORRELATIONS = 2;
int displayMode;

int NUM_SENTIMENTS = 8;

String [] sentimentNames;
int [] sentimentColors;   // we convert from string to color with unhex() 
float [][] wordFrequencies;    // 1st index is sentiment, 2nd is the values themselves

void setup() {
  size(1440,900, OPENGL );
  
  displayMode = MODE_CORRELATIONS; 
  
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
     if( displayMode == MODE_WORD_FREQUENCIES )
       saveName = "wordFrequencies.png";
     else
       saveName = "correlations.png";
       
     save(saveName); 
  }
}

//-- private --//

void drawWordFrequencies() {
  background(255);
  
  int drawX = 50;
   strokeWeight(2);
   
   for( int i = 0; i < NUM_SENTIMENTS; i++ ) {
     
      println(sentimentNames[i]);
      println( sentimentColors[i] );
      
      stroke(sentimentColors[i]);
       line( drawX,  60 + (i * 50), drawX + 50, 60 + (i * 50) );
  }
}

void drawCorrelation() {
  background(0);
  
}

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
void initWordFrequencies() {
   initSentimentArray();
   
     
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


