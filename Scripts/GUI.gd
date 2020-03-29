extends Control

onready var bottomMenu = get_node("BottomMenu")
onready var debugMenu = get_node("DebugMenu")

func update():
	bottomMenu.update()
	debugMenu.update()

func toggle(menuName):
	var node = get_node(menuName)
	node.toggle()