extends Node2D

@onready var world_city: TileMapLayer = $world_city
@onready var world_nature: TileMapLayer = $world_nature

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Change visibility of layers depending on world
func _process(delta: float) -> void:
	if manager.current_world==manager.world.city:
		world_city.visible = true
		world_nature.visible = false
	elif manager.current_world==manager.world.nature:
		world_city.visible = false
		world_nature.visible = true
