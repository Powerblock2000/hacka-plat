extends WorldManager

@onready var edit: TextButtonbase = $CanvasLayer2/MarginContainer/Control/ColorRect/HBoxContainer/Edit
@onready var reset: TextButtonbase = $CanvasLayer2/MarginContainer/Control/ColorRect/HBoxContainer/Reset
@onready var edits_remaining: TextButtonbase = $CanvasLayer2/MarginContainer/Control/ColorRect/HBoxContainer/EditsRemaining
@onready var sprint: TextButtonbase = $CanvasLayer2/MarginContainer/Control/ColorRect/HBoxContainer/Sprint

func _ready() -> void:
	start()
	start_dialog()

func start_dialog() -> void:
	edit_can_be_changed = false
	await get_tree().process_frame
	await say_dialog("Huh it looks like you need some help                                                                ")
	await say_dialog("Use [A] and [D] on your keyboard to move and press [Space] to jump!")
	await say_dialog("Press [E] (Keyboard) to enter (Edit) mode and \n drag highlighted objects to move them arround         ")
	edit.show()
	await say_dialog("But be aware, you can only move objects a set amount of times. \n Check the botton of your sceen to see!")
	edits_remaining.show()
	await say_dialog("Dont worry, if you mess up you can press [R] (Keyboad) \n but make sure you are not in edit mode")
	reset.show()
	await say_dialog("Also, you can sprint by pressing [Shift] (Keyboard)")
	sprint.show()
	can_move = true
	edit_can_be_changed = true
