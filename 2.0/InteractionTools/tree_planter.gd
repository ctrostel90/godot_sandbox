class_name TreePlanter extends InteractionTool

const TREE = preload("res://2.0/Objects/tree.tscn")

func interact_on_tile(SelectedTile : Tile) -> void:
	SelectedTile.SpawnTree(TREE)
