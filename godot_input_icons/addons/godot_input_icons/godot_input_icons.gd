@tool
extends EditorPlugin

func _enter_tree() -> void:
	# TODO: When the path to this changes do we need to do something to refresh
	# the icons everywhere?
	
	var existing_setting = ProjectSettings.get_setting(InputIconConstants.MAP_PATH_SETTING_NAME);
	if not existing_setting:
		ProjectSettings.set_setting(InputIconConstants.MAP_PATH_SETTING_NAME, InputIconConstants.DEFAULT_MAP_PATH)
	
	existing_setting = ProjectSettings.get_setting(InputIconConstants.INPUT_HELPER_ADAPTER_SETTING_NAME)
	if not existing_setting:
		ProjectSettings.set_setting(InputIconConstants.INPUT_HELPER_ADAPTER_SETTING_NAME, InputIconConstants.DEFAULT_INPUT_HELPER_ADAPTER_VALUE)
		
	ProjectSettings.set_initial_value(InputIconConstants.MAP_PATH_SETTING_NAME, InputIconConstants.DEFAULT_MAP_PATH)
	ProjectSettings.set_initial_value(InputIconConstants.INPUT_HELPER_ADAPTER_SETTING_NAME, InputIconConstants.DEFAULT_INPUT_HELPER_ADAPTER_VALUE)	
	
func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	pass
