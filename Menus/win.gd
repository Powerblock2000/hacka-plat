extends CanvasLayer
@onready var win: TextButtonbase = $TextButtonbase
@onready var win_offset: TextButtonbase = $TextButtonbase2

func win_level() -> void:
	win.wipe_in(2)
	await win_offset.wipe_in(2)
	await get_tree().create_timer(.5).timeout
	var tween = create_tween()
	tween.tween_property(win, "modulate", Color(0.0, 0.0, 0.0, 1.0), 2)
	var tween_offset = create_tween()
	tween_offset.tween_property(win_offset, "modulate", Color(0.0, 0.0, 0.0, 1.0), 2)
