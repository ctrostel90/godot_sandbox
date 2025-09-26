class_name World 
extends Resource

@export var WorldSize:Vector2i = Vector2i(50,50)
@export var Cells:Array[WorldCell]

func _init(Size : Vector2i) -> void:
	WorldSize = Size
