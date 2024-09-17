extends Sprite2D

var pos: Vector2 = Vector2.ZERO
const speed: int = 200
var test_scale: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pos = Vector2(300,200)
	position = pos
	
	#const test_rotation: int = 45
	#rotation_degrees = test_rotation
	#rotation_degrees = 90
	
	test_scale = 2
	scale = Vector2(test_scale, test_scale)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	rotation_degrees += 60 * delta
#
	if pos.x > 1000:
		pos.x = 0
		
	pos.x += speed * delta
	position = pos
	
	#test_scale += 1
	scale = Vector2(test_scale, test_scale)
