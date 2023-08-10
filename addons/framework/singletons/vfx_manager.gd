extends Node

var vfx = {}
var target = null

@export var vfx_to_add: Array[Resource]

func _ready() -> void:
	import_vfx()

func import_vfx() -> void:
	for vfx_resource in vfx_to_add:
		var path: String = vfx_resource.resource_path
		var name: String = path.right(len(path) - path.rfind("/") - 1)
		name = Global.remove_file_ending(name)
		add_vfx(name, path)

func explode_sprite(
		sprite : Sprite2D, velocity : float = 600, gravity : float = 200, direction := Vector2.ZERO, shards : int = 12
	) -> void:
	
	var explosion : Polygon2D = play_vfx("exploding_sprite", sprite.global_position, sprite.rotation, sprite.scale, -1)
	explosion.velocity  = velocity
	explosion.gravity   = gravity
	explosion.direction = direction
	explosion.shards    = shards
	explosion.set_texture(sprite.get_texture())
	
	explosion.start()

	sprite.queue_free()


func set_target(new_target) -> void:
	target = new_target

func add_vfx(name : String, path : String) -> void:
	vfx[name] = load(path)
	
func play_vfx(name : String, pos : Vector2, rot : float = 0.0, scale : Vector2 = Vector2(1, 1), duration : float = 3.0):
	var vfx_node = vfx[name].instantiate()
	
	vfx_node.global_position = pos
	vfx_node.rotation = rot
	vfx_node.scale = scale
	
	if vfx_node is GPUParticles2D:
		vfx_node.emitting = true
	
	if duration != -1:
		var kill_timer_node = Timer.new()
		kill_timer_node.wait_time = duration
		kill_timer_node.connect("timeout", vfx_node.queue_free)
		kill_timer_node.autostart = true
		vfx_node.add_child(kill_timer_node)
		
	target.add_child(vfx_node)
	
	return vfx_node

func spring_physics(value, target, delta_v, strength, damping) -> Dictionary:
	var delta_t = get_physics_process_delta_time()
	
	var force = strength * (target - value) - damping * delta_v
	delta_v += force * delta_t
	value   += delta_v
	
	return {"value" : value, "delta" : delta_v}

func slowdown(ratio : float = 0.5, time : float = 0.5) -> void:
	create_tween().tween_property(Engine, "time_scale", ratio, time * 0.5)
	await get_tree().create_timer(time * 0.5).timeout
	create_tween().tween_property(Engine, "time_scale", 1, time * 0.5)

func frame_freeze(time : float = 0.5) -> void:
	get_tree().paused = true
	await get_tree().create_timer(time).timeout
	get_tree().paused = false
