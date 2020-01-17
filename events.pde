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
		cam.ang.p.set(x,y,z);
		cam.ang.P.set(x,y,z);
	}
}

class CameraAngV extends Event {
	float x; float y; float z;

	CameraAngV(float time, float timeEnd, float x, float y, float z) {
		super(time, timeEnd);
		this.x = x; this.y = y; this.z = z;
	}

	void update() {
		cam.ang.P.add(x,y,z);
	}
}