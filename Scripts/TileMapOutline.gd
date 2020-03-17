extends TileMap

var tilePos;
onready var buildManager = get_parent()

func _ready():
	tilePos = Vector2(-1, -1);

#warning-ignore:unused_argument
func _process(delta):
	drawCursor();

func drawCursor():
	var mousePos = get_global_mouse_position();
	if self.world_to_map(mousePos) != tilePos:
		if !buildManager.buildableCells.has(tilePos) && !buildManager.unreachableCells.has(tilePos):
			self.set_cell(tilePos.x, tilePos.y, -1)
		tilePos = self.world_to_map(mousePos);
		self.set_cell(tilePos.x, tilePos.y, 0);
		Globals.cursorCoords = Vector2(tilePos.x, tilePos.y);

func drawBuildable(buildableCells):
	self.clear();
	for cell in buildableCells:
		self.set_cell(cell.x, cell.y, 1)

func drawUnreachable(unreachableTiles):
	if unreachableTiles.size() != 0:
		for tile in unreachableTiles:
			self.set_cell(tile.x, tile.y, 2)

func isBuildable(cellX, cellY):
	var neighbors = getNeighbors(cellX, cellY)
	return Globals.tileMatrix[cellX][cellY] == 0 && (isRoad(neighbors[0]) || isRoad(neighbors[1]) || isRoad(neighbors[2]) || isRoad(neighbors[3]))

func getNeighbors(cellX, cellY):
	#left, top, right, bottom
	var neighbors = [0,0,0,0];
	neighbors[0] = getNeighbor(cellX-1,cellY);
	neighbors[1] = getNeighbor(cellX,cellY-1);
	neighbors[2] = getNeighbor(cellX+1,cellY);
	neighbors[3] = getNeighbor(cellX,cellY+1);
	return neighbors;

func getNeighbor(cellX, cellY):
	if cellX >= 0 && cellX < Globals.tileMatrixSize && cellY >= 0 && cellY < Globals.tileMatrixSize:
		return Globals.tileMatrix[cellX][cellY]
	else:
		return -1;

func isRoad(tile):
	return tile == 1 || tile == 2 || tile == 3 || tile == 4 || tile == 5