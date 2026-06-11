extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	await get_tree().create_timer(.5).timeout
	animation_player.play("And Thats a Wrap ;)")
	EffectsManager.clear_effect.call_deferred()

func quit() -> void:
	get_tree().quit(0)
