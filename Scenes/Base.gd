extends Node2D

onready var buildManager = load("res://Scripts/BuildManager.gd").new()
onready var tilemap = preload("res://Scenes/TileMap.tscn").instance()
onready var outline = preload("res://Scenes/Outline.tscn").instance()
onready var navigator = load("res://Scripts/Navigator.gd").new()

func _ready():
	add_child(buildManager)
	add_child(tilemap)
	initGlobals()
	add_child(outline)
	add_child(navigator)

func initGlobals():
	Globals.tileMap = tilemap