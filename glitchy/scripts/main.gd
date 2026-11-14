extends Node2D

@onready var world_city: TileMapLayer = $world_city
@onready var world_nature: TileMapLayer = $world_nature
@onready var city_platform: AnimatableBody2D = $city_platform
@onready var nature_platform: AnimatableBody2D = $nature_platform
@onready var dis_nat: StaticBody2D = $disapear_nature
@onready var dis_city: StaticBody2D = $disapear_city
@onready var parallax_2d: Parallax2D = $Parallax2D
@onready var parallax_2d_2: Parallax2D = $Parallax2D2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Change visibility of layers depending on world
func _process(delta: float) -> void:
	if manager.current_world==manager.world.city:
		world_city.visible = true
		world_nature.visible = false
		city_platform.visible = true
		nature_platform.visible = false
		dis_nat.visible = false
		dis_city.visible = true
		parallax_2d.visible = true
		parallax_2d_2.visible = false
	elif manager.current_world==manager.world.nature:
		world_city.visible = false
		world_nature.visible = true
		city_platform.visible = false
		nature_platform.visible = true
		dis_nat.visible = true
		dis_city.visible = false
		parallax_2d.visible = false
		parallax_2d_2.visible = true
