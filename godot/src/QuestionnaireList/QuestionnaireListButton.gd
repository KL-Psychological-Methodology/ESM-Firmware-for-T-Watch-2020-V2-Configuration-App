class_name QuestionnaireListButton
extends Button

var questionnaire: Questionnaire


func _init(q: Questionnaire) -> void:
	questionnaire = q
	text = q.questionnaire_name
	q.connect("questionnaire_deleted", self, "queue_free")
	q.connect("name_changed", self, "_on_Questionnaire_name_changed")
	align = Button.ALIGN_LEFT


func _on_Questionnaire_name_changed(new_name: String) -> void:
	text = new_name
