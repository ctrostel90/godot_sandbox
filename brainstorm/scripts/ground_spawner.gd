@tool
class_name GroundSpawner extends Node

const GROUND_BLOCK = preload("res://brainstorm/components/ground/GroundBlock.tscn")

@export var GridSize:Vector2 = Vector2(10,10)
@export var CellDimensions : Vector3 = Vector3(1,1,1)
@export var Generate: bool:
	set(value):
		GenerateGround()

@export var GridScene : Node
@export var gen_noise: FastNoiseLite

var Grid: Array[GroundBlock]

func GenerateGround() -> void:
	ClearGrid()
	gen_noise.seed = randi()
	
	for x in range(GridSize.x):
		for z in range(GridSize.y):
			var noiseValue = gen_noise.get_noise_2d(x,z)
			var cell:GroundBlock = GROUND_BLOCK.instantiate()
			Grid.push_back(cell)
			GridScene.add_child(cell)
			cell.owner =  get_tree().edited_scene_root
			cell.position = Vector3(x * CellDimensions.x,noiseValue * CellDimensions.y, z * CellDimensions.z)
			

func ClearGrid() -> void:
	Grid.clear()
	for child in GridScene.get_children():
		child.queue_free()
