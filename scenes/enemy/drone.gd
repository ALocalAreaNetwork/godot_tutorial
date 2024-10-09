extends CharacterBody2D

var active: bool = false
var max_speed: int = 600
var speed: int = 0
var speed_multiplier: int = 1

var vulnerable: bool = true
var explosion_radius: int = 400
var explosion_active: bool = false

var health = 50

func get_death_animation_timer():
	return get_tree().create_timer(1.6)

func _ready():
	$Explosion.hide()
	$Sprite2D.show()

func hit():
	if vulnerable:
		vulnerable = false
		health -= 10
		$Timers/HitTimer.start()
		$Sprite2D.material.set_shader_parameter("progress", 0.7)
	if health <= 0:
		$AnimationPlayer.play("Explosion")
		explosion_active = true

func _process(delta):
	if active:
		look_at(Globals.player_pos)
		var direction: Vector2 = (Globals.player_pos - global_position).normalized()
		velocity = direction * speed * speed_multiplier
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("Explosion")
			explosion_active = true
		if explosion_active:
			var targets = get_tree().get_nodes_in_group('Entity') + get_tree().get_nodes_in_group('Container')
			for target in targets:
				var in_range = target.global_position.distance_to(global_position) < explosion_radius
				if "hit" in target and in_range:
					target.hit()

func stop_movement():
	speed_multiplier = 0

func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 6)

func _on_hit_timer_timeout() -> void:
	vulnerable = true
	$Sprite2D.material.set_shader_parameter("progress", 0)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Explosion":
		queue_free()
