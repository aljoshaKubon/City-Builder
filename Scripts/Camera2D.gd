extends Camera2D

var _speed;

func _ready():
	_speed = 10;
	
#warning-ignore:return_value_discarded
	InputManager.connect("zoom_in", self, "_on_zoom_in")
#warning-ignore:return_value_discarded
	InputManager.connect("zoom_out", self, "_on_zoom_out")

#warning-ignore:unused_argument
func _process(delta):
	if isMoving():
		move();

func move():
	self.offset.x += Globals.cameraDirection.x * _speed;
	self.offset.y += Globals.cameraDirection.y * _speed;
	
func zoom(value):
	if !(self.zoom.x + value < 0.5):
		self.zoom.x += value;
		self.zoom.y += value;

func isMoving():
	return Globals.cameraDirection != Vector2(0,0);
	
func _on_zoom_in():
	zoom(-0.05)

func _on_zoom_out():
	zoom(0.05)
