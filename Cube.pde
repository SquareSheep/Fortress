static float cubeW = 0.1;

class CubePool extends ObjectPool<Cube> {
	void set(Cube cube, float x, float y, float z, float w, float ax, float ay, float az) {
		cube.finished = false;
		cube.draw = true;
		cube.p.reset(x,y,z);
		cube.ang.reset(ax,ay,az);
		cube.w = w;
	}

	void add(float x, float y, float z, float w, float ax, float ay, float az) {
		if (arm == ar.size()) ar.add(0,new Cube());
		set(ar.get(0), x,y,z, w, ax,ay,az);
		arm ++;
	}

	void add(float x, float y, float z) {
		add(x,y,z, cubeW*de, 0,0,0);
	}
}

class Cube extends MobF {

	boolean locked = false;

	Cube() {
		p = new Point();
		ang = new Point();
	}

	Cube(float x, float y, float z, float w) {
		this.p = new Point(x,y,z);
		this.ang = new Point(0,0,0);
		this.w = w;
	}

	Cube(float x, float y, float z) {
		this(x,y,z, de*cubeW);
	}

	void update() {
		fillStyle.update();
		strokeStyle.update();
		if (!locked) {
			p.P.add(pv.p);
	   		ang.P.add(av.p);
		}
	    p.update();
	    pv.update();
	    r.update();
	    ang.update();
	    rang.update();
	    av.update();
	    sca.update();
	}

	void render() {
		setDraw();
		box(w);
		pop();
	}
}