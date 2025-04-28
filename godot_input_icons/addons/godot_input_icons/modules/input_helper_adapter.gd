## Integration with nathan hoad's godot input helper
class_name InputHelperAdapter

var _action_name: String
var _update_texture_callback: Callable

func _init(action_name: String, update_texture_callback: Callable) -> void:
	var loop = Engine.get_main_loop()
	var scene_tree = loop as SceneTree
	var input_helper = scene_tree.root.get_node("InputHelper") as InputHelper
	if input_helper:
		_action_name = action_name
		_update_texture_callback = update_texture_callback
		input_helper.device_changed.connect(on_device_changed)
		input_helper.joypad_changed.connect(on_joypad_changed)
		input_helper.keyboard_input_changed.connect(on_keyboard_input_changed)
		input_helper.joypad_input_changed.connect(on_joypad_changed)
	else:
		push_warning("Unable to locate InputHelper. Did you add the plugin and enable it?")

func set_action_name(val: String):
	_action_name = val
	
func on_device_changed(device: String, device_index: int):
	# TODO: Consider how to handle different device indexes
	if device_index != 0:
		return
	_update_texture_callback.call()
	
func on_keyboard_input_changed(action: String, input: InputEvent):
	if action == _action_name:
		_update_texture_callback.call()
	
func on_joypad_input_changed(action: String, input: InputEvent):
	if action == _action_name:
		_update_texture_callback.call()

func on_joypad_changed(device_index: int, is_connected: bool):
	# TODO: Consider how to handle different device indexes
	if device_index != 0:
		return
	_update_texture_callback.call()
