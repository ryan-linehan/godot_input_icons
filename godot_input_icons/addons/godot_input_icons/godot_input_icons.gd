@tool
extends EditorPlugin
var map_path_default_value = preload("res://addons/godot_input_icons/constants.gd").DEFAULT_MAP_PATH
var map_path_setting_name = preload("res://addons/godot_input_icons/constants.gd").MAP_PATH_SETTING_NAME

func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	var setting_name
	# TODO: When the path to this changes do we need to do something to refresh
	# the icons everywhere?
	var existing_setting = ProjectSettings.get_setting(InputIconConstants.MAP_PATH_SETTING_NAME);
	if not existing_setting:
		ProjectSettings.set_setting(InputIconConstants.MAP_PATH_SETTING_NAME, InputIconConstants.DEFAULT_MAP_PATH)

func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	pass
