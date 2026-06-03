@tool
extends TextButtonbase

class_name KeyButton

signal pressed

@export var text_for_button : String = ""

@export var update : bool = true
@export var use_underscore : bool = true

func _input(event: InputEvent) -> void:
	if not event is InputEventMouseMotion and visible and not event is InputEventJoypadMotion:
		pressed.emit()

var interval : int = 0
var is_us_present : bool = true
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		text = "> " + text_for_button
	
	if Engine.is_editor_hint() or not update: return
	if not use_underscore:
		text = "> " + text_for_button
		return
	
	interval += 1
	#print(interval)
	if interval == 100:
		interval = 0
		is_us_present = !is_us_present
	
	if is_us_present and use_underscore:
		print("Underscore wanted: %s" % use_underscore)
		text = "> " + text_for_button + " _"
	else:
		text = "> " + text_for_button
