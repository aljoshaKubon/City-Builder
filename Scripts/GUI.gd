extends Control

onready var label_money = get_node("Money");
onready var label_buildmode = get_node("Buildmode");
onready var label_coords = get_node("Coords");
onready var label_population = get_node("Population")

func _ready():
	label_money.text = "Money: " + str(Globals.money);
	label_buildmode.text = "Buildmode: " + str(Globals.buildMode);
	label_coords.text = "Coords: " + str(Globals.cursorCoords); 
	label_population.text = "Population: " + str(Globals.population);

#warning-ignore:unused_argument
func _process(delta):
	label_money.text = "Money: " + str(Globals.money);
	label_buildmode.text = "Buildmode: " + str(Globals.buildMode);
	label_coords.text = "Coords: " + str(Globals.cursorCoords); 
	label_population.text = "Population: " + str(Globals.population);