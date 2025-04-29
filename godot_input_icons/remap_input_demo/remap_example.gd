extends Panel

@export var remap_input_row: PackedScene
@export var remap_control: Control
@export var remappable_inputs_dictionary: Dictionary[String, String] # action -> display_name
var is_remapping: bool = false
var remapping_action: String = ""


func _ready() -> void:
	var input_rows_container: Control = get_node("%InputRowsContainer")
	for item in remappable_inputs_dictionary.keys():
		var input_row = remap_input_row.instantiate() as RemapInputRow
		input_rows_container.add_child(input_row)
		input_row.action_name = item
		input_row.input_icon_texture_rect.action_name = item
		input_row.row_label.text = remappable_inputs_dictionary[item]
		# Could also allow this to be settable
		input_row.input_icon_texture_rect.action_index = 0
		input_row.connect("remap_action", open_remap_control)


func open_remap_control(action: String, _icon_texutre: InputIconTextureRect):
	is_remapping = true
	remap_control.show()
	remapping_action = action


func _input(event: InputEvent) -> void:
	if is_remapping:
		try_remap_event(event)
	pass


func try_remap_event(event: InputEvent) -> void:
	var did_remap: bool = false
	if (event is InputEventKey or event is InputEventMouseButton) and event.is_released():
		InputHelper.replace_keyboard_input_at_index(remapping_action, 0, event)
		did_remap = true
	elif event is InputEventJoypadButton and event.is_released():
		InputHelper.replace_joypad_input_at_index(remapping_action, 0, event)
		did_remap = true
	elif event is InputEventJoypadMotion:
		if event.axis == JOY_AXIS_TRIGGER_RIGHT or \
			event.axis == JOY_AXIS_TRIGGER_LEFT:
				InputHelper.replace_joypad_input_at_index(remapping_action, 0, event)
				did_remap = true
				
	if did_remap:
		is_remapping = false
		remapping_action = ""
		remap_control.hide()
		get_viewport().set_input_as_handled()
				
