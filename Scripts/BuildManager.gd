extends Node

var tilePos = Vector2()
var traversableTiles = []
var buildableCells = []
var unreachableCells = []

onready var tileMap = load("res://Scenes/TileMap.tscn").instance()
onready var tileMapOutline = load("res://Scenes/Outline.tscn").instance()

func _ready():
#warning-ignore:return_value_discarded
	InputManager.connect("build", self, "_on_build")
#warning-ignore:return_value_discarded
	InputManager.connect("clear", self, "_on_clear")

func _on_build():
	tilePos = tileMap.world_to_map(tileMap.get_global_mouse_position())
	if tilePos.x >= 0 && tilePos.x < Globals.tileMatrixSize && tilePos.y >= 0 && tilePos.y < Globals.tileMatrixSize:
		tileMap.buildTile(tilePos.x, tilePos.y, false)
		updateChanges()

func _on_clear():
	tilePos = tileMap.world_to_map(tileMap.get_global_mouse_position())
	if tilePos.x >= 0 && tilePos.x < Globals.tileMatrixSize && tilePos.y >= 0 && tilePos.y < Globals.tileMatrixSize:
		tileMap.clearTile(tilePos.x, tilePos.y)
		updateChanges()

func init():
	add_child(tileMap)
	add_child(tileMapOutline)

func updateChanges():
	updateTileMatrix()
	#calculateBuildableCells()
	tileMapOutline.drawBuildable(buildableCells)
	tileMapOutline.drawUnreachable(unreachableCells)

func updateTileMatrix():
	print("TODO: updateTileMatrix(tilePos in BuildManager")
	#TODO: Update nur das veränderte Tile
	
	for x in range(Globals.tileMatrixSize):
		for y in range(Globals.tileMatrixSize):
			Globals.tileMatrix[x][y] = tileMap.get_cell(x,y)
	#Globals.tileMatrix[tilePos.x][tilePos.y] = tileMap.get_cell(tilePos.x,tilePos.y)

#warning-ignore:unused_argument
func canBuild(cell):
	print("TODO: canBuild(cell) in BuildManager")
	#if Globals.buildMode == 1:
	#	return isBuildable(cell)
	#elif Globals.buildMode == 2:
	#	return isBuildable(cell)

#warning-ignore:unused_argument
func canClear(cell):
	print("TODO: canClear(cell) in BuildManager")
	#if Globals.buildMode == 1:
	#	return isRoad(Globals.tileMatrix[cell.x][cell.y])
	#elif Globals.buildMode == 2:
	#	return isHouse(Globals.tileMatrix[cell.x][cell.y])

func isRoad(tile):
	return tile == 0 || tile == 1 || tile == 2 || tile == 3 || tile == 4

func isHouse(tile):
	return tile == 5 || tile == 6 || tile == 7 || tile == 8 || tile == 9 || tile == 10 || tile == 11 || tile == 12 || tile == 13 || tile == 14 || tile == 15 || tile == 16

func calculateBuildableCells():
	buildableCells = []
	for x in range(Globals.tileMatrixSize):
		for y in range(Globals.tileMatrixSize):
			if isBuildable(Vector2(x, y)):
				buildableCells.append(Vector2(x, y))

func calculateUnreachableCells():
	unreachableCells = []
	var entry = tileMap.map_to_world(Globals.entry)
	for tile in traversableTiles:
		var target = tileMap.map_to_world(tile)
		if Navigator.get_computed_path(tileMap, traversableTiles, entry, target) == []:
			unreachableCells.append(tileMap.world_to_map(target))

func isBuildable(cell):
	var neighbors = getNeighbors(cell.x, cell.y)
	return Globals.tileMatrix[cell.x][cell.y] == -1 && (isRoad(neighbors[0]) || isRoad(neighbors[1]) || isRoad(neighbors[2]) || isRoad(neighbors[3]))

func getNeighbors(cellX, cellY):
	#left, top, right, bottom
	var neighbors = [0,0,0,0];
	neighbors[0] = getNeighbor(cellX-1, cellY);
	neighbors[1] = getNeighbor(cellX, cellY-1);
	neighbors[2] = getNeighbor(cellX+1, cellY);
	neighbors[3] = getNeighbor(cellX, cellY+1);
	return neighbors;

func getNeighbor(cellX, cellY):
	if cellX >= 0 && cellX < Globals.tileMatrixSize && cellY >= 0 && cellY < Globals.tileMatrixSize:
		return Globals.tileMatrix[cellX][cellY]
	else:
		return -1;
