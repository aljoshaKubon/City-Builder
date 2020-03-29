extends Node

func _input(event):
	if Globals.state == "Game":
		if event.is_action_pressed("mouse_left"):
			Globals.buildManager.isBuilding = true
		if event.is_action_pressed("mouse_right"):
			Globals.buildManager.isClearing = true
		if event.is_action_pressed("ui_focus_next"):
			Globals.buildMode += 1
			Globals.buildMode = Globals.buildMode % 3
		if event.is_action_released("mouse_left"):
			Globals.buildManager.isBuilding = false
		if event.is_action_released("mouse_right"):
			Globals.buildManager.isClearing = false

		if event.is_action_pressed("ui_focus_next"):
			Globals.buildMode = (Globals.buildMode+ 1) % 3

		if event.is_action_pressed("ui_left"):
			Globals.camera._dir.x = -1;
		if event.is_action_pressed("ui_right"):
			Globals.camera._dir.x = 1;
		if event.is_action_pressed("ui_down"):
			Globals.camera._dir.y = 1;
		if event.is_action_pressed("ui_up"):
			Globals.camera._dir.y = -1;

		if event.is_action_pressed("zoom_in"):
			Globals.camera.zoom(-0.05);
		if event.is_action_pressed("zoom_out"):
			Globals.camera.zoom(0.05);

		if event.is_action_released("ui_left"):
			Globals.camera._dir.x = 0;
		if event.is_action_released("ui_right"):
			Globals.camera._dir.x = 0;
		if event.is_action_released("ui_down"):
			Globals.camera._dir.y = 0;
		if event.is_action_released("ui_up"):
			Globals.camera._dir.y = 0;
	
		if event.is_action_pressed("ui_cancel"):
			Globals.gui.toggle("SettingsMenu")