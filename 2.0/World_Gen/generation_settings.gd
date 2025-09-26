class_name GenerationSettings
extends Resource

@export_category("Tiles")
@export var tile_size : Vector3
@export var Tiles : Array[TileMeshData]

@export_category("Generation")
@export var map_seed : int
@export var heightmap_noise : FastNoiseLite

@export var map_size : Vector2i
