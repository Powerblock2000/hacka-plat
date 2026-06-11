extends Node2D

class_name WorldManager

const WIN_SCENE = preload("uid://cr6wxtmfhg24q")

signal _finished_dialog

var player : Player
var edit_can_be_changed : bool = true
var can_edit : bool = false:
	set(value):
		if edit_can_be_changed:
			can_edit = value
			if player != null and can_edit == false and not in_safe_zone:
				player.global_position = starting_pos
var dumb_timer : SceneTreeTimer
var can_move : bool = true
var in_safe_zone : bool = false

@export var moves_avalible : int = 5
@export var starting_pos : Vector2 = Vector2(0, 1)
@export var dialog: KeyButton
@export var flag : WorldFlag
@export var death_zone : DeathZone
@export_file_path("*.tscn", "*.scn") var next_scene_path : String
@export var level_index : int = 1 ## Dont use 0, starts at 1

@onready var max_moves_avalible : int = moves_avalible

var music : AudioStreamPlayer

func say_dialog(text_to_say: String) -> void:
	say_dialog_defered.call_deferred(text_to_say)
	await _finished_dialog

func say_dialog_defered(text_to_say: String) -> void:
	can_move = false
	print("saying: %s" % text_to_say)
	dialog.text_for_button = text_to_say + "\n Press any button to continue..."
	await get_tree().process_frame
	await dialog.wipe_in()
	await dialog.pressed
	await dialog.wipe()
	_finished_dialog.emit()
	return

func _ready() -> void:
	start()

func start() -> void:
	player = get_player()
	print("Player: %s" % player)
	flag.body_entered.connect(win_level)
	death_zone.body_entered.connect(death)
	
	var audio : AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(audio)
	audio.stream = AudioStreamMP3.load_from_file("res://Audio/melodyayresgriffiths-rasputin-russia-tetris-game-cossack-puzzle-soundtrack-mystery-148250.mp3")
	audio.volume_db = -15
	audio.playing = true
	music = audio

func death(body) -> void:
	if body is Player:
		player.global_position = starting_pos
		reset_level()
		edit_can_be_changed = true
		can_edit = false

func win_level(_body) -> void:
	win_level_deffered.call_deferred()

func win_level_deffered() -> void:
	LevelManager.finish_level(level_index)
	
	music.queue_free()
	
	var audio_win : AudioStreamPlayer = AudioStreamPlayer.new()
	add_child(audio_win)
	audio_win.stream = AudioStreamMP3.load_from_file("res://Audio/eaglaxle-gaming-victory-464016.mp3")
	audio_win.playing = true
	can_move = false
	await get_tree().create_timer(2).timeout
	
	process_mode = Node.PROCESS_MODE_DISABLED
	await get_tree().create_timer(1).timeout
	var win = WIN_SCENE.instantiate()
	get_viewport().add_child(win)
	win.next_level_path = next_scene_path
	win.win_level() 

func reset_level() -> void:
	for child in get_children():
		if child is MovablePlatform:
			(child as MovablePlatform).reset_position()
		if child is AddEdit:
			print("Addedit")
			(child as AddEdit).enabled = true
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
