class_name GroundBlock extends Node3D

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var shader: ShaderMaterial = $MeshInstance3D.mesh.material
@export var Highlighted : bool
@export var BlockSize : Vector3 = Vector3(1,0.25,1)

func _ready() -> void:
	mesh_instance_3d.mesh.size = BlockSize


func _on_static_body_3d_mouse_entered() -> void:
	shader.set_shader_parameter('highlight',true)


func _on_static_body_3d_mouse_exited() -> void:
	shader.set_shader_parameter('highlight',false)
