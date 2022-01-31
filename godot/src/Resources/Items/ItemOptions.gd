class_name ItemDefinitionOptions
extends ItemDefinition

export (Array, String) var options := []


func get_save_dict() -> Dictionary:
	var save_dict := .get_save_dict()
	save_dict["type"] = get_item_type()
	save_dict["options"] = _convert_options()
	return save_dict


func get_item_type() -> String:
	return "option"


func _convert_options() -> String:
	var options_string := ""
	
	for i in options.size():
		var format_string = "%s\n%s" if i > 0 else "%s%s"
		options_string = format_string % [options_string, options[i]]
	
	return options_string


func load_save(dict: Dictionary) -> void:
	.load_save(dict)
	if dict.has("options"):
		var options_string: String = dict["options"]
		options = options_string.split("\n")
