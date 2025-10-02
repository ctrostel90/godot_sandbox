class_name ForrestTree extends Node3D

@onready var tree_mesh: MeshInstance3D = $MeshInstance3D

var _health : float = 100
var _age: float = 0

@export var max_size: Vector3i = Vector3i(1.5,1.5,1.5)
@export var can_spawn_age:float = 20

signal tree_died(ForrestTree)

var CanSpawnTree: bool : 
	get:
		return _age > can_spawn_age

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

func _age_process(delta: float) -> void:
	_age += delta
	_age = clampf(_age,0,100)
	tree_mesh.scale = _age / 100 * max_size + Vector3(0.5,0.5,0.5)
	tree_mesh.position.y = tree_mesh.scale.y / 2 

func _health_process(delta: float) -> void:
	if ParentTile.moisture_level < 50:
		_health -= delta * 2
	if _health < 30:
		TreeDeath()
	

func _physics_process(delta: float) -> void:
	_age_process(delta)
	_health_process(delta)

func TreeDeath() -> void:
	emit_signal('tree_died',self)
	queue_free()
