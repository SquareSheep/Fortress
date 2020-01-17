static float zW = 0.25;
static float zMult = 0.7;
class Heart extends Poly {

	Heart(PVector p, float w) {
		super(p, new PVector(0,0,0), w, new float[]{
			-1,0,0, -1,-0.5,0, -0.5,-1,0, 0,-0.5,0, 0.5,-1,0, 1,-0.5,0, 1,0,0, 0,1,0,
			-1*zMult,0,zW, -1*zMult,-0.5*zMult,zW, -0.5*zMult,-1*zMult,zW, 
				0,-0.5*zMult,zW, 0.5*zMult,-1*zMult,zW, 1*zMult,-0.5*zMult,zW, 1*zMult,0,zW, 0,1*zMult,zW,
			-1*zMult,0,-zW, -1*zMult,-0.5*zMult,-zW, -0.5*zMult,-1*zMult,-zW, 
				0,-0.5*zMult,-zW, 0.5*zMult,-1*zMult,-zW, 1*zMult,-0.5*zMult,-zW, 1*zMult,0,-zW, 0,1*zMult,-zW
		},
		new int[][]{
			new int[]{8, 9, 10,11,12,13,14,15},
			new int[]{0,1,9,8}, new int[]{1,2,10,9}, new int[]{2,3,11,10}, new int[]{3,4,12,11}, 
			new int[]{4,5,13,12}, new int[]{5,6,14,13}, new int[]{6,7,15,14}, new int[]{7,0,8,15},
			new int[]{0,1,17,16}, new int[]{1,2,18,17}, new int[]{2,3,19,18}, new int[]{3,4,20,19},
			new int[]{4,5,21,20}, new int[]{5,6,22,21}, new int[]{6,7,23,22}, new int[]{7,0,16,23},
			new int[]{16,17,18,19,20,21,22,23}
		});
		for (int i = 0 ; i < fillStyle.length ; i ++) {
			fillStyle[i].reset(255-i*5,80-i*2,80-i*2,255,2,-5,-5,-1.5,((float)i/fillStyle.length*binCount+50)%binCount);
		}
	}

	void update() {
		super.update();
		sca.X = 1+avg/1000;
		if (timer.beat) sca.x += 0.25;
	}
}