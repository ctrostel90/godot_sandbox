class_name Cellhighlighter extends Node3D

@export var grid: GridMap
@onready var camera_3d: Camera3D = $"../../Camera3D"

const RAY_LENGTH:float = 1000

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('select'):
		var space_state = get_world_3d().direct_space_state
		var mousepos = camera_3d.get_viewport().get_mouse_position()

		var origin = camera_3d.project_ray_origin(mousepos)
		var end = origin + camera_3d.project_ray_normal(mousepos) * RAY_LENGTH
		var query = PhysicsRayQueryParameters3D.create(origin, end)
		query.collide_with_areas = true

		var result:Dictionary = space_state.intersect_ray(query)
