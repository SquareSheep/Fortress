class Tower extends BuildingGrid {
	Tower(float x, float y, float z, float w, int col, int row) {
		super(x,y,z, w, new float[][]{
			ParapetGrid(col,row),
			WallGrid(col,row),
			WallGrid(col,row),
			WallGrid(col,row),
			WallGrid(col,row),
			WallGrid(col,row),
			WallGrid(col,row),
			WallGrid(col,row),
			WallGrid(col,row),
			WallGrid(col,row),
			WallGrid(col,row),
			FloorGrid(col,row),
		}, col*0.5-0.5,12,row*0.5-0.5);
		nofCubes = col*row + (col*2+row*2-2)*10 + (col+row-1);
	}
}

class Castle extends BuildingGrid {
	Castle(float x, float y, float z, float w, int col, int row) {
		super(x,y,z, w, new float[][]{
			ParapetGrid(col,row),
			WallGrid(col,row),
			WallGrid(col,row),
			WallGrid(col,row),
			WallGrid(col,row),
			WallGrid(col,row),
			FloorGrid(col,row),
		}, col*0.5-0.5,7,row*0.5-0.5);
		nofCubes = col*row + (col*2+row*2-2)*5 + (col+row-1);
	}
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

class BuildingGrid extends Mob {
	Point[][] ar;
	Cube[][] taken;
	CubePool cubes = new CubePool();
	int nofCubes;
	int currI = 0;
	int currZ;

	BuildingGrid(float x, float y, float z, float w, float[][] ar, float dx, float dy, float dz) {
		this.p = new Point(x,y,z);
		this.w = w;
		this.ar = new Point[ar.length][];
		this.taken = new Cube[this.ar.length][];
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
		cubes.update();
		for (int i = 0 ; i < ar.length ; i ++) {
			for (int k = 0 ; k < ar[i].length ; k ++) {
				ar[i][k].update();
			}
		}
	}

	void render() {
		push();
		translate(p.p.x,p.p.y,p.p.z);
		cubes.render();
		for (int i = 0 ; i < ar.length ; i ++) {
			for (int k = 0 ; k < ar[i].length ; k ++) {
				if (taken[i][k] != null) taken[i][k].p.P.set(ar[i][k].p.x,ar[i][k].p.y,ar[i][k].p.z);
			}
		}
		//renderPoints();
		pop();
	}

	void renderPoints() {
		stroke(255);
		strokeWeight(5);
		for (int i = 0 ; i < ar.length ; i ++) {
			for (int k = 0 ; k < ar[i].length ; k ++) {
				point(ar[i][k].p.x,ar[i][k].p.y,ar[i][k].p.z);
			}
		}
	}

	void lock(Cube cube, int z, int i) {
		if (taken[z][i] == null) {
			taken[z][i] = cube;
			cube.ang.P.set(0,0,0);
			cube.locked = true;
		}
	}

	void lock(int z, int i) {
		int k = 0;
		Cube cube;
		do {
			cube = cubes.ar.get(k);
			k ++;
		} while (k < cubes.arm && cube.locked);
		if (!cube.locked) lock(cube,z,i);
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

	void unlock(int z, int i) {
		if (taken[z][i] != null) {
			taken[z][i].locked = false;
			taken[z][i] = null;
		}
	}

	void unlockNext() {
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
				unlock(currZ, currI);
			}
		}
	}

	void unlockAll() {
		for (int i = 0 ; i < ar.length ; i ++) {
			for (int k = 0 ; k < ar[i].length ; k ++) {
				unlock(i,k);
			}
		}
	}

	void lockAll() {
		for (int i = 0 ; i < ar.length ; i ++) {
			for (int k = 0 ; k < ar[i].length ; k ++) {
				lock(i,k);
			}
		}
	}
}