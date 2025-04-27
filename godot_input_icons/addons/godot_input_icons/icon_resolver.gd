@tool
class_name IconResolver

const InputTypes = preload("res://addons/godot_input_icons/constants.gd").InputTypes
var map_path_default_value = preload("res://addons/godot_input_icons/constants.gd").DEFAULT_MAP_PATH
var map_path_setting_name = preload("res://addons/godot_input_icons/constants.gd").MAP_PATH_SETTING_NAME

var input_map: InputIconMap = null

## Initalizes the resolver by loading the map specified by the plugin
## TODO: Consider allowing a user to override the input map manually?
func _init() -> void:
	input_map = load(ProjectSettings.get_setting(InputIconConstants.MAP_PATH_SETTING_NAME, InputIconConstants.DEFAULT_MAP_PATH))
	pass

## Gets an icon from the plugin's registed icon map based off of the device_type
## and the input_action passed in
func get_icon(device_type: InputTypes, input_action: String, index: int = 0) -> Texture2D:
	if device_type == InputTypes.Keyboard:
		return get_keyboard_icon(input_action, index)
	else:
		return get_joypad_icon(device_type, input_action, index)

## Gets the keyboard icon for the first keyboard input associated with
## an action
func get_keyboard_icon(input_action: String, index: int = 0) -> Texture2D:
	var input_event = get_keyboard_input_event_for_action(input_action, index)
	var textures: Array[Texture2D] = []
	# Add modifiers first
	if input_event is InputEventWithModifiers:
		textures.append_array(get_keyboard_modifier_icons(input_event))
	
	# Add key after
	if input_event is InputEventKey:
		# Get the OS keycode string (this ignores the modifiers and lets us get just the key)
		var key_name = OS.get_keycode_string(input_event.physical_keycode).to_lower()
		# arrow keys are named specially for user to setup easier
		if key_name == "up" or key_name == "down" or key_name == "left" or key_name == "right":
			key_name = key_name.insert(0, "arrow_")
		
		var texture = input_map.keyboard_icons.get("key_%s" % [key_name])
		if texture:
			textures.append(texture)
	elif input_event is InputEventMouseButton:
		var texture = get_mouse_button_icon(input_event)
		if texture:
			textures.append(texture)
			
	if textures.size() == 0:
		return null
	elif textures.size() == 1:
		return textures[0]
	return combine_textures_with_gap(textures)

func get_keyboard_modifier_icons(input_event: InputEventWithModifiers) -> Array[Texture2D]:
	var textures: Array[Texture2D] = []
	if input_event.alt_pressed:
		textures.append(input_map.keyboard_icons.key_alt)
	if input_event.ctrl_pressed:
		textures.append(input_map.keyboard_icons.key_ctrl)
	if input_event.meta_pressed:
		textures.append(input_map.keyboard_icons.key_meta)
	if input_event.shift_pressed:
		textures.append(input_map.keyboard_icons.key_shift)
	return textures

func get_mouse_button_icon(input_event: InputEventMouseButton) -> Texture2D:
	match input_event.button_index:
		MOUSE_BUTTON_LEFT:
			return input_map.keyboard_icons.mouse_left_click
		MOUSE_BUTTON_RIGHT:
			return input_map.keyboard_icons.mouse_right_click
		MOUSE_BUTTON_MIDDLE:
			return input_map.keyboard_icons.mouse_middle_click
		MOUSE_BUTTON_XBUTTON1:			
			return input_map.keyboard_icons.mouse_extra_button1
		MOUSE_BUTTON_XBUTTON2:
			return input_map.keyboard_icons.mouse_extra_button2
	return null

## Gets the controller icon for the first controller input associated with
## an action
func get_joypad_icon(device_type: InputTypes, input_action: String, index: int = 0) -> Texture2D:
	if not input_map.controller_icons.has(device_type):
		push_warning("InputIcons: Missing icon map for device %s" % \
			[get_device_type_display(device_type)])
		return null
		
	var joypad_icon_map = input_map.controller_icons.get(device_type)
	var input_event = get_joypad_input_event_for_action(input_action, index)
	if input_event is InputEventJoypadButton:
		return _get_joypad_button_icon(joypad_icon_map, input_event)
	elif input_event is InputEventJoypadMotion:
		return _get_joypad_axis_icon(joypad_icon_map, input_event)
		
	return null
	
## Gets all input events for a specified action
func get_input_events_for_action(input_action: String):
	var project_setting_input = ProjectSettings.get_setting("input/%s" % [input_action])
	if not project_setting_input:
		return []
		
	var input_events: Array[InputEvent] = []
	var input_dict = project_setting_input as Dictionary
	for item in input_dict.get_or_add("events", []):
		input_events.append(item as InputEvent)
	return input_events

## Gets a keyboard or mouse button action at a specific index.
## - if no index specified defaults to index 0
## - returns null if no actions are found
## NOTE: The index applies to only input events for keyboard and will be
## in the same order that they are registered in the ProjectSettings input	
func get_keyboard_input_event_for_action(input_action: String, index: int = 0) -> InputEvent:
	var events = get_input_events_for_action(input_action)
	var filtered_events = events.filter(func(event): return event is InputEventKey or event is InputEventMouseButton)
	if not filtered_events or index >= filtered_events.size():
		push_warning("InputIcons: keyboard action '%s' at index %s not found." % \
			 [input_action, index])
		return null
	return filtered_events[index]
	
