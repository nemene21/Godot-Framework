extends Area2D
class_name Hurtbox

@export var iframes := 3.0

var component: ComponentData

signal got_hit(damage: float, kb_dir: Vector2)

func hit(damage: float, kb_dir: Vector2) -> void:
	if component.entity.has_component("Health"):
		component.entity.get_component("Health").hurt(damage)
	got_hit.emit(damage, kb_dir)
