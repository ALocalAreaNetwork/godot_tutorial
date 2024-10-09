extends PathFollow2D

var player_near: bool = false

@onready var turret_left_ray: RayCast2D = $Turret/RayCast2D
@onready var turret_left_line: Line2D = $Turret/RayCast2D/Line2D2
@onready var turret_right_ray: RayCast2D = $Turret/RayCast2D2
@onready var turret_right_line: Line2D = $Turret/RayCast2D2/Line2D2


func fire():
	var tween = create_tween()
	$Turret/FireLeft.visible = true
	$Turret/FireRight.visible = true
	tween.set_parallel(true)
	tween.tween_property($Turret/FireLeft, "visible", false, .1)
	tween.tween_property($Turret/FireRight, "visible", false, .1)
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
	$AnimationPlayer
	player_near = false
