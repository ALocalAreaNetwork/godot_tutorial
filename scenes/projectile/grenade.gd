extends RigidBody2D

const speed = 750

func explode() -> void:
	$AnimationPlayer.play("Explosion")
