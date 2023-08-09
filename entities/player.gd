extends CharacterBody2D

@export var speed := 500.0
@export var acceleration := 300.0

@onready var entity: Entity = $Entity

var silly := false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = velocity.move_toward(input * speed, acceleration * delta)
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_accept"):
		entity.get_component("Flash").flash()
		silly = !silly
		if silly:
			AudioManager.play_track("1")
		else:
			AudioManager.play_track("2")
	
	if Input.is_action_just_pressed("exit"):
		SceneManager.transition_scene("res://world.tscn")
