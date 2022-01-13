class_name ItemsContainer
extends PanelContainer

const item_display_scene := preload("res://src/QuestionnaireConfiguration/Items/ItemDisplay.tscn")

onready var items_list: VBoxContainer = $HBox/ScrollContainer/ItemsList

var _questionnaire: Questionnaire


func setup(questionnaire: Questionnaire) -> void:
	_questionnaire = questionnaire
	for item in items_list.get_children():
		item.queue_free()
	for item in questionnaire.items:
		_add_item_display(item)


func _add_item_display(item: ItemDefinition) -> void:
	var item_display: ItemDisplay = item_display_scene.instance()
	items_list.add_child(item_display)
	item_display.setup(item)
	item_display.connect("delete_requested", self, "_on_ItemDisplay_delete_requested", [item_display])
	item_display.connect("order_up_requested", self, "_on_ItemDisplay_order_up_requested", [item_display])
	item_display.connect("order_down_requested", self, "_on_ItemDisplay_order_down_requested", [item_display])


func _on_ItemDisplay_delete_requested(item_display: ItemDisplay) -> void:
	var index := item_display.get_index()
	_questionnaire.items.remove(index)
	item_display.queue_free()


func _on_ItemDisplay_order_up_requested(item_display: ItemDisplay) -> void:
	var index := item_display.get_index()
	if index == 0:
		return
	items_list.move_child(item_display, index - 1)
	var temp: ItemDefinition = _questionnaire.items[index]
	_questionnaire.items[index] = _questionnaire.items[index - 1]
	_questionnaire.items[index - 1] = temp
	_update_indexing()


func _on_ItemDisplay_order_down_requested(item_display: ItemDisplay) -> void:
	var index := item_display.get_index()
	if index == items_list.get_child_count() - 1:
		return
	items_list.move_child(item_display, index + 1)
	var temp: ItemDefinition = _questionnaire.items[index]
	_questionnaire.items[index] = _questionnaire.items[index + 1]
	_questionnaire.items[index + 1] = temp
	_update_indexing()


func _update_indexing() -> void:
	for item_display in items_list.get_children():
		item_display.update_index()


func _on_AddButton_pressed() -> void:
	var new_item := ItemDefinitionText.new()
	_questionnaire.items.append(new_item)
	_add_item_display(new_item)
