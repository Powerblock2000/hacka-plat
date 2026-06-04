extends TextButtonbase

@export var player : Player

func _process(_delta: float) -> void:
	text = "[Shift] Dash | Time left to Dash: %s" % roundf(player.dash_timer.time_left)
