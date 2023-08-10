extends Polygon2D

var velocity := Vector2.RIGHT * 50
var rotation_velocity := .0
var gravity := .0

func _process(delta: float) -> void:
	global_position += velocity * delta
	rotation += rotation_velocity * delta
	velocity.y += gravity * delta
