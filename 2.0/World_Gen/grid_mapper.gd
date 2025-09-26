class_name GridMapper
extends Node

var settings : GenerationSettings

func calculate_map_positions(local_settings : GenerationSettings) -> Array[PositionData]:
	settings = local_settings
	var positions : Array[PositionData]
	var height_scale:Vector2 = Vector2(0,5)
	for x in range(settings.map_size.x):
		for z in range(settings.map_size.y):
			var noise = settings.heightmap_noise.get_noise_2d(x,z)
			var position = PositionData.new()
			
			position.grid_position = Vector3i(x,floor(convert_noise(noise,height_scale)),z)
			position.world_position = grid_to_world(position.grid_position)
			positions.append(position)
	return positions

func grid_to_world(grid_position : Vector3i) -> Vector3:
	return Vector3(grid_position.x * settings.tile_size.x, grid_position.y * settings.tile_size.y, grid_position.z * settings.tile_size.z)

func convert_noise(noise: float,new_scale:Vector2) -> float:
	return (noise + (new_scale.x - 0.5)) * new_scale.y
