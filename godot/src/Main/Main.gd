extends Control

enum IO_Modes {LOAD, SAVE}

var current_study := Study.new()

onready var questionnaire_list: QuestionnaireList = $Hbox/HSplitContainer/QuestionnaireList
onready var questionnaire_configuration: QuestionnaireConfiguration = $Hbox/HSplitContainer/QuestionnaireConfiguration
onready var file_dialog: FileDialog = $FileDialog
onready var edit_label: EditLabel = $Hbox/TopBar/HBoxContainer/EditLabel

var io_mode: int = IO_Modes.LOAD setget set_io_mode


func _ready() -> void:
	current_study.study_name = "New Study"
	questionnaire_list.setup(current_study)
	file_dialog.current_dir = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)


func _on_EditLabel_text_changed(new_text) -> void:
	current_study.study_name = new_text


func _on_QuestionnaireList_questionnaire_selected(questionnaire: Questionnaire) -> void:
	questionnaire_configuration.set_questionnaire(questionnaire)


func _on_QuestionnaireConfiguration_delete_requested(questionnaire: Questionnaire) -> void:
	questionnaire.emit_signal("questionnaire_deleted")
	current_study.data.erase(questionnaire)


func set_io_mode(value: int) -> void:
	io_mode = value
	match io_mode:
		IO_Modes.LOAD:
			file_dialog.mode = FileDialog.MODE_OPEN_FILE
			file_dialog.window_title = "Open Study File"
		IO_Modes.SAVE:
			file_dialog.mode = FileDialog.MODE_OPEN_DIR
			file_dialog.window_title = "Save Study File"


func _on_FileDialog_file_selected(path: String) -> void:
			_load_study(path)


func _load_study(path: String) -> void:
	var file := File.new()
	file.open(path, File.READ)
	var content := file.get_as_text()
	file.close()
	var json_result := JSON.parse(content)
	if json_result.error == OK:
		var new_study = Study.new()
		new_study.load_save(json_result.result)
		current_study = new_study
		questionnaire_configuration.disabled = true
		questionnaire_list.setup(current_study)
		edit_label.text = current_study.study_name
	


func _save_study(dir: String) -> void:
	var file := File.new()
	var path := dir.plus_file("config.json")
	file.open(path, File.WRITE_READ)
	var content := JSON.print(current_study.get_save_dict(), "\t")
	file.store_string(content)
	file.close()


func _on_LoadButton_pressed() -> void:
	self.io_mode = IO_Modes.LOAD
	file_dialog.invalidate()
	file_dialog.popup()


func _on_SaveButton_pressed() -> void:
	self.io_mode = IO_Modes.SAVE
	file_dialog.invalidate()
	file_dialog.popup()


func _on_FileDialog_dir_selected(dir: String) -> void:
	_save_study(dir)
