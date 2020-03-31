extends Control

onready var label_money = get_node("BottomPanel/HBoxContainer/Finanzen/Money/MarginContainer/Money");
onready var label_population = get_node("BottomPanel/HBoxContainer/Population/Population/MarginContainer/Population")

func update():
	label_money.text = str(Globals.money)
	label_population.text = str(Globals.population)