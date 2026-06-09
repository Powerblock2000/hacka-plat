extends TextButtonbase

@export var world_manager : WorldManager

func _process(_delta: float) -> void:
	if world_manager.can_edit:
		text = "[E] Edit mode [ON ] |"
	else:
		text = "[E] Edit mode [OFF] |"
