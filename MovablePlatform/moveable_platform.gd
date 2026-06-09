extends StaticBody2D

class_name MovablePlatform

const GRID_SIZE = 12.5

var mouse_inside : bool = false
var being_dragged : bool = false

var area_2d : Area2D

var ready_to_set : bool = true
var original_position : Vector2
var outline : Node2D

func get_area_2d() -> Area2D:
	for child in get_children():
		if child is Area2D:
			return child
	return

func _ready() -> void:
	input_pickable = true
	var snapped_x : float = snapped(global_position.x, GRID_SIZE)
	var snapped_y : float = snapped(global_position.y, GRID_SIZE)
	var pos : Vector2 = Vector2(snapped_x, snapped_y)
	global_position = pos
	mouse_entered.connect(mouse_enter)
	mouse_exited.connect(mouse_exit)
	
	area_2d = get_area_2d()
	
	area_2d.body_entered.connect(body_entered)
	area_2d.body_exited.connect(body_exited)
	original_position = global_position
	
	for child in get_children():
		if child.name == "Outline":
			outline = child

func body_entered(body: Node2D) -> void:
	if body is Player:
		ready_to_set = false

func reset_position() -> void:
	global_position = original_position

func body_exited(body: Node2D) -> void:
	if body is Player:
		ready_to_set = true

var old_pos : Vector2
func _process(_delta: float) -> void:
	if (get_parent() as WorldManager).can_edit and outline:
		outline.show()
	elif outline:
		outline.hide()
	
	being_dragged = false
	if Input.is_action_pressed("Click") and mouse_inside and (get_parent() as WorldManager).can_edit:
		being_dragged = true
	
	if old_pos != Vector2.ZERO:
		if global_position != old_pos:
			(get_parent() as WorldManager).moves_avalible -= 1
			print((get_parent() as WorldManager).moves_avalible)
	
	old_pos = global_position
	
	if (get_parent() as WorldManager).moves_avalible <= 0:
		being_dragged = false
	
	if being_dragged:
		var raw_mouse_pos : Vector2 = get_global_mouse_position()
		var snapped_x : float = snapped(raw_mouse_pos.x, GRID_SIZE)
		var snapped_y : float = snapped(raw_mouse_pos.y, GRID_SIZE)
		var pos : Vector2 = Vector2(snapped_x, snapped_y)
		
		global_position = pos
		collision_layer = 2
		#collision_mask = 1
	if not (get_parent() as WorldManager).can_edit:
		collision_layer = 1
		#collision_mask = 1
	#print(collision_layer)

func mouse_enter() -> void:
	mouse_inside = true
	print("Mouse inside")

func mouse_exit() -> void:
	mouse_inside = false
	print("Mouse outside")
