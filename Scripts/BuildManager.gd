extends Node

var isBuilding = false
var isClearing = false
var tilePos = Vector2()
var traversableTiles = []
var buildableCells = []
var unreachableCells = []

onready var tileMap = load("res://Scenes/TileMap.tscn").instance()
onready var tileMapOutline = load("res://Scenes/Outline.tscn").instance()

func _ready():
	initTileMatrix()
	initEntry()
	traversableTiles.append(Globals.entry)
	
	add_child(tileMap)
	add_child(tileMapOutline)
	updateChanges(tilePos)

func initEntry():
	var r = RandomNumberGenerator.new()
	r.randomize()
	var randomSide = int(round(r.randf()*3))
	var entryCoord = r.randi_range(round(Globals.tileMatrixSize/4), Globals.tileMatrixSize-round((Globals.tileMatrixSize/4)))
	
	match(randomSide):
		0: #left
			Globals.tileMatrix[0][entryCoord] = 0;
			Globals.entry = Vector2(0, entryCoord)
		1: #top
			Globals.tileMatrix[entryCoord][0] = 0;
			Globals.entry = Vector2(entryCoord, 0)
		2: #right
			Globals.tileMatrix[Globals.tileMatrixSize-1][entryCoord] = 0;
			Globals.entry = Vector2(Globals.tileMatrixSize-1, entryCoord)
		3: #button
			Globals.tileMatrix[entryCoord][Globals.tileMatrixSize-1] = 0;
			Globals.entry = Vector2(entryCoord, Globals.tileMatrixSize-1)

func initTileMatrix():
	Globals.tileMatrix = []
	for x in range(Globals.tileMatrixSize):
		Globals.tileMatrix.append([])
		Globals.tileMatrix[x] = []
		for y in range(Globals.tileMatrixSize):
			Globals.tileMatrix[x].append([])
			Globals.tileMatrix[x][y]=-1
			
# warning-ignore:unused_argument
func update(delta):
	tilePos = tileMap.world_to_map(tileMap.get_global_mouse_position())
	
	if tilePos.x >= 0 && tilePos.x < Globals.tileMatrixSize && tilePos.y >= 0 && tilePos.y < Globals.tileMatrixSize:
		if isBuilding && canBuild(tilePos):
			tileMap.buildTile(tilePos.x, tilePos.y, false)
			traversableTiles.append(tilePos)
			updateChanges(tilePos)
		elif isClearing && canClear(tilePos):
			tileMap.clearTile(tilePos.x, tilePos.y)
			traversableTiles.erase(tilePos)
			updateChanges(tilePos)

func updateChanges(tilePos):
	_updateTileMatrix(tilePos)
	calculateBuildableCells(tilePos)
	tileMapOutline.drawBuildable(buildableCells)
	tileMapOutline.drawUnreachable(unreachableCells)

func _updateTileMatrix(tilePos):
	for x in range(Globals.tileMatrixSize):
		for y in range(Globals.tileMatrixSize):
			Globals.tileMatrix[x][y] = tileMap.get_cell(x,y)
	#Globals.tileMatrix[tilePos.x][tilePos.y] = tileMap.get_cell(tilePos.x,tilePos.y)

func canBuild(cell):
	if Globals.buildMode == 1:
		return isBuildable(cell)
	elif Globals.buildMode == 2:
		return isBuildable(cell)

func canClear(cell):
	if Globals.buildMode == 1:
		return isRoad(Globals.tileMatrix[cell.x][cell.y])
	elif Globals.buildMode == 2:
		return isHouse(Globals.tileMatrix[cell.x][cell.y])

func isRoad(tile):
	return tile == 0 || tile == 1 || tile == 2 || tile == 3 || tile == 4

func isHouse(tile):
	return tile == 5 || tile == 6 || tile == 7 || tile == 8 || tile == 9 || tile == 10 || tile == 11 || tile == 12 || tile == 13 || tile == 14 || tile == 15 || tile == 16

func calculateBuildableCells(tilePos):
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
