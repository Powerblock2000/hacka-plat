@tool
extends TextButtonbase

class_name LoadingSpinner

var loading_string : Array[String] = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"]

func _ready() -> void:
	visible_characters = 0
	wipe_in()

var interval : int = 0
var string_index : int = 0
func _process(_delta: float) -> void:
	interval += 1
	if interval == 20:
		string_index += 1
		if string_index > loading_string.size() - 1:
			string_index = 0
		interval = 0
	text = loading_string[string_index] + " Loading..."
