void addEvents() {
	// Intro section
	float cameraAngle = -0.2;
	events.add(new FlipLights(0));
	events.add(new SetEntityDraw(0,heart,true));
	events.add(new SetGridCubeDraw(0,castle,true,false));
	events.add(new GridSetPillar(0,castle,false));
	events.add(new LockRandomGridCubes(0,castle,200));
	events.add(new SetHeartBeat(0,false));
	events.add(new CameraSetP(0, cameraAngle,0,0));
	events.add(new CameraSetAv(0, 0,-0.003,0));

	for (int i = 0 ; i < 8 ; i ++) {
		events.add(new GridCubeFillStyleSetC(1+i*4,castle));
	}
	events.add(new GridCubesAppear(1,castle,10));
	events.add(new GridCubesAppear(5,castle,10));
	events.add(new GridCubesAppear(9,castle,10));
	events.add(new GridCubesAppear(13,castle,10));
	events.add(new GridCubesAppearNotes(17,19,castle,10, new int[]{8,16,23}));
	events.add(new GridCubesAppearNotes(20,22,castle,10, new int[]{31,50}));
	events.add(new GridCubesAppearNotes(24,26,castle,10, new int[]{1772-1743,1795-1743,1814-1743}));
	events.add(new GridCubesAppear(29,castle,10));
	for (int i = 0 ; i < 5 ; i ++) {
		events.add(new SetHeartAv(28+i,0.01+i*0.06));
	}

	// Lyric section "Building ... I thought we were better"
	events.add(new GridCubeFillStyleSetC(33,castle,56,115,207,255, 25,55,55,0));
	events.add(new LockGridCubesInstant(33,castle,false));
	events.add(new SetHeartAv(33,0));
	events.add(new SetHeartAng(33,0));
	events.add(new CameraSetP(33,cameraAngle,0,0));
	events.add(new CameraSetAv(33,0,0.005,0));
	events.add(new SetGridCubeDraw(33,castle,true,false));
	events.add(new GridSetPillar(33,castle,true));

	events.add(new GridBounceBeat(32,66,castle,2,1));
	for (int i = 0 ; i < 7 ; i ++) {
		events.add(new GridCubesAppearNotes(33+i*4,35+i*4,castle,12, new int[]{5,15,25,30}));
		events.add(new LockGridCubes(35+i*4,4, castle, 48,true));
	}
	events.add(new GridCubesAppearNotes(33+7*4,35+7*4,castle,15, new int[]{5,15,25,30}));
	events.add(new LockGridCubes(35+7*4,4, castle, 60,true));

	// Lyric section "We can try ... and we can feel nothing"
	events.add(new CameraSetAv(66,0,-0.003,0));
	events.add(new LockGridCubes(66,24, castle,false));

	// Lyric section "And I know ... help me to break through"
	for (int i = 0 ; i < 12 ; i ++) {
		events.add(new GridSetAv(80+i,castle, 0,0.003+i*0.003,0));
		events.add(new GridCubesAddPv(81+i,castle, 0.03,0));
	}
	events.add(new GridCubesSetP(93,castle,0));
	events.add(new GridSetAv(93,castle, 0,-0.1,0));
	events.add(new GridCubesAddPv(93,castle, -100,0));
	events.add(new SetHeartAv(93,0.15));

	events.add(new SetEntityDraw(97, castle, false));

	// Melody section
	events.add(new SetHeartAv(97,0));
	events.add(new SetHeartAng(97,0));
	events.add(new SetHeartBeat(97,true));
	events.add(new LockGridCubesInstant(97,tower,true));
	events.add(new GridBounceBeat(97,125,tower,2,1));
	for (int i = 0 ; i < 7 ; i ++) {
		events.add(new CameraSetAv(97+i*4,random(-0.0005,0.0005),randomS(0.005,0.015),0));
		events.add(new SetEntityDraw(97+i*4, heart, false));
		events.add(new SetEntityDraw(97+i*4, tower, false));
		events.add(new MelodyStabs(97+i*4));
		events.add(new CameraSetP(98+i*4,cameraAngle,random(-PI,PI),0));
		events.add(new SetEntityDraw(98+i*4, heart, true));
		events.add(new SetEntityDraw(98+i*4, tower, true));
	}
	events.add(new GridCubesAddPv(98,tower,10,-10));
	addMainMelody(98,tower);

	events.add(new SetEntityDraw(125,tower,false));

	// Pulses
	events.add(new CameraSetP(125,cameraAngle,0,0));
	events.add(new CameraSetAv(125,0,0.007,0));
	events.add(new LockGridCubesInstant(125,castle,true));
	events.add(new GridSetAng(125,castle,0,0,0));
	events.add(new GridSetAv(125,castle,0,0,0));
	events.add(new SetGridCubeDraw(125,castle,true,true));
	events.add(new Pulses(125,castle));
	for (int i = 0 ; i < towers.length ; i ++) {
		events.add(new Pulses(125,towers[i]));
		events.add(new SetGridCubeDraw(125,towers[i],true,true));
	}

	events.add(new FlipLights(125));
	events.add(new FlipLights(126));
	events.add(new FlipLights(127));
	events.add(new FlipLights(128));
	
	for (int i = 0 ; i < towers.length ; i ++) {
		events.add(new SetEntityDraw(129,towers[i],false));
	}

	// Melody section 2
	events.add(new FlipLights(129));
	events.add(new GridBounceBeat(129,157,castle,2,1));
	for (int i = 0 ; i < 7 ; i ++) {
		events.add(new CameraSetAv(129+i*4,random(-0.0005,0.0005),randomS(0.005,0.015),0));
		events.add(new SetEntityDraw(129+i*4, heart, false));
		events.add(new SetEntityDraw(129+i*4, castle, false));
		events.add(new MelodyStabs(129+i*4));
		events.add(new CameraSetP(130+i*4,cameraAngle,random(-PI,PI),0));
		events.add(new SetEntityDraw(130+i*4, heart, true));
		events.add(new SetEntityDraw(130+i*4, castle, true));
	}
	events.add(new GridCubesAddPv(130,castle,10,-10));
	addMainMelody(130,castle);
	addMainMelody(130,castle);
	addMainMelody(130,castle);

	// Pulses 2
	events.add(new CameraSetP(285,cameraAngle,0,0));
	events.add(new CameraSetAv(285,0,-0.007,0));
	events.add(new LockGridCubesInstant(157,castle,true));
	events.add(new GridSetAng(157,castle,0,0,0));
	events.add(new GridSetAv(157,castle,0,0,0));
	events.add(new SetGridCubeDraw(157,castle,true,true));
	events.add(new Pulses(157,castle));
	for (int i = 0 ; i < towers.length ; i ++) {
		events.add(new SetGridCubeDraw(157,towers[i],true,true));
		events.add(new Pulses(157,towers[i]));
		events.add(new BurstGridCubes(157+i, towers[i]));
	}

	events.add(new FlipLights(157));
	events.add(new FlipLights(158));
	events.add(new FlipLights(159));
	events.add(new FlipLights(160));
	
	for (int i = 0 ; i < towers.length ; i ++) {
		events.add(new SetEntityDraw(161,towers[i],false));
	}

	// Lyric section "We can try ... help me to break through"
	events.add(new CameraSetAv(161,0,0,0));
	events.add(new CameraSetP(161,0,0,0));
	events.add(new BurstingTowerRows(161,193));
	for (int i = 0 ; i < 32 ; i ++) {
		events.add(new AllCubesFillStyleSetC(161+i,random(75,150),random(75,150),random(75,150),255,
			random(-100,100),random(-100,100),random(-100,100),0));
	}
	for (int i = 0 ; i < 32 ; i ++) {
		events.add(new FlipLights(161+i));
	}

	// Lyric section "Moving pictures ... Just let it consume us"
	events.add(new SetHeartBeat(193,false));
	events.add(new CameraSetAv(193,0,0.003,0));
	events.add(new CameraSetP(193,0,PI/2,0));
	for (int i = 0 ; i < fodder.length ; i ++) {
		events.add(new SetGridCubeDraw(193,fodder[i],true,false));
		events.add(new GridSetAv(193,fodder[i],random(-0.0005,0.0005),random(-0.003,0.003),random(-0.0005,0.0005)));
		events.add(new GridSetPv(193,fodder[i],random(-0.15,0.15),random(-0.15,0.15),random(-0.15,0.15)));
		events.add(new GridSetP(193,fodder[i],cos((float)i/fodder.length*2*PI)*de,random(-de*0.25,de*0.25),sin((float)i/fodder.length*2*PI)*de));
		events.add(new GridSetPillar(193,fodder[i],false));
	}

	for (int i = 0 ; i < 8 ; i ++) {
		for (int k = 0 ; k < 3 ; k ++) {
			int index = (int)random(fodder.length);
			events.add(new GridAddAng(193+i*4,fodder[index],0,PI/4,0));
			events.add(new GridCubesAppearNotes(193+i*4,195+i*4,fodder[index],14,new int[]{5,15,25}));
			events.add(new LockGridCubes(193+i*4,195+i*4,fodder[index],14*3,true));
			events.add(new GridCubeFillStyleSetC(193+i*4,fodder[index]));
		}
	}
	for (int i = 0 ; i < fodder.length ; i ++) {
		events.add(new LockGridCubes(222,226,fodder[i],false));
	}

	for (int i = 0 ; i < fodder.length ; i ++) {
		for (int k = 0 ; k < 4 ; k ++) {
			events.add(new Melody1(225+k*4,fodder[i], new int[]{10,20,30,40}));
		}
	}

	for (int i = 0 ; i < fodder.length ; i ++) {
		for (int k = 0 ; k < 10 ; k ++) {
			events.add(new GridSetAv(240+k,fodder[i], 0,k*0.004,0));
		}
	}
	for (int i = 0 ; i < fodder.length ; i ++) {
		events.add(new PVectorAdd(253,fodder[i].av.P, 0,0.2,0));
		events.add(new GridCubesSetP(253,fodder[i],0));
		events.add(new GridCubesAddPv(253,fodder[i],50,0));
	}

	for (int i = 0 ; i < fodder.length ; i ++) {
		events.add(new SetGridCubeDraw(257,fodder[i],false));
	}

	//Final build up253, "help me to break through"255, start of next257
	events.add(new FlipLights(257));
	events.add(new SetHeartAv(257,0));
	events.add(new SetHeartAng(257,0));
	events.add(new SetHeartBeat(257,true));
	events.add(new CameraSetAv(257,0,0.006,0));
	events.add(new CameraSetP(257,cameraAngle,0,0));
	events.add(new SetGridCubeDraw(257,castle,true));
	events.add(new LockGridCubesInstant(257,castle,true));
	events.add(new GridBounceBeat(257,285,castle,2,1));
	for (int i = 0 ; i < 4 ; i ++) {
		events.add(new LockGridCubesInstant(257,towers[i],true));
		events.add(new GridBounceBeat(257,285,towers[i],2,1));
	}

	for (int i = 0 ; i < 7 ; i ++) {
		events.add(new CameraSetAv(257+i*4,random(-0.0005,0.0005),randomS(0.005,0.015),0));
		events.add(new SetEntityDraw(257+i*4, heart, false));
		events.add(new SetEntityDraw(257+i*4, castle, false));
		for (int k = 0 ; k < 4 ; k ++) {
			events.add(new SetEntityDraw(257+i*4, towers[k],false));
		}
		events.add(new MelodyStabs(257+i*4));
		events.add(new SetEntityDraw(258+i*4, heart, true));
		events.add(new SetEntityDraw(258+i*4, castle, true));
		for (int k = 0 ; k < 4 ; k ++) {
			events.add(new SetEntityDraw(258+i*4, towers[k],true));
		}
		events.add(new CameraSetP(258+i*4,cameraAngle,random(-PI,PI),0));
	}
	events.add(new GridCubesAddPv(258,castle,10,-10));
	addMainMelody(258,castle);
	for (int k = 0 ; k < 4 ; k ++) {
		events.add(new GridCubesAddPv(258, towers[k],10,-10));
		addMainMelody(258,towers[k]);
	}

	//Pulses 285
	events.add(new LockGridCubesInstant(285,castle,true));
	events.add(new CameraSetAv(285,0,-0.007,0));
	for (int i = 0 ; i < towers.length ; i ++) {
		events.add(new Pulses(285,towers[i]));
		events.add(new BurstGridCubes(285+i, towers[i]));
	}

	events.add(new CameraSetP(289,-0.7,0,0));
	events.add(new GridSetPv(289,castle,0,10,0));
	events.add(new GridCubesResetPv(289,castle));
	events.add(new GridCubesAddPv(289,castle,-10,10));
	events.add(new BurstGridCubes(290,castle));
	events.add(new SetEntityDraw(297,castle,false));
	for (int i = 0 ; i < towers.length ; i ++) {
		events.add(new SetEntityDraw(297,towers[i],false));
	}

	for (int i = 0 ; i < 6 ; i ++) {
		events.add(new SetGridCubeDraw(289+i*4,fodder[i%fodder.length],true));
		events.add(new LockGridCubesInstant(289+i*4,fodder[i%fodder.length],true));
		events.add(new GridSetP(289+i*4,fodder[i%fodder.length],0,-de*2,0));
		events.add(new GridCubesResetPv(289+i*4,fodder[i%fodder.length]));
		events.add(new GridCubesAddPv(289+i*4,fodder[i%fodder.length],20,0));
		events.add(new GridSetAng(289+i*4,fodder[i%fodder.length],0,0,0));
		events.add(new GridSetAv(289+i*4,fodder[i%fodder.length],random(-0.01,0.01),random(-0.03,0.03),random(-0.01,0.01)));
		events.add(new GridSetPv(289+i*4,fodder[i%fodder.length],0,13,0));
		events.add(new BurstGridCubes(293+i*4,fodder[i%fodder.length]));
	}
	events.add(new Melody1(290, fodder[0], melody[0]));
	events.add(new Melody1(294, fodder[1], melody[1]));
	events.add(new Melody1(298, fodder[2], melody[2]));
	events.add(new Melody1(302, fodder[3], melody[3]));
	events.add(new Melody1(306, fodder[4], melody[0]));
	events.add(new Melody1(310, fodder[5], melody[4]));
	events.add(new Melody1(315, fodder[0], melody[5]));

	events.add(new CameraSetAv(317,0,0.008,0));
	for (int i = 0 ; i < towers.length ; i ++) {
		events.add(new SetGridCubeDraw(314,towers[i],true));
		events.add(new LockGridCubesInstant(314,towers[i],true));
		events.add(new GridSetP(314,towers[i],towers[i].p.p.x,-de*2.7,towers[i].p.p.z));
		events.add(new GridSetAv(314,towers[i],random(-0.01,0.01),random(-0.03,0.03),random(-0.01,0.01)));
		events.add(new GridSetAng(314,towers[i],0,0,0));
		events.add(new GridSetPv(314,towers[i],0,15,0));
		events.add(new GridSetPillar(314,towers[i],false));
		events.add(new BurstGridCubes(317+i,towers[i]));
	}
	events.add(new SetHeartAv(317,0.02));
	events.add(new CameraSetAv(317,0.002,0.005,0));
	events.add(new SetHeartBeat(321,false));
}

