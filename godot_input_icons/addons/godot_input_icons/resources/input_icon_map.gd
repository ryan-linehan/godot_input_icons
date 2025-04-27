@tool
class_name InputIconMap
extends Resource

const INPUT_TYPES = preload("res://addons/godot_input_icons/constants.gd").InputTypes

@export var keyboard_icons: KeyboardIcons
@export var controller_icons: Dictionary[INPUT_TYPES, ControllerIcons]
