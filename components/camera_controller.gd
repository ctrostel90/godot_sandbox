class_name CameraController
extends Node

@export var camera : Camera3D
@export var move_speed : float = 1

func _process(delta: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_back", "move_forward")
	if input_dir != Vector2.ZERO:
		var direction = Vector3(input_dir.y, 0.0, input_dir.x)
		camera.global_position += direction.normalized() * move_speed * delta
