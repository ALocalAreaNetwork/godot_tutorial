extends LevelParent

var outside_level_scene: String = "res://scenes/levels/outside.tscn"

func _on_exit_gate_area_body_entered(_body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	TransitionLayer.change_scene(outside_level_scene)
