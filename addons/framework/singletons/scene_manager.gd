extends CanvasLayer

@onready var quad: ColorRect = $TransitionQuad
@onready var animation_player: AnimationPlayer = $TransitionPlayer

func _ready() -> void:
	quad.size = Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_width")
	)

var transitioning := false
@export var randomize_position := true

func transition_scene(scene, speed := 1.0) -> void:
	if transitioning: return
	
	quad.material.set("shader_parameter/offset", Vector2(randf() * 100.0, randf() * 100.0) * float(randomize_position))
	
	transitioning = true
	$TransitionPlayer.speed_scale = speed
	
	$TransitionPlayer.play("transition")
	await get_tree().create_timer(0.6 * speed).timeout
	
	get_tree().change_scene_to_file(scene)
	
	$TransitionPlayer.play_backwards("transition")
	await get_tree().create_timer(0.6 * speed).timeout
	
	transitioning = false
