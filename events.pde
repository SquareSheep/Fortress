/*
Fortress is in 4/4. Most events take 4 beats or 1 beat

Manipulate color gradients. Push cubes around in wave patterns.
Spin cubes and extend them into lasers. Form and break buildings.

SetDraws:
- Heart
- Castle + towers
- Floating cubes
- Floating towers
Everything else's draw boolean is controlled by their specific events.
Stabs, pulses, build up are separate.

Quiet:
- Floating cubes
- Built or half-built castles, towers
- Slow camera rotation

Melody stabs:
- Three castle walls breaking in succession

Lyric stabs:
- Cubes spawning out of air. Form buildings when lyrics occur

Piano notes:
- Cubes spawning out of air, then drifting

Mid-melody pulses:
- Color gradient-changing wall

Build up:
- Use wave pattern events that push cubes around
- Increases in frequency with build up

Melody:
- Spinning cube lasers


156-159 4x cymbals

192-223 Quiet
224-239 Buildup
240-51 Buildup 2x
251- Peak
284-287 4x cymbals
316-319 4x cymbals
340 End

*/

class SetDraws extends Event {
	boolean heartDraw;
	boolean castleDraw;
	boolean towerDraw;

	SetDraws(float time, boolean heartDraw, boolean castleDraw, boolean towerDraw) {
		super(time, time+1);
		this.heartDraw = heartDraw;
		this.castleDraw = castleDraw;
		this.towerDraw = towerDraw;
	}

	void spawn() {
		castle.draw = castleDraw;
		tower.draw = towerDraw;
		tower2.draw = towerDraw;
		heart.draw = heartDraw;
	}
}

class SetFloating extends Event {
	int[] ar;

	SetFloating(float time, float timeEnd, int[] ar) {
		super(time, timeEnd);
		this.ar = ar;
	}

	void spawn() {
		for (int i = 0 ; i < ar.length ; i ++) {
			floaters[ar[i]].draw = true;
		}
	}

	void end() {
		for (int i = 0 ; i < ar.length ; i ++) {
			floaters[ar[i]].draw = false;
		}
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
		if (curr == 5) {
			burst(stabs.get(index1));
		} else if (curr == 15) {
			burst(stabs.get(index2));
		} else if (curr == 25) {
			burst(stabs.get(index3));
		} else if (curr == 35) {
			stabs.get(index1).cubes.scaX(0);
			stabs.get(index2).cubes.scaX(0);
			stabs.get(index3).cubes.scaX(0);
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

class Pulses extends Event {

	BuildingGrid mob;
	float angAmp = 0.05;
	float scaAmp = 0.3;

	Pulses(float time) {
		super(time, time+4);
		mob = pulses.get(0);
	}

	void spawn() {
		mob.draw = true;
		mob.lockAllInstant();
		mob.sca.x = 2;
		mob.sca.X = 2;
		mob.sca.v += 0.3;
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

class CubesFillStyleSetM extends Event {
	float r,g,b,a;
	float rr,gr,br,aa;

	CubesFillStyleSetM(float time, float r, float g, float b, float a, float rr, float gr, float br, float aa) {
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

class CubesFillStyleSetC extends Event {
	float r,g,b,a;
	float rr,gr,br,aa;

	CubesFillStyleSetC(float time, float r, float g, float b, float a, float rr, float gr, float br, float aa) {
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

class CameraPAdd extends Event {
	float x; float y; float z;

	CameraPAdd(float time, float x, float y, float z) {
		super(time, time+1);
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		cam.ang.p.add(x,y,z);
		cam.ang.P.add(x,y,z);
	}
}

class CameraPSet extends Event {
	float x; float y; float z;

	CameraPSet(float time, float x, float y, float z) {
		super(time, time+1);
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		cam.ang.reset(x,y,z);
	}
}

class CameraAvSet extends Event {
	float x; float y; float z;

	CameraAvSet(float time, float x, float y, float z) {
		super(time, time+1);
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		cam.av.reset(x,y,z);
	}
}