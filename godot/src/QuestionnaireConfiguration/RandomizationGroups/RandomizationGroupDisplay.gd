class_name RandomizationGroupDisplay
extends HBoxContainer

signal delete_requested(index)
signal from_changed(index, value)
signal to_changed(index, value)

onready var from_box: SpinBox = $FromBox
onready var to_box: SpinBox = $ToBox


func set_values(from: int, to: int) -> void:
	from_box.value = from
	to_box.value = to


func _on_DeleteButton_pressed() -> void:
	emit_signal("delete_requested", get_index())


func _on_FromBox_value_changed(value: float) -> void:
	emit_signal("from_changed", get_index(), int(value))


func _on_ToBox_value_changed(value: float) -> void:
	emit_signal("to_changed", get_index(), int(value))
