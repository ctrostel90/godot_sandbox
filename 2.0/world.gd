extends Node

var map : Array[Tile]
var map_as_dictionary : Dictionary[Vector2i,Tile] = {}

func set_map(all_tiles:Array[Tile]) -> void:
	map = all_tiles
	for tile in all_tiles:
		map_as_dictionary[Vector2i(tile.position_data.grid_position.x, tile.position_data.grid_position.z)] = tile

func GetNeighbors(_Tile : Tile) -> Array[Tile]:
	var neighbors:Array[Tile] = []
	var _grid_position = _Tile.position_data.grid_position
	var check:Vector3i
	check = _grid_position + Vector3i.LEFT
	if map_as_dictionary.has(Vector2i(check.x,check.z)):
		neighbors.append(map_as_dictionary[Vector2i(check.x,check.z)])
	
	check = _grid_position + Vector3i.FORWARD
	if map_as_dictionary.has(Vector2i(check.x,check.z)):
		neighbors.append(map_as_dictionary[Vector2i(check.x,check.z)])
		
	check = _grid_position + Vector3i.RIGHT
	if map_as_dictionary.has(Vector2i(check.x,check.z)):
		neighbors.append(map_as_dictionary[Vector2i(check.x,check.z)])
	
	check = _grid_position + Vector3i.BACK
	if map_as_dictionary.has(Vector2i(check.x,check.z)):
		neighbors.append(map_as_dictionary[Vector2i(check.x,check.z)])
	
	return neighbors
