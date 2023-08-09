extends Timer

@export var flashable: Node
var component: ComponentData

func flash(duration: float = 0.1) -> void:
	flashable.get_material().set("shader_parameter/flash", 1)
	wait_time = duration
	start()

func _on_timeout() -> void:
	flashable.get_material().set("shader_parameter/flash", 0)
