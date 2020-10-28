int totalBalls = 12; //amount of balls on screen
Ball[] balls = new Ball[totalBalls];//Array to manage totalBalls
float targetX, targetY;
int width, height;
 
void setup() {
    width = 500;
    height = 550;
    size(500, 550);
    noStroke();
    smooth();
    background(0);
    targetX = width / 2;
    targetY = height / 2;
    fill(color(255, 0, 0));
    for (int i = 0; i < totalBalls; i++) {
        Ball ball = new Ball(); //Constructor for balls
        ball.x = random(width);
        ball.y = random(height);
        ball.vx = random(10) - 5; //Velocity X deducts by 5 for every hit
        ball.vy = random(10) - 5; //Velocity Y deducts by 5 for every hit
        ball.radius = width * .05;
        balls[i] = ball; //Insert in array
    }
};
 
void draw() {
    background(0);
    fill(color(255, 0, 0));
    for (int i = 0; i < totalBalls; i++) {
        balls[i].x += balls[i].vx; //Updating X position based on X velocity
        balls[i].y += balls[i].vy; //Updating Y position based on Y velocity
        checkWallCollision(balls[i]); //Checking walls
        balls[i].render(); //Drawing circles
    }
    //Checking for each ball colliding
    for (int i = 0; i < totalBalls; i++) { //Checks which ball collided
        for (int j = i + 1; j < totalBalls; j++) { //Increase velocity of knocked ball 
            float dx = balls[j].x - balls[i].x;
            float dy = balls[j].y - balls[i].y;
            float dist = sqrt(dx * dx + dy * dy);
            if (dist < (balls[j].radius + balls[i].radius)) {
                // Balls make contact so push back
                float normalX = dx / dist;
                float normalY = dy / dist;
                float midpointX = (balls[i].x + balls[j].x) / 2;
                float midpointY = (balls[i].y + balls[j].y) / 2;
                balls[i].x = midpointX - normalX * balls[i].radius;
                balls[i].y = midpointY - normalY * balls[i].radius;
                balls[j].x = midpointX + normalX * balls[j].radius;
                balls[j].y = midpointY + normalY * balls[j].radius;
                float dVector = (balls[i].vx - balls[j].vx) * normalX;
                dVector += (balls[i].vy - balls[j].vy) * normalY;
                float dvx = dVector * normalX;
                float dvy = dVector * normalY;
                balls[i].vx -= dvx;
                balls[i].vy -= dvy;
                balls[j].vx += dvx;
                balls[j].vy += dvy;
            }
        }
    }
};
 
void checkWallCollision(Ball ball) { //Creating wall boundaries
          if (ball.x < ball.radius) { //Bounces when radius hits wall
        ball.x = ball.radius; //Bounce back
        ball.vx *= -1; //Move in opposite direction
        //Left wall boundaries
    }     if (ball.x > width - (ball.radius)) {
        ball.x = width - (ball.radius);
        ball.vx *= -1;
        //Right wall boundaries
    }     if (ball.y < ball.radius) {
        ball.y = ball.radius;
        ball.vy *= -1;
        //Roof boundaries
    }     if (ball.y > height - (ball.radius)) {
        ball.y = height - (ball.radius);
        ball.vy *= -1;
        //Floor boundaries
    }
}
 
class Ball {
  float x = 0;
  float y = 0;
  float vx = 0;
  float vy = 0;
  float gravityX = 0;
  float gravityY = 0;
  float radius = 5.0;
 
  void render() {
      ellipse(this.x, this.y, this.radius * 2, this.radius * 2);
  }
}
