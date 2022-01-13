class_name Study
extends Resource

export (String) var study_name: String = ""
export (Array, Resource) var data := []


func _init() -> void:
	data = []


func get_save_dict() -> Dictionary:
	var save_dict := {}
	save_dict["study_name"] = study_name
	save_dict["data"] = _get_questionnaire_array()
	return save_dict


func _get_questionnaire_array() -> Array:
	var questionnaire_array := []
	for questionnaire in data:
		questionnaire_array.append(questionnaire.get_save_dict())
	return questionnaire_array


func load_save(dict: Dictionary) -> void:
	if dict.has("study_name"):
		study_name = dict["study_name"]
	if dict.has("data") and dict["data"] is Array:
		for questionnaire_dict in dict["data"]:
			var new_questionnaire := Questionnaire.new()
			new_questionnaire.load_save(questionnaire_dict)
			data.append(new_questionnaire)
