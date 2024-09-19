extends StaticBody2D
class_name ItemContainer

@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)
signal open(pos, direction)
var opened = false

func open_container(items: int) -> void:
	if not opened:
		$LidSprite.hide()
		for i in range(items):
			var pos = $SpawnPositions.get_child(randi()%$SpawnPositions.get_child_count()).global_position
			open.emit(pos, current_direction)
		opened = true
