class_name AlarmsContainer
extends PanelContainer

const alarm_box_scene := preload("res://src/QuestionnaireConfiguration/Alarms/AlarmBox.tscn")

var _questionnaire: Questionnaire

onready var alarms_list: VBoxContainer = $VBox/ScrollContainer/AlarmsList


func setup(questionnaire: Questionnaire) -> void:
	_questionnaire = questionnaire
	
	for alarm_box in alarms_list.get_children():
		alarm_box.queue_free()
	
	for alarm in questionnaire.alarms:
		_create_alarm_box(alarm)


func _on_AddButton_pressed() -> void:
	var new_alarm := Alarm.new()
	_questionnaire.alarms.append(new_alarm)
	_create_alarm_box(new_alarm)


func _on_AlarmBox_delete_requested(alarm: Alarm, alarm_box: AlarmBox) -> void:
	alarm_box.queue_free()
	_questionnaire.alarms.erase(alarm)


func _create_alarm_box(alarm: Alarm) -> void:
	var alarm_box: AlarmBox = alarm_box_scene.instance()
	alarms_list.add_child(alarm_box)
	alarm_box.setup(alarm)
	alarm_box.connect("delete_requested", self, "_on_AlarmBox_delete_requested", [alarm_box])
