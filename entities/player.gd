extends CharacterBody2D

@export var speed := 5000.0
@export var acceleration := 300.0

@onready var entity: Entity = $Entity

func _ready() -> void:
	VfxManager.set_target(get_parent())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = velocity.move_toward(input * speed, acceleration * delta)
	move_and_slide()
	
	$Label.text = str(entity.get_component("Health").hp)


func _on_health_died() -> void:
	VfxManager.explode_sprite($Sprite)
	queue_free()
