class_name InteractionController
extends Node3D

@export var main_camera : Camera3D
var selected_tile : Node3D

@export var tree_scene : PackedScene
@export var Tools : Array[InteractionTool] = []

var _current_tool :InteractionTool

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_pos = get_viewport().get_mouse_position()
		var origin = main_camera.project_ray_origin(mouse_pos)
		var dir = main_camera.project_ray_normal(mouse_pos)
		var end = origin + dir * 1000
		var hit_object = raycast_at_mouse(origin, end)
		if not hit_object:
			return
		if Input.is_action_just_pressed("Click") and event.pressed:
			var tile = hit_object.get_parent()
			_current_tool.interact_on_tile(tile)
			print("LeftClicked")
		elif Input.is_action_just_pressed("RightClick"):
			print("RightClicked")

func raycast_at_mouse(origin, end) -> Node3D:
		var query = PhysicsRayQueryParameters3D.create(origin, end)
		var collision = get_world_3d().direct_space_state.intersect_ray(query)
		if collision and collision.has("collider"):
			var hit = collision.collider.get_parent()
			return hit
		else:
			return null

func _on_ui_tool_changed(NewTool: InteractionToolUI) -> void:
	_current_tool = Tools[NewTool.ToolType - 1]
