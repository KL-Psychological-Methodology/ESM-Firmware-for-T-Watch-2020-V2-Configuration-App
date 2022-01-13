class_name QuestionnaireList
extends PanelContainer

signal questionnaire_selected(questionnaire)

onready var button_list: VBoxContainer = $VBox/Scroll/ButtonList

var _study: Study


func setup(study: Study) -> void:
	_study = study
	for button in button_list.get_children():
		button.queue_free()
	for questionnaire in study.data:
		_add_button(questionnaire)
	if not study.data.empty():
		emit_signal("questionnaire_selected", study.data[0])


func _on_AddButton_pressed():
	var new_questionnaire := Questionnaire.new()
	new_questionnaire.questionnaire_name = "New Questionnaire"
	_study.data.append(new_questionnaire)
	_add_button(new_questionnaire)
	emit_signal("questionnaire_selected", new_questionnaire)


func _add_button(questionnaire: Questionnaire) -> void:
	var new_button := QuestionnaireListButton.new(questionnaire)
	button_list.add_child(new_button)
	new_button.connect("pressed", self, "_on_Questionnaire_selected", [questionnaire])


func _on_Questionnaire_selected(questionnaire: Questionnaire) -> void:
	emit_signal("questionnaire_selected", questionnaire)
