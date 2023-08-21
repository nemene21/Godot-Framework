extends Area2D

@export var push_body: CharacterBody2D
@export var push_strength := 10.0

func _process(delta: float) -> void:
	var push_dir := Vector2.ZERO
	for area in get_overlapping_areas():
		push_dir += global_position.direction_to(area.global_position)
	push_dir = push_dir.normalized()
	push_body.velocity -= push_dir * push_strength
