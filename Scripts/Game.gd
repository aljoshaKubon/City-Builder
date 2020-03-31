extends Node2D

onready var buildManager = load("res://Scripts/BuildManager.gd").new()
onready var cityManager = load("res://Scripts/CityManager.gd").new()
onready var gui = get_node("Camera2D/CanvasLayer/GUI")
onready var inputManager = load("res://Scripts/InputManager.gd").new()

func _ready():
	add_child(buildManager)
	add_child(cityManager)
	add_child(inputManager)

	if Globals.state == "New Game":
		createGame()
	if Globals.state == "Load Game":
		loadGame()

func createGame():
	createTileMatrix()
	buildManager.init()
	Globals.state = "Game"

func loadGame():
	print("TODO loadGame()")
	loadTileMatrix()

func createTileMatrix():
	Globals.tileMatrix = []
	for x in range(Globals.tileMatrixSize):
		Globals.tileMatrix.append([])
		Globals.tileMatrix[x] = []
		for y in range(Globals.tileMatrixSize):
			Globals.tileMatrix[x].append([])
			if x == Globals.tileMatrixSize/2 && y == Globals.tileMatrixSize/2:
				Globals.tileMatrix[x][y] = 0
			else:
				Globals.tileMatrix[x][y] =- 1

func loadTileMatrix():
	print("-> TODO loadTileMatrix()")

#warning-ignore:unused_argument
func _process(delta):
	gui.update()