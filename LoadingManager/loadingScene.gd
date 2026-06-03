extends CanvasLayer

@onready var loading_spinner: LoadingSpinner = $Control/MarginContainer/Control/LoadingSpinner
@onready var control: Control = $Control

func wipe() -> void:
	await loading_spinner.wipe()
	var tween : Tween = create_tween()
	
	tween.tween_property(control, "modulate", Color(1.0, 1.0, 1.0, 0.0), .5)
	await tween.finished