float randomS(float min, float max) {
	if (random(1) > 0.5) {
		return random(min,max);
	} else {
		return random(-max,-min);
	}
}

void addMainMelody(int start, BuildingGrid mob) {
	events.add(new AllCubesFillStyleSetC(start-1,55,75,200,255, 55,-100,100,0));
	events.add(new Melody1(start, mob, melody[0]));
	events.add(new Melody1(start + 4, mob, melody[1]));
	events.add(new AllCubesFillStyleSetC(start + 4, 150,100,55,255, 100,-100,55,0));
	events.add(new Melody1(start + 8, mob, melody[2]));
	events.add(new AllCubesFillStyleSetC(start + 8, 200,55,200,255, 115,-55,100,0));
	events.add(new Melody1(start + 12, mob, melody[3]));
	events.add(new AllCubesFillStyleSetC(start + 12, 56,115,207,255,56,115,40,0));
	events.add(new Melody1(start + 16, mob, melody[0]));
	events.add(new AllCubesFillStyleSetC(start + 16, 125,100,55,255, 100,-100,55,0));
	events.add(new Melody1(start + 20, mob, melody[4]));
	events.add(new AllCubesFillStyleSetC(start + 20, 200,55,200,255, 115,-55,100,0));
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
		case '7':
		setTime(109133,159);
		break;
		case '8':
		setTime(131773,192);
		break;
		case '9':
		setTime(153019,223);
		break;
		case '0':
		setTime(174962,255);
		break;
		case 'q':
		setTime(192795,281);
		break;
	}
}