extends HBoxContainer
class_name RemapInputRow
@export var action_name: String = ""
@export var input_icon_texture_rect: InputIconTextureRect
var row_label: Label
signal remap_action(action: String, icon_texutre: InputIconTextureRect)

func _ready() -> void:
	input_icon_texture_rect = get_node("%InputIconTextureRect")
	row_label = get_node("%RowLabel")
	(get_node("%RemapButton") as Button).pressed.connect(
			func(): emit_signal("remap_action", action_name, input_icon_texture_rect)
		)
