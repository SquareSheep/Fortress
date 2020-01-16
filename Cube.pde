class Cube extends MobF {

	boolean locked = false;
	Point anchor;

	Cube(float x, float y, float z, float w) {
		this.p = new Point(x,y,z);
		this.ang = new Point(0,0,0);
		this.w = w;
	}

	Cube(float x, float y, float z) {
		this(x,y,z, cubeW);
	}

	void render() {
		setDraw();
		box(w);
		pop();
	}
}