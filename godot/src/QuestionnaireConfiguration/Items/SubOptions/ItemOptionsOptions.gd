class_name ItemOptionsOptions
extends ItemSuboptionsBase

onready var num_options_label: Label = $NumOptionsLabel
onready var num_options_spin_box: SpinBox = $NumOptionsSpinBox

var _options := []


func setup(item: ItemDefinition) -> void:
	assert(item is ItemDefinitionOptions)
	_item = item
	for i in _item.options.size():
		_create_row(i+1, _item.options[i])


func _create_row(row_num: int, option_string: String = "") -> void:
	var label := Label.new()
	label.text = "Option %d" % row_num
	var line_edit := LineEdit.new()
	line_edit.text = option_string
	line_edit.connect("text_changed", self, "_assemble_options")
	add_child(label)
	add_child(line_edit)
	_options.append({"label": label, "edit": line_edit})


func _assemble_options(_text: String = "") -> void:
	var options_array := []
	for option in _options:
		options_array.append(option.edit.text)
	_item.options = options_array


func _on_NumOptionsSpinBox_value_changed(value: float) -> void:
	var num_options := int(value)
	var num_current := _options.size()
	if num_options > num_current:
		for i in range(num_current, num_options):
			_create_row(i+1)
	if num_options < num_current:
		for i in num_current - num_options:
			var option_dict: Dictionary = _options.pop_back()
			option_dict.label.queue_free()
			option_dict.edit.queue_free() 
	_assemble_options()
