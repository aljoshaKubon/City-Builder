extends Control

func _ready():
	pass # Replace with function body.

func toggle():
	self.visible = !self.visible

func _on_Resume_pressed():
	self.toggle()

func _on_Options_pressed():
	pass # Replace with function body.

func _on_Load_pressed():
	pass # Replace with function body.

func _on_Exit_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
	Globals.state = "Menu"
