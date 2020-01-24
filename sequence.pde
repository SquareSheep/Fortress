void addEvents() {
	// Intro section
	float cameraAngle = -0.2;
	events.add(new SetEntityDraw(0,heart,true));
	events.add(new SetGridCubeDraw(0,castle,true));
	events.add(new SetHeartBeat(0,false));
	events.add(new CameraSetP(0, cameraAngle,0,0));
	events.add(new CameraSetAv(0, 0,0.002,0));

	// Lyric section "Building ... I thought we were better"
	events.add(new CameraSetP(33, cameraAngle,0,0));
	events.add(new SetGridCubeDraw(33,castle,true,false));
	for (int i = 0 ; i < 7 ; i ++) {
		events.add(new LyricStabs(33+i*4, castle, i*48,12));
		events.add(new LockGridCubes(35+i*4,4, castle, 48,true));
	}
	events.add(new LyricStabs(33+7*4, castle, 7*48,15));
	events.add(new LockGridCubes(34+7*4,4, castle, 60,true));

	// Lyric section "We can try ... and we can feel nothing"
	events.add(new CameraSetAv(66,0,0,0));
	//events.add(new CameraSetP(66,cameraAngle,0,0));
	events.add(new LockGridCubes(66,24, castle,false));

	// Lyric section "And I know ... help me to break through"
	for (int i = 0 ; i < 12 ; i ++) {
		events.add(new GridSetAv(81+i,castle, 0,0.003+i*0.01,0));
		events.add(new GridCubesAddPv(81+i,castle, 0.3,-2));
	}

	events.add(new SetEntityDraw(97, castle, false));

	// Melody section
	events.add(new CameraSetAv(97,0,0.003,0));
	events.add(new SetHeartBeat(97,true));
	events.add(new LockGridCubesInstant(97,tower,true));
	for (int i = 0 ; i < 7 ; i ++) {
		events.add(new SetEntityDraw(97+i*4, heart, false));
		events.add(new SetEntityDraw(97+i*4, tower, false));
		events.add(new MelodyStabs(97+i*4));
		events.add(new SetEntityDraw(98+i*4, heart, true));
		events.add(new SetEntityDraw(98+i*4, tower, true));
	}
	events.add(new GridCubesAddPv(98,tower,10,-10));
	addMainMelody(98,tower);

	events.add(new SetEntityDraw(125,tower,false));

	// Pulses
	events.add(new SetGridCubeDraw(125,castle,true,true));
	events.add(new LockGridCubesInstant(125,castle,true));
	events.add(new GridSetAng(125,castle,0,0,0));
	events.add(new GridSetAv(125,castle,0,0,0));
	events.add(new Pulses(125,castle));
	for (int i = 0 ; i < towers.length ; i ++) {
		events.add(new Pulses(125,towers[i]));
		events.add(new SetGridCubeDraw(125,towers[i],true,true));
	}

	for (int i = 0 ; i < towers.length ; i ++) {
		events.add(new SetEntityDraw(129,towers[i],false));
	}

	// Melody section 2
	events.add(new CameraSetAv(97,0,-0.008,0));
	for (int i = 0 ; i < 7 ; i ++) {
		events.add(new SetEntityDraw(129+i*4, heart, false));
		events.add(new SetEntityDraw(129+i*4, castle, false));
		events.add(new MelodyStabs(129+i*4));
		events.add(new SetEntityDraw(130+i*4, heart, true));
		events.add(new SetEntityDraw(130+i*4, castle, true));
	}
	events.add(new GridCubesAddPv(130,castle,10,-10));
	addMainMelody(130,castle);
	addMainMelody(130,castle);
	addMainMelody(130,castle);

	// Pulses 2

	// Lyric section "We can try ... help me to break through"

	// Lyric section "Moving pictures ... Just let it consume us"
}

void addMainMelody(int start, BuildingGrid mob) {
	events.add(new Melody1(start, mob, melody[0]));
	events.add(new AllCubesFillStyleSetC(start,55,200,100,255, 55,-100,100,0));
	events.add(new Melody1(start + 4, mob, melody[1]));
	events.add(new AllCubesFillStyleSetC(start + 4, 200,100,55,255, 100,-100,55,0));
	events.add(new Melody1(start + 8, mob, melody[2]));
	events.add(new AllCubesFillStyleSetC(start + 8, 115,55,225,255, 115,-55,100,0));
	events.add(new Melody1(start + 12, mob, melody[3]));
	events.add(new AllCubesFillStyleSetC(start + 12, 56,115,207,255,56,115,40,0));
	events.add(new Melody1(start + 16, mob, melody[0]));
	events.add(new AllCubesFillStyleSetC(start + 16, 200,100,55,255, 100,-100,55,0));
	events.add(new Melody1(start + 20, mob, melody[4]));
	events.add(new AllCubesFillStyleSetC(start + 20, 115,55,225,255, 115,-55,100,0));
	events.add(new Melody1(start + 24, mob, melody[5]));
	events.add(new AllCubesFillStyleSetC(start + 24, 56,115,207,255,56,115,40,0));
}

void keyboardInput() {
	switch(key) {
		case '1':
		setTime(0,0);
		break;
		case '2':
		setTime(11075,16);
		break;
		case '3':
		setTime(22058,32);
		break;
		case '4':
		setTime(44000,64);
		break;
		case '5':
		setTime(65271,95);
		break;
		case '6':
		setTime(84450,123);
		break;
	}
}