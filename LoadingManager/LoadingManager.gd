extends Node

signal loaded_scene

const LOADING = preload("uid://dkc60nw8rw8e1")

var loading_path : String = ""

func _process(_delta: float) -> void:
	if loading_path != "":
		if ResourceLoader.load_threaded_get_status(loading_path) == 3:
			await get_tree().process_frame
			print("Scene is loaded!")
			loaded_scene.emit()

func change_scene(scene_path: String) -> void:
	#if not scene_path.is_absolute_path() or not scene_path.is_relative_path():
		#print("Invalid scene!")
		#return
	
	
	var loading_screen : CanvasLayer = LOADING.instantiate()
	
	get_viewport().add_child(loading_screen)
	
	ResourceLoader.load_threaded_request(scene_path)
	loading_path = scene_path
	print("Waiting for scene")
	await loaded_scene
	print("Scene loaded recieved")
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene_path))
	await get_tree().create_timer(3).timeout
	await loading_screen.wipe()
	loading_screen.queue_free()
