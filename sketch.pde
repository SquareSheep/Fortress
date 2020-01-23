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
Tower castle;
Tower tower;
Tower tower2;
Heart heart;

ArrayList<BuildingGrid> notes = new ArrayList<BuildingGrid>();
ArrayList<BuildingGrid> stabs = new ArrayList<BuildingGrid>();
ArrayList<BuildingGrid> stabs2 = new ArrayList<BuildingGrid>();
ArrayList<BuildingGrid> piano = new ArrayList<BuildingGrid>();
ArrayList<BuildingGrid> pulses = new ArrayList<BuildingGrid>();
ArrayList<BuildingGrid> floaters = new ArrayList<BuildingGrid>();


void render() {
	if (heart.draw) {
		heart.p.P.y -= cos(frameCount/60);
		heart.sca.X = 1+avg/1000;
		if (timer.beat && heart.beat) heart.sca.x += 0.25;
		heart.update();
		heart.render();
	}
}

void setSketch() {
	front = new PVector(de*2,de,de*0.2);
	back = new PVector(-de*2,-de,-de*2);

	heart = new Heart(new PVector(0,-de*0.89,0), de*0.2);
	heart.draw = true;
	
	tower = new Tower(-de*0.8,0,de*0.2, de*cubeW,5,5, 10);
	tower.cubes.fillStyleSetC(56,115,207,255, 56,115,115,0);
	tower.cubes.fillStyleSetM(1,1,1,0, 1,1,2,0);
	tower.cubes.scaSet(0.003);
	tower.lockAllInstant();
	mobs.add(tower);

	tower2 = new Tower(de*0.8,0,de*0.2, de*cubeW,5,5, 10);
	tower2.cubes.fillStyleSetC(56,115,207,255, 56,115,115,0);
	tower2.cubes.fillStyleSetM(1,1,1,0, 1,1,2,0);
	tower2.cubes.scaSet(0.003);
	tower2.lockAllInstant();
	mobs.add(tower2);
	
	castle = new Tower(0,0,0, de*cubeW,11,11, 8); // 11,11
	castle.cubes.fillStyleSetC(56,115,207,255, 56,115,48,0);
	castle.cubes.fillStyleSetM(1,1,1,0, 1,1,2,0);
	castle.cubes.scaSet(0.003);
	//castle.lockAllInstant();
	mobs.add(castle);

	stabs.add(new Tower(-de*0.8,0,0, de*cubeW,5,5, 10));
	stabs.get(stabs.size()-1).cubes.fillStyleSetC(156,115,207,255, 56,115,115,0);
	stabs.get(stabs.size()-1).cubes.fillStyleSetM(1,1,1,0, -1,1,2,0);
	stabs.add(new Tower(de*0,0,0, de*cubeW,5,5, 10));
	stabs.get(stabs.size()-1).cubes.fillStyleSetC(56,125,57,255, 56,115,115,0);
	stabs.get(stabs.size()-1).cubes.fillStyleSetM(1,1,1,0, -1,1,-2,0);
	stabs.add(new Tower(de*0.8,0,0, de*cubeW,5,5, 10));
	stabs.get(stabs.size()-1).cubes.fillStyleSetC(156,15,107,255, 56,115,115,0);
	stabs.get(stabs.size()-1).cubes.fillStyleSetM(1,1,1,0, -1,1,2,0);
	for (BuildingGrid mob : stabs) {
		mobs.add(mob);
	}

	stabs2.add(new Tower(-de*0.8,0,0, de*cubeW,5,5, 10));
	stabs2.get(stabs2.size()-1).cubes.fillStyleSetC(156,115,207,255, 56,115,115,0);
	stabs2.get(stabs2.size()-1).cubes.fillStyleSetM(1,1,1,0, -1,1,2,0);
	for (BuildingGrid mob : stabs2) {
		mobs.add(mob);
	}

	pulses.add(new Wall(0,0,0, de*cubeW, 20,20));
	pulses.get(0).cubes.fillStyleSetM(1,1,1,0,2,1,1,0);
	for (BuildingGrid mob : pulses) {
		mobs.add(mob);
	}

	notes.add(new Tower(0,0,0, de*cubeW, 5,5,10));
	notes.get(0).cubes.fillStyleSetC(75,155,55,255, 56,115,115,0);
	notes.get(0).cubes.fillStyleSetM(1,1,1,0,2,1,1,0);
	notes.get(0).lockAllInstant();
	for (BuildingGrid mob : notes) {
		mobs.add(mob);
	}

	for (BuildingGrid mob : mobs) {
		mob.draw = false;
	}
}