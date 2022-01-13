class_name RandomizationGroupsContainer
extends PanelContainer

const randomization_group_display_scene := preload("res://src/QuestionnaireConfiguration/RandomizationGroups/RandomizationGroupDisplay.tscn")

var _questionnaire: Questionnaire

onready var groups_list: VBoxContainer = $VBoxContainer/ScrollContainer/GroupsList


func setup(questionnaire: Questionnaire) -> void:
	_questionnaire = questionnaire
	
	for group_display in groups_list.get_children():
		group_display.queue_free()
	
	for group in questionnaire.random_groups:
		assert(group is Array and group.size() == 2)
		_add_group_display(group[0], group[1])


func _on_AddButton_pressed() -> void:
	_questionnaire.random_groups.append([0,0])
	_add_group_display()


func _on_Group_delete_requested(index: int) -> void:
	groups_list.get_child(index).queue_free()
	_questionnaire.random_groups.remove(index)


func _on_Group_from_changed(index: int, value: int) -> void:
	_questionnaire.random_groups[index][0] = value


func _on_Group_to_changed(index: int, value: int) -> void:
	_questionnaire.random_groups[index][1] = value


func _add_group_display(from: int = 0, to: int = 0) -> void:
	var randomization_group_display: RandomizationGroupDisplay = randomization_group_display_scene.instance()
	groups_list.add_child(randomization_group_display)
	randomization_group_display.set_values(from, to)
	randomization_group_display.connect("delete_requested", self, "_on_Group_delete_requested")
	randomization_group_display.connect("from_changed", self, "_on_Group_from_changed")
	randomization_group_display.connect("to_changed", self, "_on_Group_to_changed")


