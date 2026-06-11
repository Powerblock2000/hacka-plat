extends Node

const VHS_SCENE = preload("uid://cmu6w4w7np3u3")

var vhs_node : CanvasLayer

func _ready() -> void:
	var vhs = VHS_SCENE.instantiate()
	vhs_node = vhs
	get_viewport().add_child.call_deferred(vhs)

func clear_effect() -> void:
	vhs_node.queue_free()
