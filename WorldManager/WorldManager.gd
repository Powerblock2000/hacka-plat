extends Node2D

class_name WorldManager

const WIN_SCENE = preload("uid://cr6wxtmfhg24q")

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
@export var flag : WorldFlag

@onready var max_moves_avalible : int = moves_avalible

func say_dialog(text_to_say: String) -> void:
	can_move = false
	print("saying: %s" % text_to_say)
	dialog.text_for_button = text_to_say + "\n Press any button to continue..."
	await get_tree().process_frame
	await dialog.wipe_in()
	await dialog.pressed
	await dialog.wipe()
	return

func start() -> void:
	player = get_player()
	print("Player: %s" % player)
	flag.body_entered.connect(win_level)

func win_level(_body) -> void:
	win_level_deffered.call_deferred()

func win_level_deffered() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	await get_tree().create_timer(1).timeout
	var win = WIN_SCENE.instantiate()
	get_viewport().add_child(win)
	win.win_level() 

func reset_level() -> void:
	for child in get_children():
		if child is MovablePlatform:
			(child as MovablePlatform).reset_position()
	await get_tree().process_frame
	moves_avalible = max_moves_avalible

func get_player() -> Player:
	for child in get_children():
		if child is Player:
			return child
	return

func check_if_edit_can_change() -> bool:
	for child in get_children():
		if child is MovablePlatform:
			if child.ready_to_set == false:
				edit_can_be_changed = false
				return edit_can_be_changed
	edit_can_be_changed = true
	return edit_can_be_changed

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("GM_INT_Edit") and check_if_edit_can_change():
		can_edit = !can_edit
		print(can_edit)
	if Input.is_action_just_pressed("GM_INT_Reset") and not can_edit:
		reset_level()
		await get_tree().process_frame
		reset_level()
