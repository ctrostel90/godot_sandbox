@tool
class_name GridMeshSpawner extends Node

@export var grid : GridMap
@export var tree_parent : Node
@export var tree : PackedScene
@export var CurrentWorld : World

@export var HeightScale : float = 10.0
@export var treeSpawnHeight : float = 0.25
@export var gen_noise : FastNoiseLite
@export var Generate : bool:
	set(value):
		GenerateMesh()
@export var Load : bool:
	set(value):
		LoadWorld(CurrentWorld)
		
const BASE_BLOCK : int = 0

func GenerateMesh() -> void:
	grid.clear()
	gen_noise.seed = randi()
	var genWorld:World = World.new(Vector2i(50,50))
	for x in range(genWorld.WorldSize.x):
		for z in range(genWorld.WorldSize.y):
			var noiseValue = gen_noise.get_noise_2d(x,z)
			var pos:Vector3i = Vector3i(x,noiseValue * HeightScale * float(grid.cell_size.y),z)
			var celltype:WorldCell.CELL_TYPE
			if noiseValue > 0.2:
				celltype = WorldCell.CELL_TYPE.Forrest
			else:
				celltype = WorldCell.CELL_TYPE.Ground
			var cell:WorldCell = WorldCell.new(pos,celltype)	
			genWorld.Cells.append(cell)
	ResourceSaver.save(genWorld,"res://brainstorm/level/generated.tres")
	LoadWorld(genWorld)
	
func LoadWorld(LoadWorld:World) -> void:
	grid.clear()
	for child in tree_parent.get_children():
		child.queue_free()
	
	var scene_tree = get_tree()
	for cell: WorldCell in LoadWorld.Cells:
		grid.set_cell_item(cell.GridCoordinate,BASE_BLOCK)
		if cell.Type == WorldCell.CELL_TYPE.Forrest:
			var new_tree = tree.instantiate()
			tree_parent.add_child(new_tree)
			new_tree.owner =  scene_tree.edited_scene_root
			new_tree.position = Vector3(grid.cell_size.x * cell.GridCoordinate.x + (grid.cell_size.x / 2.0),grid.cell_size.y * cell.GridCoordinate.y + (grid.cell_size.y / 2.0) + treeSpawnHeight,grid.cell_size.z * cell.GridCoordinate.z + (grid.cell_size.z / 2.0))
	

func _on_button_pressed() -> void:
	Generate = true
