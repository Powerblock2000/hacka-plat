extends TextButtonbase

@export var world_manager : WorldManager

func _process(_delta: float) -> void:
	text = "%s Edits left | " % world_manager.moves_avalible
