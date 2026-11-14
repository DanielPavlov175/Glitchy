extends StaticBody2D

@onready var timer: Timer = $Timer
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var disapear_nature: StaticBody2D = $"."
var disapeared = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if disapeared == true:
		disapear_nature.visible = false 


func _on_area_2d_body_entered(body: Node2D) -> void:
	timer.start()



func _on_timer_timeout() -> void:
	collision.disabled = true
	disapeared = true
