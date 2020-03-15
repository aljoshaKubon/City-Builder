extends Node

#warning-ignore:unused_class_variable
var money = 1000
#warning-ignore:unused_class_variable
var buildMode = 0
var tileMatrix
var tileMatrixSize = 32
var cursorCoords
var population = 0
var entry;

func _ready():
	initTileMatrix(tileMatrixSize)
	initEntryRoad()

func initTileMatrix(size):
	tileMatrix = []
	for x in range(size):
		tileMatrix.append([])
		tileMatrix[x] = []
		for y in range(size):
			tileMatrix[x].append([])
			tileMatrix[x][y]=0

func initEntryRoad():
	var r = RandomNumberGenerator.new()
	r.randomize()
	var randomSide = int(round(r.randf()*3))
	var entryCoord = r.randi_range(round(tileMatrixSize/4), tileMatrixSize-round((tileMatrixSize/4)))
	
	match(randomSide):
		0: #left
			tileMatrix[0][entryCoord] = 1;
			entry = Vector2(0, entryCoord)
		1: #top
			tileMatrix[entryCoord][0] = 1;
			entry = Vector2(entryCoord, 0)
		2: #right
			tileMatrix[tileMatrixSize-1][entryCoord] = 1;
			entry = Vector2(tileMatrixSize-1, entryCoord)
		3: #button
			tileMatrix[entryCoord][tileMatrixSize-1] = 1;
			entry = Vector2(entryCoord, tileMatrixSize-1)