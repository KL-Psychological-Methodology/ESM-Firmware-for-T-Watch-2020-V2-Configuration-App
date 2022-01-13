class_name ItemDefinitionText
extends ItemDefinition

func get_save_dict() -> Dictionary:
	var save_dict := .get_save_dict()
	save_dict["type"] = get_item_type()
	return save_dict


func get_item_type() -> String:
	return "text"
