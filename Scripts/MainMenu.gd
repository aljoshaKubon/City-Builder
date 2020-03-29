extends Control

func _ready():
	pass # Replace with function body.

func _on_New_Game_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")

func _on_Load_Game_pressed():
	pass # Replace with function body.

func _on_Exit_pressed():
	get_tree().quit()
