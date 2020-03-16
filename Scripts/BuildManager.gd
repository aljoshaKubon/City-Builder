extends Node

var isBuilding
var isClearing
var tilePos

func _init():
	initTileMatrix()
	initEntry()

func initEntry():
	var r = RandomNumberGenerator.new()
	r.randomize()
	var randomSide = int(round(r.randf()*3))
	var entryCoord = r.randi_range(round(Globals.tileMatrixSize/4), Globals.tileMatrixSize-round((Globals.tileMatrixSize/4)))
	
	match(randomSide):
		0: #left
			Globals.tileMatrix[0][entryCoord] = 1;
			Globals.entry = Vector2(0, entryCoord)
		1: #top
			Globals.tileMatrix[entryCoord][0] = 1;
			Globals.entry = Vector2(entryCoord, 0)
		2: #right
			Globals.tileMatrix[Globals.tileMatrixSize-1][entryCoord] = 1;
			Globals.entry = Vector2(Globals.tileMatrixSize-1, entryCoord)
		3: #button
			Globals.tileMatrix[entryCoord][Globals.tileMatrixSize-1] = 1;
			Globals.entry = Vector2(entryCoord, Globals.tileMatrixSize-1)

func initTileMatrix():
	Globals.tileMatrix = []
	for x in range(Globals.tileMatrixSize):
		Globals.tileMatrix.append([])
		Globals.tileMatrix[x] = []
		for y in range(Globals.tileMatrixSize):
			Globals.tileMatrix[x].append([])
			Globals.tileMatrix[x][y]=0

func _input(event):
	if event.is_action_pressed("mouse_left"):
		isBuilding = true
	if event.is_action_pressed("mouse_right"):
		isClearing = true
	if event.is_action_pressed("ui_focus_next"):
		Globals.buildMode += 1
		Globals.buildMode = Globals.buildMode % 3

	if event.is_action_released("mouse_left"):
		isBuilding = false
	if event.is_action_released("mouse_right"):
		isClearing = false

# warning-ignore:unused_argument
func _process(delta):
	tilePos = Globals.tileMap.world_to_map(Globals.tileMap.get_global_mouse_position())
	
	if tilePos.x >= 0 && tilePos.x < Globals.tileMatrixSize && tilePos.y >= 0 && tilePos.y < Globals.tileMatrixSize:
		if isBuilding && canBuild(tilePos):
			Globals.tileMap.buildTile(tilePos.x, tilePos.y, false)
			_updateTileMatrix()
		if isClearing && canClear(tilePos):
			Globals.tileMap.clearTile(tilePos.x, tilePos.y)
			_updateTileMatrix()

func _updateTileMatrix():
	for x in range(Globals.tileMatrixSize):
		for y in range(Globals.tileMatrixSize):
			Globals.tileMatrix[x][y] = Globals.tileMap.get_cell(x,y)

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
	return tile == 1 || tile == 2 || tile == 3 || tile == 4 || tile == 5

func isHouse(tile):
	return tile == 6 || tile == 7 || tile == 8

func isBuildable(cell):
	var neighbors = getNeighbors(cell.x, cell.y)
	return Globals.tileMatrix[cell.x][cell.y] == 0 && (isRoad(neighbors[0]) || isRoad(neighbors[1]) || isRoad(neighbors[2]) || isRoad(neighbors[3]))

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