extends Node

onready var astar = AStar.new()

var half_cell_size
var traversable_tiles

func addTraversableTiles(traversableTiles, used_rect):
	for tile in traversableTiles:
		var id = getIdForPoint(tile, used_rect)
		astar.add_point(id, Vector3(tile.x, tile.y, 0))

func connectTraversableTiles(traversableTiles, used_rect):
	for tile in traversableTiles:
		var id = getIdForPoint(tile, used_rect)
		connectTraversableTile(tile, Vector2(tile.x-1, tile.y), used_rect)
		connectTraversableTile(tile, Vector2(tile.x, tile.y-1), used_rect)
		connectTraversableTile(tile, Vector2(tile.x+1, tile.y), used_rect)
		connectTraversableTile(tile, Vector2(tile.x, tile.y+1), used_rect)

func connectTraversableTile(tile, target, used_rect):
	if not(tile == target || not astar.has_point(getIdForPoint(target, used_rect))):
		astar.connect_points(getIdForPoint(tile, used_rect), getIdForPoint(target, used_rect))

func getIdForPoint(point, used_rect):
	var x = point.x - used_rect.position.x
	var y = point.y - used_rect.position.y
	return x+y * used_rect.size.x

func get_computed_path(tileMap, traversablePoints, start, end):
	var used_rect = tileMap.get_used_rect()
	var half_cell_size = tileMap.get_cell_size()/2
	
	var start_tile = tileMap.world_to_map(start)
	var end_tile = tileMap.world_to_map(end)
	
	var start_id = getIdForPoint(start_tile, used_rect)
	var end_id = getIdForPoint(end_tile, used_rect)
	
	astar.clear()
	addTraversableTiles(traversablePoints, used_rect)
	connectTraversableTiles(traversablePoints, used_rect)

	if not astar.has_point(start_id) or not astar.has_point(end_id):
		return null
	
	var path_map = astar.get_point_path(start_id, end_id)
	
	var path_world = []
	for point in path_map:
		var point_world = tileMap.map_to_world(Vector2(point.x, point.y)) + half_cell_size
		path_world.append(point_world)
	return path_world