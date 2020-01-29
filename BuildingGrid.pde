class Tower extends BuildingGrid {
	Tower(float x, float y, float z, float w, int col, int row, int num) {
		super(x,y,z, w, TowerGrid(col, row, num), col,row);
		nofCubes = col*row + (col*2+row*2-2)*(num-2) + (col+row-1);
		cubes.add(nofCubes, w*(col+row)/2);
	}
}

class Wall extends BuildingGrid {
	Wall(float x, float y, float z, float w, int col, int row) {
		super(x,y,z, w, Wall2DGrid(col,row), col,1);
		nofCubes = col*row;
		cubes.add(nofCubes,w*(col+row)/2);
		pillar = false;
	}
}

class BuildingGrid extends Mob {
	Point[][] ar;
	Cube[][] taken;
	CubePool cubes = new CubePool();
	int nofCubes;
	int currI = 0;
	int currZ;
	int col,row;
	boolean pillar = true;
	IColor fillStyle = defaultFill.copy();

	BuildingGrid(float x, float y, float z, float w, float[][] ar, int col, int row) {
		this.p = new Point(x,y,z);
		this.ang = new Point();
		cubes.w = w;
		this.w = (float)(col+row)/2*w;
		this.ar = new Point[ar.length][];
		this.taken = new Cube[this.ar.length][];
		this.col = col; this.row = row;
		float dx = col*0.5-0.5;
		float dz = row*0.5-0.5;
		float dy = ar.length;
		for (int i = 0 ; i < this.ar.length ; i ++) {
			this.ar[i] = new Point[ar[i].length/2];
			this.taken[i] = new Cube[this.ar[i].length];
			for (int k = 0 ; k < ar[i].length ; k += 2) {
				this.ar[i][k/2] = new Point((ar[i][k]-dx)*w, (i-dy)*w, (ar[i][k+1]-dz)*w);
			}
		}
		currZ = this.ar.length-1;
	}

	void update() {
		super.update();
		cubes.update();
		for (int i = 0 ; i < ar.length ; i ++) {
			for (int k = 0 ; k < ar[i].length ; k ++) {
				ar[i][k].update();
			}
		}
		fillStyle.update();
	}

	void render() {
		setDraw();
		cubes.render();
		for (int i = 0 ; i < ar.length ; i ++) {
			for (int k = 0 ; k < ar[i].length ; k ++) {
				if (taken[i][k] != null) taken[i][k].p.P.set(ar[i][k].p.x,ar[i][k].p.y,ar[i][k].p.z);
			}
		}
		if (pillar) {
			translate(0,de-cubes.w/2,0);
			fillStyle.fillStyle();
			defaultStroke.strokeStyle();
			box(w*1.2,de*2,w*1.2);
		}
		pop();
	}

	void lock(Cube cube, int z, int i) {
		if (taken[z][i] == null) {
			taken[z][i] = cube;
			cube.ang.P.set(0,0,0);
			cube.locked = true;
		}
	}

	boolean lock(int z, int i) {
		int k = 0;
		Cube cube;
		do {
			cube = cubes.ar.get(k);
			k ++;
		} while (k < cubes.arm && (cube.locked || !cube.draw));
		if (!cube.locked && cube.draw) {
			lock(cube,z,i);
			return true;
		}
		return false;
	}

	void lockNext() {
		if (currZ == taken.length) {
			currZ --;
			currI = 0;
		}
		if (currZ > -1) {
			while (currZ > -1 && taken[currZ][currI] != null) {
				currI ++;
				if (currI == taken[currZ].length) {
					currZ --;
					currI = 0;
				}
			}
			if (currZ > -1) {
				lock(currZ, currI);
			}
		}
	}

	Cube unlock(Cube cube) {
		for (int i = 0 ; i < taken.length ; i ++) {
			for (int k = 0 ; k < taken[i].length ; k ++) {
				if (cube == taken[i][k]) {
					return unlock(i,k);
				}
			}
		}
		return null;
	}

	Cube unlock(int z, int i) {
		Cube cube;
		if (taken[z][i] != null) {
			taken[z][i].locked = false;
			cube = taken[z][i];
			taken[z][i] = null;
			return cube;
		}
		return null;
	}

