class_name Alarm
extends Resource

export (int, 0, 23) var Hour: int = 0
export (int, 0, 59) var Minute: int = 0
export (int) var duration: int = 0
export (int) var expiry: int = 15
export (int) var repeat: int = 0


func get_save_dict() -> Dictionary:
	var save_dict := {}
	save_dict["H"] = Hour
	save_dict["M"] = Minute
	save_dict["dur"] = duration
	save_dict["exp"] = expiry
	save_dict["repeat"] = repeat
	return save_dict


func load_save(dict: Dictionary) -> void:
	if dict.has("H"):
		Hour = dict["H"]
	if dict.has("M"):
		Minute = dict["M"]
	if dict.has("dur"):
		duration = dict["dur"]
	if dict.has("exp"):
		expiry = dict["exp"]
	if dict.has("repeat"):
		repeat = dict["repeat"]
