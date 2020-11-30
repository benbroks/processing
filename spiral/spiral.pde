float r = 0;
float theta = 0;

float prev_x = 0;
float prev_y = 0;

int base = 400;

Table table;
float cases[];
int rowNum;
TableRow row;

void setup() {
  table = loadTable("national-history.csv", "header");
  cases = new float[table.getRowCount()];
  rowNum = 0;
  for (TableRow row : table.rows()) {
    cases[rowNum] = float(row.getInt("deathIncrease"))/10;
    rowNum += 1;
  }
  size(800, 800);
  background(255);
  r = 0;
  rowNum = 0;
}

void draw() {
  if (rowNum < table.getRowCount()) {
    float x = cases[rowNum] * cos(theta);
    float y = cases[rowNum] * sin(theta);
    if (rowNum != 0) {
      line(base+prev_x,base+prev_y,base+x,base+y);
    }
    
    // Increment the angle
    theta += 0.05;
    // Increment the radius
    r += 0.1;
    prev_x = x;
    prev_y = y;
    rowNum += 1;
  }
}

void randomDraw() {
  
  // Polar to Cartesian conversion
  float sample_r = r + randomGaussian()*r*0.1;
  float x = sample_r * cos(theta);
  float y = sample_r * sin(theta);

  // Draw an ellipse at x,y
  line(base+prev_x,base+prev_y,base+x,base+y);

  // Increment the angle
  theta += 0.01;
  // Increment the radius
  r += 0.1;
  prev_x = x;
  prev_y = y;
}
