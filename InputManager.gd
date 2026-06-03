extends Node

var using_controller : bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		using_controller = true
	else:
		using_controller = false
