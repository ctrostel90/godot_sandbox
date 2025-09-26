class_name WorldGenerator
extends Node

@export var settings : GenerationSettings
@export_category("Dependencies")
@export var tile_parent : Node3D

func _ready() -> void:
	init_seed()
	generate_world()

func init_seed() -> void:
	if settings.map_seed == 0 or settings.map_seed == null:
		print("Randomizing seed")
		settings.heightmap_noise.seed = randi()
	else:
		settings.heightmap_noise.seed = settings.map_seed


func generate_world() -> void:
	var mapper = GridMapper.new()
	var positions: Array[PositionData] = mapper.calculate_map_positions(settings)
	
	var factory = TileFactory.new()
	factory.init_factory(settings,tile_parent)
	var map = factory.create_map(positions)
	WorldMap.set_map(map)
