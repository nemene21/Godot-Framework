extends GPUParticles2D

@export var sprite: Sprite2D

var component: ComponentData

func _ready() -> void:
	process_material = process_material.duplicate()
	
	var sprite_size = (sprite.texture.get_size() / Vector2(sprite.hframes, sprite.vframes)) * sprite.scale
	process_material.emission_box_extents = Vector3(sprite_size.x / 2, sprite_size.y / 2, 0)
