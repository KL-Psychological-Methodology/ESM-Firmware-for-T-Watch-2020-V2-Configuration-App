tool
class_name EditLabel
extends MarginContainer

signal text_changed(new_text)

onready var _label: Label = $HBoxContainer/Label
onready var _line_edit: LineEdit = $HBoxContainer/LineEdit

export (String) var text: String = "" setget set_text
export (bool) var disabled := false setget set_disabled
var _edit_state := false

func _on_Button_pressed():
	if disabled:
		return
	_edit_state = not _edit_state
	_label.visible = not _edit_state
	_line_edit.visible = _edit_state


func _on_LineEdit_text_changed(new_text):
	_label.text = new_text
	text = new_text
	emit_signal("text_changed", new_text)


func set_text(value: String) -> void:
	if not is_inside_tree():
		yield(self, "ready")
	text = value
	_label.text = value
	_line_edit.text = value


func set_disabled(value: bool) -> void:
	if not is_inside_tree():
		yield(self, "ready")
	disabled = value
	if disabled:
		_edit_state = false
		_label.visible = true
		_line_edit.visible = false
