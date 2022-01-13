class_name ItemOptionsLikert
extends ItemSuboptionsBase

onready var resoultion_spin_box: SpinBox = $ResolutionSpinBox
onready var left_label_edit: LineEdit = $LeftLabelEdit
onready var right_label_edit: LineEdit = $RightLabelEdit


func setup(item: ItemDefinition) -> void:
	assert(item is ItemDefinitionLikert)
	_item = item
	resoultion_spin_box.value = item.resolution
	left_label_edit.text = item.left_label
	right_label_edit.text = item.right_label


func _on_ResolutionSpinBox_value_changed(value: float) -> void:
	_item.resolution = int(value)


func _on_LeftLabelEdit_text_changed(new_text: String) -> void:
	_item.left_label = new_text


func _on_RightLabelEdit_text_changed(new_text: String) -> void:
	_item.right_label = new_text
