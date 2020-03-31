extends TileMap

var isBuilding
var isClearing

func _ready():
	isBuilding = false
	isClearing = false
	initTileMap()

func initTileMap():
	for x in Globals.tileMatrixSize:
		for y in Globals.tileMatrixSize:
			self.set_cell(x,y, Globals.tileMatrix[x][y])

func buildTile(cellX, cellY, isCorrecting):
	#self.set_cell(cellX, cellY, GlobalDictionary.buildItems[Globals.buildID])
	print("TODO buildTile in TileMap called by BuildManager.build()")
	#	if Globals.buildMode == 1:
	#			buildRoad(cellX, cellY, isCorrecting)
	#	elif Globals.buildMode == 2:
	#		buildHouse(cellX, cellY)
	#		Globals.population = Globals.population + 5
	#	if grassTileMap.isTree(cellX, cellY):
	#		grassTileMap.set_cell(cellX, cellY, 0)

func clearTile(cellX, cellY):
	print("TODO clearTile in TileMap called by BuildManager.clear()")
	#self.set_cell(cellX, cellY, -1)
	#if Globals.buildMode == 1:
	#	correctNeighbors(cellX, cellY)

func buildRoad(cellX, cellY, isCorrecting): 
	var neighbors = getNeighbors(cellX, cellY)
	#Intersection
	if isRoad(neighbors[0]) && isRoad(neighbors[1]) && isRoad(neighbors[2]) && isRoad(neighbors[3]):
		buildRoadTile(cellX, cellY, 4, false, false, false)
	#Deadend - Buttom
	elif !isRoad(neighbors[0]) && !isRoad(neighbors[1]) && !isRoad(neighbors[2]):
		buildRoadTile(cellX, cellY, 3, false, false, false)
	#Deadend - Right
	elif !isRoad(neighbors[1]) && !isRoad(neighbors[2]) && !isRoad(neighbors[3]):
		buildRoadTile(cellX, cellY, 3, true, false, true)
	#Deadend - Left
	elif !isRoad(neighbors[0]) && !isRoad(neighbors[1]) && !isRoad(neighbors[3]):
		buildRoadTile(cellX, cellY, 3, false, true, true)
	#Deadend - Top
	elif !isRoad(neighbors[0]) && !isRoad(neighbors[3]) && !isRoad(neighbors[2]):
		buildRoadTile(cellX, cellY, 3, false, true, false)
	#T-Junction - Up
	elif isRoad(neighbors[0]) && isRoad(neighbors[1]) && isRoad(neighbors[2]):
		buildRoadTile(cellX, cellY, 2, false, true, false)
	#T-Junction - Down
	elif isRoad(neighbors[0]) && isRoad(neighbors[3]) && isRoad(neighbors[2]):
		buildRoadTile(cellX, cellY, 2, false, false, false)
	#T-Junction - Left
	elif isRoad(neighbors[0]) && isRoad(neighbors[1])&& isRoad(neighbors[3]):
		buildRoadTile(cellX, cellY, 2, true, true, true)
	#T-Junction - Right
	elif isRoad(neighbors[2]) && isRoad(neighbors[1]) && isRoad(neighbors[3]):
		buildRoadTile(cellX, cellY, 2, false, false, true)
	#Curve Top-Left
	elif isRoad(neighbors[0]) && isRoad(neighbors[1]):
		buildRoadTile(cellX, cellY, 1, true, true, false)
	#Curve Top-Right
	elif isRoad(neighbors[2]) && isRoad(neighbors[1]):
		buildRoadTile(cellX, cellY, 1, false, true, false)
	#Curve Bottom-Left
	elif isRoad(neighbors[0]) && isRoad(neighbors[3]):
		buildRoadTile(cellX, cellY, 1, true, false, false)
	#Curve Buttom-Right
	elif isRoad(neighbors[2]) && isRoad(neighbors[3]):
		buildRoadTile(cellX, cellY, 1, false, false, false)
	#Vertical road
	elif isRoad(neighbors[1]) || isRoad(neighbors[3]):
		buildRoadTile(cellX, cellY, 0, false, false, false)
	#Horizontal road
	elif isRoad(neighbors[0]) || isRoad(neighbors[2]):
		buildRoadTile(cellX, cellY, 0, false, false, true)
	if !isCorrecting:
		correctNeighbors(cellX, cellY)

func isRoad(tile):
	return tile == 0 || tile == 1 || tile == 2 || tile == 3 || tile == 4

func buildRoadTile(cellX, cellY, tileIndex, flipX, flipY, transpose):
	self.set_cell(cellX, cellY, tileIndex, flipX, flipY, transpose)

func buildHouse(cellX, cellY):
	buildHouseTile(cellX, cellY)

func buildHouseTile(cellX, cellY):
	var neighbors = getNeighbors(cellX, cellY)
	var random = RandomNumberGenerator.new()
	random.randomize()
	var houseTileOffset = random.randi_range(0, 3)
	var tileOffset = 3

	if isRoad(neighbors[3]):
			self.set_cell(cellX, cellY, 5 + (tileOffset * houseTileOffset))
	elif isRoad(neighbors[1]):
			self.set_cell(cellX, cellY, 6+ (tileOffset * houseTileOffset))
	elif isRoad(neighbors[0]):
			self.set_cell(cellX, cellY, 7+ (tileOffset * houseTileOffset))
	elif isRoad(neighbors[2]):
			self.set_cell(cellX, cellY, 7+ (tileOffset * houseTileOffset))

func correctNeighbors(cellX, cellY):
	if isRoad(self.get_cell(cellX-1, cellY)):
		buildTile(cellX-1, cellY, true)
	if isRoad(self.get_cell(cellX, cellY-1)):
		buildTile(cellX, cellY-1, true)
	if isRoad(self.get_cell(cellX+1, cellY)):
		buildTile(cellX+1, cellY, true)
	if isRoad(self.get_cell(cellX, cellY+1)):
		buildTile(cellX, cellY+1, true)

func getNeighbors(cellX, cellY):
	#left, top, right, bottom
	var neighbors = [0,0,0,0]
	neighbors[0] = self.get_cell(cellX-1, cellY)
	neighbors[1] = self.get_cell(cellX, cellY-1)
	neighbors[2] = self.get_cell(cellX+1, cellY)
	neighbors[3] = self.get_cell(cellX, cellY+1)
	return neighbors