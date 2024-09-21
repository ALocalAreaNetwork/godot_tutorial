extends CharacterBody2D

var player_nearby: bool = false
var can_laser: bool = true
@onready var laser_spawn_positions = $LaserSpawnPositions
var laser_spawn_positions_index = 0

var health: int = 30
var is_invulnerable: bool = false

signal laser(pos, direction)

func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			var pos: Vector2 = laser_spawn_positions.get_child(laser_spawn_positions_index % laser_spawn_positions.get_child_count()).global_position
			var direction: Vector2 = (Globals.player_pos - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$Timers/LaserTimer.start()
			laser_spawn_positions_index += 1	

func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false

func hit() -> void:
	if is_invulnerable:
		return
	is_invulnerable = true
	$Timers/InvulnerabilityTimer.start()
	$Sprite2D.material.set_shader_parameter("progress",1)
	health -= 10
	if health <= 0:
		queue_free()

func _on_laser_timer_timeout() -> void:
	can_laser = true

func _on_invulnerability_timer_timeout() -> void:
	is_invulnerable = false
	$Sprite2D.material.set_shader_parameter("progress",0)
