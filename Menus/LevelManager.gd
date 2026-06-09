extends Node

signal about_to_close

var levels : Array[int] = [
		1,
		2,
		3,
		4,
		5
]
var finished_levels : Array[int]

@onready var save : ConfigFile = ConfigFile.new()

func get_levels_array() -> Array[String]:
	var array : Array[String]
	
	for i in levels:
		#print(levels.find(i))
		if finished_levels.has(i):
			array.append("Level %s 🔓" % i)
		else:
			array.append("Level %s 🔒" % i)
	return array

func _notification(what: int) -> void:
	# Check if the window close request was triggered
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		about_to_close.emit()
		start_save()

func start_save() -> void:
	var error : Error = save.save("user://save.cfg")
	if error != OK:
		push_error("Save couldnt be completed. Error: %s" % error)

func _ready() -> void:
	if FileAccess.open("user://save.cfg", FileAccess.READ) != null:
		save.load("user://save.cfg")
		
		finished_levels = save.get_value("levels", "unlocked")

func finish_level(level : int) -> void:
	if finished_levels.has(level): return
	
	finished_levels.append(level)
	
	print("Finished level: %s" % level)
	
	save.set_value("levels", "unlocked", finished_levels)
