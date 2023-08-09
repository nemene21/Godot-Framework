extends CanvasLayer

@onready var quad: ColorRect    = $PostProcessingQuad
@onready var material: Material = $PostProcessingQuad.material

func _ready() -> void:
	quad.size = Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height")
	)
