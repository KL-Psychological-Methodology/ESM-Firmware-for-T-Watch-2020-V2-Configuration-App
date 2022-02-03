class_name ItemDisplay
extends PanelContainer

# warning-ignore:unused_signal
signal order_up_requested
# warning-ignore:unused_signal
signal order_down_requested
signal delete_requested
signal type_changed


const type_options := ["Text", "Likert", "VAS", "Numeric", "Options"]
const suboptions_scenes := {
	"Likert": preload("res://src/QuestionnaireConfiguration/Items/SubOptions/ItemOptionsLikert.tscn"),
	"VAS": preload("res://src/QuestionnaireConfiguration/Items/SubOptions/ItemOptionsVAS.tscn"),
	"Numeric": preload("res://src/QuestionnaireConfiguration/Items/SubOptions/ItemOptionsNumeric.tscn"),
	"Options": preload("res://src/QuestionnaireConfiguration/Items/SubOptions/ItemOptionsOptions.tscn")
}


onready var index_label: Label = $HBoxContainer/OrderControl/IndexLabel
onready var name_edit: LineEdit = $HBoxContainer/ItemProperties/NameEdit
onready var prompt_edit: TextEdit = $HBoxContainer/ItemProperties/PromptEdit
onready var mandatory_checkbox: CheckBox = $HBoxContainer/ItemProperties/MandatoryCheckbox
onready var type_option_button: OptionButton = $HBoxContainer/ItemProperties/HBoxContainer/TypeOptionButton
onready var item_properties: VBoxContainer = $HBoxContainer/ItemProperties

var _sub_options: ItemSuboptionsBase = null
var _item: ItemDefinition


func _ready() -> void:
	for type_option in type_options:
		type_option_button.add_item(type_option)


func setup(item: ItemDefinition) -> void:
	_item = item
	update_index()
	name_edit.text = item.item_name
	prompt_edit.text = item.prompt
	mandatory_checkbox.pressed = item.mandatory
	_setup_subtype()


func get_definition() -> ItemDefinition:
	return _item


func _setup_subtype() -> void:
	if _item is ItemDefinitionText:
		type_option_button.selected = type_options.find("Text")
		_sub_options = null
	if _item is ItemDefinitionLikert:
		type_option_button.selected = type_options.find("Likert")
		_sub_options = suboptions_scenes.Likert.instance()
	elif _item is ItemDefinitionVAS:
		type_option_button.selected = type_options.find("VAS")
		_sub_options = suboptions_scenes.VAS.instance()
	elif _item is ItemDefinitionNumeric:
		type_option_button.selected = type_options.find("Numeric")
		_sub_options = suboptions_scenes.Numeric.instance()
	elif _item is ItemDefinitionOptions:
		type_option_button.selected = type_options.find("Options")
		_sub_options = suboptions_scenes.Options.instance()
	
	if _sub_options != null:
		item_properties.add_child(_sub_options)
		_sub_options.setup(_item)


func update_index() -> void:
	index_label.text = "\n%d\n" % (get_index() + 1)


func _on_OrderButton_pressed(direction: String) -> void:
	emit_signal("order_%s_requested" % direction)


func _on_NameEdit_text_changed(new_text: String) -> void:
	_item.item_name = new_text


func _on_PromptEdit_text_changed() -> void:
	_item.prompt = prompt_edit.text


func _on_MandatoryCheckbox_toggled(button_pressed: bool) -> void:
	_item.mandatory = button_pressed


func _on_TypeOptionButton_item_selected(index: int) -> void:
	var type := type_option_button.get_item_text(index)
	var new_item: ItemDefinition
	match type:
		"Text":
			new_item = ItemDefinitionText.new()
		"Likert":
			new_item = ItemDefinitionLikert.new()
		"VAS":
			new_item = ItemDefinitionVAS.new()
		"Numeric":
			new_item = ItemDefinitionNumeric.new()
		"Options":
			new_item = ItemDefinitionOptions.new()
	
	new_item.item_name = _item.item_name
	new_item.prompt = _item.prompt
	new_item.mandatory = _item.mandatory
	_item = new_item
	
	if _sub_options != null:
		_sub_options.queue_free()
		_sub_options = null
	if type != "Text":
		_sub_options = suboptions_scenes[type].instance()
		item_properties.add_child(_sub_options)
		_sub_options.setup(_item)
	emit_signal("type_changed")


func _on_DeleteButton_pressed() -> void:
	emit_signal("delete_requested")
