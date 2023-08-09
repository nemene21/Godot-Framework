@tool
extends EditorPlugin

func _enter_tree() -> void:
	add_autoload_singleton("AudioManager", "res://addons/framework/singletons/audio_manager.tscn")
	add_autoload_singleton("VfxManager", "res://addons/framework/singletons/vfx_manager.tscn")
	add_autoload_singleton("Global", "res://addons/framework/singletons/global.tscn")
	add_autoload_singleton("PostProcessing", "res://addons/framework/singletons/post_processing.tscn")
	add_autoload_singleton("SceneManager", "res://addons/framework/singletons/scene_manager.tscn")


func _exit_tree() -> void:
	remove_autoload_singleton("AudioManager")
	remove_autoload_singleton("VfxManager")
	remove_autoload_singleton("Global")
	remove_autoload_singleton("PostProcessing")
	remove_autoload_singleton("SceneManager")
