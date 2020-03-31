extends Control

onready var coords = get_node("Panel/VBoxContainer/Coords")

func toogle():
	self.visible = !self.visible

func update():
	coords.text = "Coords: " + str(Globals.cursorCoords)
