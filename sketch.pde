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
static float volumeGain = -25;
static String songName = "../Music/fortress.mp3";

IColor defaultFill = new IColor(56,115,207,255);
IColor defaultStroke = new IColor(255,255,255,255);

static float cubeW;

void render() {
}

void keyboardInput() {

}

void addEvents() {
	
}

void setSketch() {
	front = new PVector(de*2,de,de*0.2);
	back = new PVector(-de*2,-de,-de*2);
	cubeW = de*0.1;
	mobs.add(new Castle(new PVector(0,0,0), cubeW));
}