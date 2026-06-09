extends Area2D

class_name SafeZone

@export var world_manager : WorldManager

func _ready() -> void:
	body_entered.connect(entered_zone)
	body_exited.connect(exited_zone)
	
	collision_layer = 3
	collision_mask = 3

func entered_zone(_body) -> void:
	print("ENTER")
	if world_manager:
		world_manager.in_safe_zone = true

func exited_zone(_body) -> void:
	print("EXIT")
	if world_manager:
		world_manager.in_safe_zone = false
