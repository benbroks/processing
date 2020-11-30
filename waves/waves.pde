float surfaceHeights[];
float surfaceSpeeds[];
float surfaceAcc[];

float leftDeltas[];
float rightDeltas[];



float surfaceEpsilon = 2;
float spread = 0.5;
float springStiffness = 0.01;
float dampeningFactor = 0.015;
int size = 900;
int numSprings = int(size/surfaceEpsilon);
int restingSpringSize = size*3/4;



void setup() {
  size(900,900);
  surfaceHeights = new float[numSprings];
  surfaceSpeeds = new float[numSprings];
  leftDeltas = new float[numSprings];
  rightDeltas = new float[numSprings];
  surfaceAcc = new float[numSprings];
  
  initSurf();
}

void draw() {
  background(255);
  propagate();
  update();
  drawSurf();
}

void initSurf() {
  for(int i = 0; i < numSprings; i++) {
    surfaceHeights[i] = restingSpringSize;
    surfaceSpeeds[i] = 0;
    rightDeltas[i] = 0;
    leftDeltas[i] = 0;
    surfaceAcc[i] = 0;
  }
}

void drawSurf() {
  for(int i = 0; i < numSprings; i++) {
    if ((i%2) == 0) {
      ellipse((i+0.5)*surfaceEpsilon,size-surfaceHeights[i],surfaceEpsilon,surfaceEpsilon);
    }
  }
}


void update() {
  for(int i = 0; i < numSprings; i++) {
    surfaceHeights[i] += surfaceSpeeds[i];
    surfaceSpeeds[i] += surfaceAcc[i];
    surfaceAcc[i] = -1*springStiffness*(surfaceHeights[i]-restingSpringSize) - dampeningFactor*surfaceSpeeds[i];
  }
}

void propagate() {
  for (int j = 0; j < 2; j++) {
    for (int i = 0; i < numSprings; i++) {
      if (i > 0) {
        leftDeltas[i] = spread * (surfaceHeights[i] - surfaceHeights[i-1]);
        surfaceSpeeds[i-1] += leftDeltas[i];
      }
      if (i < numSprings-1) {
        rightDeltas[i] = spread * (surfaceHeights[i] - surfaceHeights[i+1]);
        surfaceSpeeds[i+1] += rightDeltas[i];
      }
    }
    for (int k = 0; k < numSprings; k++) {
      if (k > 0) {
        surfaceHeights[k-1] += leftDeltas[k];
      } 
      if (k < numSprings-1) {
        surfaceHeights[k+1] += rightDeltas[k];
      }
    }
  }
}

void mouseClicked() {
  int particle = int(mouseX/surfaceEpsilon);
  if ((particle%2)!=0) {
    particle += 1;
  }
  surfaceSpeeds[particle] = -15;
  
}
