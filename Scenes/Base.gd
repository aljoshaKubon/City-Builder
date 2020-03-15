extends Node2D

onready var tileMap = preload("res://Scenes/TileMap.tscn").instance()
onready var outline = preload("res://Scenes/Outline.tscn").instance()
onready var buildManager = load("res://Scripts/BuildManager.gd").new(tileMap)

func _ready():
	add_child(tileMap)
	add_child(outline)
	add_child(buildManager)