class_name QuestionnaireConfiguration
extends MarginContainer

signal delete_requested(questionnaire)

onready var q_label: EditLabel = $VBox/TopPanel/VBox/Hbox/QLabel
onready var q_settings: HBoxContainer = $VBox/TopPanel/VBox/QSettings
onready var active_checkbox: CheckBox = $VBox/TopPanel/VBox/QSettings/ActiveCheckbox
onready var event_checkbox: CheckBox = $VBox/TopPanel/VBox/QSettings/EventCheckbox
onready var settings_button: Button = $VBox/TopPanel/VBox/Hbox/SettingsButton

onready var tabs: Tabs = $VBox/Tabs
onready var items_container: ItemsContainer = $VBox/ItemsContainer
onready var alarms_container: AlarmsContainer = $VBox/AlarmsContainer
onready var randomization_groups_container: RandomizationGroupsContainer = $VBox/RandomizationGroupsContainer

var disabled := false setget set_disabled
var _questionnaire: Questionnaire

var tabs_order := ["Items", "Alarms", "Random Groups"]
onready var tabs_map := {
	"Items": $VBox/ItemsContainer,
	"Alarms": $VBox/AlarmsContainer,
	"Random Groups": $VBox/RandomizationGroupsContainer
}


func _ready() -> void:
	for key in tabs_order:
		tabs.add_tab(key)
	tabs.current_tab = 0
	_on_Tabs_tab_changed(0)
	set_disabled(true)


func set_questionnaire(questionnaire: Questionnaire) -> void:
	_questionnaire = questionnaire
	settings_button.pressed = true
	q_settings.visible = true
	q_label.text = questionnaire.questionnaire_name
	active_checkbox.pressed = questionnaire.active
	event_checkbox.pressed = questionnaire.event
	
	items_container.setup(questionnaire)
	alarms_container.setup(questionnaire)
	randomization_groups_container.setup(questionnaire)
	if disabled:
		set_disabled(false)


func _on_SettingsButton_toggled(button_pressed: bool) -> void:
	q_settings.visible = button_pressed


func _on_ActiveCheckbox_toggled(button_pressed: bool) -> void:
	_questionnaire.active = button_pressed


func _on_EventCheckbox_toggled(button_pressed: bool) -> void:
	_questionnaire.event = button_pressed


func _on_QLabel_text_changed(new_text: String) -> void:
	_questionnaire.questionnaire_name = new_text


func _on_Tabs_tab_changed(tab: int) -> void:
	for i in tabs_order.size():
		tabs_map[tabs_order[i]].visible = tab == i


func _on_DeleteButton_pressed() -> void:
	set_disabled(true)
	emit_signal("delete_requested", _questionnaire)


func set_disabled(value: bool) -> void:
	disabled = value
	if disabled:
		alarms_container.visible = false
		randomization_groups_container.visible = false
		items_container.visible = false
		for tab in tabs.get_tab_count():
			tabs.set_tab_disabled(tab, true)
		q_label.disabled = true
		q_label.text = ""
		q_settings.visible = false
		settings_button.disabled = true
	else:
		for tab in tabs.get_tab_count():
			tabs.set_tab_disabled(tab, false)
		tabs.current_tab = 0
		items_container.visible = true
		q_settings.visible = true
		settings_button.disabled = false
		q_label.disabled = false





