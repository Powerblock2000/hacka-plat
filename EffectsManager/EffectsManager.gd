extends Node

const VHS_SCENE = preload("uid://cmu6w4w7np3u3")

func _ready() -> void:
	var vhs = VHS_SCENE.instantiate()
	get_viewport().add_child.call_deferred(vhs)
