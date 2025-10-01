class_name PositionData
extends Node

var grid_position : Vector3i
var world_position : Vector3
var noise : float

func Get2DGridPosition() -> Vector2i:
	return Vector2i(grid_position.x,grid_position.z)