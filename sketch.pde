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
Heart heart;
Tower[] towers = new Tower[4];

ArrayList<BuildingGrid> stabs = new ArrayList<BuildingGrid>();

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
	
	tower = new Tower(0,0,0, de*cubeW,5,5, 9);
	tower.cubes.fillStyleSetC(56,115,207,255, 56,115,115,0);
	tower.cubes.fillStyleSetM(1,1,1,0, 1,1,2,0);
	mobs.add(tower);
	
	castle = new Tower(0,0,0, de*cubeW,11,11, 8);
	castle.cubes.fillStyleSetC(56,115,207,255, 56,115,48,0);
	castle.cubes.fillStyleSetM(1,1,1,0, 1,1,2,0);
	mobs.add(castle);

	float dt = de*0.8;
	for (int i = 0 ; i < towers.length ; i ++) {
		towers[i] = new Tower(0,0,0, de*cubeW,5,5,10);
		towers[i].cubes.fillStyleSetC(56,115,207,255, 56,115,48,0);
		towers[i].cubes.fillStyleSetM(1,1,1,0, 1,1,2,0);
		towers[i].lockAllInstant();
		mobs.add(towers[i]);
	}
	towers[0].p.reset(-dt,0,-dt);
	towers[1].p.reset(dt,0,-dt);
	towers[2].p.reset(dt,0,dt);
	towers[3].p.reset(-dt,0,dt);

	for (int i = 0 ; i < 3 ; i ++) {
		stabs.add(new Tower(i*de*0.8-de*0.8,0,0, de*cubeW, 5,5,10));
		mobs.add(stabs.get(i));
	}

	for (BuildingGrid mob : mobs) {
		mob.draw = false;
	}
}