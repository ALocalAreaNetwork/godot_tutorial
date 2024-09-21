extends Node2D
class_name LevelParent

#var test_array: Array[String] = ["Test", "Hello", "World"]

var laser_scene: PackedScene = preload("res://scenes/projectile/laser.tscn")
var grenade_scene: PackedScene = preload('res://scenes/projectile/grenade.tscn')
var item_scene: PackedScene = preload('res://scenes/items/item.tscn')

func _ready() -> void:
	for container in get_tree().get_nodes_in_group('Container'):
		container.connect("open", _on_container_opened)
	for scout in get_tree().get_nodes_in_group('Scouts'):
		scout.connect('laser', _on_scout_laser)
		
func _on_container_opened(pos, direction) -> void:
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	$Items.call_deferred('add_child', item)

func _on_player_laser(pos, direction) -> void:
	create_laser(pos, direction)

func _on_player_grenade(pos, direction) -> void:
	var grenade: RigidBody2D = grenade_scene.instantiate()
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)
	$UI.update_grenade_text()

func _on_scout_laser(pos, direction) -> void:
	create_laser(pos, direction)

func create_laser(pos: Vector2, direction: Vector2) -> void:
	var laser: Area2D = laser_scene.instantiate()
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$Projectiles.add_child(laser)
	$UI.update_laser_text()
