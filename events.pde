// MAIN EVENTS
int[][] melody = new int[][]{
	new int[]{3,13,23,33,42,53,61,72,83,102,112},
	new int[]{5,14,23,35,57,67,78,96,115,123},
	new int[]{1,11,22,32,53,62,72,83,103,113},
	new int[]{1,10,22,31,52,62,73,83,102,112},
	new int[]{8,18,29,40,59,80,98,119,130},
	new int[]{2,11,21,30,49,59,68,78,98,107}};
class Melody1 extends Event {
	int start;
	int curr;
	int[] notes;
	BuildingGrid mob;

	 Melody1(float time, BuildingGrid mob, int[] notes) {
	 	super(time-1, time+3);
	 	this.mob = mob;
	 	this.notes = notes;
	 }

	 void spawn() {
	 	//mob.draw = true;
	 	start = frameCount+30;
	 }

	 void update() {
	 	curr = frameCount - start;
	 	for (int i = 0 ; i < notes.length ; i ++) {
	 		if (curr == notes[i]) laser(mob.unlockNext());
	 	}
	 }

	 void end() {
	 	//mob.draw = false;
	 }

	 void laser(Cube cube) {
	 	float amp = de*10;
	 	mob.unlock(cube);
	 	switch ((int)random(3)) {
	 		case 0:
	 		cube.w.p.x += amp;
	 		break;
	 		case 1:
	 		cube.w.p.y += amp;
	 		break;
	 		case 2:
	 		cube.w.p.z += amp;
	 		break;
	 	}
	 	cube.fillStyle.setx(500,500,500,255);
	 }
}

class MelodyStabs extends Event {

	int start;
	float pAmp;
	int curr;
	int index1; int index2; int index3;

	MelodyStabs(float time, int index1, int index2, int index3) {
		super(time,time+1);
		pAmp = de;
		this.index1 = index1; this.index2 = index2; this.index3 = index3;
	}

	MelodyStabs(float time) {
		this(time, 0,1,2);
	}

	void spawn() {
		stabs.get(index1).draw = true;
		stabs.get(index2).draw = true;
		stabs.get(index3).draw = true;
		stabs.get(index1).lockAllInstant();
		stabs.get(index2).lockAllInstant();
		stabs.get(index3).lockAllInstant();
		start = frameCount;
	}

	void update() {
		curr = frameCount-start;
		switch (curr) {
			case 5:
				burst(stabs.get(index1));
				break;
			case 15:
				burst(stabs.get(index2));
				break;
			case 25:
				burst(stabs.get(index3));
				break;
			case 30:
				stabs.get(index1).cubes.scaX(0);
				stabs.get(index2).cubes.scaX(0);
				stabs.get(index3).cubes.scaX(0);
				break;
		}
	}

	void burst(BuildingGrid mob) {
		mob.unlockAll();
		for (int i = 0 ; i < mob.cubes.arm ; i ++) {
			Cube cube = mob.cubes.ar.get(i);
			cube.p.P.add(random(-pAmp,pAmp),random(-pAmp,pAmp),random(-pAmp,pAmp));
			cube.ang.P.set(random(-PI,PI),random(-PI,PI),random(-PI,PI));
		}
	}

	void end() {
		stabs.get(index1).draw = false;
		stabs.get(index2).draw = false;
		stabs.get(index3).draw = false;
		stabs.get(index1).cubes.scaX(1);
		stabs.get(index2).cubes.scaX(1);
		stabs.get(index3).cubes.scaX(1);
	}
}

class LyricStabs extends Event {
	BuildingGrid mob;
	int start; int curr;
	int index; int num;

	LyricStabs(float time, BuildingGrid mob, int index, int num) {
		super(time, time+1);
		this.mob = mob;
		this.index = index%mob.cubes.arm;
		this.num = num;
	}

	void spawn() {
		start = frameCount;
	}

	void update() {
		curr = frameCount - start;
		switch(curr) {
			case 5:
			spawnCubes();
			break;
			case 15:
			spawnCubes();
			break;
			case 25:
			spawnCubes();
			break;
			case 30:
			spawnCubes();
			break;
		}
	}

	void spawnCubes() {
		int count = 0;
		float pAmp;
		while (count < num) {
			mob.cubes.nextCubeAppear(index);
			count ++;
			index = (index+1)%mob.cubes.arm;
		}
	}
}

class Pulses extends Event {

	BuildingGrid mob;
	float angAmp = 0.05;
	float scaAmp = 0.3;

	Pulses(float time, BuildingGrid mob) {
		super(time, time+4);
		this.mob = mob;
	}

