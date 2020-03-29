extends Node

var timer = Timer.new()
var delay = 2

func _ready():
	add_child(timer)
	timer.connect("timeout",self,"_on_timer_timeout") 
	timer.set_one_shot(true)
	timer.start(delay)

func update():
	pass

func _on_timer_timeout():
	proceedTaxes()
	timer.start(delay)

func proceedTaxes():
	Globals.money = Globals.money + Globals.population*Globals.taxRate