class_name ItemDefinitionLikert
extends ItemDefinition

export (String) var left_label: String = ""
export (String) var right_label: String = ""
export (int, 1) var resolution: int = 5


func get_save_dict() -> Dictionary:
	var save_dict := .get_save_dict()
	save_dict["type"] = get_item_type()
	save_dict["l_lab"] = left_label
	save_dict["r_lab"] = right_label
	save_dict["res"] = resolution
	return save_dict


func get_item_type() -> String:
	return "likert"


func load_save(dict: Dictionary) -> void:
	.load_save(dict)
	if dict.has("l_lab"):
		left_label = dict["l_lab"]
	if dict.has("r_lab"):
		right_label = dict["r_lab"]
	if dict.has("res"):
		resolution = dict["res"]
