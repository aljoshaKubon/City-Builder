extends Control

onready var buildMode = get_node("Panel/VBoxContainer/Buildmode")
onready var coords = get_node("Panel/VBoxContainer/Coords")

func toogle():
	self.visible = !self.visible

func update():
	buildMode.text = "Buildmode: " + str(Globals.buildMode)
	coords.text = "Coords: " + str(Globals.cursorCoords)
