@tool
class_name InputIconTextureRect
extends TextureRect

const InputTypes = preload("res://addons/godot_input_icons/constants.gd").InputTypes

@export var _preview_device: InputTypes = InputTypes.Keyboard: set = set_preview_device

func _ready():
	_update_texture()
	
func set_preview_device(value: InputTypes) -> void:
	_preview_device = value
	_update_texture()


func _update_texture() -> void:
	var icon_resolver = IconResolver.new()
	var result = icon_resolver.get_icon(_preview_device, _action_property_value)
	texture = result
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
	##_preview_device = InputHelper.device
	#_update_texture()
#
#func _on_device_changed(device: InputTypes, device_index: int) -> void:
	#_preview_device = device
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
