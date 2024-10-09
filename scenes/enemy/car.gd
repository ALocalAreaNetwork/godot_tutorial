extends PathFollow2D

var player_near: bool = false

@onready var turret_left_ray: RayCast2D = $Turret/RayCast2D
@onready var turret_left_line: Line2D = $Turret/RayCast2D/Line2D2
@onready var turret_right_ray: RayCast2D = $Turret/RayCast2D2
@onready var turret_right_line: Line2D = $Turret/RayCast2D2/Line2D2
@onready var turret_left_fire: Sprite2D = $Turret/FireLeft
@onready var turret_right_fire: Sprite2D = $Turret/FireRight


func fire():
	var tween = create_tween()
	turret_left_fire.modulate.a = 1
	turret_right_fire.modulate.a = 1
	tween.set_parallel(true)
	tween.tween_property(turret_left_fire, "modulate:a", 0, randf_range(0.1,0.2))
	tween.tween_property(turret_right_fire, "modulate:a", 0, randf_range(0.1,0.2))
	Globals.health -= 20
	
func _ready():
	turret_right_line.add_point(turret_right_ray.target_position)

func _process(delta):
	progress_ratio += 0.01 * delta
	if player_near:
		$Turret.look_at(Globals.player_pos)
		print($Turret/RayCast2D.get_collider())

func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_near = true
	$AnimationPlayer.play('laser_charge')

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_near = false
	$AnimationPlayer.pause()
	var tween = create_tween()
	tween.tween_property(turret_left_line, "width", 0, randf_range(0.1,0.3))
	tween.tween_property(turret_left_line, "width", 0, randf_range(0.1,0.3))
	await(tween.finished)
	$AnimationPlayer.stop()
