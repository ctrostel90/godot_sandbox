@tool
extends MeshInstance3D

@export var noise: FastNoiseLite
@export var Generate: bool:
	set(value):
		generate_mesh()

@export var surface_material:ShaderMaterial
@export var world_width:int = 90
@export var world_height:int = 90
@export var grid_scale: float = 1.0
@export var noise_strength: float = 10

@export var set_mouse_position:bool
var mouse_position : Vector2

func generate_mesh() -> void:
	for child in get_children():
		self.remove_child(child)
		child.queue_free()

	noise.seed = randi()

	var st := SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	var verts = PackedVector3Array()
	var uvs = PackedVector2Array()
	var normals = PackedVector3Array()
	var indicies = PackedInt32Array()

	for z in range(world_height):
		for x in range(world_width):
			var y = noise.get_noise_2d(x * grid_scale, z * grid_scale) * noise_strength
			verts.append(Vector3(x,y,z))

			# Add a simple UV for future texturing if needed
			uvs.append(Vector2(x / float(world_width), z / float(world_height)))
			
			var normal = calculate_normal(x, z, grid_scale, noise, noise_strength)
			normals.append(normal)
	
	for z in range(world_height - 1):
		for x in range(world_width -1 ):
			var i = z * world_width + x
			var i_right = i + 1
			var i_down = i + world_width
			var i_down_right = i_down + 1

			indicies.append_array([i,i_right,i_down,i_right,
									i_down_right,i_down])

	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = verts
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	arrays[Mesh.ARRAY_NORMAL] = normals
	arrays[Mesh.ARRAY_INDEX] = indicies
	# Create mesh surface from mesh array.
	# No blendshapes, lods, or compression used.
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	self.mesh = arr_mesh
	self.mesh.surface_set_material(0,surface_material)

	var static_body:StaticBody3D = StaticBody3D.new()
	var collision_shape:CollisionShape3D = CollisionShape3D.new()
	var shape:ConcavePolygonShape3D = self.mesh.create_trimesh_shape()

	collision_shape.shape = shape
	static_body.add_child(collision_shape)
	add_child(static_body)

func calculate_normal(x: float, z: float, scale: float, noise: FastNoiseLite, strength: float) -> Vector3:
	var h_l = noise.get_noise_2d((x - 1) * scale, z * scale) * strength # left
	var h_r = noise.get_noise_2d((x + 1) * scale, z * scale) * strength # right
	var h_d = noise.get_noise_2d(x * scale, (z - 1) * scale) * strength # down
	var h_u = noise.get_noise_2d(x * scale, (z + 1) * scale) * strength # up

	# Compute normal from gradients
	var dx = h_l - h_r
	var dz = h_d - h_u
	var normal = Vector3(dx, 2.0, dz).normalized() # y scale exaggerates height contrast


	return normal
func _input(event: InputEvent) -> void:
	handle_mouse_click(event)

func handle_mouse_click(event:InputEvent) -> void:
	if event is not InputEventMouseButton:
		return
	if event.pressed == false and event.button_index == MOUSE_BUTTON_LEFT:
		mouse_position = event.position
	#The physics state of the world
	var space = get_world_3d().direct_space_state
	#start and end world positions for the ray
	var start = get_viewport().get_camera_3d().project_ray_origin(mouse_position)
	var end = get_viewport().get_camera_3d().project_position(mouse_position,1000)
	#Params for 3D raycast
	#Alt var params = PhysicsRayQueryParameters3D.create(start,end)
	var params = PhysicsRayQueryParameters3D.new()
	params.from = start
	params.to = end
	#cast the ray using the space and return the results as a Dictionary
	var result:Dictionary = space.intersect_ray(params)
	if result.is_empty() == false:
		print(result.position)


func _process(_delta: float) -> void:
	return
	var mouse_pos = get_viewport().get_mouse_position()
	var from = get_viewport().get_camera_3d().project_ray_origin(mouse_pos)
	var to = get_viewport().get_camera_3d().project_position(mouse_pos,1000)

	var params = PhysicsRayQueryParameters3D.new()
	params.from = from
	params.to = to
	var space_state = get_world_3d().direct_space_state
	var result = space_state.intersect_ray(params)
	
	if result and result.has("position"):
		print(result.position)
		# var local_pos = to_local(result.position)

		# # Convert world position to UV-like 0..1 range
		# var uv_x = local_pos.x / (mesh.size.x if mesh and mesh.has("size") else 1.0)
		# var uv_y = local_pos.z / (mesh.size.z if mesh and mesh.has("size") else 1.0)

		# var grid_x = floor(uv_x * zoom)
		# var grid_y = floor(uv_y * zoom)

		# shader_material.set_shader_parameter("highlight_square", Vector2(grid_x, grid_y))