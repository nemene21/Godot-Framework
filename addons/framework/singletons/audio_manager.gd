extends Node

func _ready() -> void:
	import_sounds_and_tracks()

# Sound effects
var sounds: Dictionary = {}

@onready var last_track_tween: Tween
@onready var new_track_tween:  Tween

@export var sounds_to_add: Array[Resource]
@export var tracks_to_add: Array[Resource]

func is_sound_file(path: String) -> bool:
	return path.ends_with(".wav") or path.ends_with(".mp3") or path.ends_with(".ogg")

func import_sounds_and_tracks() -> void:
	for track_resource in tracks_to_add:
		var path: String = track_resource.resource_path
		var name: String = path.right(len(path) - path.rfind("/") - 1)
		name = Global.remove_file_ending(name)
		add_track(name, path)
	
	for sound_resource in sounds_to_add:
		var path: String = sound_resource.resource_path
		var name: String = path.right(len(path) - path.rfind("/") - 1)
		name = Global.remove_file_ending(name)
		add_sound(name, path)

func add_sound(name : String, path : String) -> void:
	sounds[name] = load(path)
	
func play_sound(name: String, pitch: float = 1.0, volume: float = 1.0, pitch_rand: float = .0, volume_rand: float = .0) -> AudioStreamPlayer:
	var player = AudioStreamPlayer.new()
	
	player.stream = sounds[name]
	player.connect("finished", player.queue_free)
	
	player.set_bus("SFX")
	player.pitch_scale = pitch + randf_range(-pitch_rand, pitch_rand)
	player.volume_db = linear_to_db(volume + randf_range(-volume_rand, volume_rand))
	
	add_child(player)
	player.play()
	
	return player
	
func play_sound2d(name: String, position: Vector2, pitch: float = 1.0, volume: float = 1.0, pitch_rand: float = .0, volume_rand: float = .0) -> AudioStreamPlayer2D:
	var player = AudioStreamPlayer2D.new()
	
	player.stream = sounds[name]
	player.connect("finished", player.queue_free)
	
	player.global_position = position
	
	player.set_bus("SFX")
	player.pitch_scale = pitch + randf_range(-pitch_rand, pitch_rand)
	player.volume_db = linear_to_db(volume + randf_range(-volume_rand, volume_rand))
	
	add_child(player)
	player.play()
	
	return player

# Tracks
var tracks = {}
var last_track = null

func add_track(name : String, path : String) -> void:
	var track_node = AudioStreamPlayer.new()
	track_node.stream = load(path)
	track_node.volume_db = -80
	track_node.set_bus("Music")
	
	add_child(track_node)
	
	tracks[name] = track_node
	

func play_track(name : String, fade_time : float = 0.5) -> void:
	if name == last_track: return
	
	if new_track_tween != null: new_track_tween.stop()
	new_track_tween = create_tween()
	new_track_tween.tween_property(tracks[name], "volume_db", 0, fade_time)
	
	var new_track_node:  AudioStreamPlayer = tracks[name]
	if !new_track_node.playing:
		new_track_node.play()
	
	if last_track != null:
		var last_track_node: AudioStreamPlayer = tracks[last_track]
		if last_track_tween != null: last_track_tween.stop()
		last_track_tween = create_tween()
		last_track_tween.tween_property(last_track_node, "volume_db", -80, fade_time)

		last_track_tween.connect("finished", last_track_node.stop)
		last_track_node.stop()
	
	last_track = name
	
