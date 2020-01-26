static float cubeW = 0.1;
float cubeSpawnPv = 4;
float cubeSpawnAv = 0.04;
class CubePool extends ObjectPool<Cube> {
	IColor cubeFill = defaultFill.copy();
	//IColor cubeStroke = defaultStroke.copy();
	float w;

	void set(Cube cube, float x, float y, float z, float w, float ax, float ay, float az) {
		cube.finished = false;
		cube.draw = true;
		cube.p.reset(x,y,z);
		cube.ang.reset(ax,ay,az);
		cube.w.reset(w,w,w);
		cube.fillStyle.reset(cubeFill);
		cube.fillStyle.index = (arm-1)%binCount;
		//cube.strokeStyle.reset(cubeStroke);
	}

	void add(float x, float y, float z, float w, float ax, float ay, float az) {
		if (arm == ar.size()) ar.add(0,new Cube());
		set(ar.get(0), x,y,z, w, ax,ay,az);
		arm ++;
	}

	void add(float x, float y, float z) {
		add(x,y,z, cubeW*de, 0,0,0);
	}

	void add(int num, float dx, float av, float pv) {
		for (int i = 0 ; i < num ; i ++) {
			add(random(-dx,dx),random(-dx*2,0),random(-dx,dx), w, random(-PI,PI),random(-PI,PI),random(-PI,PI));
			Cube cube = getLast();
			cube.av.reset(random(-av,av),random(-av,av),random(-av,av));
			cube.pv.reset(random(-pv,pv),random(-pv,pv),random(-pv,pv));
		}
	}

	void add(int num, float dx) {
		add(num, dx, cubeSpawnAv, cubeSpawnPv);
	}

	void nextCubeAppear() {
		nextCubeAppear(0);
	}

	void nextCubeAppear(int index) {
		int k = index;
		while (k < arm && ar.get(k).draw) {
			k ++;
		}
		if (k < arm && !ar.get(k).locked) {
			Cube cube = ar.get(k);
			cube.draw = true;
			cube.p.reset(random(-de,de),random(-de*2,0),random(-de,de));
			cube.w.p.set(0,0,0);
			cube.w.v.x += cube.w.P.x;
			cube.sca.x += 1;
			float pAmp = cube.w.P.x;
			cube.p.P.add(random(-pAmp,pAmp),random(-pAmp,pAmp),random(-pAmp,pAmp));
			cube.ang.P.add(random(-PI,PI),random(-PI,PI),random(-PI,PI));
		}
	}

	void setDraw(boolean boo) {
		for (int i = 0 ; i < ar.size() ; i ++) {
			ar.get(i).draw = boo;
		}
	}

	void scaX(float X) {
		for (int i = 0 ; i < ar.size() ; i ++) {
			ar.get(i).sca.X = X;
		}
	}

	void scax(float x) {
		for (int i = 0 ; i < ar.size() ; i ++) {
			ar.get(i).sca.x = x;
		}
	}

	void scaSet(float xm) {
		for (int i = 0 ; i < ar.size() ; i ++) {
			ar.get(i).sca.xm = xm;
			ar.get(i).sca.index = i%binCount;
		}
	}

	void fillStyleSetC(float r, float g, float b) {
		cubeFill.setx(r,g,b,255);
		for (int i = 0 ; i < ar.size() ; i ++) {
			ar.get(i).fillStyle.setC(r,g,b,255);
		}
	}

	void fillStyleSetC(float r, float g, float b, float a, float rr, float gr, float br, float aa) {
		cubeFill.setx(r,g,b,a);
		float fr;
		for (int i = 0 ; i < ar.size() ; i ++) {
			fr = (float)i/ar.size() - 0.5;
			ar.get(i).fillStyle.setC(r+fr*rr,g+fr*gr,b+fr*br,a+fr*aa);
		}
	}

	void fillStyleSetM(float r, float g, float b, float a) {
		cubeFill.setM(r,g,b,a);
		for (int i = 0 ; i < ar.size() ; i ++) {
			ar.get(i).fillStyle.setM(r,g,b,a, i%binCount);
		}
	}

	void fillStyleSetM(float r, float g, float b, float a, float rr, float gr, float br, float aa) {
		cubeFill.setM(r,g,b,a);
		float fr;
		for (int i = 0 ; i < ar.size() ; i ++) {
			fr = (float)i/ar.size() - 0.5;
			ar.get(i).fillStyle.setM(r+fr*rr,g+fr*gr,b+fr*br,a+fr*aa, i%binCount);
		}
	}
}

class Cube extends Mob {
	IColor fillStyle = defaultFill.copy();
	boolean locked = false;
	Point w;

	Cube() {
		p = new Point();
		ang = new Point();
		w = new Point();
	}

	Cube(float x, float y, float z, float w) {
		this.p = new Point(x,y,z);
		this.ang = new Point(0,0,0);
		this.w = new Point(w,w,w);
	}

	Cube(float x, float y, float z) {
		this(x,y,z, de*cubeW);
	}

	void update() {
		fillStyle.update();
		if (!locked) {
			p.P.add(pv.p);
			ang.P.add(av.p);
		}
	    p.update();
	    pv.update();
	    ang.update();
	    av.update();
	    w.update();
	    sca.update();
	}

	void render() {
		setDraw();
		fillStyle.fillStyle();
		box(w.p.x,w.p.y,w.p.z);
		pop();
	}
}