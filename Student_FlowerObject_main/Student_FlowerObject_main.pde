Object smallObject, largeObject;  // the first instance of the Flower class

void setup() {
  size(800, 800);

  float _size1 = 40;
  float _size2 = 150;
  float _x1 = random(0 + width/5, width-width/5);
  float _y1 = random(0 + height/5, height-height/5);
  float _x2 = random(0 + width/5, width-width/5);
  float _y2 = random(0 + height/5, height-height/5);
  boolean _mouseControlled = true;

  rectMode(CENTER);

  smallObject = new Object(_x1, _y1, _size1, 5); 
  largeObject = new Object(_x2, _y2, _size2, 1, _mouseControlled);
}

void draw() {
  background(0);

  smallObject.display();
  smallObject.move(/*2*/);  //Denne løsning virkede ikke da den i draw hele tiden satte valuen af blomstens speed tilbage til 2 selv når den nåede til hvor den skulle "bounce", altså reverse sin speed.
  largeObject.display();
  largeObject.move(/*5*/);
  
  smallObject.bounce(largeObject);
}
