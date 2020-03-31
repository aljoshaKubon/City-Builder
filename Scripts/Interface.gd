extends Control

onready var bottomMenu = get_node("BottomMenu")
onready var settingsMenu = get_node("SettingsMenu")
onready var debugMenu = get_node("DebugMenu")
onready var buildMenu = get_node("BuildMenu")

func _ready():
#warning-ignore:return_value_discarded
	InputManager.connect("toggle_settingsMenu", self, "_on_toggle_settingsMenu")
#warning-ignore:return_value_discarded
	InputManager.connect("toggle_buildMenu", self, "_on_toggle_buildMenu")

func update():
	bottomMenu.update()
	debugMenu.update()
	buildMenu.update()

func _on_toggle_settingsMenu():
	if Globals.state == "Paused":
		if settingsMenu.visible:
			settingsMenu.toggle()
			Globals.state = "Game"
	elif Globals.state == "Game":
		settingsMenu.toggle()
		Globals.state = "Paused"

func _on_toggle_buildMenu():
	if Globals.state == "Paused":
		if buildMenu.visible:
			buildMenu.toggle()
			Globals.state = "Game"
	elif Globals.state == "Game":
		buildMenu.toggle()
		Globals.state = "Paused"