	Cube unlockNext() {
		if (currZ == -1) {
			currZ ++;
			currI = taken[currZ].length-1;
		}
		if (currZ < taken.length) {
			while (currZ < taken.length && taken[currZ][currI] == null) {
				currI --;
				if (currI == -1) {
					currZ ++;
					if (currZ < taken.length) currI = taken[currZ].length-1;
				}
			}
			if (currZ < taken.length) {
				return unlock(currZ, currI);
			}
		}
		return cubes.ar.get((int)random(cubes.arm));
	}

	void unlockAll() {
		for (int i = 0 ; i < ar.length ; i ++) {
			for (int k = 0 ; k < ar[i].length ; k ++) {
				unlock(i,k);
			}
		}
		currZ = taken.length;
		currI = 0;
	}

	void lockAll() {
		for (int i = 0 ; i < ar.length ; i ++) {
			for (int k = 0 ; k < ar[i].length ; k ++) {
				lock(i,k);
			}
		}
		currZ = 0;
		currI = taken[currZ].length-1;
	}

	void lockAllInstant() {
		for (int i = 0 ; i < ar.length ; i ++) {
			for (int k = 0 ; k < ar[i].length ; k ++) {
				if (lock(i,k)) {
					taken[i][k].p.reset(ar[i][k]);
					taken[i][k].ang.reset(0,0,0);
				}
			}
		}
		currZ = 0;
		currI = taken[currZ].length-1;
	}

	void burst() {
		float amp = (col+row)/2*(w*0.5);
		unlockAll();
		for (int i = 0 ; i < cubes.arm ; i ++) {
			Cube cube = cubes.ar.get(i);
			cube.p.P.add(random(-amp,amp),random(-amp,amp),random(-amp,amp));
			cube.ang.P.set(random(-PI,PI),random(-PI,PI),random(-PI,PI));
		}
	}
}

float[][] TowerGrid(int col, int row, int y) {
	float[][] ar = new float[y][];
	ar[0] = ParapetGrid(col, row);
	for (int i = 1 ; i < y-1 ; i ++) {
		ar[i] = WallGrid(col, row);
	}
	ar[y-1] = FloorGrid(col, row);
	return ar;
}

float[][] Wall2DGrid(int x, int y) {
	float[][] ar = new float[y][];
	for (int i = 0 ; i < y ; i ++) {
		ar[i] = new float[x*2];
		for (int k = 0 ; k < x ; k ++) {
			ar[i][k*2] = k;
			ar[i][k*2+1] = 0;
		}
	}
	return ar;
}

float[] FloorGrid(int col, int row) {
	float[] ar = new float[col*row*2];
	for (int i = 0 ; i < col ; i ++) {
		for (int k = 0 ; k < row ; k ++) {
			ar[(i*col+k)*2] = i;
			ar[(i*col+k)*2+1] = k;
		}
	}
	return ar;
}

float[] ParapetGrid(int col, int row) {
	float[] ar = new float[(col*2+row*2-2)];

	int k = 0;
	for (int i = 0 ; i < col/2 ; i ++) {
		ar[i*2] = k;
		ar[i*2+1] = 0;
		k += 2;
	}
	k = 0;
	for (int i = col/2 ; i < (col+row-1)/2 ; i ++) {
		ar[i*2] = 0;
		ar[i*2+1] = k;
		k += 2;
	}
	k = 0;
	for (int i = (col+row-1)/2 ; i < (col*2+row-1)/2 ; i ++) {
		ar[i*2] = k;
		ar[i*2+1] = row-1;
		k += 2;
	}
	k = 0;
	for (int i = (col*2+row-1)/2 ; i < (col*2+row*2-2)/2 ; i ++) {
		ar[i*2] = col-1;
		ar[i*2+1] = k;
		k += 2;
	}
	return ar;
}

float[] WallGrid(int col, int row) {
	float[] ar = new float[(col*2+row*2-2)*2];

	int k = 0;
	for (int i = 0 ; i < col ; i ++) {
		ar[i*2] = k;
		ar[i*2+1] = 0;
		k ++;
	}
	k = 1;
	for (int i = col ; i < col+row-1 ; i ++) {
		ar[i*2] = 0;
		ar[i*2+1] = k;
		k ++;
	}
	k = 0;
	for (int i = col+row-1 ; i < col*2+row-1 ; i ++) {
		ar[i*2] = k;
		ar[i*2+1] = row-1;
		k ++;
	}
	k = 1;
	for (int i = col*2+row-1 ; i < col*2+row*2-2 ; i ++) {
		ar[i*2] = col-1;
		ar[i*2+1] = k;
		k ++;
	}
	return ar;
}