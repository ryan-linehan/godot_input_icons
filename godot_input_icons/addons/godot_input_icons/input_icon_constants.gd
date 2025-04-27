@tool
class_name InputIconConstants
const MAP_PATH_SETTING_NAME: String = "input_icons/input_icons_map"
const DEFAULT_MAP_PATH = "res://addons/godot_input_icons/default_icon_maps/default_map.tres"

const INPUT_HELPER_ADAPTER_SETTING_NAME: String = "input_icons/use_input_helper"
const DEFAULT_INPUT_HELPER_ADAPTER_VALUE: bool = false

enum InputTypes {
	Keyboard,
	Xbox,
	Playstation,
	Switch,
	Generic
}
