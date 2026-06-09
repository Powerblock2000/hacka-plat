extends Area2D

class_name AddEdit

@export var world_manager : WorldManager
@export var add_amount : int = 5

@onready var label: Label = $Label
@onready var smoke: CPUParticles2D = $Smoke
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var plus: CPUParticles2D = $Plus

var enabled : bool = true

func _ready() -> void:
	collision_layer = 3
	collision_mask = 3
	
	body_entered.connect(use)

func _process(_delta: float) -> void:
	if !enabled:
		sprite_2d.hide()
		label.hide()
		plus.emitting = false
	else:
		sprite_2d.show()
		label.show()
		plus.emitting = true
	label.text = " %s" % add_amount

func use(_body) -> void:
	if !enabled: return
	if world_manager:
		world_manager.moves_avalible += add_amount
		smoke.emitting = true
		enabled = false
		await get_tree().create_timer(.3).timeout
		
