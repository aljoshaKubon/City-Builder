extends Camera2D

var _dir;
var _speed;

func _ready():
	_dir = Vector2(0,0);
	_speed = 10;
	
#warning-ignore:unused_argument
func _process(delta):
	if isMoving():
		move();

func move():
	self.offset.x += _dir.x * _speed;
	self.offset.y += _dir.y * _speed;
	
func zoom(value):
	if !(self.zoom.x + value < 0.5):
		self.zoom.x += value;
		self.zoom.y += value;

func isMoving():
	return _dir != Vector2(0,0);

func _input(event):
	if event.is_action_pressed("ui_left"):
		_dir.x = -1;
	if event.is_action_pressed("ui_right"):
		_dir.x = 1;
	if event.is_action_pressed("ui_down"):
		_dir.y = 1;
	if event.is_action_pressed("ui_up"):
		_dir.y = -1;
		
	if event.is_action_pressed("zoom_in"):
		zoom(-0.05);
	if event.is_action_pressed("zoom_out"):
		zoom(0.05);

	if event.is_action_released("ui_left"):
		_dir.x = 0;
	if event.is_action_released("ui_right"):
		_dir.x = 0;
	if event.is_action_released("ui_down"):
		_dir.y = 0;
	if event.is_action_released("ui_up"):
		_dir.y = 0;