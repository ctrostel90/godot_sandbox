class_name Tile extends Node

@onready var objects: Node = $Objects
@onready var mesh_instance: MeshInstance3D = $MeshInstance3D

var mesh_data : TileMeshData
var position_data : PositionData
var HasTree : bool

var moisture_level: float = 0

var debugLabel : Label3D

func GetTree() -> Tree:
	if HasTree:
		return objects.get_child(0)
	return null

func SpawnTree(TreeScene:PackedScene) -> void:
	if HasTree:
		return
	HasTree = true
	var newTree:ForrestTree = TreeScene.instantiate()
	newTree.ParentTile = self
	newTree.position = position_data.world_position
	objects.add_child(newTree)


func WaterTile(WaterAmount:float) -> void:
	moisture_level += WaterAmount
	moisture_level = clamp(moisture_level,0,100)
	_set_shader_moisture()
	
func _set_shader_moisture() -> void:
	mesh_instance.get_active_material(0).set("shader_parameter/moisture_level",moisture_level / 100.0)
	