	void spawn() {
		mob.draw = true;
		mob.lockAllInstant();
		mob.sca.v += 0.2;
		mob.cubes.fillStyleSetC(random(55,175),random(55,175),random(55,175),255, random(-100,100),random(-100,100),random(-100,100),0);
		for (int i = 0 ; i < mob.cubes.arm ; i ++) {
			mob.cubes.get(i).av.reset(random(-angAmp, angAmp),random(-angAmp, angAmp),random(-angAmp, angAmp));
		}
	}

	void update() {
		if (timer.beat) {
			mob.sca.v += 0.3;
			mob.cubes.fillStyleSetC(random(55,175),random(55,175),random(55,175),255, random(-100,100),random(-100,100),random(-100,100),0);
			for (int i = 0 ; i < mob.cubes.arm ; i ++) {
				mob.cubes.get(i).av.reset(random(-angAmp, angAmp),random(-angAmp, angAmp),random(-angAmp, angAmp));
			}
		}
	}

	void end() {
		mob.sca.x = 1;
		mob.sca.X = 1;
		mob.draw = false;
	}
}

// MODIFICATION EVENTS
class LockGridCubes extends Event {
	int num;
	BuildingGrid mob;
	boolean lock;
	int count;
	int tick = 1;

	LockGridCubes(float time, float timeEnd, BuildingGrid mob, int num, boolean lock) {
		super(time,time+timeEnd);
		this.mob = mob;
		this.num = num;
		this.lock = lock;
	}

	LockGridCubes(float time, float timeEnd, BuildingGrid mob, boolean lock) {
		this(time,timeEnd, mob, mob.cubes.arm, lock);
	}

	void spawn() {
		count = 0;
	}

	void update() {
		if (frameCount % tick == 0 && count < num) {
			if (lock) {
				mob.lockNext();
			} else {
				mob.unlockNext();
			}
			count ++;
		}
	}
}

class LockGridCubesInstant extends Event {
	BuildingGrid mob;
	boolean lock;

	LockGridCubesInstant(float time, BuildingGrid mob, boolean lock) {
		super(time,time+1);
		this.mob = mob;
		this.lock = lock;
	}

	void spawn() {
		if (lock) {
			mob.lockAllInstant();
		} else {
			mob.unlockAll();
		}
	}
}

class GridSetAv extends Event {
	float x,y,z;
	BuildingGrid mob;

	GridSetAv(float time, BuildingGrid mob, float x, float y, float z) {
		super(time,time+1);
		this.mob = mob;
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		mob.av.reset(x,y,z);
	}
}

class GridSetPv extends Event {
	float x,y,z;
	BuildingGrid mob;

	GridSetPv(float time, BuildingGrid mob, float x, float y, float z) {
		super(time,time+1);
		this.mob = mob;
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		mob.pv.P.set(x,y,z);
	}
}

class GridSetAng extends Event {
	float x,y,z;
	BuildingGrid mob;

	GridSetAng(float time, BuildingGrid mob, float x, float y, float z) {
		super(time,time+1);
		this.mob = mob;
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		mob.ang.reset(x,y,z);
	}
}

class GridCubesAddPv extends Event {
	float x,y;
	BuildingGrid mob;

	GridCubesAddPv(float time, BuildingGrid mob, float x, float y) {
		super(time,time+1);
		this.mob = mob;
		this.x = x; this.y = y;
	}

	void spawn() {
		float ang;
		for (Cube cube : mob.cubes.ar) {
			ang = atan2(cube.p.p.z-mob.p.p.z,cube.p.p.x-mob.p.p.x);
			cube.pv.P.add(cos(ang)*x,y,sin(ang)*x);
		}
	}
}

class GridCubesAddAv extends Event {
	float x,y;
	BuildingGrid mob;

	GridCubesAddAv(float time, BuildingGrid mob, float x, float y) {
		super(time,time+1);
		this.mob = mob;
		this.x = x; this.y = y;
	}

	void spawn() {
		float ang;
		for (Cube cube : mob.cubes.ar) {
			ang = atan2(cube.p.p.y-mob.p.p.y,cube.p.p.x-mob.p.p.x);
			cube.av.P.add(cos(ang)*x,y,sin(ang)*x);
		}
	}
}

class SetEntityP extends Event {
	float x,y,z;
	BuildingGrid mob;

	SetEntityP(float time, BuildingGrid mob, float x, float y, float z) {
		super(time,time+1);
		this.mob = mob;
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		mob.p.reset(x,y,z);
	}
}

class SetHeartBeat extends Event {
	boolean heartBeat;

	SetHeartBeat(float time, boolean heartBeat) {
		super(time,time+1);
		this.heartBeat = heartBeat;
	}

	void spawn() {
		heart.beat = heartBeat;
	}
}

// SETDRAW EVENTS
class SetEntityDraw extends Event {
	Entity mob;
	boolean entityDraw;

	SetEntityDraw(float time, Entity mob, boolean entityDraw) {
		super(time, time+1);
		this.mob = mob;
		this.entityDraw = entityDraw;
	}

