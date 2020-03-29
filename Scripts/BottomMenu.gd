extends Control

onready var foldedMenu = get_node("Folded")

var currentMenu

func _ready():
	currentMenu = foldedMenu

func update():
	currentMenu.update()