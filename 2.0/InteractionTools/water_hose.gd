class_name WaterHose extends InteractionTool

var waterstrength: float = 50

func interact_on_tile(SelectedTile : Tile) -> void:
	SelectedTile.WaterTile(waterstrength)
