class_name ForrestTree extends Node3D

var ParentTile: Tile

func _ready() -> void:
	var tree_controller:TreeController = get_tree().get_root().get_node("World/Controllers/TreeController")
	tree_controller.TreeSpawned(self)

func GetTreeNeighbors() -> Array[Tile]:
	var neighbors : Array[Tile]
	for tile in WorldMap.GetNeighbors(ParentTile):
		if tile.HasTree:
			neighbors.append(tile)
	return neighbors

func GetNonTreeNeighbors() -> Array[Tile]:
	var neighbors : Array[Tile]
	for tile in WorldMap.GetNeighbors(ParentTile):
		if not tile.HasTree:
			neighbors.append(tile)
	return neighbors
