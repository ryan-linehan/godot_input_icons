extends Panel

func _ready() -> void:
	var is_adapter_enabled = ProjectSettings.get_setting(InputIconConstants.INPUT_HELPER_ADAPTER_SETTING_NAME, false)
	visible = not is_adapter_enabled
	pass
