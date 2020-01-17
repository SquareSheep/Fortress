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
	heart.p.P.y -= cos(frameCount/60);
	if (castle.draw) castle.render();
	if (heart.draw) heart.render();
	if (tower.draw) tower.render();
}

void keyboardInput() {

}

void addEvents() {
	
}

void setSketch() {
	front = new PVector(de*2,de,de*0.2);
	back = new PVector(-de*2,-de,-de*2);



	castle = new Castle(0,0,0, de*cubeW,13,13);
	float amp = 0.01;
	float amp2 = 3;
	for (int i = 0 ; i < castle.nofCubes ; i ++) {
		castle.cubes.add(random(-de,de),random(-de,de),random(-de,de),de*cubeW, random(-PI,PI),random(-PI,PI),random(-PI,PI));
		Cube cube = castle.cubes.getLast();
		cube.av.reset(random(-amp,amp),random(-amp,amp),random(-amp,amp));
		cube.pv.reset(random(-amp2,amp2),random(-amp2,amp2),random(-amp2,amp2));
		cube.fillStyle.setM(-1,-1,-0.5,0, i%binCount);
	}
	castle.draw = false;
	mobs.add(castle);

	heart = new Heart(new PVector(0,-de*0.35,0), de*0.2);
	mobs.add(heart);
	
	tower = new Tower(de,0,0, de*cubeW,5,5);
	amp = 0.01;
	amp2 = 3;
	for (int i = 0 ; i < tower.nofCubes ; i ++) {
		tower.cubes.add(random(-de,de),random(-de,de),random(-de,de),de*cubeW, random(-PI,PI),random(-PI,PI),random(-PI,PI));
		Cube cube = tower.cubes.getLast();
		cube.av.reset(random(-amp,amp),random(-amp,amp),random(-amp,amp));
		cube.pv.reset(random(-amp2,amp2),random(-amp2,amp2),random(-amp2,amp2));
		cube.fillStyle.setM(-1,-1,-0.5,0, i%binCount);
	}
	tower.lockAll();
	tower.draw = false;
	mobs.add(tower);
}