## Gets a joypad action at a specific index.
## - if no index specified defaults to index 0
## - returns null if no actions are found
## NOTE: The index applies to only input events for joypad and will be
## in the same order that they are registered in the ProjectSettings input 
func get_joypad_input_event_for_action(input_action: String, index: int = 0) -> InputEvent:
	var events = get_input_events_for_action(input_action)
	var filtered_events = events.filter(func(event): return event is InputEventJoypadButton \
		 or event is InputEventJoypadMotion)
	if not filtered_events or index >= filtered_events.size():
		push_warning("InputIcons: joypad action '%s' at index %s not found." % \
			 [input_action, index])
		return null
	return filtered_events[index]
	
## Gets the controller icon from the input map using a InputEventJoypadButton
func _get_joypad_axis_icon(icon_map: ControllerIcons, joypad_motion_event: InputEventJoypadMotion):
	match joypad_motion_event.axis:
		JoyAxis.JOY_AXIS_TRIGGER_LEFT:
			return icon_map.left_trigger
		JoyAxis.JOY_AXIS_TRIGGER_RIGHT:
			return icon_map.right_trigger
		_:
			return null
	
## Gets the controller icon from the input map using a InputEventJoypadButton
## TODO: Fill the rest of these out!
func _get_joypad_button_icon(icon_map: ControllerIcons, button_event: InputEventJoypadButton) -> Texture2D:
	match button_event.button_index:
		JOY_BUTTON_A:
			return icon_map.face_button_down
		JOY_BUTTON_B:
			return icon_map.face_button_right
		JOY_BUTTON_X:
			return icon_map.face_button_left
		JOY_BUTTON_Y:
			return icon_map.face_button_up
		JOY_BUTTON_DPAD_UP:
			return icon_map.dpad_up
		JOY_BUTTON_DPAD_LEFT:
			return icon_map.dpad_left
		JOY_BUTTON_DPAD_RIGHT:
			return icon_map.dpad_right
		JOY_BUTTON_DPAD_DOWN:
			return icon_map.dpad_down
		JOY_BUTTON_START:
			return icon_map.start_button
		JOY_BUTTON_LEFT_SHOULDER:
			return icon_map.left_bumper
		JOY_BUTTON_RIGHT_SHOULDER:
			return icon_map.right_bumper
		JOY_BUTTON_BACK:
			return icon_map.back_button
		JOY_BUTTON_INVALID:
			return icon_map.invalid_button
		JOY_BUTTON_GUIDE:
			return null
			# return icon_map.guide_button 
		JOY_BUTTON_LEFT_STICK:
			return icon_map.left_stick_in
		JOY_BUTTON_RIGHT_STICK:
			return icon_map.right_stick_in
		JOY_BUTTON_MISC1:
			return null
			#return icon_map.misc1_button
		JOY_BUTTON_PADDLE1:
			return null
			# return icon_map.paddle1_button
		JOY_BUTTON_PADDLE2:
			return null
			#return icon_map.paddle2_button
		JOY_BUTTON_PADDLE3:
			return null
			#return icon_map.paddle3_button
		JOY_BUTTON_PADDLE4:
			return null
			#return icon_map.paddle4_button
		JOY_BUTTON_TOUCHPAD:
			return null
			#return icon_map.touchpad_button
		JOY_BUTTON_SDL_MAX:
			return null
			#return icon_map.sdl_max_button
		JOY_BUTTON_MAX:
			return null
			#return icon_map.max_button
		_:
			return null

static func get_device_type_display(device_type: InputTypes) -> String:
	match device_type:
		InputTypes.Keyboard:
			return "Keyboard"
		InputTypes.Xbox:
			return "Xbox"
		InputTypes.Playstation:
			return "Playstation"
		InputTypes.Switch:
			return "Switch"
		InputTypes.Generic:
			return "Generic"
	return "Unknown device type"


## TODO: Consider caching textures that are combined so they don't
## need to be recreated over and over
## Combines an array of Texture2Ds and converts them into a single Texture2D with a gap
static func combine_textures_with_gap(textures: Array[Texture2D], gap: int = 2) -> Texture2D:
	var total_width = 0
	var max_height = 0

	for texture in textures:
		if texture is Texture2D:
			total_width += texture.get_width() + gap
			max_height = max(max_height, texture.get_height())

	total_width -= gap  # Remove the last gap
	
	var combined_image = Image.create_empty(total_width, max_height, false, Image.FORMAT_RGBA8)

	# Blit each texture onto the combined image with a gap
	var current_x = 0
	for texture in textures:
		if texture is Texture2D:
			var image = texture.get_image()
			combined_image.blit_rect(image, Rect2(Vector2.ZERO, image.get_size()), Vector2(current_x, 0))
			current_x += texture.get_width() + gap
			
	return ImageTexture.create_from_image(combined_image)

## Gets all registered user inputs (filters out inputs that start with ui_)
static func get_all_user_registered_inputs() -> PackedStringArray:
	var input_actions = []
	var project_settings = Engine.get_singleton("ProjectSettings")
	for setting_dict in project_settings.get_property_list():
		if setting_dict and "name" in setting_dict:
			var setting_name = str(setting_dict["name"])
			if setting_name.begins_with("input/"):
				setting_name = setting_name.substr("input/".length())
				if not setting_name.begins_with("ui_"):
					input_actions.append(setting_name)
	return input_actions
