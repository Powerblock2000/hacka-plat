@tool
extends TextButtonbase

class_name TextMenu

signal item_selected(index)

@export var items_in_menu : Array[String] = []

var selected_item_array : int = 0

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("MN_INT_Down") and not selected_item_array > items_in_menu.size() - 2 and visible:
		selected_item_array += 1
	if Input.is_action_just_pressed("MN_INT_Up") and not selected_item_array == 0 and visible:
		selected_item_array -= 1
	if Input.is_action_just_pressed("MN_INT_Select") and visible:
		item_selected.emit(selected_item_array)

func _process(_delta: float) -> void:
	if Engine.is_editor_hint() and items_in_menu.size() > 0:
		var text_to_display_engine : String = ""
		text_to_display_engine = "\n() ".join(items_in_menu)
		text = text_to_display_engine
	
	if Engine.is_editor_hint() or not visible: return
	var text_to_display : String = ""
	var items : Array[String] = items_in_menu.duplicate()
	var index : int = 0
	for i in items:
		items[index] = "( ) " + items[index]
		index += 1
	
	items[selected_item_array] = "(x) " + (items_in_menu[selected_item_array])
	
	text_to_display = "\n".join(items)
	text = text_to_display