	void spawn() {
		mob.draw = entityDraw;
	}
}

class SetGridCubeDraw extends Event {
	BuildingGrid mob;
	boolean gridDraw;
	boolean cubeDraw;

	SetGridCubeDraw(float time, BuildingGrid mob, boolean gridDraw, boolean cubeDraw) {
		super(time, time+1);
		this.gridDraw = gridDraw;
		this.cubeDraw = cubeDraw;
		this.mob = mob;
	}

	SetGridCubeDraw(float time, BuildingGrid mob, boolean gridDraw) {
		this(time, mob, gridDraw, gridDraw);
	}

	void spawn() {
		mob.draw = gridDraw;
		for (int i = 0 ; i < mob.cubes.arm ; i ++) {
			mob.cubes.get(i).draw = cubeDraw;
		}
	}
}

// COLOR EVENTS
class AllCubesFillStyleSetM extends Event {
	float r,g,b,a;
	float rr,gr,br,aa;

	AllCubesFillStyleSetM(float time, float r, float g, float b, float a, float rr, float gr, float br, float aa) {
		super(time, time+1);
		this.r = r; this.g = g; this.b = b; this.a = a;
		this.rr = rr; this.gr = gr; this.br = br; this.aa = aa;
	}

	void spawn() {
		for (Entity mob : mobs) {
			((BuildingGrid)mob).cubes.fillStyleSetM(r,g,b,a,rr,gr,br,aa);
		}
	}
}

class AllCubesFillStyleSetC extends Event {
	float r,g,b,a;
	float rr,gr,br,aa;

	AllCubesFillStyleSetC(float time, float r, float g, float b, float a, float rr, float gr, float br, float aa) {
		super(time, time+1);
		this.r = r; this.g = g; this.b = b; this.a = a;
		this.rr = rr; this.gr = gr; this.br = br; this.aa = aa;
	}

	void spawn() {
		for (Entity mob : mobs) {
			((BuildingGrid)mob).cubes.fillStyleSetC(r,g,b,a,rr,gr,br,aa);
		}
	}
}

class GridCubeFillStyleSetM extends Event {
	float r,g,b,a;
	float rr,gr,br,aa;
	BuildingGrid mob;

	GridCubeFillStyleSetM(float time, BuildingGrid mob, float r, float g, float b, float a, float rr, float gr, float br, float aa) {
		super(time, time+1);
		this.mob = mob;
		this.r = r; this.g = g; this.b = b; this.a = a;
		this.rr = rr; this.gr = gr; this.br = br; this.aa = aa;
	}

	void spawn() {
		mob.cubes.fillStyleSetM(r,g,b,a,rr,gr,br,aa);
	}
}

class GridCubeFillStyleSetC extends Event {
	float r,g,b,a;
	float rr,gr,br,aa;
	BuildingGrid mob;

	GridCubeFillStyleSetC(float time, BuildingGrid mob, float r, float g, float b, float a, float rr, float gr, float br, float aa) {
		super(time, time+1);
		this.mob = mob;
		this.r = r; this.g = g; this.b = b; this.a = a;
		this.rr = rr; this.gr = gr; this.br = br; this.aa = aa;
	}

	void spawn() {
		mob.cubes.fillStyleSetC(r,g,b,a,rr,gr,br,aa);
	}
}

// PATTERN EVENTS
class GlobalWavePattern extends Event {
	ArrayList<Point> ar = new ArrayList<Point>();
	int start;
	int curr;

	GlobalWavePattern(float time) {
		super(time, time+114);
	}

	void spawn() {
		start = frameCount;
		for (BuildingGrid mob : mobs) {
			if (mob.draw) {
				for (int i = 0 ; i < mob.ar.length ; i ++) {
					for (int k = 0 ; k < mob.ar[i].length ; k ++) {
						ar.add(mob.ar[i][k]);
					}
				}
			}
		}
	}

	void update() {
		curr = frameCount - start;
		if (curr < ar.size()) {
			for (int i = 0 ; i < 30 ; i ++) {
				Point p = ar.get((curr+i*10)%ar.size());
				p.v.y -= de;
			}
		}
	}

	void end() {
		ar.clear();
	}
}

// CAMERA EVENTS
class CameraAddP extends Event {
	float x; float y; float z;

	CameraAddP(float time, float x, float y, float z) {
		super(time, time+1);
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		cam.ang.p.add(x,y,z);
		cam.ang.P.add(x,y,z);
	}
}

class CameraSetP extends Event {
	float x; float y; float z;

	CameraSetP(float time, float x, float y, float z) {
		super(time, time+1);
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		cam.ang.reset(x,y,z);
	}
}

class CameraSetAv extends Event {
	float x; float y; float z;

	CameraSetAv(float time, float x, float y, float z) {
		super(time, time+1);
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		cam.av.reset(x,y,z);
	}
}