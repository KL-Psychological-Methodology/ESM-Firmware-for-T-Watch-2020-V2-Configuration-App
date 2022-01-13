class_name ItemDefinitionNumeric
extends ItemDefinition

export (int, 1) var num_digits: int = 1
#export (int, 0) var separator_position: int = 0
export (int) var min_value: int = 0
export (int) var max_value: int = 0


func get_save_dict() -> Dictionary:
	var save_dict := .get_save_dict()
	save_dict["type"] = get_item_type()
	save_dict["digits"] = num_digits
	#save_dict["dot_pos"] = separator_position
	save_dict["min_val"] = min_value
	save_dict["max_val"] = max_value
	return save_dict


func get_item_type() -> String:
	return "numeric"


func load_save(dict: Dictionary) -> void:
	.load_save(dict)
	if dict.has("digits"):
		num_digits = dict["digits"]
	if dict.has("min_val"):
		min_value = dict["min_val"]
	if dict.has("max_val"):
		max_value = dict["max_val"]
