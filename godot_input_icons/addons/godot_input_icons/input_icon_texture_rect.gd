@tool
class_name InputIconTextureRect
extends TextureRect

## The display device for the texture rect
@export var display_device: InputIconConstants.InputTypes = InputIconConstants.InputTypes.Keyboard: set = set_display_device

## The input index to use when displaying this control for when there are multiple
## mappings for the same action and device type
@export var action_index: int = 0: set = set_action_index

var _icon_resolver: IconResolver = IconResolver.new()
var input_helper_adapter: InputHelperAdapter = null
var is_input_helper_adapter_enabled: bool = false

#region Editor custom property variables
var _action_property_name: String = "action_name"
var _action_property_default: StringName = "--select--"
var _action_property_value: StringName = _action_property_default
#endregion

func _init():
	is_input_helper_adapter_enabled = ProjectSettings.get_setting(InputIconConstants.INPUT_HELPER_ADAPTER_SETTING_NAME, false)

func _ready():
	if is_input_helper_adapter_enabled:
		input_helper_adapter = InputHelperAdapter.new(_action_property_value, _update_texture, set_display_device)
	_update_texture()
	
	
## Sets the action_index and updates the controls texture
func set_action_index(value: int):
	action_index = value
	_update_texture()

## Sets the display_device and updates the controls texture
func set_display_device(value: InputIconConstants.InputTypes) -> void:
	display_device = value
	_update_texture()


## Updates the texture of the control to the control's current
## configuration (display_device + action)
func _update_texture() -> void:
	if _action_property_value == _action_property_default:
		texture = null
		return
	
	var result = _icon_resolver.get_icon(display_device, _action_property_value, action_index)
	texture = result
	update_configuration_warnings()

#region Godot Editor Customizations

func set_action_property_value(value: Variant):
	_action_property_value = value
	_update_texture()


func _get_property_list() -> Array:
	var properties = [get_action_property_dict()]
	if is_input_helper_adapter_enabled:
		properties.append(InputHelperAdapter.get_device_index_property_dict())
	return properties


func _property_can_revert(property: StringName) -> bool:
	return property == _action_property_name or \
		property == InputHelperAdapter.device_indexes_property_name
	

func _property_get_revert(property: StringName) -> Variant:
	if property == _action_property_name:
		return _action_property_default
	elif property == InputHelperAdapter.device_indexes_property_name:
		return InputHelperAdapter.editor_device_indexes_default
	return null


func _get_configuration_warnings() -> PackedStringArray:
	if not texture and _action_property_value != _action_property_default:
		return ["Input icon not mapped"]
	return []


func get_action_property_dict() -> Dictionary:
	var inputs: PackedStringArray = [_action_property_default]
	inputs.append_array(IconResolver.get_all_user_registered_inputs())
	var hint_string = ",".join(inputs)
	return {
		"name": _action_property_name,
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": hint_string,
		"usage": PROPERTY_USAGE_DEFAULT
	}
	
	
func _set(property: StringName, value: Variant) -> bool:
	if property == _action_property_name:
		set_action_property_value(value)
		return true
	elif property == InputHelperAdapter.device_indexes_property_name \
		and input_helper_adapter != null:
			input_helper_adapter.device_indexes = value
			return true
	return false


func _get(property: StringName) -> Variant:
	if property == _action_property_name:
		return _action_property_value
	elif property == InputHelperAdapter.device_indexes_property_name \
		and input_helper_adapter != null:
			return input_helper_adapter.device_indexes
	return null
	
#endregion
