class_name ItemOptionsNumeric
extends ItemSuboptionsBase

onready var digits_spin_box: SpinBox = $DigitsSpinBox
onready var min_value_spin_box: SpinBox = $MinValueSpinBox
onready var max_value_spin_box: SpinBox = $MaxValueSpinBox


func setup(item: ItemDefinition) -> void:
	assert(item is ItemDefinitionNumeric)
	_item = item
	digits_spin_box.value = item.num_digits
	min_value_spin_box.value = item.min_value
	max_value_spin_box.value = item.max_value


func _on_DigitsSpinBox_value_changed(value: float) -> void:
	_item.num_digits = int(value)


func _on_MinValueSpinBox_value_changed(value: float) -> void:
	_item.min_value = int(value)


func _on_MaxValueSpinBox_value_changed(value: float) -> void:
	_item.max_value = int(value)
