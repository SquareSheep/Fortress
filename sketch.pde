static float bpm = 175*0.5;
static float beatInc = 1;
static int threshold = 100;
static int offset = -100;
static int binCount = 144;
static float defaultMass = 10;
static float defaultVMult = 0.5;
static float fillMass = 5;
static float fillVMult = 0.15;
static float fftThreshold = 1.5;
static float fftPow = 2;
static float fftAmp = 3;
static float volumeGain = -10;
static String songName = "../Music/fortress.mp3";

IColor defaultFill = new IColor(56,115,207,255);
IColor defaultStroke = new IColor(232,232,230,255);

CubePool cubes;
Castle castle;
Tower tower;
Heart heart;

float tick = 1;
void render() {
	if (frameCount % tick == 0) {
		if (frameCount % (castle.nofCubes*2.6*tick) < castle.nofCubes*tick*1) {
			castle.unlockNext();
		} else if (frameCount % (castle.nofCubes*2.6*tick) < castle.nofCubes*tick*2) {
			castle.lockNext();
		}
	}
	cam.ang.P.y += 0.01;
	
	if (heart.draw) {
		heart.p.P.y -= cos(frameCount/60);
		heart.sca.X = 1+avg/1000;
		if (timer.beat) heart.sca.x += 0.25;
		heart.update();
		heart.render();
	}
}

void keyboardInput() {

}

void setSketch() {
	front = new PVector(de*2,de,de*0.2);
	back = new PVector(-de*2,-de,-de*2);

	heart = new Heart(new PVector(0,-de*0.5,0), de*0.2);

	castle = new Castle(0,0,0, de*cubeW,9,9);
	castle.cubes.fillStyleSetM(-1,-1,-1,0);
	mobs.add(castle);
	
	tower = new Tower(de,0,0, de*cubeW,5,5);
	tower.cubes.fillStyleSetM(1,1,-1,0);
	tower.lockAll();
	mobs.add(tower);

	tower.cubes.fillStyleSetC(56,115,207,255, 100,-50,50,0);
}