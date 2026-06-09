extends Control

@onready var levels: TextMenu = $Levels

func _ready() -> void:
	levels.items_in_menu = LevelManager.get_levels_array()
	levels.show()

func _on_levels_item_selected(index: Variant) -> void:
	if index <= LevelManager.finished_levels[-1]:
		print("Get ready!")
		await levels.wipe()
		LoadingManager.change_scene("res://Levels/%s/%s.tscn" % [index + 1, index + 1])
	else:
		var tween : Tween = create_tween()
		tween.tween_property(levels, "modulate", Color(0.706, 0.0, 0.0, 1.0), .07)
		tween.tween_property(levels, "modulate", Color("009700"), .8)
