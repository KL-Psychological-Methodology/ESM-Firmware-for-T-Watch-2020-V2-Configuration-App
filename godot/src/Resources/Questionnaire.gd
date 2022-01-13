class_name Questionnaire
extends Resource

signal name_changed(new_name)
signal questionnaire_deleted

export (String) var questionnaire_name: String = "" setget set_questionnaire_name
export (bool) var active := true
export (bool) var event := false
export (Array, Resource) var alarms := []
export (Array, Resource) var items := []
export (Array, Array) var random_groups := []


func _init() -> void:
	alarms = []
	items = []
	random_groups = []


func get_save_dict() -> Dictionary:
	var save_dict := {}
	save_dict["name"] = questionnaire_name
	save_dict["active"] = active
	save_dict["event"] = event
	save_dict["alarms"] = _get_alarms_array()
	save_dict["items"] = _get_items_array()
	save_dict["randomize"] = _get_randomize_array()
	return save_dict


func _get_alarms_array() -> Array:
	var alarms_array := []
	for alarm in alarms:
		alarms_array.append(alarm.get_save_dict())
	return alarms_array


func _get_items_array() -> Array:
	var items_array := []
	for item in items:
		items_array.append(item.get_save_dict())
	return items_array


func _get_randomize_array() -> Array:
	var random_array := []
	for random_group in random_groups:
		random_array.append(random_group)
	return random_array


func set_questionnaire_name(new_name: String) -> void:
	questionnaire_name = new_name
	emit_signal("name_changed", questionnaire_name)


func load_save(dict: Dictionary) -> void:
	if dict.has("name"):
		questionnaire_name = dict.name
	if dict.has("active"):
		active = dict.active
	if dict.has("event"):
		event = dict.event
	if dict.has("randomize") and dict["randomize"] is Array:
		random_groups = dict["randomize"]
	if dict.has("alarms") and dict["alarms"] is Array:
		for alarm in dict.alarms:
			var new_alarm := Alarm.new()
			new_alarm.load_save(alarm)
			alarms.append(new_alarm)
	if dict.has("items") and dict["items"] is Array:
		for item in dict["items"]:
			var new_item: ItemDefinition
			if item.has("type"):
				match item.type:
					"text":
						new_item = ItemDefinitionText.new()
					"likert":
						new_item = ItemDefinitionLikert.new()
					"vas":
						new_item = ItemDefinitionVAS.new()
					"numeric":
						new_item = ItemDefinitionNumeric.new()
					"option":
						new_item = ItemDefinitionOptions.new()
					_:
						continue
			else:
				continue
			new_item.load_save(item)
			items.append(new_item)
