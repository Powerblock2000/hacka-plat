extends WorldManager

func _ready() -> void:
	start()
	start_dialog()

func start_dialog() -> void:
	await get_tree().process_frame
	await say_dialog("Huh it looks like you need some help")
