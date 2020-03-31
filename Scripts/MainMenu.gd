extends Control

func _ready():
	pass # Replace with function body.

func _on_New_Game_pressed():
	Globals.state = "New Game"
#warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Game.tscn")

func _on_Load_Game_pressed():
	Globals.state = "Load Game"
#warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/LoadMenu.tscn")

func _on_Options_pressed():
#warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Options.tscn")

func _on_Exit_pressed():
	get_tree().quit()