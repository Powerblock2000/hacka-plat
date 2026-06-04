extends Control

@onready var label: TextButtonbase = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var play_label : KeyButton = $Play
@onready var main_menu: TextMenu = $MainMenu

var await_key_press : bool = false

func _ready() -> void:
	#await get_tree().create_timer(10).timeout
	animation_player.play("Start")

func flash_text() -> void:
	var flash_tween : Tween = create_tween()
	flash_tween.tween_property(label, "modulate", Color(0.0, 1.0, 0.0, 1.0), .1)
	await flash_tween.finished
	await get_tree().create_timer(.2).timeout
	var diffuse_tween : Tween = create_tween()
	diffuse_tween.tween_property(label, "modulate", Color(0.0, 0.36, 0.0, 1.0), .7)
	await diffuse_tween.finished
	play_label.wipe_in()
	await_key_press = true

func _on_play_pressed() -> void:
	await play_label.wipe()
	play_label.hide()
	await get_tree().process_frame
	await main_menu.wipe_in()

func _on_main_menu_item_selected(index: Variant) -> void:
	if index == 0:
		print("Play!")
		await main_menu.wipe()
		await label.wipe()
		LoadingManager.change_scene("res://Levels/Tutorial/tutorial.tscn")
	if index == 2:
		await main_menu.wipe()
		get_tree().quit(0)
