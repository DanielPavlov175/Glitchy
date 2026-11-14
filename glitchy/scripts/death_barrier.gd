extends Area2D

#func _process(delta: float) -> void:
	#if body_entered:
		#manager.death_counter += 1
func _on_body_entered(body: Node2D) -> void:
	if body == CharacterBody2D:
		manager.death_barrier
		get_tree().reload_current_scene()
