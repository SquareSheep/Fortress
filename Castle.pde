class Castle extends PointGrid {
	
	Castle(PVector p, float w) {
		super(p,
			new int[][]{
				hollowRectGrid(10,10, new int[]{0,1,2,3}),
				hollowRectGrid(10,10),
				// hollowRectGrid(10,10),
				// hollowRectGrid(10,10),
				// hollowRectGrid(10,10),
				// hollowRectGrid(10,10),
				// rectGrid(10,10)
			},
		w,10,10);
	}
}