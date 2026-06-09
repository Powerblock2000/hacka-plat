extends WorldManager

func _ready() -> void:
	can_move = false
	edit_can_be_changed = false
	await get_tree().process_frame
	await say_dialog("Watch out for green zones, these are safe zones \n                 ")
	await say_dialog("If your in this zone you can exit editing and stay in the same spot!")
	can_move = true
	start()
