class_name MoistureController
extends Node

@export var _moisture_settings:MoistureSettings
var _update_check:float

func _ready() -> void:
	_update_check = _moisture_settings.update_rate

func _update_moisture() -> void:
	
	for tile in WorldMap.map:
		var water_amount: float = -_moisture_settings.evaporation_rate
		var _neighbors:Array[Tile] = WorldMap.GetAllNeighbors(tile)
		var current_moisture_level = tile.moisture_level
		
		var neighbor_moisture: float = 0
		for neighbor in _neighbors:
			neighbor_moisture += neighbor.moisture_level
		neighbor_moisture /= _neighbors.size()
		if neighbor_moisture > current_moisture_level:
			water_amount += neighbor_moisture - current_moisture_level + _moisture_settings.bleed_rate
		tile.WaterTile(water_amount)	

		
func _physics_process(delta: float) -> void:
	_update_check -= delta
	if _update_check < 0:
		_update_moisture()
		_update_check = _moisture_settings.update_rate
