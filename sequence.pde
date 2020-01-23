void addEvents() {
	events.add(new SetEntityDraw(0,heart,true));
	events.add(new SetGridCubeDraw(0,castle,true));
}

void addMainMelody(int start) {
	events.add(new Melody1(start, melody[0]));
	events.add(new Melody1(start + 4, melody[1]));
	events.add(new Melody1(start + 8, melody[2]));
	events.add(new Melody1(start + 12, melody[3]));
	events.add(new Melody1(start + 16, melody[0]));
	events.add(new Melody1(start + 20, melody[4]));
	events.add(new Melody1(start + 24, melody[5]));
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