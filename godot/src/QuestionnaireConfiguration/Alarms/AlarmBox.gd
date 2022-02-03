class_name AlarmBox
extends PanelContainer

signal delete_requested(alarm)

onready var hour_box: SpinBox = $VBoxContainer/HBoxContainer/HourBox
onready var minute_box: SpinBox = $VBoxContainer/HBoxContainer/MinuteBox
onready var duration_box: SpinBox = $VBoxContainer/HBoxContainer2/DurationBox
onready var expiry_box: SpinBox = $VBoxContainer/HBoxContainer2/ExpiryBox
onready var repeat_box: SpinBox = $VBoxContainer/HBoxContainer2/RepeatBox
onready var info_label: Label = $VBoxContainer/InfoLabel

var _alarm: Alarm


func setup(alarm: Alarm) -> void:
	_alarm = alarm
	hour_box.value = alarm.Hour
	minute_box.value = alarm.Minute
	duration_box.value = alarm.duration
	expiry_box.value = alarm.expiry
	repeat_box.value = alarm.repeat
	_update_info_label()


func _on_DeleteButton_pressed() -> void:
	emit_signal("delete_requested", _alarm)


func _on_AlarmBox_value_changed(value: float, property: String) -> void:
	_alarm.set(property, value)
	_update_info_label()


func _update_info_label() -> void:
	var start_time := 60 * _alarm.Hour +  _alarm.Minute
	var start_time_string = "%d:%d" % [_alarm.Hour, _alarm.Minute]
	
	var expiry_total := _alarm.expiry * (_alarm.repeat + 1)
	
	var label_text := ""
	if _alarm.duration > 0:
		var duration_end := start_time + _alarm.duration
# warning-ignore:integer_division
		var duration_end_string = "%d:%d" % [int(duration_end / 60), duration_end % 60]
		label_text = "Alarm will trigger between %s and %s" % [start_time_string, duration_end_string]
	else:
		label_text = "Alarm will trigger at %s" % start_time_string
	
	if _alarm.repeat > 0:
		label_text = "%s and repeat %d time%s after %d minute%s each. The alarm will expire after %d minute%s." % [
			label_text,
			_alarm.repeat,
			"s" if _alarm.repeat > 1 else "",
			_alarm.expiry, "s" if _alarm.expiry > 1 else "",
			expiry_total,
			"s" if expiry_total > 1 else ""
		]
	else:
		label_text = "%s and expire after %d minute%s" % [label_text, expiry_total, "s" if expiry_total > 1 else ""]
	
	info_label.text = label_text
