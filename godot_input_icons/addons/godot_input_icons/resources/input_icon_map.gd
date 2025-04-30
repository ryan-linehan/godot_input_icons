@tool
class_name InputIconMap
extends Resource

const INPUT_TYPES = preload("res://addons/godot_input_icons/input_icon_constants.gd").InputTypes

@export var keyboard_icons: KeyboardIcons
@export var controller_icons: Dictionary[INPUT_TYPES, ControllerIcons]
## If provided this texture is displayed when the keyboard key is unmapped
## NOTE: Will also display if the button is unsupported by the plugin
@export var unmapped_key: Texture2D
## If provided this texture is displayed when the joypad button is unmapped
## NOTE: Will also display if the button is unsupported by the plugin
@export var unmapped_controller_button: Texture2D
