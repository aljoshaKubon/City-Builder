extends Node

signal zoom_in
signal zoom_out
signal toggle_buildMenu
signal toggle_settingsMenu
signal build
signal clear

func _input(event):
	if Globals.state == "Game":
		if event.is_action_pressed("mouse_left"):
			emit_signal("build")
		if event.is_action_pressed("mouse_right"):
			emit_signal("clear")

		if event.is_action_pressed("zoom_in"):
			emit_signal("zoom_in")
		if event.is_action_pressed("zoom_out"):
			emit_signal("zoom_out")
		if event.is_action_pressed("ui_left"):
			Globals.cameraDirection.x = -1
		if event.is_action_pressed("ui_right"):
			Globals.cameraDirection.x = 1
		if event.is_action_pressed("ui_down"):
			Globals.cameraDirection.y = 1
		if event.is_action_pressed("ui_up"):
			Globals.cameraDirection.y = -1

		if event.is_action_released("ui_left"):
			Globals.cameraDirection.x = 0
		if event.is_action_released("ui_right"):
			Globals.cameraDirection.x = 0
		if event.is_action_released("ui_down"):
			Globals.cameraDirection.y = 0
		if event.is_action_released("ui_up"):
			Globals.cameraDirection.y = 0

		if event.is_action_pressed("ui_cancel"):
			emit_signal("toggle_settingsMenu")
		if event.is_action_pressed("ui_buildMenu_toggle"):
			emit_signal("toggle_buildMenu")

	elif Globals.state == "Paused":
		if event.is_action_pressed("ui_cancel"):
			emit_signal("toggle_settingsMenu")
		if event.is_action_pressed("ui_buildMenu_toggle"):
			emit_signal("toggle_buildMenu")