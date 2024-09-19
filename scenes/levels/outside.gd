extends LevelParent

var inside_level_scene: String = "res://scenes/levels/inside.tscn"

func _on_gate_player_entered_gate(_body: Variant) -> void:
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	TransitionLayer.change_scene(inside_level_scene)
