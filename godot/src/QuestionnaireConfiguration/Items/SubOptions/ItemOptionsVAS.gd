class_name ItemOptionsVAS
extends ItemSuboptionsBase


onready var left_label_edit: LineEdit = $LeftLabelEdit
onready var right_label_edit: LineEdit = $RightLabelEdit


func setup(item: ItemDefinition) -> void:
	assert(item is ItemDefinitionVAS)
	_item = item
	left_label_edit.text = item.left_label
	right_label_edit.text = item.right_label


func _on_LeftLabelEdit_text_changed(new_text: String) -> void:
	_item.left_label = new_text


func _on_RightLabelEdit_text_changed(new_text: String) -> void:
	_item.right_label = new_text
