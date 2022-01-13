class_name ItemDefinition
extends Resource

enum ItemType {VAS, LIKERT, TEXT, NUMERIC, OPTIONS};

export (String) var prompt: String = "";
export (String) var item_name: String = "";
export (bool) var mandatory := false;


func get_save_dict() -> Dictionary:
	var save_dict := {}
	save_dict["prompt"] = prompt
	save_dict["item"] = item_name
	save_dict["mandatory"] = mandatory
	return save_dict


func get_item_type() -> String:
	return ""


func load_save(dict: Dictionary) -> void:
	if dict.has("prompt"):
		prompt = dict.prompt
	if dict.has("item"):
		item_name = dict.item
	if dict.has("mandatory"):
		mandatory = dict.mandatory
