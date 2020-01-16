static float bpm = 175/2;
static float beatInc = 1;
static int threshold = 100;
static int offset = -150;
static int binCount = 144;
static float defaultMass = 10;
static float defaultVMult = 0.5;
static float fillMass = 10;
static float fillVMult = 0.5;
static float fftThreshold = 1.5;
static float fftPow = 2;
static float fftAmp = 3;
static float volumeGain = -10;
static String songName = "../Music/fortress.mp3";

IColor defaultFill = new IColor(56,115,207,255);
IColor defaultStroke = new IColor(255,255,255,255);

void render() {
	cam.ang.P.y += 0.01;
}

void keyboardInput() {

}

void addEvents() {
	
}

void setSketch() {
	front = new PVector(de*2,de,de*0.2);
	back = new PVector(-de*2,-de,-de*2);
	mobs.add(new Heart(new PVector(0,0,0),de*0.5));
	float row = 10;
	float w = de*2.5;
	for (int i = 0 ; i < row ; i ++) {
		for (int k = 0 ; k < row ; k ++) {
			Poly poly = newPoly("Box",new PVector(-de+i*w/row,de,-de+k*w/row), new PVector(0,0,0),w/2/row);
			poly.fillStyleSetM(-2,-2,3,-1, i*row+k);
			mobs.add(poly);
		}
	}
}