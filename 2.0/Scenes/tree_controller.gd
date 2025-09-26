class_name TreeController extends Node

var _trees:Array[ForrestTree]
@export var SpawnRates: Array[float] = [0.1,0.25,0.5,0.75]
@export var SpawnUpdateRate:float = 2.0
@export var TreeScene:PackedScene

var _spawn_check:float = SpawnUpdateRate

func TreeSpawned(_Tree : ForrestTree) -> void:
	_trees.append(_Tree)

func _update_trees() -> void:
	#iterate through all trees
	for _tree in _trees:
		_check_spawn_chance(_tree)

func _check_spawn_chance(_Tree : ForrestTree) -> bool:
	var _spawn:bool = false
	var _spawnChance: float = randf_range(0,1)
	var _neighbors:Array[Tile] = _Tree.GetTreeNeighbors()
	_spawn = _spawnChance < SpawnRates[_neighbors.size() - 1]
	if _spawn and _neighbors.size() < 4:
		_neighbors = _Tree.GetNonTreeNeighbors()
		if _neighbors.size() == 0:
			return _spawn
		var index = randi_range(0,_neighbors.size() - 1)
		_neighbors[index].SpawnTree(TreeScene)		
	return _spawn

func _physics_process(delta: float) -> void:
	_spawn_check -= delta
	if _spawn_check < 0:
		_update_trees()
		_spawn_check = SpawnUpdateRate	
