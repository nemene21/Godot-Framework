extends Area2D
class_name Hurtbox

@export var iframes := 3.0

var component: ComponentData

signal took_damage(amount: float, kb_dir: Vector2)

func _ready() -> void:
	add_to_group("Hurtbox")

func take_damage(amount: float, kb_dir: Vector2) -> void:
	took_damage.emit(amount, kb_dir)
