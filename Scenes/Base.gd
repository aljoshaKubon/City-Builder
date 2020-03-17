extends Node2D

onready var buildManager = load("res://Scripts/BuildManager.gd").new()

func _ready():
	add_child(buildManager)
	Globals.buildManager = buildManager