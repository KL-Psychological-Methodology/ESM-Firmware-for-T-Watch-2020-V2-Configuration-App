class_name ItemDefinitionVAS
extends ItemDefinition

export (String) var left_label: String = ""
export (String) var right_label: String = ""


func get_save_dict() -> Dictionary:
	var save_dict := .get_save_dict()
	save_dict["type"] = get_item_type()
	save_dict["l_lab"] = "left_label"
	save_dict["r_lab"] = "right_label"
	return save_dict


func get_item_type() -> String:
	return "vas"


func load_save(dict: Dictionary) -> void:
	.load_save(dict)
	if dict.has("l_lab"):
		left_label = dict["l_lab"]
	if dict.has("r_lab"):
		right_label = dict["r_lab"]
