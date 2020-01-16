/*
PointGrid models are built top-down, level by level
ar[] is each level. ar[][] is each point
*/

boolean inGridArray(int[] ar, int val) {
	for (int k : ar) {
		if (k == val) return true;
	}
	return false;
}

int[] rectGrid(int row, int col) {
	int[] ar = new int[row*col*2];
	for (int i = 0 ; i < row ; i ++) {
		for (int k = 0 ; k < col ; k ++) {
			ar[i*row*2+k*2] = i;
			ar[i*row*2+k*2+1] = k;
		}
	}
	return ar;
}

int[] hollowRectGrid(int row, int col, int[] none) {
	int[] ar = new int[row*4+col*4];
	int i = 0;
	int x = -1;
	int z = 0;
	while (i < ar.length) {
		while (inGridArray(none,i)) {
			i+=2;
		}
		if (i < col*2) {
			x++;
		} else if (i < col*2+row*2) {
			z++;
		} else if (i < col*4+row*2) {
			x--;
		} else {
			z--;
		}
		ar[i] = x;
		ar[i+1] = z;
		i += 2;
	}
	return ar;
}

int[] hollowRectGrid(int row, int col) {
	int[] ar = new int[row*4+col*4];
	for (int i = 1 ; i < col ; i ++) {
		ar[i*2] = i;
		ar[i*2+1] = 0;
	}
	for (int i = 0 ; i < col-1 ; i ++) {
		ar[col*2 + i*2] = i;
		ar[col*2 + i*2+1] = col - 1;
	}
	for (int i = 0 ; i < row-1 ; i ++) {
		ar[col*2+row*2+i*2] = 0;
		ar[col*2+row*2+i*2+1] = i;
	}
	for (int i = 1 ; i < row ; i ++) {
		ar[col*4+row*2 + i*2] = row-1;
		ar[col*4+row*2 + i*2+1] = i;
	}
	return ar;
}

class PointGrid extends Mob {
	Point[][] ar;
	int i; int k;

	PointGrid(PVector p, int[][] ar, float w, float row, float col) {
		this.p = new Point(p);
		this.ang = new Point();
		this.ar = new Point[ar.length][];
		for (i = 0 ; i < ar.length ; i ++) {
			this.ar[i] = new Point[ar[i].length/2];
			for (k = 0 ; k < ar[i].length ; k += 2) {
				this.ar[i][k/2] = new Point(-w*col*0.5+w/2 + ar[i][k]*w, i*w, -w*row*0.5+w/2 + ar[i][k+1]*w);
			}
		}
		draw = false;
	}

	void update() {
		super.update();
		for (i = 0 ; i < ar.length ; i ++) {
			for (k = 0 ; k < ar[i].length ; k ++) {
				ar[i][k].update();
			}
		}
	}

	void render() {
		setDraw();
		fill(0);
		stroke(0);
		strokeWeight(10);
		for (i = 0 ; i < ar.length ; i ++) {
			for (k = 0 ; k < ar[i].length ; k ++) {
				point(ar[i][k].p.x, ar[i][k].p.y, ar[i][k].p.z);
			}
		}
		pop();
	}
}