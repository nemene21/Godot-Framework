extends Area2D
class_name Hitbox

@export var damage := 3.0
@export var static_kb := Vector2.ZERO

var component: ComponentData

signal hit_hurtbox(hurtbox: Hurtbox, damage: float, kb: Vector2)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Hurtbox"):
		var hurtbox = area as Hurtbox
		
		var kb = static_kb
		if kb == Vector2.ZERO:
			kb = global_position.direction_to(hurtbox.global_position)
		hurtbox.hit(damage, kb)
		hit_hurtbox.emit(hurtbox, damage, kb)
