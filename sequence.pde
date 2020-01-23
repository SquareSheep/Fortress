void addEvents() {

	events.add(new SetGridCubeDraw(33,castle,true,false));
	for (int i = 0 ; i < 8 ; i ++) {
		events.add(new LyricStabs(33+i*4,castle,i*49,13));
		events.add(new LockGridCubes(35+i*4,6,castle,50,true));
	}
	events.add(new LockGridCubes(67,24,castle,castle.cubes.arm,false));

	events.add(new GridCubeFillStyleSetC(33,castle,56,115,207,255, 56,115,115,0));
	events.add(new GridCubeFillStyleSetC(37,castle,100,151,105,255, 56,115,115,0));
	events.add(new GridCubeFillStyleSetC(41,castle,156,156,55,255, 56,115,115,0));
	events.add(new GridCubeFillStyleSetC(45,castle,222,55,100,255, 56,115,115,0));
	events.add(new GridCubeFillStyleSetC(49,castle,56,115,207,255, 56,115,115,0));
	events.add(new GridCubeFillStyleSetC(53,castle,100,151,105,255, 56,115,115,0));
	events.add(new GridCubeFillStyleSetC(57,castle,156,156,55,255, 56,115,115,0));
	events.add(new GridCubeFillStyleSetC(61,castle,222,55,100,255, 56,115,115,0));
	events.add(new GridCubeFillStyleSetC(65,castle,56,115,207,255, 56,115,115,0));

	events.add(new SetDraws(93,false,true,false));
	//events.add(new GlobalWavePattern(93));
	//events.add(new CameraAvSet(93,0,-0.006,0));
	events.add(new Melody1(98, melody[0]));
	events.add(new Melody1(102, melody[1]));
	events.add(new Melody1(106, melody[2]));
	events.add(new Melody1(110, melody[3]));
	events.add(new Melody1(114, melody[0]));
	events.add(new Melody1(118, melody[4]));
	events.add(new Melody1(122, melody[5]));
	// for (int i = 0 ; i < 7 ; i ++) {
	// 	events.add(new CameraPSet(97+i*4,-0.3,random(-PI,PI),0));
	// 	events.add(new CameraAvSet(97+i*4,0,0,0));
	// 	events.add(new SetDraws(97+i*4,false));
	// 	events.add(new MelodyStabs(97+i*4));
	// 	events.add(new SetDraws(98+i*4,true));
	// 	events.add(new CameraAvSet(98+i*4,0,-0.006,0));
	// }
	events.add(new SetDraws(125,false));
	events.add(new Pulses(125));

	for (int i = 0 ; i < 7 ; i ++) {
		events.add(new SetDraws(129+i*4,false));
		events.add(new MelodyStabs(129+i*4));
		events.add(new SetDraws(130+i*4,true));
	}
	events.add(new Pulses(157));
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
		setTime(54960,80);
		break;
		case '6':
		setTime(65271,95);
		break;
	}
}