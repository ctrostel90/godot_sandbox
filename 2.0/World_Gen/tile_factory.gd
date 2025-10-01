class_name TileFactory
extends Node

const TILE_CLASS = preload("res://2.0/World_Gen/tile.gd")

var tile_materials : Array[Material]
var settings : GenerationSettings
var tile_parent : Node3D

func init_factory(local_settings: GenerationSettings, Tile_Parent:Node3D) -> void:
	settings = local_settings
	self.tile_parent = Tile_Parent


func create_map(map_data : Array[PositionData]) -> Array[Tile]:
	var new_map : Array[Tile] = []
	for m in settings.Tiles:
		## Allow for shader overrides
		if m.shader_override != null:
			tile_materials.append(m.shader_override)
			continue
		var new_mat = StandardMaterial3D.new()
		new_mat.albedo_color = m.color
		tile_materials.append(new_mat)
	
	for tile in map_data:
		var new_tile = instantiate_tile(0)
		init_tile(new_tile,tile)
		new_map.append(new_tile)
	
	print("Tiles placed: " + str(new_map.size()))
	return new_map


func init_tile(tile : Tile, position : PositionData):
	if not tile.is_in_group("tiles"):
		tile.add_to_group("tiles")

	# Set up material override
	var mesh_instance: MeshInstance3D = tile.get_child(0) as MeshInstance3D
	mesh_instance.material_override = tile_materials[tile.mesh_data.index].duplicate()
	
	tile.position = position.world_position
	tile_parent.add_child(tile)
	tile.set_script(TILE_CLASS)
	tile.position_data = position


func instantiate_tile(tile_type:int) -> Tile:
	var data = settings.Tiles[tile_type]
	
	var biome = data.mesh
	var t = biome.instantiate()
	t.set_script(TILE_CLASS)
	t.moisture_level = 100
	t.mesh_data = data
	t.mesh_data.index = tile_type
	
	return t as Tile
	
	
