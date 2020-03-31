extends TileMap

func _ready():
	initTileMap()

func initTileMap():
	var random = RandomNumberGenerator.new()
	random.randomize()
	
	for x in range(Globals.tileMatrixSize):
		for y in range(Globals.tileMatrixSize):
			initBackroundTile(x, y, random)

func initBackroundTile(x, y, random):
	var randomInteger = random.randi_range(0,10)
	
	if randomInteger <= 7:
		self.set_cell(x,y, 0)
	elif randomInteger == 8:
		self.set_cell(x,y, 1)
	elif randomInteger == 9:
		self.set_cell(x,y, 2)
	elif randomInteger == 10:
		self.set_cell(x,y, 3)

func isTree(x, y):
	return self.get_cell(x, y) == 3
