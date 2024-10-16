extends CharacterBody2D

signal laser(pos, direction)
signal grenade(pos, direction)

var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 500
var speed: int = max_speed

func _process(_delta):
	
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_pos = global_position

	look_at(get_global_mouse_position())
	var player_direction: Vector2 = (get_global_mouse_position() - position).normalized()
	
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		can_laser = false
		$LaserReloadTimer.start()
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		laser.emit(selected_laser.global_position, player_direction)
		$GPUParticles2D.emitting = true

	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		can_grenade = false
		$GrenadeReloadTimer.start()
		var pos = $LaserStartPositions.get_children()[0].global_position
		grenade.emit(pos, player_direction)

func _on_laser_reload_timer_timeout() -> void:
	can_laser = true

func _on_grenade_reload_timer_timeout() -> void:
	can_grenade = true

func hit() -> void:
	Globals.health -= 10
