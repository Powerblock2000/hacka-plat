extends CanvasLayer

var next_level_path : String = ""

@onready var win: TextButtonbase = $TextButtonbase
@onready var win_offset: TextButtonbase = $TextButtonbase2
@onready var color_rect: ColorRect = $Control/ColorRect
@onready var key_button: KeyButton = $Control/KeyButton
@onready var text_buttonbase: TextButtonbase = $Control/TextButtonbase

func _ready() -> void:
	win_level()

func win_level() -> void:
	win.wipe_in(2)
	await win_offset.wipe_in(2)
	await get_tree().create_timer(.5).timeout
	var tween = create_tween()
	tween.tween_property(win, "modulate", Color(0.0, 0.0, 0.0, 1.0), 2)
	var tween_offset = create_tween()
	tween_offset.tween_property(win_offset, "modulate", Color(0.0, 0.0, 0.0, 1.0), 2)
	await tween_offset.finished
	tween_offset.kill()
	tween.kill()
	color_rect.show()
	await key_button.wipe_in()
	text_buttonbase.wipe_in()

func _on_key_button_pressed() -> void:
	await text_buttonbase.wipe()
	await key_button.wipe()
	if next_level_path != "":
		LoadingManager.change_scene(next_level_path)
		queue_free()
