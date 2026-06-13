extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	await get_tree().create_timer(.5).timeout
	animation_player.play_section("And Thats a Wrap ;)", 0, 373.5667)
	EffectsManager.clear_effect.call_deferred()

func quit() -> void:
	if OS.has_feature("web"):
		JavaScriptBridge.eval("window.open('', '_self', ''); window.close();")
		return
	
	print("Quiting!")
	get_tree().quit(0)
