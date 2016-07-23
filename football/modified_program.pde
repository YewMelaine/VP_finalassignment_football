//import the Processing minim library
import ddf.minim.*;
//Declare a audio player
AudioPlayer player;
Minim minim;
boolean STARTGAME = false;
float x =370;
float y = 220;
float xAxis = 5;
float yAxis = 5;
int score1=0;
int score2=0;
int lives=3; 
boolean lost=false;
int player1= 200;
int player2= 200;
//Declare Images
PImage football;
PImage goal1;
PImage goal2;
PImage field;
void setup(){
size(800,500);
smooth();
fill(0);
textFont(createFont("SansSerif",18));
textAlign(400,400);
//Load images
football = loadImage("football.png");
goal1= loadImage("goal.png");
goal2= loadImage("goal2.png");
field = loadImage("field.png");
//Initialize the audio player
minim = new Minim(this);
player = minim.loadFile("Angry Emotional Instrumental.mp3", 2048);
player.play();
}
void draw() {
background(56,145,67);
image(field,0,10,800,500);
fill (255,0,0);
text("Press 'Space Bar' to start/pause",290,20);
text("lives = "+lives,385,35);
fill (247,147,29);
text("score 1 = "+score1,20,20);
fill (56,171,249);
text("score 2 = "+score2,680,20);
//football
image(football, x, y, football.width/12, football.height/12);
//player1
image(goal1,0,player1,20,100);
//player2
image(goal2,780,player2,20,100);
//Players' controls
if (keyPressed){
if (key == 'W' || key == 'w') {player1 = player1 -10;}
if (key == 'S' || key == 's') {player1 = player1 +10;}
if (keyCode == UP) {player2 = player2 -10;}
if (keyCode == DOWN) {player2 = player2 +10;}
}
//Players' border
if (player1 < 0) {player1 = 0;}
if (player1 > 400) {player1 = 400;}
if (player2 < 0) {player2 = 0;}
if (player2 > 400) {player2 = 400;}
if (STARTGAME){ 
//starting point
x = x+xAxis;
y = y+yAxis;
// if ball hits player1's goal, change direction
if (x < 25 && x > 0 && y > player1-100 && y < player1 +100 ){
xAxis = xAxis * -1; // speed it bounces off wall
x = x + xAxis; // direction it bounces off wall
score1=score1+10;//increase the score when hits the goal
}// if ball hits player2's goal, change direction
else if ( x > 730 && x < 800 && y > player2-100 && y < player2 +100) {
xAxis = xAxis * -1;
x = x + xAxis;
score2=score2+10;
}//if ball never hit both of the goals
else if (x>800 || x<0){
lives=lives-1;//lives will decrease
STARTGAME = false;//restart the game
x = 370;
y = 220;
}
}
//no more lives, show the scores 
if (lives<=0) {
background(100);
fill(255,0,0);
textSize(20);
text("Press 'Space Bar' to restart.", 272, 380);
text("Player 1's score: "+score1, 310, 290);
text("Player 2's score: "+score2, 310, 310);
textSize(50);
if (score1>score2){
fill (247,147,29);
text("Player 1 wins!", 248, 150);
}else if(score2>score1){
fill (56,171,249);
text("Player 2 wins!", 248, 150);
}else{
textSize(36);
text("Draw!", 345, 150);
lost=true;
lives=0;
}
}
// if ball hits top or bottom, change Y
if ( y > 500 || y < 0 ) {
yAxis = yAxis * -1; // speed it bounces off top or bottom
y = y + yAxis; // direction off top or bottom
}
}
//When press 'Space Bar' 
void keyPressed(){
if (key == ' '){
STARTGAME = !STARTGAME;//game start or pause
if (lost==true){
STARTGAME = false;
textFont(createFont("SansSerif",18));
x = 370;
y = 220;
score1=0;
score2=0;
lives=3; 
lost=false;
player1= 200;
player2= 200;
loop(); 
}
}
}
//stop the audio 
void stop(){
player.close();
minim.stop();
super.stop();
}
