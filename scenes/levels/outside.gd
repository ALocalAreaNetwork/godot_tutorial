extends LevelParent

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _on_gate_player_entered_gate(_body: Variant) -> void:
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	get_tree().change_scene_to_file("res://scenes/levels/inside.tscn")
