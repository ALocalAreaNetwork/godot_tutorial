extends Node

signal stat_change

var laser_amount = 20:
	set(value):
		laser_amount = value
		stat_change.emit()
		
var grenade_amount = 5:
	set(value):
		grenade_amount = value
		stat_change.emit()
	
var player_vulnerable: bool = true
var health: int = 60: 
	set(value):
		if value < health:
			if player_vulnerable:
				player_vulnerable = false
				player_invulnerable_timer()
			else:
				value = health
		health = value
		stat_change.emit()

func player_invulnerable_timer() -> void:
	await get_tree().create_timer(1).timeout
	player_vulnerable = true

var player_pos: Vector2
