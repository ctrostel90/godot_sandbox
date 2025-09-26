class_name Tile extends Node

@onready var objects: Node = $Objects

var mesh_data : TileMeshData
var position_data : PositionData
var HasTree : bool

var debugLabel : Label3D

func SpawnTree(TreeScene:PackedScene) -> void:
	if HasTree:
		return
	HasTree = true
	var newTree:ForrestTree = TreeScene.instantiate()
	newTree.ParentTile = self
	newTree.position = position_data.world_position
	objects.add_child(newTree)
	
