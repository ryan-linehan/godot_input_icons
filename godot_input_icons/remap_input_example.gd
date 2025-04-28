extends Node

@export var listen: bool = false

func _unhandled_input(event) -> void:
	if not listen:
		return
	
	if (event is InputEventKey or event is InputEventMouseButton) and event.is_pressed():
		InputHelper.replace_keyboard_input_at_index("attack", 0, event)
	elif event is InputEventJoypadButton and event.is_pressed():
		InputHelper.replace_joypad_input_at_index("attack", 0, event)
	elif event is InputEventJoypadMotion:
		if event.axis == JOY_AXIS_TRIGGER_RIGHT or \
			event.axis == JOY_AXIS_TRIGGER_LEFT:
			InputHelper.replace_joypad_input_at_index("attack", 0, event)
