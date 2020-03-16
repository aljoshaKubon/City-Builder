extends Node

onready var line = Line2D.new()
onready var astar = AStar.new()

var half_cell_size
var traversable_tiles
var used_rect

func _ready():
	add_child(line)
	self.half_cell_size = Globals.tileMap.cell_size/2
	self.used_rect = Globals.tileMap.get_used_rect()

func _process(delta):
	astar.clear()
	self.traversable_tiles = Globals.tileMap.getTraversableTiles()
	addTraversableTiles(traversable_tiles)
	connectTraversableTiles(traversable_tiles)
	
	line.clear_points()
	var points = get_computed_path(Globals.tileMap.map_to_world(Globals.entry), Globals.tileMap.map_to_world(Globals.cursorCoords))
	if points != null:
		line.points = points

func addTraversableTiles(traversableTiles):
	for tile in traversableTiles:
		var id = getIdForPoint(tile)
		astar.add_point(id, Vector3(tile.x, tile.y, 0))

func connectTraversableTiles(traversableTiles):
	for tile in traversableTiles:
		var id = getIdForPoint(tile)
		
		for x in range(3):
			for y in range(3):
				var target = tile + Vector2(x-1, y-1)
				var targetID = getIdForPoint(target)
				if tile == target or not astar.has_point(targetID):
					continue
				astar.connect_points(id, targetID, true)

func getIdForPoint(point):
	var x = point.x - used_rect.position.x
	var y = point.y - used_rect.position.y
	return x+y * used_rect.size.x

func get_computed_path(start, end):
	var start_tile = Globals.tileMap.world_to_map(start)
	var end_tile = Globals.tileMap.world_to_map(end)
	
	var start_id = getIdForPoint(start_tile)
	var end_id = getIdForPoint(end_tile)
	
	if not astar.has_point(start_id) or not astar.has_point(end_id):
		return null
	
	var path_map = astar.get_point_path(start_id, end_id)
	
	var path_world = []
	for point in path_map:
		var point_world = Globals.tileMap.map_to_world(Vector2(point.x, point.y)) + half_cell_size
		path_world.append(point_world)
	return path_world