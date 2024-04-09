boolean clicked = false;  // Flag to track click event
float width = 400;
float height = 400;
float acceleration = 9.8; // Adjusted to realistic value
float restitution = 0.8;  // Adjusted for bounce energy loss
float dt;  // Time variable

void setup() {
  size(400, 400);
  smooth();
  frameRate(60);  // Set frame rate to 60 frames per second
  dt = millis();  // Initialize dt to current time
}

class Ball {
  float mass,  // Renamed from 'm' to 'mass'
        y,
        x,
        velocity,
        tot;

  Ball(float massValue, float xPos, float yPos) {
    mass = massValue;
    x = xPos;
    y = yPos;
    velocity = 0;  // Initial velocity
    tot = 0;       // Initial total displacement
  }

  void update(float deltaTime) {
    // Update velocity and position based on acceleration
    velocity += acceleration * deltaTime / 1000.0; // Convert milliseconds to seconds
    float displacement = velocity * deltaTime / 1000.0; // Convert milliseconds to seconds
    tot += displacement;
    y += displacement;

    // Check for collision with the floor
    if (y >= height - 15) { // Assuming radius of the ball is 15
      y = height - 15;  // Set the ball just above the floor
      velocity *= -restitution; // Reverse the velocity with some energy loss
    }

    // Limit y position to stay within screen boundaries
    y = constrain(y, 0, height);
  }
}

Ball ball;  // Only one ball needed

void draw() {
  background(220);

  // Calculate time difference since the last frame
  float currentTime = millis();
  float deltaTime = currentTime - dt;
  dt = currentTime;  // Update dt for the next frame

  if (clicked) {
    ball.update(deltaTime);
    drawBall(ball);
  }
}

void mousePressed() {
  clicked = !clicked;  // Toggle click state
  if (clicked) {
    dt = millis();  // Reset dt for accurate time tracking
    ball = new Ball(30, mouseX, mouseY);
  }
}

void drawBall(Ball ball) {
  ellipse(ball.x, ball.y, 30, 30); // Draw the ball
}
