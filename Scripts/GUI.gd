extends Control

onready var bottomMenu = get_node("BottomMenu")
onready var debugMenu = get_node("DebugMenu")
onready var buildMenu = get_node("BuildMenu")

func update():
	bottomMenu.update()
	debugMenu.update()
	buildMenu.update()

func toggle(menuName):
	var node = get_node(menuName)
	node.toggle()