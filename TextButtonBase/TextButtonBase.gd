extends Label

class_name TextButtonbase

var ready_for_effects : bool = false

func wipe_in(time: float = .6) -> void:
	visible_characters = 0
	show()
	
	var tween : Tween = create_tween()
	tween.tween_property(self, "visible_characters", text.length(), time)
	print(text.length())
	print(text)
	await tween.finished
	ready_for_effects = true
	return

func wipe(time: float = .6) -> void:
	visible_characters = text.length()
	
	var tween : Tween = create_tween()
	tween.tween_property(self, "visible_characters", 0, time)
	await tween.finished
	hide()
	ready_for_effects = false
	return
