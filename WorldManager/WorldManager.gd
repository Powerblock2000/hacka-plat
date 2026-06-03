extends Node2D

class_name WorldManager

var player : Player
var edit_can_be_changed : bool = true
var can_edit : bool = false:
	set(value):
		if edit_can_be_changed:
			can_edit = value
			if player != null and can_edit == false:
				player.global_position = starting_pos
var dumb_timer : SceneTreeTimer
var can_move : bool = true

@export var moves_avalible : int = 5
@export var starting_pos : Vector2 = Vector2(0, 1)
@export var dialog: KeyButton

func say_dialog(text_to_say: String) -> void:
	can_move = false
	print("saying: %s" % text_to_say)
	dialog.text_for_button = text_to_say + "\n Press any button to continue..."
	await get_tree().process_frame
	await dialog.wipe_in()
	await dialog.pressed
	await dialog.wipe()
	can_move = true
	return

func start() -> void:
	player = get_player()
	print("Player: %s" % player)

func get_player() -> Player:
	for child in get_children():
		if child is Player:
			return child
	return

func check_if_edit_can_change() -> void:
	for child in get_children():
		if child is MovablePlatform:
			if child.ready_to_set == false:
				edit_can_be_changed = false
				return
	edit_can_be_changed = true

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("GM_INT_Edit"):
		check_if_edit_can_change()
		can_edit = !can_edit
		print(can_edit)
