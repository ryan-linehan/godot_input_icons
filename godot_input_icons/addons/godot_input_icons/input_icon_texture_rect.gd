@tool
class_name InputIconTextureRect
extends TextureRect

const InputTypes = preload("res://addons/godot_input_icons/constants.gd").InputTypes

## The display device for the texture rect
@export var display_device: InputTypes = InputTypes.Keyboard: set = set_display_device

## The input index to use when displaying this control for when there are multiple
## mappings for the same action and device type
@export var action_index: int = 0: set = set_action_index

var _icon_resolver = IconResolver.new()

func _ready():
	_update_texture()
	
func set_action_index(value: int):
	action_index = value
	_update_texture()
	
func set_display_device(value: InputTypes) -> void:
	display_device = value
	_update_texture()

func _update_texture() -> void:
	if _action_property_value == "--select--":
		texture = null
		return
	
	var result = _icon_resolver.get_icon(display_device, _action_property_value, action_index)
	texture = result
	update_configuration_warnings()
	
func _get_configuration_warnings() -> PackedStringArray:
	if not texture and _action_property_value != "--select--":
		return ["Input icon not mapped"]
	return []
#
#func _on_keyboard_input_changed(action: String, input: InputEvent) -> void:
	#if action == _input_event_name:
		#_update_texture()
#
#func _on_joypad_input_changed(action: String, input: InputEvent) -> void:
	#if action == _input_event_name:
		#_update_texture()
#
#func _on_joypad_changed(device_index: int, is_connected: bool) -> void:
	##display_device = InputHelper.device
	#_update_texture()
#
#func _on_device_changed(device: InputTypes, device_index: int) -> void:
	#display_device = device
	#_update_texture()

func set_action_property_value(value: Variant):
	_action_property_value = value
	_update_texture()

var _action_property_name: String = "action_name"
var _action_property_value: StringName = "--select--"
func _get_property_list() -> Array:
	var inputs: PackedStringArray = ["--select--"]
	inputs.append_array(IconResolver.get_all_user_registered_inputs())
	var hint_string = ",".join(inputs)
	return [
		{
			"name": _action_property_name,
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": hint_string,
			"usage": PROPERTY_USAGE_DEFAULT
		}
	]

func _set(property: StringName, value: Variant) -> bool:
	if property == _action_property_name:
		set_action_property_value(value)
	return false


func _get(property: StringName):
	if property == _action_property_name:
		return _action_property_value
	return null
