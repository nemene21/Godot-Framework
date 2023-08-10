extends Area2D
class_name Hurtbox

@export var iframes := 3.0

var component: ComponentData

signal got_hit(amount: float, kb_dir: Vector2)

func hit(amount: float, kb_dir: Vector2) -> void:
	got_hit.emit(amount, kb_dir)
