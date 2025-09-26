class_name WorldCell extends Resource

@export var GridCoordinate:Vector3i = Vector3i(0,0,0)
@export var Type:CELL_TYPE = CELL_TYPE.Empty

enum CELL_TYPE{
	Empty,
	Ground,
	Forrest,
	ForrestFire
}

func _init(GridCoord : Vector3i, CellType : CELL_TYPE) -> void:
	GridCoordinate = GridCoord
	Type = CellType
