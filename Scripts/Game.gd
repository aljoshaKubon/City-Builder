extends Node2D

onready var buildManager = load("res://Scripts/BuildManager.gd").new()
onready var cityManager = load("res://Scripts/CityManager.gd").new()
onready var camera = get_node("Camera2D")
onready var gui = get_node("Camera2D/CanvasLayer/GUI")
onready var inputManager = load("res://Scripts/InputManager.gd").new()

func _ready():
	add_child(buildManager)
	add_child(cityManager)
	add_child(inputManager)
	Globals.buildManager = buildManager
	Globals.cityManager = cityManager
	Globals.camera = camera
	Globals.gui = gui
	Globals.state = "Game"

func _process(delta):
	cityManager.update()
	buildManager.update()
	gui.update()