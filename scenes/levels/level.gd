extends Node2D
class_name LevelParent

#var test_array: Array[String] = ["Test", "Hello", "World"]

var laser_scene: PackedScene = preload("res://scenes/projectile/laser.tscn")
var grenade_scene: PackedScene = preload('res://scenes/projectile/grenade.tscn')

func _on_player_laser(pos, direction) -> void:
	var laser: Area2D = laser_scene.instantiate()
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$Projectiles.add_child(laser)
	$UI.update_laser_text()

func _on_player_grenade(pos, direction) -> void:
	var grenade: RigidBody2D = grenade_scene.instantiate()
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)
	$UI.update_grenade_text()

func _on_house_player_entered() -> void:
	var tween = get_tree().create_tween()
	#tween.set_parallel(true)
	#tween.tween_property($Player, "modulate:a", 0, 2).from(1)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1,1), 1).set_trans(Tween.TRANS_QUAD)

func _on_house_player_exited() -> void:
	var tween = get_tree().create_tween()
	#tween.set_parallel(true)
	#tween.tween_property($Player, "modulate:a", 1, 2).from(0)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6,0.6), 2)

func _on_player_update_stats() -> void:
	$UI.update_laser_text()	
	$UI.update_grenade_text()
