extends Area2D




func _on_body_entered(body: Node2D) -> void:
	manager.death_counter +=1
	manager.current_world = manager.world.city
	get_tree().call_deferred("reload_current_scene")
